Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D31C43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 21:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3166206DB
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 21:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgyNizmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3166206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idi57-0004GM-No
	for qemu-devel@archiver.kernel.org; Sat, 07 Dec 2019 16:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bilalwasim676@gmail.com>) id 1idi46-0003mq-RF
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 16:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bilalwasim676@gmail.com>) id 1idi43-0005gO-HW
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 16:56:37 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bilalwasim676@gmail.com>)
 id 1idi41-0005Fs-R9; Sat, 07 Dec 2019 16:56:34 -0500
Received: by mail-lj1-x243.google.com with SMTP id e10so11418601ljj.6;
 Sat, 07 Dec 2019 13:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rkF2arBD2vxAqqsYBIWf8CfxbPo7WPFbWgGJ6mDwSdQ=;
 b=sgyNizmwe7innVSNyflnpZwewpwCgInXV2ezUxFKajfACIO4yg3JFNMZmwcdi4UlP7
 gE11tzfVLzL+ZyRZFJT9Jhik/Di3/p9xHelajT/yTXuSICQBLt8++nBs/RWxBtzDXLZE
 btoUrehSumXXK7ncttnSZyBQ/KmtDccOncdmhD2VTFbj6Ln5yt/G4/mEQt9RszuAxomg
 YwZUeJdgN6xB8L6mb2d/awNey42EDLLBa1RDmk/Rm4IhtDTxQg7W3Dz9lwFTmVV0BFWY
 YF8bbCrud4jjvNuWY3TLVwpKmS1ddwaiUVXdIo0d4UDG0tcdWlF302+B0wSfU/n9BqLx
 ZPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rkF2arBD2vxAqqsYBIWf8CfxbPo7WPFbWgGJ6mDwSdQ=;
 b=jDfKl3id+cPRUiVH3U8uAtJRTpYWY9ym9LB4wfb92GYywEyjvMwZjG/HlaSrxch3fx
 SKvfhmNDfBkk2KpHn+P0P9adP/pG7lPvHJ4ibFBgarFfy5duLAPFLTjSdIkVLCb1gRLJ
 qQ5sbANMcFmb1QjKysBBil4n2x3eBNJg3JnoTwmYMOLD982YAzzI7KZ0TtwMOzi2F0wy
 9uv3O9k8YnqTsw0KlLwCujvYerNY+MYd7+B6y/MPXo+ahDXDzYQ2aQbvcu5DfTOJ08Q1
 l/mudF8JM8hF1jWziv5n84vnw/gLhmVMkKj1d6eO2y9yAUifEFr/GxJKKsleggnO/DPP
 Kyuw==
X-Gm-Message-State: APjAAAWp0k13rjJTN2wj4dm3SFaJuLU777hHX+tocVzNDEkCBLKaVw+Q
 4nsbJy45k87nICOMe3gNfnGa+3famEM=
X-Google-Smtp-Source: APXvYqzgZy0ykW1OxDWyJM+yJCCsLv4SKlcPX9yVyE8Oeegqd5HVYkjyQdTcS+HcExrsQ8w2+fBTiw==
X-Received: by 2002:a2e:868c:: with SMTP id l12mr2405751lji.194.1575755790433; 
 Sat, 07 Dec 2019 13:56:30 -0800 (PST)
Received: from PKL-BWASIM-LT.mgc.mentorg.com
 (static-host202-147-173-53.link.net.pk. [202.147.173.53])
 by smtp.gmail.com with ESMTPSA id s22sm8759229ljm.41.2019.12.07.13.56.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 07 Dec 2019 13:56:29 -0800 (PST)
From: bilalwasim676@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2] Adding support for MAC filtering in the FEC IP
 implementation.
Date: Sun,  8 Dec 2019 02:56:23 +0500
Message-Id: <20191207215623.16532-1-bilalwasim676@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, jasowang@redhat.com,
 qemu-arm@nongnu.org, bilal_wasim@mentor.com,
 Bilal Wasim <bilalwasim676@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bilal Wasim <bilalwasim676@gmail.com>

This addition ensures that the IP does NOT boot up in
promiscuous mode by default, and so the software only receives the desired
packets(Unicast, Broadcast, Unicast / Multicast hashed) by default. The
software running on-top of QEMU can also modify these settings and disable
reception of broadcast frames or make the IP receive all packets (PROM mode).
This patch greatly reduces the number of packets received by the software
running on-top of the QEMU model. Tested with the armv7-a SABRE_LITE machine.
Testing included running a custom OS with IPv4 / IPv6 support. Hashing and
filtering of packets is tested to work well. Skeleton taken from the
CADENCE_GEM IP and hash generation algorithm from the Linux Kernel.

Signed-off-by: Bilal Wasim <bilalwasim676@gmail.com>
---
 hw/net/imx_fec.c         | 117 ++++++++++++++++++++++++++++++++++++++-
 include/hw/net/imx_fec.h |  12 ++++
 2 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index bd99236864..cc1572b5fe 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -419,6 +419,87 @@ static void imx_enet_write_bd(IMXENETBufDesc *bd, dma_addr_t addr)
     dma_memory_write(&address_space_memory, addr, bd, sizeof(*bd));
 }
 
