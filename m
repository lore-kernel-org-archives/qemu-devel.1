Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234A2CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 19:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F152B20873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 19:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F152B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPAiw-0007kB-Qz
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 15:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zp-0002hB-CW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iP9Zn-00042y-HE
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 14:17:13 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52963)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iP9Zi-0003yC-QK; Mon, 28 Oct 2019 14:17:07 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGhi0-1iBM4D0CSw-00Dn53; Mon, 28 Oct 2019 19:16:55 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] dp8393x: manage big endian bus
Date: Mon, 28 Oct 2019 19:16:36 +0100
Message-Id: <20191028181643.5143-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028181643.5143-1-laurent@vivier.eu>
References: <20191028181643.5143-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SRHVVvKWAENMmfZJjHF9g6iEGZFLNXNExMJ6J0oLXGspb30Sf2z
 xWsXAA/wCPV25G4ys0los6x28oHCJvvMHU5e0VGnk+VC+v8cPGcz476lU2L1YoISOMXMKik
 jmkwBY4mwfstGj2vpY65z9wwK3dzD3CCxcINkXABEB77c1zfpellsbchghCKTItBmc3RZYq
 PKSZngDfho8CpApdheezQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u0FRLH4e08s=:WtYCkYYTFmFyuSAyGZ4t07
 BbdOnSgZm/S4y/bJv0Aqz80wTui0xVUVMaGgakAucgXh2d7/N3tQbK87YHUpUxlKciXPCpAoZ
 OSpTl9Rqbh4xq/aA/hIuoyfJTJ0+gRo7AXGo5K1rWrW6mwx2M4jLnuZJ4T0gMxUUkAgCBvyw+
 qdyjHIVQi4dwV8FR3Ei8kJ+Z+RaYRZJxhxQbo+lGEuaNq0u2kKTLnLbAmxhvtXs1ndZ/G/dme
 SOgEkMBq4J7vsLWoTBIBRKcsg306TmoKfJmZBpFN+29SE/mFWPoLVqaDH0ZORj6Bd7Du5uRRG
 FOupdX6UhlWA4mgfGUlGgmpbPFaeU4EyxEXYXnUcSilI5+Fd1wcQ6/Fpa20josq58byGhGgK7
 qxkDwMEkfekY0xeZkJwXxwJPnorjF6Jyi2JpdCXEqQjYuseYNfSZgKM2BgKSmgZCEOoBpHLBe
 GjaCoyELOxPwrvDrLcRpoB/lD/tUCCbOEA/UKvTGP1X6iHgp9AAVwLvzwaZTN5SW5HKNO6A1j
 I4NtKiZYeM1LzfT48bt7SDSk9nrI3qJY5aQybkMTIOlOV7slKHXRwUEub0NoqQAiho/7ourek
 nSl4LvnQGw/Z15B7aZv3KnNidGYLOykow5bF5XsPywdGo6Utz5wvSXNfUehEpXxsJZ9Bv41sd
 T2jnNwzvzdeGn7W4P6poS2eid5YpVyGgPQASqmPpUFBFdwhmNdcFT22LMrmaJXBWAUYpJ5cjW
 E9Y5YMwEErSNvvuwPSKuLWD0ZdrECRd6tGpCuLV/istAUyl7nk7BsacS/HAe3grT/JObuuxjo
 T6XFDkqkDKG5l3h/rwxcCilx63JvCjp7/jlKdlds3+Ng7YBGySf+W4jDrHlmPzoXyIUkyVs0U
 bi1qx9Sfxt/LePShsNRHXUjjHR23hT834NTbYVjD4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is needed by Quadra 800, this card can run on little-endian
or big-endian bus.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Hervé Poussineau <hpoussin@reactos.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Message-Id: <20191026164546.30020-5-laurent@vivier.eu>
---
 hw/net/dp8393x.c | 88 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index a5678e11fa..693e244ce6 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -153,6 +153,7 @@ typedef struct dp8393xState {
 
     /* Hardware */
     uint8_t it_shift;
+    bool big_endian;
     qemu_irq irq;
 #ifdef DEBUG_SONIC
     int irq_level;
@@ -223,6 +224,29 @@ static uint32_t dp8393x_wt(dp8393xState *s)
     return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
 }
 
