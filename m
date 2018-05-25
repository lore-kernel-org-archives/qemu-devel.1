Received: from eggs.gnu.org ([2001:4830:134:3::10]:38494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vf-0001mh-2P
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fM7vb-0008JE-L3
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:27 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fM7vb-0008IO-BO
	for qemu-devel@nongnu.org; Fri, 25 May 2018 04:18:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 25 May 2018 10:17:52 +0200
Message-Id: <20180525081754.29506-12-laurent@vivier.eu>
In-Reply-To: <20180525081754.29506-1-laurent@vivier.eu>
References: <20180525081754.29506-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 11/13] linux-user: copy sparc/sockbits.h
 definitions from linux
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

Values defined for sparc are not correct.
Copy the content of "arch/sparc/include/uapi/asm/socket.h"
to fix them.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180519092956.15134-8-laurent@vivier.eu>
---
 linux-user/sparc/sockbits.h | 131 +++++++++++++++++++++++++++++++-------------
 1 file changed, 92 insertions(+), 39 deletions(-)

diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
index 6434b07033..0a822e3e1f 100644
--- a/linux-user/sparc/sockbits.h
+++ b/linux-user/sparc/sockbits.h
@@ -8,51 +8,104 @@
 #ifndef SPARC_SOCKBITS_H
 #define SPARC_SOCKBITS_H
 
-#define TARGET_SO_PASSSEC        31
-
 /* For setsockopt(2) */
-#define TARGET_SOL_SOCKET      1
-
-#define TARGET_SO_DEBUG        1
-#define TARGET_SO_REUSEADDR    2
-#define TARGET_SO_TYPE         3
-#define TARGET_SO_ERROR        4
-#define TARGET_SO_DONTROUTE    5
-#define TARGET_SO_BROADCAST    6
-#define TARGET_SO_SNDBUF       7
-#define TARGET_SO_RCVBUF       8
-#define TARGET_SO_SNDBUFFORCE  32
-#define TARGET_SO_RCVBUFFORCE  33
-#define TARGET_SO_KEEPALIVE    9
-#define TARGET_SO_OOBINLINE    10
-#define TARGET_SO_NO_CHECK     11
-#define TARGET_SO_PRIORITY     12
-#define TARGET_SO_LINGER       13
-#define TARGET_SO_BSDCOMPAT    14
-/* To add :#define TARGET_SO_REUSEPORT 15 */
-#define TARGET_SO_PASSCRED     16
-#define TARGET_SO_PEERCRED     17
-#define TARGET_SO_RCVLOWAT     18
-#define TARGET_SO_SNDLOWAT     19
-#define TARGET_SO_RCVTIMEO     20
-#define TARGET_SO_SNDTIMEO     21
+#define TARGET_SOL_SOCKET      0xffff
 
-/* Security levels - as per NRL IPv6 - don't actually do anything */
-#define TARGET_SO_SECURITY_AUTHENTICATION              22
-#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        23
-#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          24
+#define TARGET_SO_DEBUG        0x0001
+#define TARGET_SO_PASSCRED     0x0002
+#define TARGET_SO_REUSEADDR    0x0004
+#define TARGET_SO_KEEPALIVE    0x0008
+#define TARGET_SO_DONTROUTE    0x0010
+#define TARGET_SO_BROADCAST    0x0020
+#define TARGET_SO_PEERCRED     0x0040
+#define TARGET_SO_LINGER       0x0080
+#define TARGET_SO_OOBINLINE    0x0100
+#define TARGET_SO_REUSEPORT    0x0200
+#define TARGET_SO_BSDCOMPAT    0x0400
+#define TARGET_SO_RCVLOWAT     0x0800
+#define TARGET_SO_SNDLOWAT     0x1000
+#define TARGET_SO_RCVTIMEO     0x2000
+#define TARGET_SO_SNDTIMEO     0x4000
+#define TARGET_SO_ACCEPTCONN   0x8000
+
+#define TARGET_SO_SNDBUF       0x1001
+#define TARGET_SO_RCVBUF       0x1002
+#define TARGET_SO_SNDBUFFORCE  0x100a
+#define TARGET_SO_RCVBUFFORCE  0x100b
+#define TARGET_SO_ERROR        0x1007
+#define TARGET_SO_TYPE         0x1008
+#define TARGET_SO_PROTOCOL     0x1028
+#define TARGET_SO_DOMAIN       0x1029
+
+/* Linux specific, keep the same. */
+#define TARGET_SO_NO_CHECK     0x000b
+#define TARGET_SO_PRIORITY     0x000c
 
