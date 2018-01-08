Received: from eggs.gnu.org ([2001:4830:134:3::10]:50573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbl2-00054L-Kg
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbky-0006Az-LC
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:48 -0500
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:33491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbky-0006Ai-GP
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:02:44 -0500
Received: by mail-qt0-x22d.google.com with SMTP id e2so14673627qti.0
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 10:02:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 15:02:26 -0300
Message-Id: <20180108180231.21122-3-f4bug@amsat.org>
In-Reply-To: <20180108180231.21122-1-f4bug@amsat.org>
References: <20180108180231.21122-1-f4bug@amsat.org>
Subject: [Qemu-devel] [PATCH 2/7] net/eth: use the QEMU_PACKED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

---
 include/net/eth.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/net/eth.h b/include/net/eth.h
index 09054a506d..87c6499f18 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -36,12 +36,12 @@ struct eth_header {
     uint8_t  h_dest[ETH_ALEN];   /* destination eth addr */
     uint8_t  h_source[ETH_ALEN]; /* source ether addr    */
     uint16_t h_proto;            /* packet type ID field */
-};
+} QEMU_PACKED;
 
 struct vlan_header {
     uint16_t  h_tci;     /* priority and VLAN ID  */
     uint16_t  h_proto;   /* encapsulated protocol */
-};
+} QEMU_PACKED;
 
 struct ip_header {
     uint8_t  ip_ver_len;     /* version and header length */
@@ -53,9 +53,9 @@ struct ip_header {
     uint8_t  ip_p;           /* protocol */
     uint16_t ip_sum;         /* checksum */
     uint32_t ip_src, ip_dst; /* source and destination address */
-};
+} QEMU_PACKED;
 
-typedef struct tcp_header {
+typedef struct QEMU_PACKED tcp_header {
     uint16_t th_sport;          /* source port */
     uint16_t th_dport;          /* destination port */
     uint32_t th_seq;            /* sequence number */
@@ -77,14 +77,14 @@ typedef struct tcp_header {
 #define TCP_HEADER_DATA_OFFSET(tcp) \
     (((be16_to_cpu((tcp)->th_offset_flags) >> 12) & 0xf) << 2)
 
-typedef struct udp_header {
+typedef struct QEMU_PACKED udp_header {
     uint16_t uh_sport; /* source port */
     uint16_t uh_dport; /* destination port */
     uint16_t uh_ulen;  /* udp length */
     uint16_t uh_sum;   /* udp checksum */
 } udp_header;
 
-typedef struct ip_pseudo_header {
+typedef struct QEMU_PACKED ip_pseudo_header {
     uint32_t ip_src;
     uint32_t ip_dst;
     uint8_t  zeros;
@@ -116,9 +116,9 @@ struct ip6_header {
     } ip6_ctlun;
     struct in6_address ip6_src;    /* source address */
     struct in6_address ip6_dst;    /* destination address */
-};
+} QEMU_PACKED;
 
-typedef struct ip6_pseudo_header {
+typedef struct QEMU_PACKED ip6_pseudo_header {
     struct in6_address ip6_src;
     struct in6_address ip6_dst;
     uint32_t           len;
@@ -129,7 +129,7 @@ typedef struct ip6_pseudo_header {
 struct ip6_ext_hdr {
     uint8_t        ip6r_nxt;   /* next header */
     uint8_t        ip6r_len;   /* length in units of 8 octets */
-};
+} QEMU_PACKED;
 
 struct ip6_ext_hdr_routing {
     uint8_t     nxt;
@@ -137,21 +137,21 @@ struct ip6_ext_hdr_routing {
     uint8_t     rtype;
     uint8_t     segleft;
     uint8_t     rsvd[4];
-};
+} QEMU_PACKED;
 
 struct ip6_option_hdr {
 #define IP6_OPT_PAD1   (0x00)
 #define IP6_OPT_HOME   (0xC9)
     uint8_t type;
     uint8_t len;
-};
+} QEMU_PACKED;
 
 struct udp_hdr {
   uint16_t uh_sport;           /* source port */
   uint16_t uh_dport;           /* destination port */
   uint16_t uh_ulen;            /* udp length */
   uint16_t uh_sum;             /* udp checksum */
-};
+} QEMU_PACKED;
 
 struct tcp_hdr {
     u_short     th_sport;   /* source port */
@@ -180,7 +180,7 @@ struct tcp_hdr {
     u_short th_win;      /* window */
     u_short th_sum;      /* checksum */
     u_short th_urp;      /* urgent pointer */
-};
+} QEMU_PACKED;
 
 #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
 #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
-- 
2.15.1
