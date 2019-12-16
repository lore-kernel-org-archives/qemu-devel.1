Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F06C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:21:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65AD20725
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWpNzHn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65AD20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoRI-000541-7Y
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFa-0007Yt-QS
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFZ-0007gp-4C
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:18 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:55909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFY-0007fh-TS
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:17 -0500
Received: by mail-wm1-x32b.google.com with SMTP id q9so6246033wmj.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sqHoAwkhNl/Lv1gv8tFshXJ8XtXJpiotpdOiAG6Y6qE=;
 b=MWpNzHn3+99FF5Q++GWsN1zi3j9pf91a+5ma60V0Xk71xaaLBDjXKfcpXZO/ybS15N
 vP6BJ9sPxwBTbxl+dCyiw3BwPPN4K5SxgXOwx3hZmNDM2XHELuZxy/5or/gOR1rOksNv
 eK5LsoCKd6bP5xvKKrGRLOCvIozJGwuorRvq/J81YnbD6sMN3EXxbCQApnhVvV3ME8SO
 +0/Hy0p813fHMdhSdvL53JXxYN8I8DZTe42EBTLSdXRuplOw5Y68I8ddk+raH+ed9zyA
 eto6/wBCv42fQ3c1YL9NM4Ax4n8jDl9UA3rkXoZrelqwMR/Gje1KL3Fr0oeTwjrgmgGi
 AEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sqHoAwkhNl/Lv1gv8tFshXJ8XtXJpiotpdOiAG6Y6qE=;
 b=jL6i/rTB0gw8Q5QRkmQq08J1dhlobqZTwib3Ok+GJdJZ2thxxGwiAE+ihTLHrwlh+r
 u4UTKmEnZCbDEZqFXF+Xvy2kNiGMiVKtt/8KBNnqNAR2SGh27cdNbyZ+8lgj4Q9GXfEq
 Y9+ICo7s+O7SmOyv4/26x05zPUfmfj1m8OWrVhE8vtTvUIFTV7zVCrYSd5CxxpkzxF5v
 4sJqBudLiKqxF/q2QurMM1m4xSH+RM9eOS1up1KP0jssFvmDxD//7ztlOhc/gFqRYNa2
 o647GJV/KBuWOcH4Ndixa/XttVwWBqrbaPPGlJ1WbRCHw3stOzLzqUqgncVPsqwD23eq
 S+6g==
X-Gm-Message-State: APjAAAVtj9vaB3QWfzjdNUlS4/vPEdwSlrqbRcCmNERjND9jJP3QFYvp
 Ipd5hZlnMyE2zvm7D3aGLHhVRoTD1DO1kA==
X-Google-Smtp-Source: APXvYqw6L2YCMc+TEe43brqQEjzvN8DGKvBr9swrn+yRDl8yXcHmwhm8u67w1YPU8NoXIe4X1NvWzg==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr29021132wmb.81.1576494555578; 
 Mon, 16 Dec 2019 03:09:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/34] aspeed/i2c: Add trace events
Date: Mon, 16 Dec 2019 11:08:37 +0000
Message-Id: <20191216110904.30815-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

From: Cédric Le Goater <clg@kaod.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-6-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/aspeed_i2c.c | 93 ++++++++++++++++++++++++++++++++++++++-------
 hw/i2c/trace-events |  9 +++++
 2 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 030d9c56be6..2da04a4bff3 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -28,6 +28,7 @@
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "trace.h"
 
 /* I2C Global Register */
 
