Received: from eggs.gnu.org ([209.51.188.92]:57149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66G-0005SX-LY
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gk66E-0004Tz-DT
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gk66E-0004Rs-2H
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 06:44:42 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 17 Jan 2019 15:43:39 +0400
Message-Id: <20190117114359.5164-8-marcandre.lureau@redhat.com>
In-Reply-To: <20190117114359.5164-1-marcandre.lureau@redhat.com>
References: <20190117114359.5164-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/27] slirp: replace QEMU_PACKED with
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
Cc: Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, pbonzini@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/ip.h       | 14 +++++++-------
 slirp/ip6.h      |  4 ++--
 slirp/ip6_icmp.h | 16 ++++++++--------
 slirp/slirp.h    |  5 +++--
 slirp/util.h     | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 52 insertions(+), 19 deletions(-)
 create mode 100644 slirp/util.h

diff --git a/slirp/ip.h b/slirp/ip.h
index 243b6c8b249..cd6ddf2bb7a 100644
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
@@ -217,7 +217,7 @@ struct ipq {
 	uint8_t	ipq_p;			/* protocol of this fragment */
 	uint16_t	ipq_id;			/* sequence id for reassembly */
 	struct	in_addr ipq_src,ipq_dst;
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 /*
  * Ip header, when holding a fragment.
@@ -227,7 +227,7 @@ struct ipq {
 struct	ipasfrag {
 	struct qlink ipf_link;
 	struct ip ipf_ip;
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 #define ipf_off      ipf_ip.ip_off
 #define ipf_tos      ipf_ip.ip_tos
diff --git a/slirp/ip6.h b/slirp/ip6.h
index 14e9c787357..b6ba0a63927 100644
--- a/slirp/ip6.h
+++ b/slirp/ip6.h
@@ -133,7 +133,7 @@ struct ip6 {
     uint8_t     ip_nh;               /* next header */
     uint8_t     ip_hl;               /* hop limit */
     struct in6_addr ip_src, ip_dst;  /* source and dest address */
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 /*
  * IPv6 pseudo-header used by upper-layer protocols
@@ -145,7 +145,7 @@ struct ip6_pseudohdr {
     uint16_t    ih_zero_hi;       /* zero */
     uint8_t     ih_zero_lo;       /* zero */
     uint8_t     ih_nh;            /* next header */
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
=20
 #endif
diff --git a/slirp/ip6_icmp.h b/slirp/ip6_icmp.h
index 32b0914055a..1f09b485e32 100644
--- a/slirp/ip6_icmp.h
+++ b/slirp/ip6_icmp.h
@@ -48,12 +48,12 @@ struct ndp_ra {     /* Router Advertisement Message *=
/
     uint16_t lifetime;      /* Router Lifetime */
     uint32_t reach_time;    /* Reachable Time */
     uint32_t retrans_time;  /* Retrans Timer */
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 struct ndp_ns {     /* Neighbor Solicitation Message */
     uint32_t reserved;
     struct in6_addr target; /* Target Address */
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 struct ndp_na {     /* Neighbor Advertisement Message */
 #if G_BYTE_ORDER =3D=3D G_BIG_ENDIAN
@@ -72,13 +72,13 @@ struct ndp_na {     /* Neighbor Advertisement Message=
 */
         reserved_lo:24;
 #endif
     struct in6_addr target; /* Target Address */
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 struct ndp_redirect {
     uint32_t reserved;
     struct in6_addr target; /* Target Address */
     struct in6_addr dest;   /* Destination Address */
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 /*
  * Structure of an icmpv6 header.
@@ -103,7 +103,7 @@ struct icmp6 {
 #define icmp6_nns icmp6_body.ndp_ns
 #define icmp6_nna icmp6_body.ndp_na
 #define icmp6_redirect icmp6_body.ndp_redirect
-} QEMU_PACKED;
+} SLIRP_PACKED;
=20
 #define ICMP6_MINLEN    4
 #define ICMP6_ERROR_MINLEN  8
@@ -134,16 +134,16 @@ struct ndpopt {
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
index 17056f4b836..67ff4d610c4 100644
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
index 00000000000..00291c30a67
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
2.20.1.98.gecbdaf0899
