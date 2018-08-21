Received: from eggs.gnu.org ([2001:4830:134:3::10]:32811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA43-0001Jk-Gh
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA3n-0005e9-GQ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:23 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA3m-0005Ul-6g
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id v16-v6so2036684wro.11
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:39 +0200
Message-Id: <1534870966-9287-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/74] chardev/char-fe: Fix typos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Julia Suvorova <jusual@mail.ru>

From: Julia Suvorova <jusual@mail.ru>

Fixup some typos in the comments.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Message-Id: <20180813093402.10852-1-jusual@mail.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/chardev/char-fe.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 71cd069..c67271f 100644
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
1.8.3.1
