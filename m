Received: from eggs.gnu.org ([2001:4830:134:3::10]:44025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcf6-0007gc-0a
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcf3-0001tB-OB
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:40 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dwcf3-0001s6-G6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:37 -0400
Received: by mail-pf0-x242.google.com with SMTP id h4so4230320pfk.0
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:19:37 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Mon, 25 Sep 2017 16:19:19 -0700
Message-Id: <20170925231924.31303-2-carenas@gmail.com>
In-Reply-To: <20170925231924.31303-1-carenas@gmail.com>
References: <20170925231924.31303-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/6] linux-user: update hppa sockbits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

updated to match arch/parisc/include/uapi/asm/socket.h from linux 4.14
include in socket.h changed to prefer a local path like all other qemu
headers and for consistency and clarity when adding all other arch

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/hppa/sockbits.h | 148 +++++++++++++++++++++++----------------------
 linux-user/socket.h        |   2 +-
 2 files changed, 78 insertions(+), 72 deletions(-)

diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
index 5044619e16..3dab31a76a 100644
--- a/linux-user/hppa/sockbits.h
+++ b/linux-user/hppa/sockbits.h
@@ -1,71 +1,77 @@
-#define TARGET_SOL_SOCKET      0xffff
+#define TARGET_SOL_SOCKET                       0xffff
 
-#define TARGET_SO_DEBUG        0x0001
-#define TARGET_SO_REUSEADDR    0x0004
-#define TARGET_SO_KEEPALIVE    0x0008
-#define TARGET_SO_DONTROUTE    0x0010
-#define TARGET_SO_BROADCAST    0x0020
-#define TARGET_SO_LINGER       0x0080
-#define TARGET_SO_OOBINLINE    0x0100
-#define TARGET_SO_REUSEPORT    0x0200
-#define TARGET_SO_SNDBUF       0x1001
-#define TARGET_SO_RCVBUF       0x1002
-#define TARGET_SO_SNDBUFFORCE  0x100a
-#define TARGET_SO_RCVBUFFORCE  0x100b
-#define TARGET_SO_SNDLOWAT     0x1003
-#define TARGET_SO_RCVLOWAT     0x1004
-#define TARGET_SO_SNDTIMEO     0x1005
-#define TARGET_SO_RCVTIMEO     0x1006
-#define TARGET_SO_ERROR        0x1007
-#define TARGET_SO_TYPE         0x1008
-#define TARGET_SO_PROTOCOL     0x1028
-#define TARGET_SO_DOMAIN       0x1029
-#define TARGET_SO_PEERNAME     0x2000
-#define TARGET_SO_NO_CHECK     0x400b
-#define TARGET_SO_PRIORITY     0x400c
-#define TARGET_SO_BSDCOMPAT    0x400e
-#define TARGET_SO_PASSCRED     0x4010
-#define TARGET_SO_PEERCRED     0x4011
-#define TARGET_SO_TIMESTAMP    0x4012
-#define TARGET_SCM_TIMESTAMP   TARGET_SO_TIMESTAMP
-#define TARGET_SO_TIMESTAMPNS  0x4013
-#define TARGET_SCM_TIMESTAMPNS TARGET_SO_TIMESTAMPNS
+#define TARGET_SO_DEBUG                         0x0001
+#define TARGET_SO_REUSEADDR                     0x0004
+#define TARGET_SO_KEEPALIVE                     0x0008
+#define TARGET_SO_DONTROUTE                     0x0010
+#define TARGET_SO_BROADCAST                     0x0020
+#define TARGET_SO_LINGER                        0x0080
+#define TARGET_SO_OOBINLINE                     0x0100
+#define TARGET_SO_REUSEPORT                     0x0200
+#define TARGET_SO_SNDBUF                        0x1001
+#define TARGET_SO_RCVBUF                        0x1002
+#define TARGET_SO_SNDBUFFORCE                   0x100a
+#define TARGET_SO_RCVBUFFORCE                   0x100b
+#define TARGET_SO_SNDLOWAT                      0x1003
+#define TARGET_SO_RCVLOWAT                      0x1004
+#define TARGET_SO_SNDTIMEO                      0x1005
+#define TARGET_SO_RCVTIMEO                      0x1006
+#define TARGET_SO_ERROR                         0x1007
+#define TARGET_SO_TYPE                          0x1008
+#define TARGET_SO_PROTOCOL                      0x1028
+#define TARGET_SO_DOMAIN                        0x1029
+#define TARGET_SO_PEERNAME                      0x2000
+#define TARGET_SO_NO_CHECK                      0x400b
+#define TARGET_SO_PRIORITY                      0x400c
+#define TARGET_SO_BSDCOMPAT                     0x400e
+#define TARGET_SO_PASSCRED                      0x4010
+#define TARGET_SO_PEERCRED                      0x4011
+#define TARGET_SO_TIMESTAMP                     0x4012
+#define TARGET_SCM_TIMESTAMP                    TARGET_SO_TIMESTAMP
+#define TARGET_SO_TIMESTAMPNS                   0x4013
+#define TARGET_SCM_TIMESTAMPNS                  TARGET_SO_TIMESTAMPNS
 
