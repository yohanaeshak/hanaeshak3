import 'package:flutter/material.dart';
import 'package:untitled20/OrderConfirmationScreen.dart'; // تأكد من المسار
import 'checkout.dart'; // تأكد من أن المسار صحيح

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cart;
  final VoidCallback onClearCart;
  final Function(Map<String, dynamic>) onRemoveProduct;

  CartPage({
    required this.cart,
    required this.onClearCart,
    required this.onRemoveProduct,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = cart.fold(0, (sum, item) => sum + item['price']);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onClearCart,
          ),
        ],
      ),
      body: cart.isEmpty
          ? Center(child: Text('Your cart is empty.'))
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final item = cart[index];
          return ListTile(
            leading: Image.asset(item['imagePath'], width: 50, height: 50),
            title: Text(item['name']),
            subtitle: Text('\$${item['price'].toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () => onRemoveProduct(item),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: cart.isEmpty ? null : onClearCart,
                  child: Text('Clear Cart'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
                ElevatedButton(
                  onPressed: cart.isEmpty
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderConfirmationPage(),
                      ),
                    );
                  },
                  child: Text('Checkout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your order is confirmed!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // التوجيه إلى صفحة Checkout بعد تأكيد الطلب
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()),
                );
              },
              child: Text('Proceed to Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
