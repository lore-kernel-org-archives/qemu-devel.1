Received: from eggs.gnu.org ([209.51.188.92]:52620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCE-0001Qa-UH
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gnjCB-0007RI-GZ
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:53 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:46438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gnjCB-0007Ox-3z
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:05:51 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 27 Jan 2019 13:05:05 +0100
Message-Id: <20190127120526.15457-11-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
References: <20190127120526.15457-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/31] slirp: replace QEMU_PACKED with
 SLIRP_PACKED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/ip.h       | 10 +++++-----
 slirp/ip6_icmp.h |  6 +++---
 slirp/slirp.h    |  5 +++--
 slirp/util.h     | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 10 deletions(-)
 create mode 100644 slirp/util.h

diff --git a/slirp/ip.h b/slirp/ip.h
index 20614f3b53..2baeeb9a3a 100644
--- a/slirp/ip.h
+++ b/slirp/ip.h
@@ -89,7 +89,7 @@ struct ip {
 	uint8_t ip_p;			/* protocol */
 	uint16_t	ip_sum;			/* checksum */
 	struct	in_addr ip_src,ip_dst;	/* source and dest address */
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 #define	IP_MAXPACKET	65535		/* maximum packet size */
=20
@@ -151,7 +151,7 @@ struct	ip_timestamp {
 			n_long ipt_time;
 		} ipt_ta[1];
 	} ipt_timestamp;
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 /* flag bits for ipt_flg */
 #define	IPOPT_TS_TSONLY		0		/* timestamps only */
@@ -181,11 +181,11 @@ struct	ip_timestamp {
 struct mbuf_ptr {
 	struct mbuf *mptr;
 	uint32_t dummy;
-} QEMU_PACKED;
+} SLIRP_PACKED;
 #else
 struct mbuf_ptr {
 	struct mbuf *mptr;
-} QEMU_PACKED;
+} SLIRP_PACKED;
 #endif
 struct qlink {
 	void *next, *prev;
@@ -201,7 +201,7 @@ struct ipovly {
 	uint16_t	ih_len;			/* protocol length */
 	struct	in_addr ih_src;		/* source internet address */
 	struct	in_addr ih_dst;		/* destination internet address */
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 /*
  * Ip reassembly queue structure.  Each fragment
diff --git a/slirp/ip6_icmp.h b/slirp/ip6_icmp.h
index 2ad2b75e67..3f44ed2f49 100644
--- a/slirp/ip6_icmp.h
+++ b/slirp/ip6_icmp.h
@@ -144,16 +144,16 @@ struct ndpopt {
             uint32_t    pref_lt;                /* Preferred Lifetime */
             uint32_t    reserved2;
             struct in6_addr prefix;
-        } QEMU_PACKED prefixinfo;
+        } SLIRP_PACKED prefixinfo;
 #define ndpopt_prefixinfo ndpopt_body.prefixinfo
         struct rdnss {
             uint16_t reserved;
             uint32_t lifetime;
             struct in6_addr addr;
-        } QEMU_PACKED rdnss;
+        } SLIRP_PACKED rdnss;
 #define ndpopt_rdnss ndpopt_body.rdnss
     } ndpopt_body;
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 /* NDP options type */
 #define NDPOPT_LINKLAYER_SOURCE     1   /* Source Link-Layer Address */
diff --git a/slirp/slirp.h b/slirp/slirp.h
index 17056f4b83..67ff4d610c 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -45,6 +45,7 @@ typedef char *caddr_t;
 #define quehead slirp_quehead
=20
 #include "debug.h"
+#include "util.h"
=20
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
@@ -93,7 +94,7 @@ struct slirp_arphdr {
     uint32_t      ar_sip;           /* sender IP address       */
     unsigned char ar_tha[ETH_ALEN]; /* target hardware address */
     uint32_t      ar_tip;           /* target IP address       */
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 #define ARP_TABLE_SIZE 16
=20
@@ -110,7 +111,7 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_addr,
 struct ndpentry {
     unsigned char   eth_addr[ETH_ALEN];     /* sender hardware address *=
/
     struct in6_addr ip_addr;                /* sender IP address       *=
/
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 #define NDP_TABLE_SIZE 16
=20
diff --git a/slirp/util.h b/slirp/util.h
new file mode 100644
index 0000000000..00291c30a6
--- /dev/null
+++ b/slirp/util.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ * Copyright (c) 2010-2019 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+#ifndef UTIL_H_
+#define UTIL_H_
+
+#if defined(_WIN32)
+# define SLIRP_PACKED __attribute__((gcc_struct, packed))
+#else
+# define SLIRP_PACKED __attribute__((packed))
+#endif
+
+#endif
--=20
2.20.1