@@ -158,6 +159,13 @@ static inline void aspeed_i2c_bus_raise_interrupt(AspeedI2CBus *bus)
 {
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
 
+    trace_aspeed_i2c_bus_raise_interrupt(bus->intr_status,
+          bus->intr_status & I2CD_INTR_TX_NAK ? "nak|" : "",
+          bus->intr_status & I2CD_INTR_TX_ACK ? "ack|" : "",
+          bus->intr_status & I2CD_INTR_RX_DONE ? "done|" : "",
+          bus->intr_status & I2CD_INTR_NORMAL_STOP ? "normal|" : "",
+          bus->intr_status & I2CD_INTR_ABNORMAL ? "abnormal" : "");
+
     bus->intr_status &= bus->intr_ctrl;
     if (bus->intr_status) {
         bus->controller->intr_status |= 1 << bus->id;
@@ -170,41 +178,57 @@ static uint64_t aspeed_i2c_bus_read(void *opaque, hwaddr offset,
 {
     AspeedI2CBus *bus = opaque;
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
+    uint64_t value = -1;
 
     switch (offset) {
     case I2CD_FUN_CTRL_REG:
-        return bus->ctrl;
+        value = bus->ctrl;
+        break;
     case I2CD_AC_TIMING_REG1:
-        return bus->timing[0];
+        value = bus->timing[0];
+        break;
     case I2CD_AC_TIMING_REG2:
-        return bus->timing[1];
+        value = bus->timing[1];
+        break;
     case I2CD_INTR_CTRL_REG:
-        return bus->intr_ctrl;
+        value = bus->intr_ctrl;
+        break;
     case I2CD_INTR_STS_REG:
-        return bus->intr_status;
+        value = bus->intr_status;
+        break;
     case I2CD_POOL_CTRL_REG:
-        return bus->pool_ctrl;
+        value = bus->pool_ctrl;
+        break;
     case I2CD_BYTE_BUF_REG:
-        return bus->buf;
+        value = bus->buf;
+        break;
     case I2CD_CMD_REG:
-        return bus->cmd | (i2c_bus_busy(bus->bus) << 16);
+        value = bus->cmd | (i2c_bus_busy(bus->bus) << 16);
+        break;
     case I2CD_DMA_ADDR:
         if (!aic->has_dma) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
-            return -1;
+            break;
         }
-        return bus->dma_addr;
+        value = bus->dma_addr;
+        break;
     case I2CD_DMA_LEN:
         if (!aic->has_dma) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: No DMA support\n",  __func__);
-            return -1;
+            break;
         }
-        return bus->dma_len;
+        value = bus->dma_len;
+        break;
+
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, offset);
-        return -1;
+        value = -1;
+        break;
     }
+
+    trace_aspeed_i2c_bus_read(bus->id, offset, size, value);
+    return value;
 }
 
 static void aspeed_i2c_set_state(AspeedI2CBus *bus, uint8_t state)
