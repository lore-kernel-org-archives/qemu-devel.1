Received: from eggs.gnu.org ([2001:4830:134:3::10]:38413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vc-0001kA-LX
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vY-0008FQ-8i
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:24 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42047)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fM7vX-0008Ei-Uy
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:20 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 25 May 2018 10:17:47 +0200
Message-Id: <20180525081754.29506-7-laurent@vivier.eu>
In-Reply-To: <20180525081754.29506-1-laurent@vivier.eu>
References: <20180525081754.29506-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/13] linux-user: move alpha socket.h
 definitions to alpha/sockbits.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

No code change.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180519092956.15134-3-laurent@vivier.eu>
---
 linux-user/alpha/sockbits.h | 113 ++++++++++++++++++++++++++++++++++++++++++++
 linux-user/socket.h         | 106 +----------------------------------------
 2 files changed, 114 insertions(+), 105 deletions(-)
 create mode 100644 linux-user/alpha/sockbits.h

diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
new file mode 100644
index 0000000000..4db3e52b67
--- /dev/null
+++ b/linux-user/alpha/sockbits.h
@@ -0,0 +1,113 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation, or (at your option) any
+ * later version. See the COPYING file in the top-level directory.
+ */
+
+#ifndef ALPHA_SOCKBITS_H
+#define ALPHA_SOCKBITS_H
+
+/* For setsockopt(2) */
+#define TARGET_SOL_SOCKET   0xffff
+
+#define TARGET_SO_DEBUG 0x0001
+#define TARGET_SO_REUSEADDR 0x0004
+#define TARGET_SO_KEEPALIVE 0x0008
+#define TARGET_SO_DONTROUTE 0x0010
+#define TARGET_SO_BROADCAST 0x0020
+#define TARGET_SO_LINGER    0x0080
+#define TARGET_SO_OOBINLINE 0x0100
+/* To add :#define TARGET_SO_REUSEPORT 0x0200 */
+
+#define TARGET_SO_TYPE      0x1008
+#define TARGET_SO_ERROR 0x1007
+#define TARGET_SO_SNDBUF    0x1001
+#define TARGET_SO_RCVBUF    0x1002
+#define TARGET_SO_SNDBUFFORCE   0x100a
+#define TARGET_SO_RCVBUFFORCE   0x100b
+#define TARGET_SO_RCVLOWAT  0x1010
+#define TARGET_SO_SNDLOWAT  0x1011
+#define TARGET_SO_RCVTIMEO  0x1012
+#define TARGET_SO_SNDTIMEO  0x1013
+#define TARGET_SO_ACCEPTCONN    0x1014
+#define TARGET_SO_PROTOCOL  0x1028
+#define TARGET_SO_DOMAIN    0x1029
+
+/* linux-specific, might as well be the same as on i386 */
+#define TARGET_SO_NO_CHECK  11
+#define TARGET_SO_PRIORITY  12
+#define TARGET_SO_BSDCOMPAT 14
+
+#define TARGET_SO_PASSCRED  17
+#define TARGET_SO_PEERCRED  18
+#define TARGET_SO_BINDTODEVICE 25
+
+/* Socket filtering */
+#define TARGET_SO_ATTACH_FILTER        26
+#define TARGET_SO_DETACH_FILTER        27
+
+#define TARGET_SO_PEERNAME      28
+#define TARGET_SO_TIMESTAMP     29
+#define TARGET_SCM_TIMESTAMP        TARGET_SO_TIMESTAMP
+
+#define TARGET_SO_PEERSEC       30
+#define TARGET_SO_PASSSEC       34
+#define TARGET_SO_TIMESTAMPNS       35
+#define TARGET_SCM_TIMESTAMPNS      TARGET_SO_TIMESTAMPNS
+
+/* Security levels - as per NRL IPv6 - don't actually do anything */
+#define TARGET_SO_SECURITY_AUTHENTICATION       19
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT 20
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK       21
+
+#define TARGET_SO_MARK          36
+
+#define TARGET_SO_TIMESTAMPING      37
+#define TARGET_SCM_TIMESTAMPING TARGET_SO_TIMESTAMPING
+
+#define TARGET_SO_RXQ_OVFL             40
+
+#define TARGET_SO_WIFI_STATUS       41
+#define TARGET_SCM_WIFI_STATUS      TARGET_SO_WIFI_STATUS
+#define TARGET_SO_PEEK_OFF      42
+
+/* Instruct lower device to use last 4-bytes of skb data as FCS */
+#define TARGET_SO_NOFCS     43
+
+/** sock_type - Socket types
+ *
+ * Please notice that for binary compat reasons ALPHA has to
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
+       TARGET_SOCK_STREAM      = 1,
+       TARGET_SOCK_DGRAM       = 2,
+       TARGET_SOCK_RAW         = 3,
+       TARGET_SOCK_RDM         = 4,
+       TARGET_SOCK_SEQPACKET   = 5,
+       TARGET_SOCK_DCCP        = 6,
+       TARGET_SOCK_PACKET      = 10,
+       TARGET_SOCK_CLOEXEC     = 010000000,
+       TARGET_SOCK_NONBLOCK    = 010000000000,
+};
+
+#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
+#define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
+#endif
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 9c57da7a61..1328906205 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -1,110 +1,6 @@
 
-#if defined(TARGET_MIPS) || defined(TARGET_HPPA)
+#if defined(TARGET_MIPS) || defined(TARGET_HPPA) || defined(TARGET_ALPHA)
 #include "sockbits.h"
-#elif defined(TARGET_ALPHA)
-
-    /* For setsockopt(2) */
-    #define TARGET_SOL_SOCKET   0xffff
-
-    #define TARGET_SO_DEBUG 0x0001
-    #define TARGET_SO_REUSEADDR 0x0004
-    #define TARGET_SO_KEEPALIVE 0x0008
-    #define TARGET_SO_DONTROUTE 0x0010
-    #define TARGET_SO_BROADCAST 0x0020
-    #define TARGET_SO_LINGER    0x0080
-    #define TARGET_SO_OOBINLINE 0x0100
-    /* To add :#define TARGET_SO_REUSEPORT 0x0200 */
-
-    #define TARGET_SO_TYPE      0x1008
-    #define TARGET_SO_ERROR 0x1007
-    #define TARGET_SO_SNDBUF    0x1001
-    #define TARGET_SO_RCVBUF    0x1002
-    #define TARGET_SO_SNDBUFFORCE   0x100a
-    #define TARGET_SO_RCVBUFFORCE   0x100b
-    #define TARGET_SO_RCVLOWAT  0x1010
-    #define TARGET_SO_SNDLOWAT  0x1011
-    #define TARGET_SO_RCVTIMEO  0x1012
-    #define TARGET_SO_SNDTIMEO  0x1013
-    #define TARGET_SO_ACCEPTCONN    0x1014
-    #define TARGET_SO_PROTOCOL  0x1028
-    #define TARGET_SO_DOMAIN    0x1029
-
-    /* linux-specific, might as well be the same as on i386 */
-    #define TARGET_SO_NO_CHECK  11
-    #define TARGET_SO_PRIORITY  12
-    #define TARGET_SO_BSDCOMPAT 14
-
-    #define TARGET_SO_PASSCRED  17
-    #define TARGET_SO_PEERCRED  18
-    #define TARGET_SO_BINDTODEVICE 25
-
-    /* Socket filtering */
-    #define TARGET_SO_ATTACH_FILTER        26
-    #define TARGET_SO_DETACH_FILTER        27
-
-    #define TARGET_SO_PEERNAME      28
-    #define TARGET_SO_TIMESTAMP     29
-    #define TARGET_SCM_TIMESTAMP        TARGET_SO_TIMESTAMP
-
-    #define TARGET_SO_PEERSEC       30
-    #define TARGET_SO_PASSSEC       34
-    #define TARGET_SO_TIMESTAMPNS       35
-    #define TARGET_SCM_TIMESTAMPNS      TARGET_SO_TIMESTAMPNS
-
-    /* Security levels - as per NRL IPv6 - don't actually do anything */
-    #define TARGET_SO_SECURITY_AUTHENTICATION       19
-    #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT 20
-    #define TARGET_SO_SECURITY_ENCRYPTION_NETWORK       21
-
-    #define TARGET_SO_MARK          36
-
-    #define TARGET_SO_TIMESTAMPING      37
-    #define TARGET_SCM_TIMESTAMPING TARGET_SO_TIMESTAMPING
-
-    #define TARGET_SO_RXQ_OVFL             40
-
-    #define TARGET_SO_WIFI_STATUS       41
-    #define TARGET_SCM_WIFI_STATUS      TARGET_SO_WIFI_STATUS
-    #define TARGET_SO_PEEK_OFF      42
-
-    /* Instruct lower device to use last 4-bytes of skb data as FCS */
-    #define TARGET_SO_NOFCS     43
-
-    /** sock_type - Socket types
-     *
-     * Please notice that for binary compat reasons ALPHA has to
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
-           TARGET_SOCK_STREAM      = 1,
-           TARGET_SOCK_DGRAM       = 2,
-           TARGET_SOCK_RAW         = 3,
-           TARGET_SOCK_RDM         = 4,
-           TARGET_SOCK_SEQPACKET   = 5,
-           TARGET_SOCK_DCCP        = 6,
-           TARGET_SOCK_PACKET      = 10,
-           TARGET_SOCK_CLOEXEC     = 010000000,
-           TARGET_SOCK_NONBLOCK    = 010000000000,
-    };
-
-    #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-    #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
 #else
 
 #if defined(TARGET_SPARC)
-- 
2.14.3
