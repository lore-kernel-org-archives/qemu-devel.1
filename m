Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0652AFC6197
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBEA920674
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 20:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEA920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTB4i-0007RZ-Sv
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 15:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iTB24-0004aD-7n
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iTB22-000312-7m
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:39:00 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:56391)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iTB20-0002rY-Rl
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:38:58 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MeTD8-1hskLl0Unk-00aR8h; Fri, 08 Nov 2019 21:38:49 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] dp8393x: put the DMA buffer in the state structure
Date: Fri,  8 Nov 2019 21:38:45 +0100
Message-Id: <20191108203846.8837-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191108203846.8837-1-laurent@vivier.eu>
References: <20191108203846.8837-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:za8Uv5f+w3gFqAgcyou0Po5Vo/QQaUesC3EKjj2zbbfjaaLAPWj
 DE9pb+INLF7Agc4LvHjKSHsV0fjhtTIfjDBT6muTXD9GO0rbslWZoKgIOe9Qu55Oq++8jAv
 Ii5XFOYAUln/DsDwI+uqdjuiV0yV2cnkwEJQfBS3c5vTq5Lum6wYYiP8k0xyBXi8a19Xwxo
 MnQ2u2spxGHSjjxWpFnMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MOHdAfY275U=:AMtPHNdqRkr3cQtVsvubLu
 0Vr6PJiqWEX6S353P0qADOBDNDcLNUrlCQFXp5diafRjQYHQflWjLuuaOn6/GECkfFlIhbzI+
 Q2ih5JI4rJMWD0Gt4flevRprkmzELbDokBdngjvLSNFPKJs0Ysj1U+3/SnDVbcIP6CCSHqlpZ
 CKe/Vhn3KNM2V4iPbfSyCaQfALytrGp9/GFD4iHzbTKk0UfvzQq9fsimSom7a+gHFdcyE+/3C
 pJkj5E+F5gB7sgi7DAs6D8wZIpLgkyklTFplmAo6VfK5IxWUkTKvz63dnM4mQV7+Ewmwj7YpI
 oVAYgSQb6MwsBE1W16twK6wzVDx89802AkgsQyicn92jvmDz1dEiYqghWd1Nw087A4FX9DMms
 GE7RDMyfDMmUp5gDbHy5RA9GRxLV42lZB/ar/+e4R8Sv5XRPIQhBsH4PF4tglROYdTwf0gkLJ
 t1FD0NqmsohjjTrl4qWQCEuk0ruLZ+sKCXOZE4DnXLeDRoKlQjjUE7hvwx2Lk9aSQKA5256kK
 yixUgfov6oIG1YxaarBm1fLsY9V1s+uPAcBurDH+D87q+WEb6u++CyWcgYJVwMmAfSgqRL41T
 9eL6MmhFddbk0CqNHIgYbKK5ci9oDfdfufPRjcYYWRg44xINHbf3ZsHiJA1M5Ey0vzJi/IdhV
 8Erb+Ljo4Ej76FCDfmwhD+VwhnSMkvWxsD9YRMcGpfkPW8aMuNy7nR52ycFX1QpVglY83xfan
 gVIExYCDOVpvKzYvM6gvBToIFwalBrKtk0fDXuUGfi08D0cPQiYIZc+hRQq0uhNUCCp3oEFsI
 XJIu2ZA4VapCtsfTj9W59FV/QAF6Hy/hKvruXnEq2jKf0Hpm40EIk2B3omt/oYHcipV1Aiprl
 /huNXVZzPfa0007G8OSNMO3snDhLVRm9iyS5v5IcM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move it from the stack.

It's only 24 bytes, and this simplifies the dp8393x_get()/
dp8393x_put() interface.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Message-Id: <20191106112341.23735-2-laurent@vivier.eu>
---
 hw/net/dp8393x.c | 105 ++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 55 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 693e244ce6..85d3f3788e 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -171,6 +171,7 @@ typedef struct dp8393xState {
 
     /* Temporaries */
     uint8_t tx_buffer[0x10000];
+    uint16_t data[12];
     int loopback_packet;
 
     /* Memory access */
@@ -224,26 +225,25 @@ static uint32_t dp8393x_wt(dp8393xState *s)
     return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
 }
 
-static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
-                            int offset)
+static uint16_t dp8393x_get(dp8393xState *s, int width, int offset)
 {
     uint16_t val;
 
     if (s->big_endian) {
-        val = be16_to_cpu(base[offset * width + width - 1]);
+        val = be16_to_cpu(s->data[offset * width + width - 1]);
     } else {
-        val = le16_to_cpu(base[offset * width]);
+        val = le16_to_cpu(s->data[offset * width]);
     }
     return val;
 }
 
