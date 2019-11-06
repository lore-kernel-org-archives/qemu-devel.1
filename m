Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D0C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF2420659
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF2420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJTR-0002Xm-4b
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSJPn-0007zu-Bd
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSJPl-0000as-G4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:55 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:39173)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iSJPl-0000X2-5o
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:23:53 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N49d1-1hkUCW3Spl-0105wm; Wed, 06 Nov 2019 12:23:46 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] dp8393x: put the DMA buffer in the state structure
Date: Wed,  6 Nov 2019 12:23:40 +0100
Message-Id: <20191106112341.23735-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191106112341.23735-1-laurent@vivier.eu>
References: <20191106112341.23735-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ph0vUdpbQKMk9zryzaiBGsmREIV/etHPXOiTtByPQA85xQyyenV
 hHBmw+cvBqFC7GxPn9g/1DdCpQWfLPMM35FWmdCQgPlnLARiy546vNLP3qwMScD7VGS3+aP
 9Oa64wl+Z7JBmgyqElX2VEAkiEWop/mg+LViKukW5KcxE5q9eVRJ4jE1zTLmP6BtY5rVyaR
 gMld9qUGtH73rRowsrpvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y5GFsLTs9dk=:QMSvxEnXql/i7ICvF6sDgt
 A6sqtEMdBnpcPwT67ABcr6gdG4eXzCsjmf4FNjitP9e50TE9HgcXwV0zo1MODNxTX54PEDeXL
 HzbEwVFQSDJW1jPUzfVa9/NkdLi3qYbWGFhUWAfSYNPTU6aq5GypvDmFTeN9Xy4goLLdt0Y9S
 6xplWg4YVj2ViIkmXrS8m4Whr7JYIvIkPh4yI4NA3+o7wzGMsZmQuSbcjwwTXc0a4XAPbq6s6
 4S5tC51IQXQGeGdaMU9kydfQ6EPWHWHry0bOCXNo61Kgqryd5NlomR2tgwxQW4wlSoEtohztI
 QBQF3HSmtluZ35DvCiWoSmtdtdqcai2yjUUc5vuXQEcY+LTq1IXjr48QDyFIEhtGD9GeP9tyE
 WTKminHWd7OGCjyjCl2mBCPyNfTu6dljGui9rueKlDLH4ml6tprvgOtdo5cXIQzZc/tAiWHyR
 A5QS3HMjqZAwUGTJagwTePNJlb9/L0oO8Js08PFPzBLVmh+pneZYOK/ITcAO4iwgrZhj36h2S
 aUwmZiBXJlMHynttsJWm0H7u1ML3wqva4BBzHFVRZPiSvkFXNsNQS6YjVHruA8JdjXduwuUCB
 Y3LGC0fCYzzVGeun5u53xo8ozjVYc2tU0MPUlOrSmUAoTwtiVXj5SfBh8oOsXPTEWK3KSJlpz
 DJQCk/E1xkV1ivhvdudzTqeGNUluf0LVZKfceHRBSiL3X8F4lVITtPPSyxzp60ll88Ng9t9zm
 bS7UPxjsP2r4nSWdaYdGmnu+F0oUIZdNb31kCZwOpZde0sT7YOhc9jinqwyqSw2W3TOo7YGF+
 OP06QHrpSi/DMYwb2UILhQAk76UC3ErpTIyH4DA0a0tWnl9dE+//y4g/YgImlKtLdifF4urYi
 h+nHhh3uTL96ZkXiUiVw==
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


