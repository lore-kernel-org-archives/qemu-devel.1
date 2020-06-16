Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF25C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A664920707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOGBVZQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A664920707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8YY-0002te-Uo
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LV-0007jK-Uq
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LT-000441-N8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id j198so1888842wmj.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yV6zq6/vjo+Fdrha6af2dr9oOxkMAKU4dYXCHkXr58M=;
 b=rOGBVZQXwZZRcpvNrqz1bwYKJdOEN2Q7ultRB/kcD/nIrlI+4HcmXaMv2O+iCsHvD3
 wj6BVEbW8wOunY0qlu9cI5zi23Iy6VG5kiuiXnUMIgkXyga4IhnlOwpklCcELppaUemr
 nkEfkH0qtsuSlCDOgkeoTW02n1Mf4fHcoKU/7BpG7jBwXCIs0vuqhTcedhWcKU/0aumn
 hhTWFF7Rti3zlM9Jiar3GgDwbqHnelriPIcJz2iRqp1NK6bKihGsJGU7i/kJOnhxfJ7o
 gphMcC0Y6hMXo36MVj5JjQdO1xSK7k3i3yr69jGg3WvrcdpnituMyG8q3OXY1A7KoO6J
 JA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yV6zq6/vjo+Fdrha6af2dr9oOxkMAKU4dYXCHkXr58M=;
 b=M+xf94BtJgUj1mcocc3eevoNMynQsvn15BB+0TIqH3i3QFoO521qkeeYS8JRbc4hz+
 Jo6L2F+aMV2VHdcg9opeMJiAGYGWQNIXFtakucUe4EDiLrUXcKFKivNDstzc+plnG2hP
 xq6b2C6nhjNk9qaWrxQdt7PP6SQHopEXLEG9z52juZjgUPx71rvUE9MzRfUWRr1HVTal
 4v2NYGMe+xQe6+vZhJt7WZPBsl56WXGtE3tzu2qgdCyV52Alm0rlJoDsXtpDmXC2fSVU
 mONvXUglukVom67f6ightLLb5hgNySxfjSdQFFWlBuZ4JNS57RWN1LY0H96DW37qm9gy
 WqwA==
X-Gm-Message-State: AOAM531zb3cYNOGJOiHY6DC8gDLVp1+7zdvQ1c8G0TMHFTVlDWUSQBJ9
 LswPUvs/c3mOXJxPJSTz4i196F8wfaiJKg==
X-Google-Smtp-Source: ABdhPJynyxx9JGl4ezDtWM7vijgMiZrrKoJvT2NeRT7BKtm8iB95X7Yo3kmFosXdxlYPXZA+kA+Jvw==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr2371975wmf.4.1592301449863; 
 Tue, 16 Jun 2020 02:57:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/23] hw/net/imx_fec: Convert debug fprintf() to trace events
Date: Tue, 16 Jun 2020 10:57:00 +0100
Message-Id: <20200616095702.25848-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jean-Christophe Dubois <jcd@tribudubois.net>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: Fixed 32-bit format string using PRIx32/PRIx64]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/imx_fec.c    | 106 +++++++++++++++++++-------------------------
 hw/net/trace-events |  18 ++++++++
 2 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 7adcc9df654..eefedc252de 100644
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
@@ -471,11 +455,11 @@ static void imx_fec_do_tx(IMXFECState *s)
         int len;
 
         imx_fec_read_bd(&bd, addr);
-        FEC_PRINTF("tx_bd %x flags %04x len %d data %08x\n",
-                   addr, bd.flags, bd.length, bd.data);
         if ((bd.flags & ENET_BD_R) == 0) {
+
             /* Run out of descriptors to transmit.  */
-            FEC_PRINTF("tx_bd ran out of descriptors to transmit\n");
+            trace_imx_eth_tx_bd_busy();
+
             break;
         }
         len = bd.length;
@@ -552,11 +536,11 @@ static void imx_enet_do_tx(IMXFECState *s, uint32_t index)
         int len;
 
         imx_enet_read_bd(&bd, addr);
-        FEC_PRINTF("tx_bd %x flags %04x len %d data %08x option %04x "
-                   "status %04x\n", addr, bd.flags, bd.length, bd.data,
-                   bd.option, bd.status);
         if ((bd.flags & ENET_BD_R) == 0) {
             /* Run out of descriptors to transmit.  */
+
+            trace_imx_eth_tx_bd_busy();
+
             break;
         }
         len = bd.length;
@@ -633,7 +617,7 @@ static void imx_eth_enable_rx(IMXFECState *s, bool flush)
     s->regs[ENET_RDAR] = (bd.flags & ENET_BD_E) ? ENET_RDAR_RDAR : 0;
 
     if (!s->regs[ENET_RDAR]) {
-        FEC_PRINTF("RX buffer full\n");
+        trace_imx_eth_rx_bd_full();
     } else if (flush) {
         qemu_flush_queued_packets(qemu_get_queue(s->nic));
     }