-#define TARGET_SO_SECURITY_AUTHENTICATION              0x4016
-#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        0x4017
-#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          0x4018
+#define TARGET_SO_SECURITY_AUTHENTICATION       0x4016
+#define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT 0x4017
+#define TARGET_SO_SECURITY_ENCRYPTION_NETWORK   0x4018
 
-#define TARGET_SO_BINDTODEVICE         0x4019
-#define TARGET_SO_ATTACH_FILTER        0x401a
-#define TARGET_SO_DETACH_FILTER        0x401b
-#define TARGET_SO_GET_FILTER           TARGET_SO_ATTACH_FILTER
-#define TARGET_SO_ACCEPTCONN           0x401c
-#define TARGET_SO_PEERSEC              0x401d
-#define TARGET_SO_PASSSEC              0x401e
-#define TARGET_SO_MARK                 0x401f
-#define TARGET_SO_TIMESTAMPING         0x4020
-#define TARGET_SCM_TIMESTAMPING        TARGET_SO_TIMESTAMPING
-#define TARGET_SO_RXQ_OVFL             0x4021
-#define TARGET_SO_WIFI_STATUS          0x4022
-#define TARGET_SCM_WIFI_STATUS         TARGET_SO_WIFI_STATUS
-#define TARGET_SO_PEEK_OFF             0x4023
-#define TARGET_SO_NOFCS                0x4024
-#define TARGET_SO_LOCK_FILTER          0x4025
-#define TARGET_SO_SELECT_ERR_QUEUE     0x4026
-#define TARGET_SO_BUSY_POLL            0x4027
-#define TARGET_SO_MAX_PACING_RATE      0x4028
-#define TARGET_SO_BPF_EXTENSIONS       0x4029
-#define TARGET_SO_INCOMING_CPU         0x402A
-#define TARGET_SO_ATTACH_BPF           0x402B
-#define TARGET_SO_DETACH_BPF           TARGET_SO_DETACH_FILTER
+#define TARGET_SO_BINDTODEVICE                  0x4019
+#define TARGET_SO_ATTACH_FILTER                 0x401a
+#define TARGET_SO_DETACH_FILTER                 0x401b
+#define TARGET_SO_GET_FILTER                    TARGET_SO_ATTACH_FILTER
+#define TARGET_SO_ACCEPTCONN                    0x401c
+#define TARGET_SO_PEERSEC                       0x401d
+#define TARGET_SO_PASSSEC                       0x401e
+#define TARGET_SO_MARK                          0x401f
+#define TARGET_SO_TIMESTAMPING                  0x4020
+#define TARGET_SCM_TIMESTAMPING                 TARGET_SO_TIMESTAMPING
+#define TARGET_SO_RXQ_OVFL                      0x4021
+#define TARGET_SO_WIFI_STATUS                   0x4022
+#define TARGET_SCM_WIFI_STATUS                  TARGET_SO_WIFI_STATUS
+#define TARGET_SO_PEEK_OFF                      0x4023
+#define TARGET_SO_NOFCS                         0x4024
+#define TARGET_SO_LOCK_FILTER                   0x4025
+#define TARGET_SO_SELECT_ERR_QUEUE              0x4026
+#define TARGET_SO_BUSY_POLL                     0x4027
+#define TARGET_SO_MAX_PACING_RATE               0x4028
+#define TARGET_SO_BPF_EXTENSIONS                0x4029
+#define TARGET_SO_INCOMING_CPU                  0x402A
+#define TARGET_SO_ATTACH_BPF                    0x402B
+#define TARGET_SO_DETACH_BPF                    TARGET_SO_DETACH_FILTER
 
