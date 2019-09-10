Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE61C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F7720872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F7720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7eTZ-0001qg-0h
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7ePJ-0007OT-AX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7ePH-0003cL-Hk
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:34:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37781)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i7ePH-0003c0-7y; Tue, 10 Sep 2019 07:33:59 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIdW9-1ht8Lh1rcr-00Efog; Tue, 10 Sep 2019 13:33:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 13:33:16 +0200
Message-Id: <20190910113323.17324-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910113323.17324-1-laurent@vivier.eu>
References: <20190910113323.17324-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pP75NG9DPzK3yAL8VikBtYmzMDRJ0wIIHs1aCw/yNnHWqzzc2C0
 s9hrUZCsYOdHOsiBZptP16mDFUrgv/Ohx7S2qA9tl45QwS0tvKQmOlYQTx4vH0d609nqPwZ
 0yJis0LeXq7hhP6dSx4rQ+W0pnaXd/uyhg/7Zs43iDVnNXwEBIXpZZ7hY/VxDzGIBFnjuU6
 O1zZtGU/GKS0DgI2foiKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X4leeqUdRS0=:sJzKt7DmRzso6AlPNNfj2S
 a9szPus0b/gAL8p4iFT6gc/xxgUdaGHkQ2Uxvhb9YUb+ib47KQejw6T9rYv+Qoipxt1UaVTvS
 C7AHF8MdrycIVuO7vMn0HP7Of36FrF6IFiHUpheljdBHOIhXnB0LeM96XZXPu2NsnzhzmZoR3
 3g4yxT9hyCn4DzmKXX7CAnePLGCFgQtgghk1F0Pto1adP2wQ+YNWW2lc6lgYu1kLvfNVBip0Q
 oD2w/ttpMpLf4QBMt3tlSKGdR/hzmxLf276uHstaCp1c8RFltbws4bh1XTt958zbkz3SDNnbL
 e2Bju39eksoCJa9toUsagWE4ohMqwmkyblzq3ybXaib1W2QtFsll9U9NHq21WqXMvlB+YmV4m
 jfrpAcih+nIhXlROstZV+5w8F+VAhcK07ckGbxIwqqjuSllWQEKXWt63UwDu0hBRBqIO7q7AV
 dP0AjkJXRwtPscsCbeprhvmtvLGQAhXdjG5Hmn46uGA6rZbfExeGNNxQBfsUXpfU7yUOzUsSU
 DmFTc+v0kjqWMIeCAQzgjSi0R8Mfzji7074NFRSfpc0/DONgGjpGmqhrzVWIx9C5qFbPYlcJ0
 nnfOUXV0F0fJ+eAFVd0O6NyouQx8Z+wbg7WdV7eKYUO35dkSfz6wwpHZ0k1IaILmYVWAXxa2z
 9g8kG3t1X1c/Me8h04tQ7jCdRFhWUyPURYgPM8yCLbHHD3X4Wa0Rc1LjdOEkM1/b4GeLwforY
 CHPCWGslqD1181vdPWAunt79RAecXGSKx8CR+izX2U0DwrF4g8s4N6byMj22rgrS1yDdbbjGa
 wvqTHWn0CTlAR6ERTfG6+/PAn5tXpdeAlSAh+dEfeSgTR7+9S2Y+4XKK6/VIfdjmjM76a5UFp
 HrYI94ZqbzqFbhZDSESHcejvpJXfZeZA3qpdH6nyY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PATCH v10 2/9] dp8393x: manage big endian bus
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
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


