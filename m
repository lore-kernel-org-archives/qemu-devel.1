Received: from eggs.gnu.org ([2001:4830:134:3::10]:46563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCr-0007hX-Ew
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCq-0004tS-EN
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:05 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUCq-0004tJ-9I
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:04 -0500
Received: by mail-qt0-x243.google.com with SMTP id l7so14115901qtd.3
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:04 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:30 -0800
Message-Id: <20170123021748.13170-9-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 08/26] linux-user: Add HPPA socket.h definitions
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

Split this out into a "cpu/sockbits.h" file now,
like we ought to do for all of the other targets.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/hppa/sockbits.h | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 linux-user/socket.h        |  2 +
 2 files changed, 99 insertions(+)
 create mode 100644 linux-user/hppa/sockbits.h

diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
new file mode 100644
index 0000000..5044619
--- /dev/null
+++ b/linux-user/hppa/sockbits.h
@@ -0,0 +1,97 @@
+#define TARGET_SOL_SOCKET      0xffff
+
+#define TARGET_SO_DEBUG        0x0001
+#define TARGET_SO_REUSEADDR    0x0004
+#define TARGET_SO_KEEPALIVE    0x0008
+#define TARGET_SO_DONTROUTE    0x0010
+#define TARGET_SO_BROADCAST    0x0020
+#define TARGET_SO_LINGER       0x0080
+#define TARGET_SO_OOBINLINE    0x0100
+#define TARGET_SO_REUSEPORT    0x0200
+#define TARGET_SO_SNDBUF       0x1001
+#define TARGET_SO_RCVBUF       0x1002
+#define TARGET_SO_SNDBUFFORCE  0x100a
+#define TARGET_SO_RCVBUFFORCE  0x100b
+#define TARGET_SO_SNDLOWAT     0x1003
+#define TARGET_SO_RCVLOWAT     0x1004
+#define TARGET_SO_SNDTIMEO     0x1005
+#define TARGET_SO_RCVTIMEO     0x1006
+#define TARGET_SO_ERROR        0x1007
+#define TARGET_SO_TYPE         0x1008
+#define TARGET_SO_PROTOCOL     0x1028
+#define TARGET_SO_DOMAIN       0x1029
+#define TARGET_SO_PEERNAME     0x2000
+#define TARGET_SO_NO_CHECK     0x400b
+#define TARGET_SO_PRIORITY     0x400c
+#define TARGET_SO_BSDCOMPAT    0x400e
+#define TARGET_SO_PASSCRED     0x4010
+#define TARGET_SO_PEERCRED     0x4011
+#define TARGET_SO_TIMESTAMP    0x4012
+#define TARGET_SCM_TIMESTAMP   TARGET_SO_TIMESTAMP
+#define TARGET_SO_TIMESTAMPNS  0x4013
+#define TARGET_SCM_TIMESTAMPNS TARGET_SO_TIMESTAMPNS
+
+#define TARGET_SO_SECURITY_AUTHENTICATION              0x4016
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        0x4017
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          0x4018
+
+#define TARGET_SO_BINDTODEVICE         0x4019
+#define TARGET_SO_ATTACH_FILTER        0x401a
+#define TARGET_SO_DETACH_FILTER        0x401b
+#define TARGET_SO_GET_FILTER           TARGET_SO_ATTACH_FILTER
+#define TARGET_SO_ACCEPTCONN           0x401c
+#define TARGET_SO_PEERSEC              0x401d
+#define TARGET_SO_PASSSEC              0x401e
+#define TARGET_SO_MARK                 0x401f
+#define TARGET_SO_TIMESTAMPING         0x4020
+#define TARGET_SCM_TIMESTAMPING        TARGET_SO_TIMESTAMPING
+#define TARGET_SO_RXQ_OVFL             0x4021
+#define TARGET_SO_WIFI_STATUS          0x4022
+#define TARGET_SCM_WIFI_STATUS         TARGET_SO_WIFI_STATUS
+#define TARGET_SO_PEEK_OFF             0x4023
+#define TARGET_SO_NOFCS                0x4024
+#define TARGET_SO_LOCK_FILTER          0x4025
+#define TARGET_SO_SELECT_ERR_QUEUE     0x4026
+#define TARGET_SO_BUSY_POLL            0x4027
+#define TARGET_SO_MAX_PACING_RATE      0x4028
+#define TARGET_SO_BPF_EXTENSIONS       0x4029
+#define TARGET_SO_INCOMING_CPU         0x402A
+#define TARGET_SO_ATTACH_BPF           0x402B
+#define TARGET_SO_DETACH_BPF           TARGET_SO_DETACH_FILTER
+
+#define TARGET_SO_ATTACH_REUSEPORT_CBPF        0x402C
+#define TARGET_SO_ATTACH_REUSEPORT_EBPF        0x402D
+
+#define TARGET_SO_CNX_ADVICE           0x402E
+
+/** sock_type - Socket types - default values
+ *
+ *
+ * @SOCK_STREAM - stream (connection) socket
+ * @SOCK_DGRAM - datagram (conn.less) socket
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
+enum sock_type {
+   TARGET_SOCK_STREAM      = 1,
+   TARGET_SOCK_DGRAM       = 2,
+   TARGET_SOCK_RAW         = 3,
+   TARGET_SOCK_RDM         = 4,
+   TARGET_SOCK_SEQPACKET   = 5,
+   TARGET_SOCK_DCCP        = 6,
+   TARGET_SOCK_PACKET      = 10,
+   TARGET_SOCK_CLOEXEC     = 010000000,
+   TARGET_SOCK_NONBLOCK    = 0x40000000,
+};
+
+#define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
+#define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
+
+#define ARCH_HAS_SOCKET_TYPES 1
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 4dacae6..7051cd2 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -205,6 +205,8 @@
 
     #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
     #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
+#elif defined(TARGET_HPPA)
+#include <hppa/sockbits.h>
 #else
 
 #if defined(TARGET_SPARC)
-- 
2.9.3