+static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
+                            int offset)
+{
+    uint16_t val;
+
+    if (s->big_endian) {
+        val = be16_to_cpu(base[offset * width + width - 1]);
+    } else {
+        val = le16_to_cpu(base[offset * width]);
+    }
+    return val;
+}
+
+static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
+                        uint16_t val)
+{
+    if (s->big_endian) {
+        base[offset * width + width - 1] = cpu_to_be16(val);
+    } else {
+        base[offset * width] = cpu_to_le16(val);
+    }
+}
+
 static void dp8393x_update_irq(dp8393xState *s)
 {
     int level = (s->regs[SONIC_IMR] & s->regs[SONIC_ISR]) ? 1 : 0;
@@ -254,12 +278,12 @@ static void dp8393x_do_load_cam(dp8393xState *s)
         /* Fill current entry */
         address_space_rw(&s->as, dp8393x_cdp(s),
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-        s->cam[index][0] = data[1 * width] & 0xff;
-        s->cam[index][1] = data[1 * width] >> 8;
-        s->cam[index][2] = data[2 * width] & 0xff;
-        s->cam[index][3] = data[2 * width] >> 8;
-        s->cam[index][4] = data[3 * width] & 0xff;
-        s->cam[index][5] = data[3 * width] >> 8;
+        s->cam[index][0] = dp8393x_get(s, width, data, 1) & 0xff;
+        s->cam[index][1] = dp8393x_get(s, width, data, 1) >> 8;
+        s->cam[index][2] = dp8393x_get(s, width, data, 2) & 0xff;
+        s->cam[index][3] = dp8393x_get(s, width, data, 2) >> 8;
+        s->cam[index][4] = dp8393x_get(s, width, data, 3) & 0xff;
+        s->cam[index][5] = dp8393x_get(s, width, data, 3) >> 8;
         DPRINTF("load cam[%d] with %02x%02x%02x%02x%02x%02x\n", index,
             s->cam[index][0], s->cam[index][1], s->cam[index][2],
             s->cam[index][3], s->cam[index][4], s->cam[index][5]);
@@ -272,7 +296,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     /* Read CAM enable */
     address_space_rw(&s->as, dp8393x_cdp(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_CE] = data[0 * width];
+    s->regs[SONIC_CE] = dp8393x_get(s, width, data, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
 
     /* Done */
@@ -293,10 +317,10 @@ static void dp8393x_do_read_rra(dp8393xState *s)
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
 
     /* Update SONIC registers */
-    s->regs[SONIC_CRBA0] = data[0 * width];
-    s->regs[SONIC_CRBA1] = data[1 * width];
-    s->regs[SONIC_RBWC0] = data[2 * width];
-    s->regs[SONIC_RBWC1] = data[3 * width];
+    s->regs[SONIC_CRBA0] = dp8393x_get(s, width, data, 0);
+    s->regs[SONIC_CRBA1] = dp8393x_get(s, width, data, 1);
+    s->regs[SONIC_RBWC0] = dp8393x_get(s, width, data, 2);
+    s->regs[SONIC_RBWC1] = dp8393x_get(s, width, data, 3);
     DPRINTF("CRBA0/1: 0x%04x/0x%04x, RBWC0/1: 0x%04x/0x%04x\n",
         s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
         s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
@@ -411,12 +435,12 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         tx_len = 0;
 
         /* Update registers */
-        s->regs[SONIC_TCR] = data[0 * width] & 0xf000;
-        s->regs[SONIC_TPS] = data[1 * width];
-        s->regs[SONIC_TFC] = data[2 * width];
-        s->regs[SONIC_TSA0] = data[3 * width];
-        s->regs[SONIC_TSA1] = data[4 * width];
-        s->regs[SONIC_TFS] = data[5 * width];
+        s->regs[SONIC_TCR] = dp8393x_get(s, width, data, 0) & 0xf000;
+        s->regs[SONIC_TPS] = dp8393x_get(s, width, data, 1);
+        s->regs[SONIC_TFC] = dp8393x_get(s, width, data, 2);
+        s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 3);
+        s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 4);
+        s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 5);
 
         /* Handle programmable interrupt */
         if (s->regs[SONIC_TCR] & SONIC_TCR_PINT) {
@@ -442,9 +466,9 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                 address_space_rw(&s->as,
                     dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
                     MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-                s->regs[SONIC_TSA0] = data[0 * width];
-                s->regs[SONIC_TSA1] = data[1 * width];
-                s->regs[SONIC_TFS] = data[2 * width];
+                s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 0);
+                s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 1);
+                s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 2);
             }
         }
 
@@ -471,7 +495,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         s->regs[SONIC_TCR] |= SONIC_TCR_PTX;
 
         /* Write status */
-        data[0 * width] = s->regs[SONIC_TCR] & 0x0fff; /* status */
+        dp8393x_put(s, width, data, 0,
+                    s->regs[SONIC_TCR] & 0x0fff); /* status */
         size = sizeof(uint16_t) * width;
         address_space_rw(&s->as,
             dp8393x_ttda(s),
@@ -485,8 +510,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                              sizeof(uint16_t) *
                              (4 + 3 * s->regs[SONIC_TFC]) * width,
                 MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-            s->regs[SONIC_CTDA] = data[0 * width] & ~0x1;
-            if (data[0 * width] & 0x1) {
+            s->regs[SONIC_CTDA] = dp8393x_get(s, width, data, 0) & ~0x1;
+            if (dp8393x_get(s, width, data, 0) & 0x1) {
                 /* EOL detected */
                 break;
             }
@@ -749,7 +774,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)data, size, 0);
-        if (data[0 * width] & 0x1) {
+        if (dp8393x_get(s, width, data, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
         } else {
@@ -793,11 +818,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
 
     /* Write status to memory */
     DPRINTF("Write status at %08x\n", dp8393x_crda(s));
-    data[0 * width] = s->regs[SONIC_RCR]; /* status */
-    data[1 * width] = rx_len; /* byte count */
-    data[2 * width] = s->regs[SONIC_TRBA0]; /* pkt_ptr0 */
-    data[3 * width] = s->regs[SONIC_TRBA1]; /* pkt_ptr1 */
-    data[4 * width] = s->regs[SONIC_RSC]; /* seq_no */
+    dp8393x_put(s, width, data, 0, s->regs[SONIC_RCR]); /* status */
+    dp8393x_put(s, width, data, 1, rx_len); /* byte count */
+    dp8393x_put(s, width, data, 2, s->regs[SONIC_TRBA0]); /* pkt_ptr0 */
+    dp8393x_put(s, width, data, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
+    dp8393x_put(s, width, data, 4, s->regs[SONIC_RSC]); /* seq_no */
     size = sizeof(uint16_t) * 5 * width;
     address_space_rw(&s->as, dp8393x_crda(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
@@ -806,12 +831,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_LLFA] = data[0 * width];
+    s->regs[SONIC_LLFA] = dp8393x_get(s, width, data, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
-        data[0 * width] = 0; /* in_use */
+        dp8393x_put(s, width, data, 0, 0); /* in_use */
         address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
@@ -924,6 +949,7 @@ static Property dp8393x_properties[] = {
     DEFINE_NIC_PROPERTIES(dp8393xState, conf),
     DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
     DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
+    DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.21.0