@@ -246,6 +270,9 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
         for (i = pool_start; i < I2CD_POOL_TX_COUNT(bus->pool_ctrl); i++) {
             uint8_t *pool_base = aic->bus_pool_base(bus);
 
+            trace_aspeed_i2c_bus_send("BUF", i + 1,
+                                      I2CD_POOL_TX_COUNT(bus->pool_ctrl),
+                                      pool_base[i]);
             ret = i2c_send(bus->bus, pool_base[i]);
             if (ret) {
                 break;
@@ -256,6 +283,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
         while (bus->dma_len) {
             uint8_t data;
             aspeed_i2c_dma_read(bus, &data);
+            trace_aspeed_i2c_bus_send("DMA", bus->dma_len, bus->dma_len, data);
             ret = i2c_send(bus->bus, data);
             if (ret) {
                 break;
@@ -263,6 +291,7 @@ static int aspeed_i2c_bus_send(AspeedI2CBus *bus, uint8_t pool_start)
         }
         bus->cmd &= ~I2CD_TX_DMA_ENABLE;
     } else {
+        trace_aspeed_i2c_bus_send("BYTE", pool_start, 1, bus->buf);
         ret = i2c_send(bus->bus, bus->buf);
     }
 
@@ -281,6 +310,9 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
 
         for (i = 0; i < I2CD_POOL_RX_SIZE(bus->pool_ctrl); i++) {
             pool_base[i] = i2c_recv(bus->bus);
+            trace_aspeed_i2c_bus_recv("BUF", i + 1,
+                                      I2CD_POOL_RX_SIZE(bus->pool_ctrl),
+                                      pool_base[i]);
         }
 
         /* Update RX count */
@@ -294,6 +326,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
             MemTxResult result;
 
             data = i2c_recv(bus->bus);
+            trace_aspeed_i2c_bus_recv("DMA", bus->dma_len, bus->dma_len, data);
             result = address_space_write(&s->dram_as, bus->dma_addr,
                                          MEMTXATTRS_UNSPECIFIED, &data, 1);
             if (result != MEMTX_OK) {
@@ -307,6 +340,7 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
         bus->cmd &= ~I2CD_RX_DMA_ENABLE;
     } else {
         data = i2c_recv(bus->bus);
+        trace_aspeed_i2c_bus_recv("BYTE", 1, 1, bus->buf);
         bus->buf = (data & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
     }
 }
@@ -364,6 +398,33 @@ static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
     return true;
 }
 
+static void aspeed_i2c_bus_cmd_dump(AspeedI2CBus *bus)
+{
+    g_autofree char *cmd_flags;
+    uint32_t count;
+
+    if (bus->cmd & (I2CD_RX_BUFF_ENABLE | I2CD_RX_BUFF_ENABLE)) {
+        count = I2CD_POOL_TX_COUNT(bus->pool_ctrl);
+    } else if (bus->cmd & (I2CD_RX_DMA_ENABLE | I2CD_RX_DMA_ENABLE)) {
+        count = bus->dma_len;
+    } else { /* BYTE mode */
+        count = 1;
+    }
+
+    cmd_flags = g_strdup_printf("%s%s%s%s%s%s%s%s%s",
+                                bus->cmd & I2CD_M_START_CMD ? "start|" : "",
+                                bus->cmd & I2CD_RX_DMA_ENABLE ? "rxdma|" : "",
+                                bus->cmd & I2CD_TX_DMA_ENABLE ? "txdma|" : "",
+                                bus->cmd & I2CD_RX_BUFF_ENABLE ? "rxbuf|" : "",
+                                bus->cmd & I2CD_TX_BUFF_ENABLE ? "txbuf|" : "",
+                                bus->cmd & I2CD_M_TX_CMD ? "tx|" : "",
+                                bus->cmd & I2CD_M_RX_CMD ? "rx|" : "",
+                                bus->cmd & I2CD_M_S_RX_CMD_LAST ? "last|" : "",
+                                bus->cmd & I2CD_M_STOP_CMD ? "stop" : "");
+
+    trace_aspeed_i2c_bus_cmd(bus->cmd, cmd_flags, count, bus->intr_status);
+}
+
 /*
  * The state machine needs some refinement. It is only used to track
  * invalid STOP commands for the moment.
@@ -379,6 +440,10 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
         return;
     }
 
+    if (trace_event_get_state_backends(TRACE_ASPEED_I2C_BUS_CMD)) {
+        aspeed_i2c_bus_cmd_dump(bus);
+    }
+
     if (bus->cmd & I2CD_M_START_CMD) {
         uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
             I2CD_MSTARTR : I2CD_MSTART;
@@ -465,6 +530,8 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
     bool handle_rx;
 
+    trace_aspeed_i2c_bus_write(bus->id, offset, size, value);
+
     switch (offset) {
     case I2CD_FUN_CTRL_REG:
         if (value & I2CD_SLAVE_EN) {
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index e1c810d5bd0..08db8fa6892 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -5,3 +5,12 @@
 i2c_event(const char *event, uint8_t address) "%s(addr:0x%02x)"
 i2c_send(uint8_t address, uint8_t data) "send(addr:0x%02x) data:0x%02x"
 i2c_recv(uint8_t address, uint8_t data) "recv(addr:0x%02x) data:0x%02x"
+
+# aspeed_i2c.c
+
+aspeed_i2c_bus_cmd(uint32_t cmd, const char *cmd_flags, uint32_t count, uint32_t intr_status) "handling cmd=0x%x %s count=%d intr=0x%x"
+aspeed_i2c_bus_raise_interrupt(uint32_t intr_status, const char *str1, const char *str2, const char *str3, const char *str4, const char *str5) "handled intr=0x%x %s%s%s%s%s"
+aspeed_i2c_bus_read(uint32_t busid, uint64_t offset, unsigned size, uint64_t value) "bus[%d]: To 0x%" PRIx64 " of size %u: 0x%" PRIx64
+aspeed_i2c_bus_write(uint32_t busid, uint64_t offset, unsigned size, uint64_t value) "bus[%d]: To 0x%" PRIx64 " of size %u: 0x%" PRIx64
+aspeed_i2c_bus_send(const char *mode, int i, int count, uint8_t byte) "%s send %d/%d 0x%02x"
+aspeed_i2c_bus_recv(const char *mode, int i, int count, uint8_t byte) "%s recv %d/%d 0x%02x"
-- 
2.20.1


