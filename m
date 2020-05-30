Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:36:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E5D20723
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 08:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E5D20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jewyV-0005ZL-Ay
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 04:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jewxR-0004SF-AW; Sat, 30 May 2020 04:35:09 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:51287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jewxP-0002qz-AK; Sat, 30 May 2020 04:35:08 -0400
Received: from localhost.localdomain (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3B175100003;
 Sat, 30 May 2020 08:35:00 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Subject: [PATCH v2] hw/net/imx_fec.c: Convert debug fprintf() to trace event
Date: Sat, 30 May 2020 10:34:58 +0200
Message-Id: <20200530083458.179819-1-jcd@tribudubois.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.70.178.231; envelope-from=jcd@tribudubois.net;
 helo=relay11.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 04:35:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, peter.chubb@nicta.com.au, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---

 v2: fix coding style issues.

 hw/net/imx_fec.c    | 101 ++++++++++++++++++--------------------------
 hw/net/trace-events |  18 ++++++++
 2 files changed, 58 insertions(+), 61 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 7adcc9df654..853d47deeb6 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -31,34 +31,11 @@
 #include "qemu/module.h"
 #include "net/checksum.h"
 #include "net/eth.h"
+#include "trace.h"
 
 /* For crc32 */
 #include <zlib.h>
 
-#ifndef DEBUG_IMX_FEC
-#define DEBUG_IMX_FEC 0
-#endif
-
-#define FEC_PRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_FEC) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_FEC, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
-
-#ifndef DEBUG_IMX_PHY
-#define DEBUG_IMX_PHY 0
-#endif
-
-#define PHY_PRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_PHY) { \
-            fprintf(stderr, "[%s.phy]%s: " fmt , TYPE_IMX_FEC, \
-                                                 __func__, ##args); \
-        } \
-    } while (0)
-
 #define IMX_MAX_DESC    1024
 
 static const char *imx_default_reg_name(IMXFECState *s, uint32_t index)
@@ -262,43 +239,45 @@ static void imx_eth_update(IMXFECState *s);
  * For now we don't handle any GPIO/interrupt line, so the OS will
  * have to poll for the PHY status.
  */
-static void phy_update_irq(IMXFECState *s)
+static void imx_phy_update_irq(IMXFECState *s)
 {
     imx_eth_update(s);
 }
 
-static void phy_update_link(IMXFECState *s)
+static void imx_phy_update_link(IMXFECState *s)
 {
     /* Autonegotiation status mirrors link status.  */
     if (qemu_get_queue(s->nic)->link_down) {
-        PHY_PRINTF("link is down\n");
+        trace_imx_phy_update_link("down");
         s->phy_status &= ~0x0024;
         s->phy_int |= PHY_INT_DOWN;
     } else {
-        PHY_PRINTF("link is up\n");
+        trace_imx_phy_update_link("up");
         s->phy_status |= 0x0024;
         s->phy_int |= PHY_INT_ENERGYON;
         s->phy_int |= PHY_INT_AUTONEG_COMPLETE;
     }
-    phy_update_irq(s);
+    imx_phy_update_irq(s);
 }
 
 static void imx_eth_set_link(NetClientState *nc)
 {
-    phy_update_link(IMX_FEC(qemu_get_nic_opaque(nc)));
+    imx_phy_update_link(IMX_FEC(qemu_get_nic_opaque(nc)));
 }
 
-static void phy_reset(IMXFECState *s)
+static void imx_phy_reset(IMXFECState *s)
 {
+    trace_imx_phy_reset();
+
     s->phy_status = 0x7809;
     s->phy_control = 0x3000;
     s->phy_advertise = 0x01e1;
     s->phy_int_mask = 0;
     s->phy_int = 0;
-    phy_update_link(s);
+    imx_phy_update_link(s);
 }
 
-static uint32_t do_phy_read(IMXFECState *s, int reg)
+static uint32_t imx_phy_read(IMXFECState *s, int reg)
 {
     uint32_t val;
 
@@ -332,7 +311,7 @@ static uint32_t do_phy_read(IMXFECState *s, int reg)
     case 29:    /* Interrupt source.  */
         val = s->phy_int;
         s->phy_int = 0;
-        phy_update_irq(s);
+        imx_phy_update_irq(s);
         break;
     case 30:    /* Interrupt mask */
         val = s->phy_int_mask;
@@ -352,14 +331,14 @@ static uint32_t do_phy_read(IMXFECState *s, int reg)
         break;
     }
 
-    PHY_PRINTF("read 0x%04x @ %d\n", val, reg);
+    trace_imx_phy_read(val, reg);
 
     return val;
 }
 
