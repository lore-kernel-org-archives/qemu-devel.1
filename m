Received: from eggs.gnu.org ([2001:4830:134:3::10]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patryk@fala.ehost.pl>) id 1fK5yr-0008R7-0E
	for qemu-devel@nongnu.org; Sat, 19 May 2018 13:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patryk@fala.ehost.pl>) id 1fK5yn-0006Zw-UP
	for qemu-devel@nongnu.org; Sat, 19 May 2018 13:49:21 -0400
Received: from s16.ehost.pl ([193.143.77.16]:40660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <patryk@fala.ehost.pl>)
	id 1fK5yn-0006Kn-JP
	for qemu-devel@nongnu.org; Sat, 19 May 2018 13:49:17 -0400
From: Patryk Olszewski <patryk@fala.ehost.pl>
Date: Sat, 19 May 2018 19:48:28 +0200
Message-Id: <1526752108-21204-1-git-send-email-patryk@fala.ehost.pl>
Subject: [Qemu-devel] [PATCH] Remove unwanted crlf conversion in serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Patryk Olszewski <patryk@fala.ehost.pl>

Signed-off-by: Patryk Olszewski <patryk@fala.ehost.pl>
---
 chardev/char-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index feb52e5..ae548d2 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -139,7 +139,7 @@ static void tty_serial_init(int fd, int speed,
 
     tty.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
                      | INLCR | IGNCR | ICRNL | IXON);
-    tty.c_oflag |= OPOST;
+    tty.c_oflag &= ~OPOST;
     tty.c_lflag &= ~(ECHO | ECHONL | ICANON | IEXTEN | ISIG);
     tty.c_cflag &= ~(CSIZE | PARENB | PARODD | CRTSCTS | CSTOPB);
     switch (data_bits) {
-- 
2.7.4
