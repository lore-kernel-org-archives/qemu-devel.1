Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE0C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2C42176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2C42176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaJN0-0006UC-9h
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 07:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaJFD-0001Lb-1Y
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Bilal_Wasim@mentor.com>) id 1iaJEq-0007O5-Ru
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:49:44 -0500
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:10524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Bilal_Wasim@mentor.com>)
 id 1iaJEn-0007F4-OV
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 07:49:38 -0500
IronPort-SDR: wodJaMmiJvQnCYEMqMdxorBiHIAAps3RZvLaDMUun2wGfJnv2DsWF5qSIPnMrZvpCKqZdPq/2a
 bKEmQIJb3XHk8ZxhrYDvC9vko4kSbMgFa8wKj1mmh/xi/eKexd78KwYxpJBpWv5P4OaFXvEC3z
 xm7ZuZpc7EKDQ3xRR+lnWZwgUPBc+Zcc2y/2h0sa6N57SjaVHWEpo3ZyKytdkCcS2lBKVF7P0e
 tf2brQSpTIduIW7xcGXaM4/WuO+aLBSK/oF/iD0Gl+XnLmwMkdPe/dS1ZDW6hrEktrNYQ6FLz0
 MBw=
X-IronPort-AV: E=Sophos;i="5.69,253,1571731200"; d="scan'208,217";a="43631364"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 28 Nov 2019 04:49:32 -0800
IronPort-SDR: H1o8IWMpEB4vsWodXcJgtJQCN/+RLr3OtRiNxsaMvf+KM+mesUohZT3itaOobPzIRsssjTTK5a
 kfVQ38w3k18lGKbYiPKZdsAheMslPl8LpChiI1etWKEozh7b8BgPYpa1Co6jKT/W96N3p/gwvq
 PM3OgQWusRrd0B5Xfm3U54eMW7UkkG0o+zPeIfamMHmA4LtoiBwSXM9PXdK0DCDP5TGUQWAEBe
 1xi47CFEJNpES7Ntpp/TLJDjngRy45WcdMgSfY0/MH0xLX79BkbWPNpAvNBqKLpQ4lwA4MEM9W
 +Xc=
From: "Wasim, Bilal" <Bilal_Wasim@mentor.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] Adding support for MAC filtering in the FEC IP implementation
Thread-Topic: [PATCH] Adding support for MAC filtering in the FEC IP
 implementation
Thread-Index: AQHVpenGG+H5kkbz0ECoeUMLi/ynzw==
Date: Thu, 28 Nov 2019 12:49:26 +0000
Message-ID: <1574945365996.88572@mentor.com>
Accept-Language: en-GB, en-IE, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: multipart/alternative;
 boundary="_000_157494536599688572mentorcom_"
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.137.252
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "aa1ronham@gmail.com" <aa1ronham@gmail.com>,
 "jcd@tribudubois.net" <jcd@tribudubois.net>, "Wasim,
 Bilal" <Bilal_Wasim@mentor.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_157494536599688572mentorcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

 Adding support for MAC filtering in the FEC IP
 implementation. This addition ensures that the IP does NOT boot up in
 promiscuous mode by default, and so the software only receives the desired
 packets(Unicast, Broadcast, Unicast / Multicast hashed) by default. The
 software running on-top of QEMU can also modify these settings and disable
 reception of broadcast frames or make the IP receive all packets (PROM mod=
e).
 This patch greatly reduces the number of packets received by the software
 running on-top of the QEMU model. Tested with the armv7-a SABRE_LITE machi=
ne.
 Testing included running a custom OS with IPv4 / IPv6 support. Hashing and
 filtering of packets is tested to work well. Skeleton taken from the
 CADENCE_GEM IP and hash generation algorithm from the Linux Kernel.

Signed-off-by: Bilal Wasim <bilal_wasim@mentor.com>
---
 hw/net/imx_fec.c         | 92 ++++++++++++++++++++++++++++++++++++++++++++=
+++-
 include/hw/net/imx_fec.h | 12 +++++++
 2 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index bd99236..96c52dd 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -419,6 +419,80 @@ static void imx_enet_write_bd(IMXENETBufDesc *bd, dma_=
addr_t addr)
     dma_memory_write(&address_space_memory, addr, bd, sizeof(*bd));
 }

