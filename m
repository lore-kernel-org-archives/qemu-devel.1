Received: from eggs.gnu.org ([2001:4830:134:3::10]:50524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duYdj-0002HY-MR
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1duYde-0004k5-MM
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:37:43 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1duYde-0004fU-HO
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:37:38 -0400
Received: by mail-pg0-x244.google.com with SMTP id u18so1151253pgo.1
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 23:37:38 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Tue, 19 Sep 2017 23:35:58 -0700
Message-Id: <20170920063558.89376-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux_user: fix TARGET_SOL_SOCKET for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/socket.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/linux-user/socket.h b/linux-user/socket.h
index 129f9b4713..1db1a184b9 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -229,7 +229,9 @@
      * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
      */
 
-    #define ARCH_HAS_SOCKET_TYPES          1
+    #define ARCH_HAS_SOCKET_TYPES    1
+
+    #define TARGET_SOL_SOCKET        0xffff
 
     enum sock_type {
            TARGET_SOCK_STREAM      = 1,
@@ -250,14 +252,13 @@
 
     #define TARGET_SO_PASSSEC        31
 #else
+    #define TARGET_SOL_SOCKET        1
+
     #define TARGET_SO_LINGER         13
 
     #define TARGET_SO_PASSSEC        34
 #endif
 
-    /* For setsockopt(2) */
-    #define TARGET_SOL_SOCKET      1
-
     #define TARGET_SO_DEBUG        1
     #define TARGET_SO_REUSEADDR    2
     #define TARGET_SO_TYPE         3
-- 
2.14.1
