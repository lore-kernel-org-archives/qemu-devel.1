Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E9C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113612073B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 14:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMUOdv/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113612073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iegAk-00061S-6a
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 09:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bilalwasim676@gmail.com>) id 1ieg9n-0005Wy-Pm
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bilalwasim676@gmail.com>) id 1ieg9i-0006Mp-DI
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 09:06:31 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bilalwasim676@gmail.com>)
 id 1ieg9i-0006Lw-6g; Tue, 10 Dec 2019 09:06:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id p17so3352482wma.1;
 Tue, 10 Dec 2019 06:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hFqtim+9HHduFLwD+2dEusU1yjl817nJKs7Wo98MEgE=;
 b=jMUOdv/4vkzCnEKeawJsCaVi+Lbjd2XAaHGdZ8MFuLCEzIggZVuTB0JOO6iu2Qa3m6
 w7GF+iDZciJEIG650S+BFnThIV6mm62foubsEofJfklqn7OcfNn30Gmy8WqWiVH0nk6L
 AOWSx6JUP9rPubFybEFuKEbceJ3M1OrFcMjAwRMA1cYHFZerCujZDfLc+aCW9B8r9D32
 4tXw4Gi+dJq2ntdoPNds7uHcPC/GMe0QH41R8TGnMIySVkrDVgYloQcCd0pye5ZNxfpe
 /llg3LC8pWA1YeIAJki2pc1p23WZi8qyQBrZZ3smx3Xfm5p6lbWJYjVxE3dfWUefNKpr
 oNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hFqtim+9HHduFLwD+2dEusU1yjl817nJKs7Wo98MEgE=;
 b=fnj5WGVsP/+7+GAcjtJ0imbl/p4WwiEnT04QEUshEtLQcnOhwzZX/X33s9+POtk6TJ
 N000sXT4IelTiUNE0VibJruPWRsaQa5vn2XZ7BDJGvLRSlrIpH8VZo+vgx89Y53Tkb9z
 yAtS2suwB0AvrRfzz9h9VeVPRlsOz6ucP9QAQm69H40oLfQrVOJITLZK+rwx79btUEnO
 8HQRM5UmCXrGmlw5NwjGRZHWmNjlzmMqUvOkWJvXmhKKyTvBP7wajwZO9jVmB8siXScp
 6BLT5J5wzB7nwlERovt7zmxVIs8Wcut1HgRJcU2ozXcDLkmdWXHIRZGan5dN0U9IHVoX
 Qfsg==
X-Gm-Message-State: APjAAAX7ceEPx7xkWN1+7IocKhUsMli427oU1UK3WRlcgemXabTBk/Db
 3/9PGg2uKEgg8wjHHiF9wQE48DX71rk=
X-Google-Smtp-Source: APXvYqwtA7VVHVotAEReY74Dbkn0vnsGgNqQ075JMMKF0EFSVWinb1Ye7UVp6qKoXgqlotsAQZ/YyQ==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr5433570wmi.152.1575986784103; 
 Tue, 10 Dec 2019 06:06:24 -0800 (PST)
Received: from PKL-BWASIM-LT.mgc.mentorg.com ([110.93.212.98])
 by smtp.gmail.com with ESMTPSA id n188sm3514002wme.14.2019.12.10.06.06.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Dec 2019 06:06:23 -0800 (PST)
From: bilalwasim676@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3] net/imx_fec: Adding support for MAC filtering in the FEC
 IP implementation.
Date: Tue, 10 Dec 2019 19:06:17 +0500
Message-Id: <20191210140617.16656-1-bilalwasim676@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 mark.cave-ayland@ilande.co.uk, qemu-arm@nongnu.org,
 bwasim <bilalwasim676@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: bwasim <bilalwasim676@gmail.com>

This addition ensures that the IP does NOT boot up in promiscuous mode
by default, and so the software only receives the desired
packets(Unicast, Broadcast, Unicast / Multicast hashed) by default.
The software running on-top of QEMU can also modify these settings and
disable reception of broadcast frames or make the IP receive all packets (PROM mode).
This patch greatly reduces the number of packets received by the
software running on-top of the QEMU model. Tested with the armv7-a SABRE_LITE machine.
Testing included running a custom OS with IPv4 / IPv6 support. Hashing
and filtering of packets is tested to work well. Skeleton taken from
the CADENCE_GEM IP and hash generation algorithm from the Linux Kernel.

Signed-off-by: Bilal Wasim <bilalwasim676@gmail.com>
---
 hw/net/imx_fec.c         | 109 ++++++++++++++++++++++++++++++++++++++-
 include/hw/net/imx_fec.h |  10 ++++
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index bd99236864..d248f39fb0 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -419,6 +419,79 @@ static void imx_enet_write_bd(IMXENETBufDesc *bd, dma_addr_t addr)
     dma_memory_write(&address_space_memory, addr, bd, sizeof(*bd));
 }
 
+/*
+ * Calculate a FEC MAC Address hash index
+ */
+static unsigned calc_mac_hash(const uint8_t *mac, uint8_t mac_length)
+{
+    uint32_t crc = net_crc32_le(mac, mac_length);
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
@@ -984,7 +1057,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
     case ENET_IALR:
     case ENET_GAUR:
     case ENET_GALR:
-        /* TODO: implement MAC hash filtering.  */
+        s->regs[index] |= value;
         break;
     case ENET_TFWR:
         if (s->is_fec) {
@@ -1066,8 +1139,15 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
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
@@ -1133,6 +1213,16 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
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
@@ -1159,8 +1249,15 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
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
@@ -1254,6 +1351,16 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
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
index 7b3faa4019..f9cfcf6af5 100644
--- a/include/hw/net/imx_fec.h
+++ b/include/hw/net/imx_fec.h
@@ -275,4 +275,14 @@ typedef struct IMXFECState {
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
+#define FEC_HASH_BITS                    6    /* #bits in hash */
+
 #endif
-- 
2.19.1.windows.1