-static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
+static void dp8393x_put(dp8393xState *s, int width, int offset,
                         uint16_t val)
 {
     if (s->big_endian) {
-        base[offset * width + width - 1] = cpu_to_be16(val);
+        s->data[offset * width + width - 1] = cpu_to_be16(val);
     } else {
-        base[offset * width] = cpu_to_le16(val);
+        s->data[offset * width] = cpu_to_le16(val);
     }
 }
 
@@ -267,7 +267,6 @@ static void dp8393x_update_irq(dp8393xState *s)
 
 static void dp8393x_do_load_cam(dp8393xState *s)
 {
-    uint16_t data[8];
     int width, size;
     uint16_t index = 0;
 
@@ -277,13 +276,13 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     while (s->regs[SONIC_CDC] & 0x1f) {
         /* Fill current entry */
         address_space_rw(&s->as, dp8393x_cdp(s),
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-        s->cam[index][0] = dp8393x_get(s, width, data, 1) & 0xff;
-        s->cam[index][1] = dp8393x_get(s, width, data, 1) >> 8;
-        s->cam[index][2] = dp8393x_get(s, width, data, 2) & 0xff;
-        s->cam[index][3] = dp8393x_get(s, width, data, 2) >> 8;
-        s->cam[index][4] = dp8393x_get(s, width, data, 3) & 0xff;
-        s->cam[index][5] = dp8393x_get(s, width, data, 3) >> 8;
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+        s->cam[index][0] = dp8393x_get(s, width, 1) & 0xff;
+        s->cam[index][1] = dp8393x_get(s, width, 1) >> 8;
+        s->cam[index][2] = dp8393x_get(s, width, 2) & 0xff;
+        s->cam[index][3] = dp8393x_get(s, width, 2) >> 8;
+        s->cam[index][4] = dp8393x_get(s, width, 3) & 0xff;
+        s->cam[index][5] = dp8393x_get(s, width, 3) >> 8;
         DPRINTF("load cam[%d] with %02x%02x%02x%02x%02x%02x\n", index,
             s->cam[index][0], s->cam[index][1], s->cam[index][2],
             s->cam[index][3], s->cam[index][4], s->cam[index][5]);
@@ -295,8 +294,8 @@ static void dp8393x_do_load_cam(dp8393xState *s)
 
     /* Read CAM enable */
     address_space_rw(&s->as, dp8393x_cdp(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_CE] = dp8393x_get(s, width, data, 0);
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+    s->regs[SONIC_CE] = dp8393x_get(s, width, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
 
     /* Done */
@@ -307,20 +306,19 @@ static void dp8393x_do_load_cam(dp8393xState *s)
 
 static void dp8393x_do_read_rra(dp8393xState *s)
 {
-    uint16_t data[8];
     int width, size;
 
     /* Read memory */
     width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
     size = sizeof(uint16_t) * 4 * width;
     address_space_rw(&s->as, dp8393x_rrp(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
 
     /* Update SONIC registers */
-    s->regs[SONIC_CRBA0] = dp8393x_get(s, width, data, 0);
-    s->regs[SONIC_CRBA1] = dp8393x_get(s, width, data, 1);
-    s->regs[SONIC_RBWC0] = dp8393x_get(s, width, data, 2);
-    s->regs[SONIC_RBWC1] = dp8393x_get(s, width, data, 3);
+    s->regs[SONIC_CRBA0] = dp8393x_get(s, width, 0);
+    s->regs[SONIC_CRBA1] = dp8393x_get(s, width, 1);
+    s->regs[SONIC_RBWC0] = dp8393x_get(s, width, 2);
+    s->regs[SONIC_RBWC1] = dp8393x_get(s, width, 3);
     DPRINTF("CRBA0/1: 0x%04x/0x%04x, RBWC0/1: 0x%04x/0x%04x\n",
         s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
         s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
@@ -417,7 +415,6 @@ static void dp8393x_do_receiver_disable(dp8393xState *s)
 static void dp8393x_do_transmit_packets(dp8393xState *s)
 {
     NetClientState *nc = qemu_get_queue(s->nic);
-    uint16_t data[12];
     int width, size;
     int tx_len, len;
     uint16_t i;
@@ -429,18 +426,17 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         size = sizeof(uint16_t) * 6 * width;
         s->regs[SONIC_TTDA] = s->regs[SONIC_CTDA];
         DPRINTF("Transmit packet at %08x\n", dp8393x_ttda(s));
-        address_space_rw(&s->as,
-            dp8393x_ttda(s) + sizeof(uint16_t) * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
+        address_space_rw(&s->as, dp8393x_ttda(s) + sizeof(uint16_t) * width,
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
         tx_len = 0;
 
         /* Update registers */
-        s->regs[SONIC_TCR] = dp8393x_get(s, width, data, 0) & 0xf000;
-        s->regs[SONIC_TPS] = dp8393x_get(s, width, data, 1);
-        s->regs[SONIC_TFC] = dp8393x_get(s, width, data, 2);
-        s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 3);
-        s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 4);
-        s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 5);
+        s->regs[SONIC_TCR] = dp8393x_get(s, width, 0) & 0xf000;
+        s->regs[SONIC_TPS] = dp8393x_get(s, width, 1);
+        s->regs[SONIC_TFC] = dp8393x_get(s, width, 2);
+        s->regs[SONIC_TSA0] = dp8393x_get(s, width, 3);
+        s->regs[SONIC_TSA1] = dp8393x_get(s, width, 4);
+        s->regs[SONIC_TFS] = dp8393x_get(s, width, 5);
 
         /* Handle programmable interrupt */
         if (s->regs[SONIC_TCR] & SONIC_TCR_PINT) {
@@ -465,10 +461,10 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                 size = sizeof(uint16_t) * 3 * width;
                 address_space_rw(&s->as,
                     dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
-                    MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-                s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 0);
-                s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 1);
-                s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 2);
+                    MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+                s->regs[SONIC_TSA0] = dp8393x_get(s, width, 0);
+                s->regs[SONIC_TSA1] = dp8393x_get(s, width, 1);
+                s->regs[SONIC_TFS] = dp8393x_get(s, width, 2);
             }
         }
 
@@ -495,12 +491,12 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         s->regs[SONIC_TCR] |= SONIC_TCR_PTX;
 
         /* Write status */
-        dp8393x_put(s, width, data, 0,
+        dp8393x_put(s, width, 0,
                     s->regs[SONIC_TCR] & 0x0fff); /* status */
         size = sizeof(uint16_t) * width;
         address_space_rw(&s->as,
             dp8393x_ttda(s),
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
 
         if (!(s->regs[SONIC_CR] & SONIC_CR_HTX)) {
             /* Read footer of packet */
@@ -509,9 +505,9 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                 dp8393x_ttda(s) +
                              sizeof(uint16_t) *
                              (4 + 3 * s->regs[SONIC_TFC]) * width,
-                MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-            s->regs[SONIC_CTDA] = dp8393x_get(s, width, data, 0) & ~0x1;
-            if (dp8393x_get(s, width, data, 0) & 0x1) {
+                MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
+            if (dp8393x_get(s, width, 0) & 0x1) {
                 /* EOL detected */
                 break;
             }
@@ -748,7 +744,6 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
                                size_t size)
 {
     dp8393xState *s = qemu_get_nic_opaque(nc);
-    uint16_t data[10];
     int packet_type;
     uint32_t available, address;
     int width, rx_len = size;
@@ -773,8 +768,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         size = sizeof(uint16_t) * 1 * width;
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)data, size, 0);
-        if (dp8393x_get(s, width, data, 0) & 0x1) {
+                         (uint8_t *)s->data, size, 0);
+        if (dp8393x_get(s, width, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
         } else {
@@ -818,27 +813,27 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
 
     /* Write status to memory */
     DPRINTF("Write status at %08x\n", dp8393x_crda(s));
-    dp8393x_put(s, width, data, 0, s->regs[SONIC_RCR]); /* status */
-    dp8393x_put(s, width, data, 1, rx_len); /* byte count */
-    dp8393x_put(s, width, data, 2, s->regs[SONIC_TRBA0]); /* pkt_ptr0 */
-    dp8393x_put(s, width, data, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
-    dp8393x_put(s, width, data, 4, s->regs[SONIC_RSC]); /* seq_no */
+    dp8393x_put(s, width, 0, s->regs[SONIC_RCR]); /* status */
+    dp8393x_put(s, width, 1, rx_len); /* byte count */
+    dp8393x_put(s, width, 2, s->regs[SONIC_TRBA0]); /* pkt_ptr0 */
+    dp8393x_put(s, width, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
+    dp8393x_put(s, width, 4, s->regs[SONIC_RSC]); /* seq_no */
     size = sizeof(uint16_t) * 5 * width;
     address_space_rw(&s->as, dp8393x_crda(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
 
     /* Move to next descriptor */
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_LLFA] = dp8393x_get(s, width, data, 0);
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+    s->regs[SONIC_LLFA] = dp8393x_get(s, width, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
-        dp8393x_put(s, width, data, 0, 0); /* in_use */
+        dp8393x_put(s, width, 0, 0); /* in_use */
         address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1);
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, sizeof(uint16_t), 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
-- 
2.21.0