-#define TARGET_SO_BINDTODEVICE 25
+#define TARGET_SO_BINDTODEVICE 0x000d
 
-/* Socket filtering */
-#define TARGET_SO_ATTACH_FILTER        26
-#define TARGET_SO_DETACH_FILTER        27
+#define TARGET_SO_ATTACH_FILTER        0x001a
+#define TARGET_SO_DETACH_FILTER        0x001b
+#define TARGET_SO_GET_FILTER           TARGET_SO_ATTACH_FILTER
 
-#define TARGET_SO_PEERNAME             28
-#define TARGET_SO_TIMESTAMP            29
+#define TARGET_SO_PEERNAME             0x001c
+#define TARGET_SO_TIMESTAMP            0x001d
 #define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
 
-#define TARGET_SO_ACCEPTCONN           30
+#define TARGET_SO_PEERSEC              0x001e
+#define TARGET_SO_PASSSEC              0x001f
+#define TARGET_SO_TIMESTAMPNS          0x0021
+#define TARGET_SCM_TIMESTAMPNS         TARGET_SO_TIMESTAMPNS
+
+#define TARGET_SO_MARK                 0x0022
+
+#define TARGET_SO_TIMESTAMPING         0x0023
+#define TARGET_SCM_TIMESTAMPING        TARGET_SO_TIMESTAMPING
+
+#define TARGET_SO_RXQ_OVFL             0x0024
+
+#define TARGET_SO_WIFI_STATUS          0x0025
+#define TARGET_SCM_WIFI_STATUS         TARGET_SO_WIFI_STATUS
+#define TARGET_SO_PEEK_OFF             0x0026
+
+/* Instruct lower device to use last 4-bytes of skb data as FCS */
+#define TARGET_SO_NOFCS                0x0027
+
+#define TARGET_SO_LOCK_FILTER          0x0028
+
+#define TARGET_SO_SELECT_ERR_QUEUE     0x0029
+
+#define TARGET_SO_BUSY_POLL            0x0030
+
+#define TARGET_SO_MAX_PACING_RATE      0x0031
 
-#define TARGET_SO_PEERSEC              31
+#define TARGET_SO_BPF_EXTENSIONS       0x0032
+
+#define TARGET_SO_INCOMING_CPU         0x0033
+
+#define TARGET_SO_ATTACH_BPF           0x0034
+#define TARGET_SO_DETACH_BPF           TARGET_SO_DETACH_FILTER
+
+#define TARGET_SO_ATTACH_REUSEPORT_CBPF        0x0035
+#define TARGET_SO_ATTACH_REUSEPORT_EBPF        0x0036
+
+#define TARGET_SO_CNX_ADVICE           0x0037
+
+#define TARGET_SCM_TIMESTAMPING_OPT_STATS      0x0038
+
+#define TARGET_SO_MEMINFO              0x0039
+
+#define TARGET_SO_INCOMING_NAPI_ID     0x003a
+
+#define TARGET_SO_COOKIE               0x003b
+
+#define TARGET_SCM_TIMESTAMPING_PKTINFO        0x003c
+
+#define TARGET_SO_PEERGROUPS           0x003d
+
+#define TARGET_SO_ZEROCOPY             0x003e
+
+/* Security levels - as per NRL IPv6 - don't actually do anything */
+#define TARGET_SO_SECURITY_AUTHENTICATION              0x5001
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        0x5002
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          0x5004
 #endif
-- 
2.14.3