-#define TARGET_SO_ATTACH_REUSEPORT_CBPF        0x402C
-#define TARGET_SO_ATTACH_REUSEPORT_EBPF        0x402D
+#define TARGET_SO_ATTACH_REUSEPORT_CBPF         0x402C
+#define TARGET_SO_ATTACH_REUSEPORT_EBPF         0x402D
 
-#define TARGET_SO_CNX_ADVICE           0x402E
+#define TARGET_SO_CNX_ADVICE                    0x402E
+#define TARGET_SCM_TIMESTAMPING_OPT_STATS       0x402F
+#define TARGET_SO_MEMINFO                       0x4030
+#define TARGET_SO_INCOMING_NAPI_ID              0x4031
+#define TARGET_SO_COOKIE                        0x4032
+#define TARGET_SCM_TIMESTAMPING_PKTINFO         0x4033
+#define TARGET_SO_PEERGROUPS                    0x4034
+#define TARGET_SO_ZEROCOPY                      0x4035
 
 /** sock_type - Socket types - default values
- *
  *
  * @SOCK_STREAM - stream (connection) socket
  * @SOCK_DGRAM - datagram (conn.less) socket
@@ -80,18 +86,18 @@
  * @SOCK_NONBLOCK - sets the O_NONBLOCK file status flag.
  */
 enum sock_type {
-   TARGET_SOCK_STREAM      = 1,
-   TARGET_SOCK_DGRAM       = 2,
-   TARGET_SOCK_RAW         = 3,
-   TARGET_SOCK_RDM         = 4,
-   TARGET_SOCK_SEQPACKET   = 5,
-   TARGET_SOCK_DCCP        = 6,
-   TARGET_SOCK_PACKET      = 10,
-   TARGET_SOCK_CLOEXEC     = 010000000,
-   TARGET_SOCK_NONBLOCK    = 0x40000000,
+    TARGET_SOCK_STREAM    = 1,
+    TARGET_SOCK_DGRAM     = 2,
+    TARGET_SOCK_RAW       = 3,
+    TARGET_SOCK_RDM       = 4,
+    TARGET_SOCK_SEQPACKET = 5,
+    TARGET_SOCK_DCCP      = 6,
+    TARGET_SOCK_PACKET    = 10,
+    TARGET_SOCK_CLOEXEC   = 010000000,
+    TARGET_SOCK_NONBLOCK  = 0x40000000,
 };
 
 #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-#define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
+#define TARGET_SOCK_TYPE_MASK 0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
 
 #define ARCH_HAS_SOCKET_TYPES 1
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 7051cd2cf4..c7e6cb8ea1 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -206,7 +206,7 @@
     #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
     #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
 #elif defined(TARGET_HPPA)
-#include <hppa/sockbits.h>
+#include "hppa/sockbits.h"
 #else
 
 #if defined(TARGET_SPARC)
-- 
2.14.1