@@ -676,7 +660,7 @@ static void imx_eth_reset(DeviceState *d)
     memset(s->tx_descriptor, 0, sizeof(s->tx_descriptor));
 
     /* We also reset the PHY */
-    phy_reset(s);
+    imx_phy_reset(s);
 }
 
 static uint32_t imx_default_read(IMXFECState *s, uint32_t index)
@@ -774,8 +758,7 @@ static uint64_t imx_eth_read(void *opaque, hwaddr offset, unsigned size)
         break;
     }
 
-    FEC_PRINTF("reg[%s] => 0x%" PRIx32 "\n", imx_eth_reg_name(s, index),
-                                              value);
+    trace_imx_eth_read(index, imx_eth_reg_name(s, index), value);
 
     return value;
 }
@@ -884,8 +867,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
     const bool single_tx_ring = !imx_eth_is_multi_tx_ring(s);
     uint32_t index = offset >> 2;
 
-    FEC_PRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx_eth_reg_name(s, index),
-                (uint32_t)value);
+    trace_imx_eth_write(index, imx_eth_reg_name(s, index), value);
 
     switch (index) {
     case ENET_EIR:
@@ -940,12 +922,12 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
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
@@ -1053,8 +1035,6 @@ static bool imx_eth_can_receive(NetClientState *nc)
 {
     IMXFECState *s = IMX_FEC(qemu_get_nic_opaque(nc));
 
-    FEC_PRINTF("\n");
-
     return !!s->regs[ENET_RDAR];
 }
 
@@ -1071,7 +1051,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
     unsigned int buf_len;
     size_t size = len;
 
-    FEC_PRINTF("len %d\n", (int)size);
+    trace_imx_fec_receive(size);
 
     if (!s->regs[ENET_RDAR]) {
         qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Unexpected packet\n",
@@ -1113,7 +1093,7 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
         bd.length = buf_len;
         size -= buf_len;
 
-        FEC_PRINTF("rx_bd 0x%x length %d\n", addr, bd.length);
+        trace_imx_fec_receive_len(addr, bd.length);
 
         /* The last 4 bytes are the CRC.  */
         if (size < 4) {
@@ -1131,7 +1111,9 @@ static ssize_t imx_fec_receive(NetClientState *nc, const uint8_t *buf,
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
@@ -1164,7 +1146,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
     size_t size = len;
     bool shift16 = s->regs[ENET_RACC] & ENET_RACC_SHIFT16;
 
-    FEC_PRINTF("len %d\n", (int)size);
+    trace_imx_enet_receive(size);
 
     if (!s->regs[ENET_RDAR]) {
         qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Unexpected packet\n",
@@ -1210,7 +1192,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
         bd.length = buf_len;
         size -= buf_len;
 
-        FEC_PRINTF("rx_bd 0x%x length %d\n", addr, bd.length);
+        trace_imx_enet_receive_len(addr, bd.length);
 
         /* The last 4 bytes are the CRC.  */
         if (size < 4) {
@@ -1246,7 +1228,9 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
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
index e18f883cfd4..26700dad997 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -408,3 +408,21 @@ i82596_receive_packet(size_t sz) "len=%zu"
 i82596_new_mac(const char *id_with_mac) "New MAC for: %s"
 i82596_set_multicast(uint16_t count) "Added %d multicast entries"
 i82596_channel_attention(void *s) "%p: Received CHANNEL ATTENTION"
+
+# imx_fec.c
+imx_phy_read(uint32_t val, int reg) "0x%04"PRIx32" <= reg[%d]"
+imx_phy_write(uint32_t val, int reg) "0x%04"PRIx32" => reg[%d]"
+imx_phy_update_link(const char *s) "%s"
+imx_phy_reset(void) ""
+imx_fec_read_bd(uint64_t addr, int flags, int len, int data) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x"
+imx_enet_read_bd(uint64_t addr, int flags, int len, int data, int options, int status) "tx_bd 0x%"PRIx64" flags 0x%04x len %d data 0x%08x option 0x%04x status 0x%04x"
+imx_eth_tx_bd_busy(void) "tx_bd ran out of descriptors to transmit"
+imx_eth_rx_bd_full(void) "RX buffer is full"
+imx_eth_read(int reg, const char *reg_name, uint32_t value) "reg[%d:%s] => 0x%08"PRIx32
+imx_eth_write(int reg, const char *reg_name, uint64_t value) "reg[%d:%s] <= 0x%08"PRIx64
+imx_fec_receive(size_t size) "len %zu"
+imx_fec_receive_len(uint64_t addr, int len) "rx_bd 0x%"PRIx64" length %d"
+imx_fec_receive_last(int last) "rx frame flags 0x%04x"
+imx_enet_receive(size_t size) "len %zu"
+imx_enet_receive_len(uint64_t addr, int len) "rx_bd 0x%"PRIx64" length %d"
+imx_enet_receive_last(int last) "rx frame flags 0x%04x"
-- 
2.20.1


