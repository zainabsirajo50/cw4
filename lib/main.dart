import 'package:flutter/material.dart';

void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // A list to hold tasks
  List<Task> tasks = [];
  // Controller for the TextField
  TextEditingController taskController = TextEditingController();

  // Method to add a new task
  void addTask(String taskName) {
    setState(() {
      tasks.add(Task(name: taskName));  // Updates the task list and re-renders the UI
    });
    taskController.clear();  // Clear the text field after adding a task
  }

  // Method to complete a task
  void completeTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;  // Toggles task completion status
    });
  }

  // Method to remove a task
  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);  // Removes task and refreshes the UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Column(
        children: [
           // Add Task input field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Input field for adding new tasks
                Expanded(
                  child: TextField(
                    controller: taskController,  // Use the controller to get the input
                    decoration: InputDecoration(
                      labelText: 'New Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      addTask(taskController.text);  // Add the task on button press
                    }
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
          // Expanded widget for the task list display
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,  // Number of tasks
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    tasks[index].name,
                    style: TextStyle(
                      // If the task is completed, it will be displayed with a strikethrough
                      decoration: tasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Checkbox to mark the task as completed or not
                      IconButton(
                        icon: Icon(
                          tasks[index].isCompleted
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                        onPressed: () => completeTask(index),  // Toggle task completion
                      ),
                      // Button to delete the task
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => removeTask(index),  // Remove the task
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}