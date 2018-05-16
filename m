Received: from eggs.gnu.org ([2001:4830:134:3::10]:52558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ3TK-00006j-Uz
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fJ3TH-0003wP-Py
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:31 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42951)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fJ3TH-0003vZ-FL
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:56:27 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed, 16 May 2018 22:55:36 +0200
Message-Id: <20180516205543.29305-2-laurent@vivier.eu>
In-Reply-To: <20180516205543.29305-1-laurent@vivier.eu>
References: <20180516205543.29305-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/8] linux-user: move mips socket.h
 definitions to mips/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Yongbok Kim <yongbok.kim@mips.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

No code change.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/mips/sockbits.h   | 110 +++++++++++++++++++++++++++++++++++++++++++
 linux-user/mips64/sockbits.h |   1 +
 linux-user/socket.h          | 106 +----------------------------------------
 3 files changed, 113 insertions(+), 104 deletions(-)
 create mode 100644 linux-user/mips/sockbits.h
 create mode 100644 linux-user/mips64/sockbits.h

diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
new file mode 100644
index 0000000000..3fe5ac88e7
--- /dev/null
+++ b/linux-user/mips/sockbits.h
@@ -0,0 +1,110 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef MIPS_SOCKBITS_H
+#define MIPS_SOCKBITS_H
+/* MIPS special values for constants */
+
+/*
+ * For setsockopt(2)
+ *
+ * This defines are ABI conformant as far as Linux supports these ...
+ */
+#define TARGET_SOL_SOCKET      0xffff
+
+#define TARGET_SO_DEBUG        0x0001  /* Record debugging information. */
+#define TARGET_SO_REUSEADDR    0x0004  /* Allow reuse of local addresses. */
+#define TARGET_SO_KEEPALIVE    0x0008  /* Keep connections alive and send
+                                          SIGPIPE when they die. */
+#define TARGET_SO_DONTROUTE    0x0010  /* Don't do local routing. */
+#define TARGET_SO_BROADCAST    0x0020  /* Allow transmission of
+                                          broadcast messages. */
+#define TARGET_SO_LINGER       0x0080  /* Block on close of a reliable
+                                        * socket to transmit pending data.
+                                        */
+#define TARGET_SO_OOBINLINE 0x0100     /* Receive out-of-band data in-band.
+                                        */
+#if 0
+/* To add: Allow local address and port reuse. */
+#define TARGET_SO_REUSEPORT 0x0200
+#endif
+
+#define TARGET_SO_TYPE         0x1008  /* Compatible name for SO_STYLE. */
+#define TARGET_SO_STYLE        SO_TYPE /* Synonym */
+#define TARGET_SO_ERROR        0x1007  /* get error status and clear */
+#define TARGET_SO_SNDBUF       0x1001  /* Send buffer size. */
+#define TARGET_SO_RCVBUF       0x1002  /* Receive buffer. */
+#define TARGET_SO_SNDLOWAT     0x1003  /* send low-water mark */
+#define TARGET_SO_RCVLOWAT     0x1004  /* receive low-water mark */
+#define TARGET_SO_SNDTIMEO     0x1005  /* send timeout */
+#define TARGET_SO_RCVTIMEO     0x1006  /* receive timeout */
+#define TARGET_SO_ACCEPTCONN   0x1009
+
+/* linux-specific, might as well be the same as on i386 */
+#define TARGET_SO_NO_CHECK     11
+#define TARGET_SO_PRIORITY     12
+#define TARGET_SO_BSDCOMPAT    14
+
+#define TARGET_SO_PASSCRED     17
+#define TARGET_SO_PEERCRED     18
+
+/* Security levels - as per NRL IPv6 - don't actually do anything */
+#define TARGET_SO_SECURITY_AUTHENTICATION              22
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        23
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          24
+
+#define TARGET_SO_BINDTODEVICE         25
+
+/* Socket filtering */
+#define TARGET_SO_ATTACH_FILTER        26
+#define TARGET_SO_DETACH_FILTER        27
+
+#define TARGET_SO_PEERNAME             28
+#define TARGET_SO_TIMESTAMP            29
+#define SCM_TIMESTAMP          SO_TIMESTAMP
+
+#define TARGET_SO_PEERSEC              30
+#define TARGET_SO_SNDBUFFORCE          31
+#define TARGET_SO_RCVBUFFORCE          33
+#define TARGET_SO_PASSSEC              34
+
+/** sock_type - Socket types
+ *
+ * Please notice that for binary compat reasons MIPS has to
+ * override the enum sock_type in include/linux/net.h, so
+ * we define ARCH_HAS_SOCKET_TYPES here.
+ *
+ * @SOCK_DGRAM - datagram (conn.less) socket
+ * @SOCK_STREAM - stream (connection) socket
+ * @SOCK_RAW - raw socket
+ * @SOCK_RDM - reliably-delivered message
+ * @SOCK_SEQPACKET - sequential packet socket
+ * @SOCK_DCCP - Datagram Congestion Control Protocol socket
+ * @SOCK_PACKET - linux specific way of getting packets at the dev level.
+ *                For writing rarp and other similar things on the user
+ *                level.
+ * @SOCK_CLOEXEC - sets the close-on-exec (FD_CLOEXEC) flag.
+ * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
+ */
+
+#define ARCH_HAS_SOCKET_TYPES          1
+
+enum sock_type {
+       TARGET_SOCK_DGRAM       = 1,
+       TARGET_SOCK_STREAM      = 2,
+       TARGET_SOCK_RAW         = 3,
+       TARGET_SOCK_RDM         = 4,
+       TARGET_SOCK_SEQPACKET   = 5,
+       TARGET_SOCK_DCCP        = 6,
+       TARGET_SOCK_PACKET      = 10,
+       TARGET_SOCK_CLOEXEC     = 02000000,
+       TARGET_SOCK_NONBLOCK    = 0200,
+};
+
+#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
+#define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
+#endif
diff --git a/linux-user/mips64/sockbits.h b/linux-user/mips64/sockbits.h
new file mode 100644
index 0000000000..e6b6d31ac9
--- /dev/null
+++ b/linux-user/mips64/sockbits.h
@@ -0,0 +1 @@
+#include "../mips/sockbits.h"
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 7051cd2cf4..9c57da7a61 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -1,106 +1,6 @@
 
