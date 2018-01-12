Received: from eggs.gnu.org ([2001:4830:134:3::10]:42020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZD-0007sj-AV
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZC-0005ux-HY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:11 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxZC-0005tl-Az
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:10 -0500
Received: by mail-wr0-x242.google.com with SMTP id g38so1843549wrd.2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:32:10 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:31:07 +0100
Message-Id: <1515756676-3860-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 43/52] chardev: Clean up previous patch
 indentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

The previous patch left in an extra scope layer for ease of
review; time to remove it.  No semantic change.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20171201232433.25193-5-eblake@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-serial.c | 66 +++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/chardev/char-serial.c b/chardev/char-serial.c
index 10162f9..93392c5 100644
--- a/chardev/char-serial.c
+++ b/chardev/char-serial.c
@@ -71,66 +71,64 @@ static void tty_serial_init(int fd, int speed,
     }
 
     speed = speed * 10 / 11;
-    {
-        check_speed(50);
-        check_speed(75);
-        check_speed(110);
-        check_speed(134);
-        check_speed(150);
-        check_speed(200);
-        check_speed(300);
-        check_speed(600);
-        check_speed(1200);
-        check_speed(1800);
-        check_speed(2400);
-        check_speed(4800);
-        check_speed(9600);
-        check_speed(19200);
-        check_speed(38400);
-        /* Non-Posix values follow. They may be unsupported on some systems. */
-        check_speed(57600);
-        check_speed(115200);
+    check_speed(50);
+    check_speed(75);
+    check_speed(110);
+    check_speed(134);
+    check_speed(150);
+    check_speed(200);
+    check_speed(300);
+    check_speed(600);
+    check_speed(1200);
+    check_speed(1800);
+    check_speed(2400);
+    check_speed(4800);
+    check_speed(9600);
+    check_speed(19200);
+    check_speed(38400);
+    /* Non-Posix values follow. They may be unsupported on some systems. */
+    check_speed(57600);
+    check_speed(115200);
 #ifdef B230400
-        check_speed(230400);
+    check_speed(230400);
 #endif
 #ifdef B460800
-        check_speed(460800);
+    check_speed(460800);
 #endif
 #ifdef B500000
-        check_speed(500000);
+    check_speed(500000);
 #endif
 #ifdef B576000
-        check_speed(576000);
+    check_speed(576000);
 #endif
 #ifdef B921600
-        check_speed(921600);
+    check_speed(921600);
 #endif
 #ifdef B1000000
-        check_speed(1000000);
+    check_speed(1000000);
 #endif
 #ifdef B1152000
-        check_speed(1152000);
+    check_speed(1152000);
 #endif
 #ifdef B1500000
-        check_speed(1500000);
+    check_speed(1500000);
 #endif
 #ifdef B2000000
-        check_speed(2000000);
+    check_speed(2000000);
 #endif
 #ifdef B2500000
-        check_speed(2500000);
+    check_speed(2500000);
 #endif
 #ifdef B3000000
-        check_speed(3000000);
+    check_speed(3000000);
 #endif
 #ifdef B3500000
-        check_speed(3500000);
+    check_speed(3500000);
 #endif
 #ifdef B4000000
-        check_speed(4000000);
+    check_speed(4000000);
 #endif
-        spd = B115200;
-    }
+    spd = B115200;
 
 #undef check_speed
  done:
-- 
1.8.3.1
