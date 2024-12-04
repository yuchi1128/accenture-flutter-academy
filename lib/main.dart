import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const TodoPage(),
    );
  }
}

typedef TodoItem = ({String title, bool done});

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<TodoItem> todoItems = [
    (title: 'Accentureセッションに参加', done: false),
    (title: 'モバイル開発について学習する', done: false),
    (title: '実際にアプリを作ってみる', done: false),
    (title: 'タスク管理アプリを作る！', done: false)
  ];

  void _toggleTodoItem(int index, bool? value) {
    if (value != null) {
      setState(() {
        todoItems[index] = (title: todoItems[index].title, done: value);
      });
    }
  }

  void _goToDetailPage(TodoItem item) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => DetailPage(item: item)),
    );
  }

  void _addNewItem() {
    setState(() {
      todoItems.add((title: "新しい項目", done: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 1,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.purple[300],
                child: Icon(Icons.assignment, color: Colors.white),
              ),
              title: Text(
                todoItems[index].title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "タップして詳細を見る",
                style: TextStyle(color: Colors.grey[600]),
              ),
              trailing: Checkbox(
                value: todoItems[index].done,
                onChanged: (value) {
                  _toggleTodoItem(index, value);
                },
                activeColor: Colors.purple[400],
              ),
              onTap: () => _goToDetailPage(todoItems[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        backgroundColor: Colors.purple[300],
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'プロフィール'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
        selectedItemColor: Colors.purple[300],
        unselectedItemColor: Colors.grey[500],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.item});
  final TodoItem item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('項目の詳細'),
        backgroundColor: Colors.purple[300],
      ),
      body: Center(
        child: Text(
          item.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