-static void do_phy_write(IMXFECState *s, int reg, uint32_t val)
+static void imx_phy_write(IMXFECState *s, int reg, uint32_t val)
 {
-    PHY_PRINTF("write 0x%04x @ %d\n", val, reg);
+    trace_imx_phy_write(val, reg);
 
     if (reg > 31) {
         /* we only advertise one phy */
@@ -369,7 +348,7 @@ static void do_phy_write(IMXFECState *s, int reg, uint32_t val)
     switch (reg) {
     case 0:     /* Basic Control */
         if (val & 0x8000) {
-            phy_reset(s);
+            imx_phy_reset(s);
         } else {
             s->phy_control = val & 0x7980;
             /* Complete autonegotiation immediately.  */
@@ -383,7 +362,7 @@ static void do_phy_write(IMXFECState *s, int reg, uint32_t val)
         break;
     case 30:    /* Interrupt mask */
         s->phy_int_mask = val & 0xff;
-        phy_update_irq(s);
+        imx_phy_update_irq(s);
         break;
     case 17:
     case 18:
@@ -402,6 +381,8 @@ static void do_phy_write(IMXFECState *s, int reg, uint32_t val)
 static void imx_fec_read_bd(IMXFECBufDesc *bd, dma_addr_t addr)
 {
     dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd));
+
+    trace_imx_fec_read_bd(addr, bd->flags, bd->length, bd->data);
 }
 
 static void imx_fec_write_bd(IMXFECBufDesc *bd, dma_addr_t addr)
@@ -412,6 +393,9 @@ static void imx_fec_write_bd(IMXFECBufDesc *bd, dma_addr_t addr)
 static void imx_enet_read_bd(IMXENETBufDesc *bd, dma_addr_t addr)
 {
     dma_memory_read(&address_space_memory, addr, bd, sizeof(*bd));
+
+    trace_imx_enet_read_bd(addr, bd->flags, bd->length, bd->data,
+                   bd->option, bd->status);
 }
 
 static void imx_enet_write_bd(IMXENETBufDesc *bd, dma_addr_t addr)
@@ -471,11 +455,9 @@ static void imx_fec_do_tx(IMXFECState *s)
         int len;
 
         imx_fec_read_bd(&bd, addr);
-        FEC_PRINTF("tx_bd %x flags %04x len %d data %08x\n",
-                   addr, bd.flags, bd.length, bd.data);
         if ((bd.flags & ENET_BD_R) == 0) {
             /* Run out of descriptors to transmit.  */
-            FEC_PRINTF("tx_bd ran out of descriptors to transmit\n");
+            trace_imx_fec_do_tx();
             break;
         }
         len = bd.length;
@@ -552,9 +534,6 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
         int len;
 
         imx_enet_read_bd(&bd, addr);
-        FEC_PRINTF("tx_bd %x flags %04x len %d data %08x option %04x "
-                   "status %04x\n", addr, bd.flags, bd.length, bd.data,
-                   bd.option, bd.status);
         if ((bd.flags & ENET_BD_R) == 0) {
             /* Run out of descriptors to transmit.  */
             break;
@@ -633,7 +612,7 @@ static void imx_eth_enable_rx(IMXFECState *s, bool flush)
     s->regs[ENET_RDAR] = (bd.flags & ENET_BD_E) ? ENET_RDAR_RDAR : 0;
 
     if (!s->regs[ENET_RDAR]) {
-        FEC_PRINTF("RX buffer full\n");
+        trace_imx_eth_enable_rx();
     } else if (flush) {
         qemu_flush_queued_packets(qemu_get_queue(s->nic));
     }
@@ -676,7 +655,7 @@ static void imx_eth_reset(DeviceState *d)
     memset(s->tx_descriptor, 0, sizeof(s->tx_descriptor));
 
     /* We also reset the PHY */
-    phy_reset(s);
+    imx_phy_reset(s);
 }
 
 static uint32_t imx_default_read(IMXFECState *s, uint32_t index)
@@ -774,8 +753,7 @@ static uint64_t imx_eth_read(void *opaque, hwaddr offset, unsigned size)
         break;
     }
 
-    FEC_PRINTF("reg[%s] => 0x%" PRIx32 "\n", imx_eth_reg_name(s, index),
-                                              value);
+    trace_imx_eth_read(imx_eth_reg_name(s, index), value);
 
     return value;
 }
@@ -884,8 +862,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
     const bool single_tx_ring = !imx_eth_is_multi_tx_ring(s);
     uint32_t index = offset >> 2;
 
