Received: from eggs.gnu.org ([2001:4830:134:3::10]:34471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fp9F2-0004RF-E4
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fp9Ey-00021f-DW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:34:24 -0400
Received: from smtp29.i.mail.ru ([94.100.177.89]:47772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fp9Ey-000213-1X
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:34:20 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Mon, 13 Aug 2018 12:34:02 +0300
Message-Id: <20180813093402.10852-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] chardev/char-fe: Fix typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>

Fixup some typos in the comments.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 include/chardev/char-fe.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 71cd069478..c67271f1ba 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -113,7 +113,7 @@ void qemu_chr_fe_accept_input(CharBackend *be);
 /**
  * @qemu_chr_fe_disconnect:
  *
- * Close a fd accpeted by character backend.
+ * Close a fd accepted by character backend.
  * Without associated Chardev, do nothing.
  */
 void qemu_chr_fe_disconnect(CharBackend *be);
@@ -122,7 +122,7 @@ void qemu_chr_fe_disconnect(CharBackend *be);
  * @qemu_chr_fe_wait_connected:
  *
  * Wait for characted backend to be connected, return < 0 on error or
- * if no assicated Chardev.
+ * if no associated Chardev.
  */
 int qemu_chr_fe_wait_connected(CharBackend *be, Error **errp);
 
@@ -186,7 +186,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
  * @buf the data
  * @len the number of bytes to send
  *
- * Returns: the number of bytes consumed (0 if no assicated Chardev)
+ * Returns: the number of bytes consumed (0 if no associated Chardev)
  */
 int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
 
@@ -201,7 +201,7 @@ int qemu_chr_fe_write(CharBackend *be, const uint8_t *buf, int len);
  * @buf the data
  * @len the number of bytes to send
  *
- * Returns: the number of bytes consumed (0 if no assicated Chardev)
+ * Returns: the number of bytes consumed (0 if no associated Chardev)
  */
 int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
 
@@ -213,7 +213,7 @@ int qemu_chr_fe_write_all(CharBackend *be, const uint8_t *buf, int len);
  * @buf the data buffer
  * @len the number of bytes to read
  *
- * Returns: the number of bytes read (0 if no assicated Chardev)
+ * Returns: the number of bytes read (0 if no associated Chardev)
  */
 int qemu_chr_fe_read_all(CharBackend *be, uint8_t *buf, int len);
 
-- 
2.17.1
