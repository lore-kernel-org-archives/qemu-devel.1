Received: from eggs.gnu.org ([2001:4830:134:3::10]:45207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGu1C-00056p-Bi
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGu1A-0007rz-C8
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:26:34 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:47713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fGu1A-0007re-3B
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:26:32 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 11 May 2018 00:26:00 +0200
Message-Id: <20180510222601.19944-5-laurent@vivier.eu>
In-Reply-To: <20180510222601.19944-1-laurent@vivier.eu>
References: <20180510222601.19944-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 4/5] linux-user: move ppc socket.h definitions
 to ppc/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>

No code change.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ppc/sockbits.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 linux-user/socket.h       | 11 +--------
 2 files changed, 59 insertions(+), 10 deletions(-)
 create mode 100644 linux-user/ppc/sockbits.h

diff --git a/linux-user/ppc/sockbits.h b/linux-user/ppc/sockbits.h
new file mode 100644
index 0000000000..7561529395
--- /dev/null
+++ b/linux-user/ppc/sockbits.h
@@ -0,0 +1,58 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef PPC_SOCKBITS_H
+#define PPC_SOCKBITS_H
+
+#define TARGET_SO_PASSSEC        34
+
+/* For setsockopt(2) */
+#define TARGET_SOL_SOCKET      1
+
+#define TARGET_SO_DEBUG        1
+#define TARGET_SO_REUSEADDR    2
+#define TARGET_SO_TYPE         3
+#define TARGET_SO_ERROR        4
+#define TARGET_SO_DONTROUTE    5
+#define TARGET_SO_BROADCAST    6
+#define TARGET_SO_SNDBUF       7
+#define TARGET_SO_RCVBUF       8
+#define TARGET_SO_SNDBUFFORCE  32
+#define TARGET_SO_RCVBUFFORCE  33
+#define TARGET_SO_KEEPALIVE    9
+#define TARGET_SO_OOBINLINE    10
+#define TARGET_SO_NO_CHECK     11
+#define TARGET_SO_PRIORITY     12
+#define TARGET_SO_LINGER       13
+#define TARGET_SO_BSDCOMPAT    14
+/* To add :#define TARGET_SO_REUSEPORT 15 */
+#define TARGET_SO_RCVLOWAT     16
+#define TARGET_SO_SNDLOWAT     17
+#define TARGET_SO_RCVTIMEO     18
+#define TARGET_SO_SNDTIMEO     19
+#define TARGET_SO_PASSCRED     20
+#define TARGET_SO_PEERCRED     21
+
+/* Security levels - as per NRL IPv6 - don't actually do anything */
+#define TARGET_SO_SECURITY_AUTHENTICATION              22
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        23
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          24
+
+#define TARGET_SO_BINDTODEVICE 25
+
+/* Socket filtering */
+#define TARGET_SO_ATTACH_FILTER        26
+#define TARGET_SO_DETACH_FILTER        27
+
+#define TARGET_SO_PEERNAME             28
+#define TARGET_SO_TIMESTAMP            29
+#define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
+
+#define TARGET_SO_ACCEPTCONN           30
+
+#define TARGET_SO_PEERSEC              31
+#endif
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 8eb62ea3f2..3eceb6534e 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -1,6 +1,6 @@
 
 #if defined(TARGET_MIPS) || defined(TARGET_HPPA) || defined(TARGET_ALPHA) || \
-    defined(TARGET_SPARC)
+    defined(TARGET_SPARC) || defined(TARGET_PPC)
 #include "sockbits.h"
 #else
     #define TARGET_SO_PASSSEC        34
@@ -25,21 +25,12 @@
     #define TARGET_SO_LINGER       13
     #define TARGET_SO_BSDCOMPAT    14
     /* To add :#define TARGET_SO_REUSEPORT 15 */
-#if defined(TARGET_PPC)
-    #define TARGET_SO_RCVLOWAT     16
-    #define TARGET_SO_SNDLOWAT     17
-    #define TARGET_SO_RCVTIMEO     18
-    #define TARGET_SO_SNDTIMEO     19
-    #define TARGET_SO_PASSCRED     20
-    #define TARGET_SO_PEERCRED     21
-#else
     #define TARGET_SO_PASSCRED     16
     #define TARGET_SO_PEERCRED     17
     #define TARGET_SO_RCVLOWAT     18
     #define TARGET_SO_SNDLOWAT     19
     #define TARGET_SO_RCVTIMEO     20
     #define TARGET_SO_SNDTIMEO     21
-#endif
 
     /* Security levels - as per NRL IPv6 - don't actually do anything */
     #define TARGET_SO_SECURITY_AUTHENTICATION              22
-- 
2.14.3