-    FEC_PRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx_eth_reg_name(s, index),
-                (uint32_t)value);
+    trace_imx_eth_write(imx_eth_reg_name(s, index), (uint32_t)value);
 
     switch (index) {
     case ENET_EIR:
@@ -940,12 +917,12 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
         if (extract32(value, 29, 1)) {
             /* This is a read operation */
             s->regs[ENET_MMFR] = deposit32(s->regs[ENET_MMFR], 0, 16,
-                                           do_phy_read(s,
+                                           imx_phy_read(s,
                                                        extract32(value,
                                                                  18, 10)));
         } else {
             /* This a write operation */
-            do_phy_write(s, extract32(value, 18, 10), extract32(value, 0, 16));
+            imx_phy_write(s, extract32(value, 18, 10), extract32(value, 0, 16));
         }
         /* raise the interrupt as the PHY operation is done */
         s->regs[ENET_EIR] |= ENET_INT_MII;
@@ -1053,8 +1030,6 @@ static bool imx_eth_can_receive(NetClientState *nc)
 {
     IMXFECState *s = IMX_FEC(qemu_get_nic_opaque(nc));
 
-    FEC_PRINTF("\n");
-
     return !!s->regs[ENET_RDAR];
 }
 
@@ -1071,7 +1046,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
     unsigned int buf_len;
     size_t size = len;
 
-    FEC_PRINTF("len %d\n", (int)size);
+    trace_imx_fec_receive(size);
 
     if (!s->regs[ENET_RDAR]) {
         qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Unexpected packet\n",
@@ -1113,7 +1088,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
         bd.length = buf_len;
         size -= buf_len;
 
-        FEC_PRINTF("rx_bd 0x%x length %d\n", addr, bd.length);
+        trace_imx_fec_receive_len(addr, bd.length);
 
         /* The last 4 bytes are the CRC.  */
         if (size < 4) {
@@ -1131,7 +1106,9 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
         if (size == 0) {
             /* Last buffer in frame.  */
             bd.flags |= flags | ENET_BD_L;
-            FEC_PRINTF("rx frame flags %04x\n", bd.flags);
+
+            trace_imx_fec_receive_last(bd.flags);
+
             s->regs[ENET_EIR] |= ENET_INT_RXF;
         } else {
             s->regs[ENET_EIR] |= ENET_INT_RXB;
@@ -1164,7 +1141,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
     size_t size = len;
     bool shift16 = s->regs[ENET_RACC] & ENET_RACC_SHIFT16;
 
-    FEC_PRINTF("len %d\n", (int)size);
+    trace_imx_enet_receive(size);
 
     if (!s->regs[ENET_RDAR]) {
         qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Unexpected packet\n",
@@ -1210,7 +1187,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
         bd.length = buf_len;
         size -= buf_len;
 
-        FEC_PRINTF("rx_bd 0x%x length %d\n", addr, bd.length);
+        trace_imx_enet_receive_len(addr, bd.length);
 
         /* The last 4 bytes are the CRC.  */
         if (size < 4) {
@@ -1246,7 +1223,9 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
         if (size == 0) {
             /* Last buffer in frame.  */
             bd.flags |= flags | ENET_BD_L;
-            FEC_PRINTF("rx frame flags %04x\n", bd.flags);
+
+            trace_imx_enet_receive_last(bd.flags);
+
             /* Indicate that we've updated the last buffer descriptor. */
             bd.last_buffer = ENET_BD_BDU;
             if (bd.option & ENET_BD_RX_INT) {
diff --git a/hw/net/trace-events b/hw/net/trace-events
index e18f883cfd4..2344c002694 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -408,3 +408,21 @@ i82596_receive_packet(size_t sz) "len=%zu"
 i82596_new_mac(const char *id_with_mac) "New MAC for: %s"
 i82596_set_multicast(uint16_t count) "Added %d multicast entries"
 i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"
+
+# imx_fec.c
+imx_phy_read(uint32_t val, int reg) "0x%04x <= reg[%d]"
+imx_phy_write(uint32_t val, int reg) "0x%04x => reg[%d]"
+imx_phy_update_link(const char *s) "%s"
+imx_phy_reset(void) ""
+imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd 0x%lx flags 0x%04x len %d data 0x%08x"
+imx_enet_read_bd(uint64_t addr, int flags, int len, int data, int options, int status) "tx_bd 0x%lx flags 0x%04x len %d data 0x%08x option 0x%04x status 0x%04x"
+imx_fec_do_tx(void) "tx_bd ran out of descriptors to transmit"
+imx_eth_enable_rx(void) "RX buffer is full"
+imx_eth_read(const char *reg, uint32_t value) "reg[%s] => 0x%08x"
+imx_eth_write(const char *reg, uint32_t value) "reg[%s] <= 0x%08x"
+imx_fec_receive(size_t size) "len %ld"
+imx_fec_receive_len(uint64_t addr, int len) "rx_bd 0x%lx length %d"
+imx_fec_receive_last(int last) "rx frame flags 0x%04x"
+imx_enet_receive(size_t size) "len %ld"
+imx_enet_receive_len(uint64_t addr, int len) "rx_bd 0x%lx length %d"
+imx_enet_receive_last(int last) "rx frame flags 0x%04x"
-- 
2.25.1


