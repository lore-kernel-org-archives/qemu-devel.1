Received: from eggs.gnu.org ([2001:4830:134:3::10]:44102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcfA-0007jY-Rq
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwcfA-00022S-0N
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:44 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dwcf9-00021X-RA
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:19:43 -0400
Received: by mail-pg0-x242.google.com with SMTP id v5so5671674pgn.4
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:19:43 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Mon, 25 Sep 2017 16:19:23 -0700
Message-Id: <20170925231924.31303-6-carenas@gmail.com>
In-Reply-To: <20170925231924.31303-5-carenas@gmail.com>
References: <20170925231924.31303-1-carenas@gmail.com>
	<20170925231924.31303-2-carenas@gmail.com>
	<20170925231924.31303-3-carenas@gmail.com>
	<20170925231924.31303-4-carenas@gmail.com>
	<20170925231924.31303-5-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/6] linux-user: update default socket.h
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

enable SO_REUSEPORT as a sideeffect and add SO_GET_FILTER alias

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/socket.h | 59 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/linux-user/socket.h b/linux-user/socket.h
index dfa692286b..6f49255b5f 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -27,7 +27,7 @@
     #define TARGET_SO_PRIORITY     12
     #define TARGET_SO_LINGER       13
     #define TARGET_SO_BSDCOMPAT    14
-    /* To add :#define TARGET_SO_REUSEPORT 15 */
+    #define TARGET_SO_REUSEPORT    15
 #if defined(TARGET_PPC)
     #define TARGET_SO_RCVLOWAT     16
     #define TARGET_SO_SNDLOWAT     17
@@ -49,21 +49,58 @@
     #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        23
     #define TARGET_SO_SECURITY_ENCRYPTION_NETWORK          24
 
-    #define TARGET_SO_BINDTODEVICE 25
+    #define TARGET_SO_BINDTODEVICE            25
 
     /* Socket filtering */
-    #define TARGET_SO_ATTACH_FILTER        26
-    #define TARGET_SO_DETACH_FILTER        27
+    #define TARGET_SO_ATTACH_FILTER           26
+    #define TARGET_SO_DETACH_FILTER           27
+    #define TARGET_SO_GET_FILTER              TARGET_SO_ATTACH_FILTER
 
-    #define TARGET_SO_PEERNAME             28
-    #define TARGET_SO_TIMESTAMP            29
-    #define TARGET_SCM_TIMESTAMP           TARGET_SO_TIMESTAMP
+    #define TARGET_SO_PEERNAME                28
+    #define TARGET_SO_TIMESTAMP               29
+    #define TARGET_SCM_TIMESTAMP              TARGET_SO_TIMESTAMP
 
-    #define TARGET_SO_ACCEPTCONN           30
+    #define TARGET_SO_ACCEPTCONN              30
 
-    #define TARGET_SO_PEERSEC              31
+    #define TARGET_SO_PEERSEC                 31
+    #define TARGET_SO_PASSSEC                 34
+    #define TARGET_SO_TIMESTAMPNS             35
+    #define TARGET_SCM_TIMESTAMPNS            TARGET_SO_TIMESTAMPNS
+
+    #define TARGET_SO_MARK                    36
+
+    #define TARGET_SO_TIMESTAMPING            37
+    #define TARGET_SCM_TIMESTAMPING           TARGET_SO_TIMESTAMPING
+
+    #define TARGET_SO_PROTOCOL                38
+    #define TARGET_SO_DOMAIN                  39
+
+    #define TARGET_SO_RXQ_OVFL                40
+
+    #define TARGET_SO_WIFI_STATUS             41
+    #define TARGET_SCM_WIFI_STATUS            TARGET_SO_WIFI_STATUS
+    #define TARGET_SO_PEEK_OFF                42
+
+    #define TARGET_SO_NOFCS                   43
+    #define TARGET_SO_LOCK_FILTER             44
+    #define TARGET_SO_SELECT_ERR_QUEUE        45
+    #define TARGET_SO_BUSY_POLL               46
+    #define TARGET_SO_MAX_PACING_RATE         47
+    #define TARGET_SO_BPF_EXTENSIONS          48
+    #define TARGET_SO_INCOMING_CPU            49
+    #define TARGET_SO_ATTACH_BPF              50
+    #define TARGET_SO_DETACH_BPF              TARGET_SO_DETACH_FILTER
+    #define TARGET_SO_ATTACH_REUSEPORT_CBPF   51
+    #define TARGET_SO_ATTACH_REUSEPORT_EBPF   52
+    #define TARGET_SO_CNX_ADVICE              53
+    #define TARGET_SCM_TIMESTAMPING_OPT_STATS 54
+    #define TARGET_SO_MEMINFO                 55
+    #define TARGET_SO_INCOMING_NAPI_ID        56
+    #define TARGET_SO_COOKIE                  57
+    #define TARGET_SCM_TIMESTAMPING_PKTINFO   58
+    #define TARGET_SO_PEERGROUPS              59
+    #define TARGET_SO_ZEROCOPY                60
 
-    #define TARGET_SO_PASSSEC              34
 #endif
 
 #ifndef ARCH_HAS_SOCKET_TYPES
@@ -94,6 +131,6 @@
     };
 
     #define TARGET_SOCK_MAX (TARGET_SOCK_PACKET + 1)
-    #define TARGET_SOCK_TYPE_MASK    0xf  /* Covers up to TARGET_SOCK_MAX-1. */
+    #define TARGET_SOCK_TYPE_MASK  0xf  /* Covers up to TARGET_SOCK_MAX - 1. */
 
 #endif
-- 
2.14.1