+/*
+ * Calculate a FEC MAC Address hash index
+ */
+static unsigned calc_mac_hash(const uint8_t *mac, uint8_t mac_length)
+{
+    uint32_t crc =3D -1;
+    int i;
+
+    while (mac_length --) {
+        crc ^=3D *mac++;
+        for (i =3D 0; i < 8; i++) {
+            crc =3D (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
+        }
+    }
+
+    /* only upper 6 bits (FEC_HASH_BITS) are used
+     * which point to specific bit in the hash registers
+     */
+    return ((crc >> (32 - FEC_HASH_BITS)) & 0x3f);
+}
+
+/*
+ * fec_mac_address_filter:
+ * Accept or reject this destination address?
+ */
+static int fec_mac_address_filter(IMXFECState *s, const uint8_t *packet)
+{
+    const uint8_t broadcast_addr[] =3D { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xF=
F };
+    uint32_t addr1, addr2;
+    uint8_t  hash;
+
+    /* Promiscuous mode? */
+    if (s->regs[ENET_RCR] & ENET_RCR_PROM) {
+        return (FEC_RX_PROMISCUOUS_ACCEPT); /* Accept all packets in promi=
scuous mode (even if bc_rej is set). */
+    }
+
+    /* Broadcast packet? */
+    if (!memcmp(packet, broadcast_addr, 6)) {
+        /* Reject broadcast packets? */
+        if (s->regs[ENET_RCR] & ENET_RCR_BC_REJ) {
+            return (FEC_RX_REJECT);
+        }
+        return (FEC_RX_BROADCAST_ACCEPT); /* Accept packets from broadcast=
 address. */
+    }
+
+    /* Accept packets -w- hash match? */
+    hash =3D calc_mac_hash(packet, 6);
+
+    /* Accept packets -w- multicast hash match? */
+    if ((packet[0] & 0x01) =3D=3D 0x01) {
+        /* See if the computed hash matches a set bit in either GAUR / GAL=
R register. */
+        if (((hash < 32) && (s->regs[ENET_GALR] & (1 << hash)))
+                || ((hash > 31) && (s->regs[ENET_GAUR] & (1 << (hash-32)))=
)) {
+            return (FEC_RX_MULTICAST_HASH_ACCEPT); /* Accept multicast has=
h enabled address. */
+        }
+    } else {
+        /* See if the computed hash matches a set bit in either IAUR / IAL=
R register. */
+        if (((hash < 32) && (s->regs[ENET_IALR] & (1 << hash)))
+                || ((hash > 31) && (s->regs[ENET_IAUR] & (1 << (hash-32)))=
)) {
+            return (FEC_RX_UNICAST_HASH_ACCEPT); /* Accept multicast hash =
enabled address. */
+        }
+    }
+
+    /* Match Unicast address. */
+    addr1  =3D g_htonl(s->regs[ENET_PALR]);
+    addr2  =3D g_htonl(s->regs[ENET_PAUR]);
+    if (!(memcmp(packet, (uint8_t *) &addr1, 4) || memcmp(packet+4, (uint8=
_t *) &addr2, 2))) {
+        return (FEC_RX_UNICAST_ACCEPT); /* Accept packet because it matche=
s my unicast address. */
+    }
+
+    /* Return -1 because we do NOT support MAC address filtering.. */
+    return (FEC_RX_REJECT);
+}
+
 static void imx_eth_update(IMXFECState *s)
 {
     /*
@@ -984,7 +1058,7 @@ static void imx_eth_write(void *opaque, hwaddr offset,=
 uint64_t value,
     case ENET_IALR:
     case ENET_GAUR:
     case ENET_GALR:
-        /* TODO: implement MAC hash filtering.  */
+        s->regs[index] |=3D value;
         break;
     case ENET_TFWR:
         if (s->is_fec) {
@@ -1066,8 +1140,16 @@ static ssize_t imx_fec_receive(NetClientState *nc, c=
onst uint8_t *buf,
     uint32_t buf_addr;
     uint8_t *crc_ptr;
     unsigned int buf_len;
+    int maf;
     size_t size =3D len;

+    /* Is this destination MAC address "for us" ? */
+    maf =3D fec_mac_address_filter(s, buf);
+    if (maf =3D=3D FEC_RX_REJECT)
+    {
+        return (FEC_RX_REJECT);
+    }
+
     FEC_PRINTF("len %d\n", (int)size);

     if (!s->regs[ENET_RDAR]) {
@@ -1133,6 +1215,14 @@ static ssize_t imx_fec_receive(NetClientState *nc, c=
onst uint8_t *buf,
         } else {
             s->regs[ENET_EIR] |=3D ENET_INT_RXB;
         }
+
+        /* Update descriptor based on the "maf" flag. */
+        if (maf =3D=3D FEC_RX_BROADCAST_ACCEPT) {
+            bd.flags |=3D ENET_BD_BC; /* The packet is destined for the "b=
roadcast" address. */
+        } else if (maf =3D=3D FEC_RX_MULTICAST_HASH_ACCEPT) {
+            bd.flags |=3D ENET_BD_MC; /* The packet is destined for a "mul=
ticast" address. */
+        }
+
         imx_fec_write_bd(&bd, addr);
         /* Advance to the next descriptor.  */
         if ((bd.flags & ENET_BD_W) !=3D 0) {
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 7b3faa4..d38c8fe 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -275,4 +275,16 @@ typedef struct IMXFECState {
     uint8_t frame[ENET_MAX_FRAME_SIZE];
 } IMXFECState;

+/* FEC address filtering defines. */
+#define FEC_RX_REJECT                   (-1)
+#define FEC_RX_PROMISCUOUS_ACCEPT       (-2)
+#define FEC_RX_BROADCAST_ACCEPT         (-3)
+#define FEC_RX_MULTICAST_HASH_ACCEPT    (-4)
+#define FEC_RX_UNICAST_HASH_ACCEPT      (-5)
+#define FEC_RX_UNICAST_ACCEPT           (-6)
+
+/* FEC hash filtering defines.*/
+#define CRCPOLY_LE                      0xedb88320
+#define FEC_HASH_BITS                    6    /* #bits in hash */
+
 #endif
--
2.9.3


--_000_157494536599688572mentorcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none"><!--P{margin-top:0;margin-b=
ottom:0;} --></style>
</head>
<body dir=3D"ltr" style=3D"font-size:12pt;color:#000000;background-color:#F=
FFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>&nbsp;Adding support for MAC filtering in the FEC IP<br>
&nbsp;implementation. This addition ensures that the IP does NOT boot up in=
<br>
&nbsp;promiscuous mode by default, and so the software only receives the de=
sired<br>
&nbsp;packets(Unicast, Broadcast, Unicast / Multicast hashed) by default. T=
he<br>
&nbsp;software running on-top of QEMU can also modify these settings and di=
sable<br>
&nbsp;reception of broadcast frames or make the IP receive all packets (PRO=
M mode).<br>
&nbsp;This patch greatly reduces the number of packets received by the soft=
ware<br>
&nbsp;running on-top of the QEMU model. Tested with the armv7-a SABRE_LITE =
machine.<br>
&nbsp;Testing included running a custom OS with IPv4 / IPv6 support. Hashin=
g and<br>
&nbsp;filtering of packets is tested to work well. Skeleton taken from the<=
br>
&nbsp;CADENCE_GEM IP and hash generation algorithm from the Linux Kernel.<b=
r>
<br>
Signed-off-by: Bilal Wasim &lt;bilal_wasim@mentor.com&gt;<br>
---<br>
&nbsp;hw/net/imx_fec.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 92=
 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;-<br>
&nbsp;include/hw/net/imx_fec.h | 12 &#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 103 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c<br>
index bd99236..96c52dd 100644<br>
--- a/hw/net/imx_fec.c<br>
&#43;&#43;&#43; b/hw/net/imx_fec.c<br>
@@ -419,6 &#43;419,80 @@ static void imx_enet_write_bd(IMXENETBufDesc *bd, =
dma_addr_t addr)<br>
&nbsp;&nbsp;&nbsp;&nbsp; dma_memory_write(&amp;address_space_memory, addr, =
bd, sizeof(*bd));<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/*<br>
&#43; * Calculate a FEC MAC Address hash index<br>
&#43; */<br>
&#43;static unsigned calc_mac_hash(const uint8_t *mac, uint8_t mac_length)<=
br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp; uint32_t crc =3D -1;<br>
&#43;&nbsp;&nbsp;&nbsp; int i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; while (mac_length --) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crc ^=3D *mac&#43;&#43;;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 8; i&#=
43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; crc=
 =3D (crc &gt;&gt; 1) ^ ((crc &amp; 1) ? CRCPOLY_LE : 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; /* only upper 6 bits (FEC_HASH_BITS) are used<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; * which point to specific bit in the hash reg=
isters<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp; return ((crc &gt;&gt; (32 - FEC_HASH_BITS)) &amp; 0=
x3f);<br>
&#43;}<br>
&#43;<br>
&#43;/*<br>
&#43; * fec_mac_address_filter:<br>
&#43; * Accept or reject this destination address?<br>
&#43; */<br>
&#43;static int fec_mac_address_filter(IMXFECState *s, const uint8_t *packe=
t)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp; const uint8_t broadcast_addr[] =3D { 0xFF, 0xFF, 0x=
FF, 0xFF, 0xFF, 0xFF };<br>
&#43;&nbsp;&nbsp;&nbsp; uint32_t addr1, addr2;<br>
&#43;&nbsp;&nbsp;&nbsp; uint8_t&nbsp; hash;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; /* Promiscuous mode? */<br>
&#43;&nbsp;&nbsp;&nbsp; if (s-&gt;regs[ENET_RCR] &amp; ENET_RCR_PROM) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (FEC_RX_PROMISCUOUS_=
ACCEPT); /* Accept all packets in promiscuous mode (even if bc_rej is set).=
 */<br>
&#43;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; /* Broadcast packet? */<br>
&#43;&nbsp;&nbsp;&nbsp; if (!memcmp(packet, broadcast_addr, 6)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reject broadcast packets=
? */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;regs[ENET_RCR] &a=
mp; ENET_RCR_BC_REJ) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn (FEC_RX_REJECT);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (FEC_RX_BROADCAST_AC=
CEPT); /* Accept packets from broadcast address. */<br>
&#43;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; /* Accept packets -w- hash match? */<br>
&#43;&nbsp;&nbsp;&nbsp; hash =3D calc_mac_hash(packet, 6);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; /* Accept packets -w- multicast hash match? */<br>
&#43;&nbsp;&nbsp;&nbsp; if ((packet[0] &amp; 0x01) =3D=3D 0x01) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* See if the computed hash=
 matches a set bit in either GAUR / GALR register. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((hash &lt; 32) &amp;&a=
mp; (s-&gt;regs[ENET_GALR] &amp; (1 &lt;&lt; hash)))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; || ((hash &gt; 31) &amp;&amp; (s-&gt;regs[ENET_GAUR] &=
amp; (1 &lt;&lt; (hash-32))))) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn (FEC_RX_MULTICAST_HASH_ACCEPT); /* Accept multicast hash enabled addres=
s. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* See if the computed hash=
 matches a set bit in either IAUR / IALR register. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (((hash &lt; 32) &amp;&a=
mp; (s-&gt;regs[ENET_IALR] &amp; (1 &lt;&lt; hash)))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; || ((hash &gt; 31) &amp;&amp; (s-&gt;regs[ENET_IAUR] &=
amp; (1 &lt;&lt; (hash-32))))) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn (FEC_RX_UNICAST_HASH_ACCEPT); /* Accept multicast hash enabled address.=
 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; /* Match Unicast address. */<br>
&#43;&nbsp;&nbsp;&nbsp; addr1&nbsp; =3D g_htonl(s-&gt;regs[ENET_PALR]);<br>
&#43;&nbsp;&nbsp;&nbsp; addr2&nbsp; =3D g_htonl(s-&gt;regs[ENET_PAUR]);<br>
&#43;&nbsp;&nbsp;&nbsp; if (!(memcmp(packet, (uint8_t *) &amp;addr1, 4) || =
memcmp(packet&#43;4, (uint8_t *) &amp;addr2, 2))) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (FEC_RX_UNICAST_ACCE=
PT); /* Accept packet because it matches my unicast address. */<br>
&#43;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp; /* Return -1 because we do NOT support MAC address =
filtering.. */<br>
&#43;&nbsp;&nbsp;&nbsp; return (FEC_RX_REJECT);<br>
&#43;}<br>
&#43;<br>
&nbsp;static void imx_eth_update(IMXFECState *s)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
@@ -984,7 &#43;1058,7 @@ static void imx_eth_write(void *opaque, hwaddr off=
set, uint64_t value,<br>
&nbsp;&nbsp;&nbsp;&nbsp; case ENET_IALR:<br>
&nbsp;&nbsp;&nbsp;&nbsp; case ENET_GAUR:<br>
&nbsp;&nbsp;&nbsp;&nbsp; case ENET_GALR:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO: implement MAC hash fil=
tering.&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;regs[index] |=3D valu=
e;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp; case ENET_TFWR:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;is_fec) {<br>
@@ -1066,8 &#43;1140,16 @@ static ssize_t imx_fec_receive(NetClientState *n=
c, const uint8_t *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t buf_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *crc_ptr;<br>
&nbsp;&nbsp;&nbsp;&nbsp; unsigned int buf_len;<br>
&#43;&nbsp;&nbsp;&nbsp; int maf;<br>
&nbsp;&nbsp;&nbsp;&nbsp; size_t size =3D len;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp; /* Is this destination MAC address &quot;for us&quo=
t; ? */<br>
&#43;&nbsp;&nbsp;&nbsp; maf =3D fec_mac_address_filter(s, buf);<br>
&#43;&nbsp;&nbsp;&nbsp; if (maf =3D=3D FEC_RX_REJECT)<br>
&#43;&nbsp;&nbsp;&nbsp; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (FEC_RX_REJECT);<br>
&#43;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp; FEC_PRINTF(&quot;len %d\n&quot;, (int)size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (!s-&gt;regs[ENET_RDAR]) {<br>
@@ -1133,6 &#43;1215,14 @@ static ssize_t imx_fec_receive(NetClientState *n=
c, const uint8_t *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-=
&gt;regs[ENET_EIR] |=3D ENET_INT_RXB;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update descriptor based =
on the &quot;maf&quot; flag. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (maf =3D=3D FEC_RX_BROAD=
CAST_ACCEPT) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bd.=
flags |=3D ENET_BD_BC; /* The packet is destined for the &quot;broadcast&qu=
ot; address. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (maf =3D=3D FEC_R=
X_MULTICAST_HASH_ACCEPT) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bd.=
flags |=3D ENET_BD_MC; /* The packet is destined for a &quot;multicast&quot=
; address. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; imx_fec_write_bd(&amp;bd, =
addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Advance to the next des=
criptor.&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((bd.flags &amp; ENET_B=
D_W) !=3D 0) {<br>
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h<br>
index 7b3faa4..d38c8fe 100644<br>
--- a/include/hw/net/imx_fec.h<br>
&#43;&#43;&#43; b/include/hw/net/imx_fec.h<br>
@@ -275,4 &#43;275,16 @@ typedef struct IMXFECState {<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t frame[ENET_MAX_FRAME_SIZE];<br>
&nbsp;} IMXFECState;<br>
&nbsp;<br>
&#43;/* FEC address filtering defines. */<br>
&#43;#define FEC_RX_REJECT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (-1)<br>
&#43;#define FEC_RX_PROMISCUOUS_ACCEPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(-2)<br>
&#43;#define FEC_RX_BROADCAST_ACCEPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (-3)<br>
&#43;#define FEC_RX_MULTICAST_HASH_ACCEPT&nbsp;&nbsp;&nbsp; (-4)<br>
&#43;#define FEC_RX_UNICAST_HASH_ACCEPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (-5)<=
br>
&#43;#define FEC_RX_UNICAST_ACCEPT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (-6)<br>
&#43;<br>
&#43;/* FEC hash filtering defines.*/<br>
&#43;#define CRCPOLY_LE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xedb88320<br>
&#43;#define FEC_HASH_BITS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6&nbsp;&n=
bsp;&nbsp; /* #bits in hash */<br>
&#43;<br>
&nbsp;#endif<br>
-- <br>
2.9.3<br>
<br>
</p>
</body>
</html>

--_000_157494536599688572mentorcom_--