+/*
+ * Calculate a FEC MAC Address hash index
+ */
+static unsigned calc_mac_hash(const uint8_t *mac, uint8_t mac_length)
+{
+    uint32_t crc = -1;
+    int i;
+
+    while (mac_length--) {
+        crc ^= *mac++;
+        for (i = 0; i < 8; i++) {
+            crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
+        }
+    }
+
+    /*
+     * only upper 6 bits (FEC_HASH_BITS) are used
+     * which point to specific bit in the hash registers
+     */
+    return (crc >> (32 - FEC_HASH_BITS)) & 0x3f;
+}
+
+/*
+ * fec_mac_address_filter:
+ * Accept or reject this destination address?
+ */
+static int fec_mac_address_filter(IMXFECState *s, const uint8_t *packet)
+{
+    const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
+    uint32_t addr1, addr2;
+    uint8_t  hash;
+
+    /* Promiscuous mode? */
+    if (s->regs[ENET_RCR] & ENET_RCR_PROM) {
+        /* Accept all packets in promiscuous mode (even if bc_rej is set). */
+        return FEC_RX_PROMISCUOUS_ACCEPT;
+    }
+
+    /* Broadcast packet? */
+    if (!memcmp(packet, broadcast_addr, 6)) {
+        /* Reject broadcast packets? */
+        if (s->regs[ENET_RCR] & ENET_RCR_BC_REJ) {
+            return FEC_RX_REJECT;
+        }
+        /* Accept packets from broadcast address. */
+        return FEC_RX_BROADCAST_ACCEPT;
+    }
+
+    /* Accept packets -w- hash match? */
+    hash = calc_mac_hash(packet, 6);
+
+    /* Accept packets -w- multicast hash match? */
+    if ((packet[0] & 0x01) == 0x01) {
+        /* Computed hash matches GAUR / GALR register ? */
+        if (((hash < 32) && (s->regs[ENET_GALR] & (1 << hash)))
+                || ((hash > 31) && (s->regs[ENET_GAUR] & (1 << (hash - 32))))) {
+            /* Accept multicast hash enabled address. */
+            return FEC_RX_MULTICAST_HASH_ACCEPT;
+        }
+    } else {
+        /* Computed hash matches IAUR / IALR register ? */
+        if (((hash < 32) && (s->regs[ENET_IALR] & (1 << hash)))
+                || ((hash > 31) && (s->regs[ENET_IAUR] & (1 << (hash - 32))))) {
+            /* Accept multicast hash enabled address. */
+            return FEC_RX_UNICAST_HASH_ACCEPT;
+        }
+    }
+
+    /* Match Unicast address. */
+    addr1  = g_htonl(s->regs[ENET_PALR]);
+    addr2  = g_htonl(s->regs[ENET_PAUR]);
+    if (!(memcmp(packet, (uint8_t *) &addr1, 4) ||
+          memcmp(packet + 4, (uint8_t *) &addr2, 2))) {
+        /* Accept packet because it matches my unicast address. */
+        return FEC_RX_UNICAST_ACCEPT;
+    }
+
+    /* Return -1 because we do NOT support MAC address filtering.. */
+    return FEC_RX_REJECT;
+}
+
 static void imx_eth_update(IMXFECState *s)
 {
     /*
@@ -984,7 +1065,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
     case ENET_IALR:
     case ENET_GAUR:
     case ENET_GALR:
-        /* TODO: implement MAC hash filtering.  */
+        s->regs[index] |= value;
         break;
     case ENET_TFWR:
         if (s->is_fec) {
@@ -1066,8 +1147,15 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
     uint32_t buf_addr;
     uint8_t *crc_ptr;
     unsigned int buf_len;
+    int maf;
     size_t size = len;
 
+    /* Is this destination MAC address "for us" ? */
+    maf = fec_mac_address_filter(s, buf);
+    if (maf == FEC_RX_REJECT) {
+        return FEC_RX_REJECT;
+    }
+
     FEC_PRINTF("len %d\n", (int)size);
 
     if (!s->regs[ENET_RDAR]) {
@@ -1133,6 +1221,16 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
         } else {
             s->regs[ENET_EIR] |= ENET_INT_RXB;
         }
+
+        /* Update descriptor based on the "maf" flag. */
+        if (maf == FEC_RX_BROADCAST_ACCEPT) {
+            /* The packet is destined for the "broadcast" address. */
+            bd.flags |= ENET_BD_BC;
+        } else if (maf == FEC_RX_MULTICAST_HASH_ACCEPT) {
+            /* The packet is destined for a "multicast" address. */
+            bd.flags |= ENET_BD_MC;
+        }
+
         imx_fec_write_bd(&bd, addr);
         /* Advance to the next descriptor.  */
         if ((bd.flags & ENET_BD_W) != 0) {
@@ -1159,8 +1257,15 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
     uint8_t *crc_ptr;
     unsigned int buf_len;
     size_t size = len;
+    int maf;
     bool shift16 = s->regs[ENET_RACC] & ENET_RACC_SHIFT16;
 
+    /* Is this destination MAC address "for us" ? */
+    maf = fec_mac_address_filter(s, buf);
+    if (maf == FEC_RX_REJECT) {
+        return FEC_RX_REJECT;
+    }
+
     FEC_PRINTF("len %d\n", (int)size);
 
     if (!s->regs[ENET_RDAR]) {
@@ -1254,6 +1359,16 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
                 s->regs[ENET_EIR] |= ENET_INT_RXB;
             }
         }
+
+        /* Update descriptor based on the "maf" flag. */
+        if (maf == FEC_RX_BROADCAST_ACCEPT) {
+            /* The packet is destined for the "broadcast" address. */
+            bd.flags |= ENET_BD_BC;
+        } else if (maf == FEC_RX_MULTICAST_HASH_ACCEPT) {
+            /* The packet is destined for a "multicast" address. */
+            bd.flags |= ENET_BD_MC;
+        }
+
         imx_enet_write_bd(&bd, addr);
         /* Advance to the next descriptor.  */
         if ((bd.flags & ENET_BD_W) != 0) {
diff --git a/include/hw/net/imx_fec.h b/include/hw/net/imx_fec.h
index 7b3faa4019..d38c8fe0e8 100644
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
2.19.1.windows.1


