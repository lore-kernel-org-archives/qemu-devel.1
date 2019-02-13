Received: from eggs.gnu.org ([209.51.188.92]:39445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGP-0004Oe-Le
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gtxGO-0005ho-TK
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gtxGN-0005gW-DY
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:19:56 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 13 Feb 2019 17:19:06 +0100
Message-Id: <20190213161913.22107-19-marcandre.lureau@redhat.com>
In-Reply-To: <20190213161913.22107-1-marcandre.lureau@redhat.com>
References: <20190213161913.22107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 18/25] chardev: ensure termios is fully
 initialized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

valgrind on the test-char.c code reports that 'struct termios' contains
uninitialized memory.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20190211182442.8542-17-berrange@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 chardev/char-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 3299b46853..a8bae31b8d 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -57,7 +57,7 @@ static void qmp_chardev_open_serial(Chardev *chr,
 static void tty_serial_init(int fd, int speed,
                             int parity, int data_bits, int stop_bits)
 {
-    struct termios tty;
+    struct termios tty =3D {0};
     speed_t spd;
=20
 #if 0
--=20
2.21.0.rc0.1.g036caf7885