-#if defined(TARGET_MIPS)
-    /* MIPS special values for constants */
-
-    /*
-     * For setsockopt(2)
-     *
-     * This defines are ABI conformant as far as Linux supports these ...
-     */
-    #define TARGET_SOL_SOCKET      0xffff
-
-    #define TARGET_SO_DEBUG        0x0001  /* Record debugging information. */
-    #define TARGET_SO_REUSEADDR    0x0004  /* Allow reuse of local addresses. */
-    #define TARGET_SO_KEEPALIVE    0x0008  /* Keep connections alive and send
-                                              SIGPIPE when they die. */
-    #define TARGET_SO_DONTROUTE    0x0010  /* Don't do local routing. */
-    #define TARGET_SO_BROADCAST    0x0020  /* Allow transmission of
-                                              broadcast messages. */
-    #define TARGET_SO_LINGER       0x0080  /* Block on close of a reliable
-                                            * socket to transmit pending data.
-                                            */
-    #define TARGET_SO_OOBINLINE 0x0100     /* Receive out-of-band data in-band.
-                                            */
-    #if 0
-    /* To add: Allow local address and port reuse. */
-    #define TARGET_SO_REUSEPORT 0x0200
-    #endif
-
-    #define TARGET_SO_TYPE         0x1008  /* Compatible name for SO_STYLE. */
-    #define TARGET_SO_STYLE        SO_TYPE /* Synonym */
-    #define TARGET_SO_ERROR        0x1007  /* get error status and clear */
-    #define TARGET_SO_SNDBUF       0x1001  /* Send buffer size. */
-    #define TARGET_SO_RCVBUF       0x1002  /* Receive buffer. */
-    #define TARGET_SO_SNDLOWAT     0x1003  /* send low-water mark */
-    #define TARGET_SO_RCVLOWAT     0x1004  /* receive low-water mark */
-    #define TARGET_SO_SNDTIMEO     0x1005  /* send timeout */
-    #define TARGET_SO_RCVTIMEO     0x1006  /* receive timeout */
-    #define TARGET_SO_ACCEPTCONN   0x1009
-
-    /* linux-specific, might as well be the same as on i386 */
-    #define TARGET_SO_NO_CHECK     11
-    #define TARGET_SO_PRIORITY     12
-    #define TARGET_SO_BSDCOMPAT    14
-
-    #define TARGET_SO_PASSCRED     17
-    #define TARGET_SO_PEERCRED     18
-
-    /* Security levels - as per NRL IPv6 - don't actually do anything */
-    #define TARGET_SO_SECURITY_AUTHENTICATION              22
-    #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        23
-    #define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          24
-
-    #define TARGET_SO_BINDTODEVICE         25
-
-    /* Socket filtering */
-    #define TARGET_SO_ATTACH_FILTER        26
-    #define TARGET_SO_DETACH_FILTER        27
-
-    #define TARGET_SO_PEERNAME             28
-    #define TARGET_SO_TIMESTAMP            29
-    #define SCM_TIMESTAMP          SO_TIMESTAMP
-
-    #define TARGET_SO_PEERSEC              30
-    #define TARGET_SO_SNDBUFFORCE          31
-    #define TARGET_SO_RCVBUFFORCE          33
-    #define TARGET_SO_PASSSEC              34
-
-    /** sock_type - Socket types
-     *
-     * Please notice that for binary compat reasons MIPS has to
-     * override the enum sock_type in include/linux/net.h, so
-     * we define ARCH_HAS_SOCKET_TYPES here.
-     *
-     * @SOCK_DGRAM - datagram (conn.less) socket
-     * @SOCK_STREAM - stream (connection) socket
-     * @SOCK_RAW - raw socket
-     * @SOCK_RDM - reliably-delivered message
-     * @SOCK_SEQPACKET - sequential packet socket
-     * @SOCK_DCCP - Datagram Congestion Control Protocol socket
-     * @SOCK_PACKET - linux specific way of getting packets at the dev level.
-     *                For writing rarp and other similar things on the user
-     *                level.
-     * @SOCK_CLOEXEC - sets the close-on-exec (FD_CLOEXEC) flag.
-     * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
-     */
-
-    #define ARCH_HAS_SOCKET_TYPES          1
-
-    enum sock_type {
-           TARGET_SOCK_DGRAM       = 1,
-           TARGET_SOCK_STREAM      = 2,
-           TARGET_SOCK_RAW         = 3,
-           TARGET_SOCK_RDM         = 4,
-           TARGET_SOCK_SEQPACKET   = 5,
-           TARGET_SOCK_DCCP        = 6,
-           TARGET_SOCK_PACKET      = 10,
-           TARGET_SOCK_CLOEXEC     = 02000000,
-           TARGET_SOCK_NONBLOCK    = 0200,
-    };
-
-    #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-    #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
-
+#if defined(TARGET_MIPS) || defined(TARGET_HPPA)
+#include "sockbits.h"
 #elif defined(TARGET_ALPHA)
 
     /* For setsockopt(2) */
@@ -205,8 +105,6 @@
 
     #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
     #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
-#elif defined(TARGET_HPPA)
-#include <hppa/sockbits.h>
 #else
 
 #if defined(TARGET_SPARC)
-- 
2.14.3
