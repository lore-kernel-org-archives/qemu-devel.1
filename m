Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75554C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 22:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3058B20672
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 22:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dtbKckZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3058B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jteoy-00007k-Fs
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 18:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45291e402=alistair.francis@wdc.com>)
 id 1jteoA-0007Xd-9z; Thu, 09 Jul 2020 18:14:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3638)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=45291e402=alistair.francis@wdc.com>)
 id 1jteo7-0003yw-LA; Thu, 09 Jul 2020 18:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594332859; x=1625868859;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7dbPKaY43FTYNItiOQnARPGjvTidJRiT5AM7+OjgX6o=;
 b=dtbKckZP7sYkS5r/rsP11aCDfPzYcc+T/TqRwaNuOJjw7T0ZgHCGSdxy
 ELUSQ6B3hQm7ClaocNttqxeow2eHRKmvL8g+Hp9DXP1QhoIL5bRfQ11Mt
 +1BzRw8T8Ga/4vEclwIAya2i6msg+7u0HKmPj3MscX8FLsY6V7fXllglh
 pv/eugHVwSvzgXjbS7aIIHGoOUVVAE3w+/DqdHzhRcnJy2gdnGMgU41f6
 reDlI6Xj3wWwDB9vB+GXpyFZN/b0QGazjdYXFdBR3ggEapig7f4BkHSj6
 CuMYwSgToz5/xt28D/9RZCC3k8IhmsyClXRBTrSOBtLiul3p9xx5aBpVn w==;
IronPort-SDR: h/F2vkUaBfSTSA4ZBw075+9VVIpWHi1NHA5SGaNDRCM6JL0ZykCDonDSRxwdcQTpeRl1tsxoeR
 aYNfySokGNWPw7BB4dMRrH3uSHNbquh6xPIyYpIryBMexoMtFbNdNrr3RKX8rpzCWwZST8UJ74
 I7I7OF18Flu61+mjSAuyJ7LIWdS2E5hYDgsNTipB6z4oM7Jq67tjXG4SmuhH0WC3IxVTNuaEB6
 lAwKA6nxLhq44t8aghMSw8frovAyoGzLIW6chhZMs5UfQQlluwm/rDhwjtggcfFiWSyb7+HPEa
 xQM=
X-IronPort-AV: E=Sophos;i="5.75,332,1589212800"; d="scan'208";a="146394145"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2020 06:14:17 +0800
IronPort-SDR: x+Hu+HUOmyS7b3NFr4gqTa+i966+hW27S1Ib4qmpmLftrHTGTf0XkM3m8fy13pkC1sIw8QfDLm
 tPH12V4FDYmAPIMEf1dRAXFI2vwqVIqBo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 15:02:52 -0700
IronPort-SDR: /NvqU3AFdBSh0s21WChMME0poJuq9y1tOzlkLQzNoIOjW7Y/5LH8tK/gZ8ms9QQEZAA47b+nU5
 qVeYcMiejzuw==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.245])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Jul 2020 15:14:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 v2 2/2] hw/char: Convert the Ibex UART to use the
 registerfields API
Date: Thu,  9 Jul 2020 15:04:51 -0700
Message-Id: <06372c9cdeec715077899e71c858d9f0a2a3395b.1594332223.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1594332223.git.alistair.francis@wdc.com>
References: <cover.1594332223.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=45291e402=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 18:14:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/char/ibex_uart.h |  76 ++++++++++-----------
 hw/char/ibex_uart.c         | 130 ++++++++++++++++++------------------
 2 files changed, 100 insertions(+), 106 deletions(-)

diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
index 6d81051161..b6bd5a6700 100644
--- a/include/hw/char/ibex_uart.h
+++ b/include/hw/char/ibex_uart.h
@@ -26,50 +26,44 @@
 #define HW_IBEX_UART_H
 
 #include "hw/sysbus.h"
+#include "hw/registerfields.h"
 #include "chardev/char-fe.h"
 #include "qemu/timer.h"
 
-#define IBEX_UART_INTR_STATE   0x00
-    #define INTR_STATE_TX_WATERMARK (1 << 0)
-    #define INTR_STATE_RX_WATERMARK (1 << 1)
-    #define INTR_STATE_TX_EMPTY     (1 << 2)
-    #define INTR_STATE_RX_OVERFLOW  (1 << 3)
-#define IBEX_UART_INTR_ENABLE  0x04
-#define IBEX_UART_INTR_TEST    0x08
-
-#define IBEX_UART_CTRL         0x0c
-    #define UART_CTRL_TX_ENABLE     (1 << 0)
-    #define UART_CTRL_RX_ENABLE     (1 << 1)
-    #define UART_CTRL_NF            (1 << 2)
-    #define UART_CTRL_SLPBK         (1 << 4)
-    #define UART_CTRL_LLPBK         (1 << 5)
-    #define UART_CTRL_PARITY_EN     (1 << 6)
-    #define UART_CTRL_PARITY_ODD    (1 << 7)
-    #define UART_CTRL_RXBLVL        (3 << 8)
-    #define UART_CTRL_NCO           (0xFFFF << 16)
-
-#define IBEX_UART_STATUS       0x10
-    #define UART_STATUS_TXFULL  (1 << 0)
-    #define UART_STATUS_RXFULL  (1 << 1)
-    #define UART_STATUS_TXEMPTY (1 << 2)
-    #define UART_STATUS_RXIDLE  (1 << 4)
-    #define UART_STATUS_RXEMPTY (1 << 5)
-
-#define IBEX_UART_RDATA        0x14
-#define IBEX_UART_WDATA        0x18
-
-#define IBEX_UART_FIFO_CTRL    0x1c
-    #define FIFO_CTRL_RXRST          (1 << 0)
-    #define FIFO_CTRL_TXRST          (1 << 1)
-    #define FIFO_CTRL_RXILVL         (7 << 2)
-    #define FIFO_CTRL_RXILVL_SHIFT   (2)
-    #define FIFO_CTRL_TXILVL         (3 << 5)
-    #define FIFO_CTRL_TXILVL_SHIFT   (5)
-
-#define IBEX_UART_FIFO_STATUS  0x20
-#define IBEX_UART_OVRD         0x24
-#define IBEX_UART_VAL          0x28
-#define IBEX_UART_TIMEOUT_CTRL 0x2c
+REG32(INTR_STATE, 0x00)
+    FIELD(INTR_STATE, TX_WATERMARK, 0, 1)
+    FIELD(INTR_STATE, RX_WATERMARK, 1, 1)
+    FIELD(INTR_STATE, TX_EMPTY, 2, 1)
+    FIELD(INTR_STATE, RX_OVERFLOW, 3, 1)
+REG32(INTR_ENABLE, 0x04)
+REG32(INTR_TEST, 0x08)
+REG32(CTRL, 0x0C)
+    FIELD(CTRL, TX_ENABLE, 0, 1)
+    FIELD(CTRL, RX_ENABLE, 1, 1)
+    FIELD(CTRL, NF, 2, 1)
+    FIELD(CTRL, SLPBK, 4, 1)
+    FIELD(CTRL, LLPBK, 5, 1)
+    FIELD(CTRL, PARITY_EN, 6, 1)
+    FIELD(CTRL, PARITY_ODD, 7, 1)
+    FIELD(CTRL, RXBLVL, 8, 2)
+    FIELD(CTRL, NCO, 16, 16)
+REG32(STATUS, 0x10)
+    FIELD(STATUS, TXFULL, 0, 1)
+    FIELD(STATUS, RXFULL, 1, 1)
+    FIELD(STATUS, TXEMPTY, 2, 1)
+    FIELD(STATUS, RXIDLE, 4, 1)
+    FIELD(STATUS, RXEMPTY, 5, 1)
+REG32(RDATA, 0x14)
+REG32(WDATA, 0x18)
+REG32(FIFO_CTRL, 0x1c)
+    FIELD(FIFO_CTRL, RXRST, 0, 1)
+    FIELD(FIFO_CTRL, TXRST, 1, 1)
+    FIELD(FIFO_CTRL, RXILVL, 2, 3)
+    FIELD(FIFO_CTRL, TXILVL, 5, 2)
+REG32(FIFO_STATUS, 0x20)
+REG32(OVRD, 0x24)
+REG32(VAL, 0x28)
+REG32(TIMEOUT_CTRL, 0x2c)
 
 #define IBEX_UART_TX_FIFO_SIZE 16
 #define IBEX_UART_CLOCK 50000000 /* 50MHz clock */
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index ab6247de89..cc49a35013 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -36,25 +36,25 @@
 
 static void ibex_uart_update_irqs(IbexUartState *s)
 {
-    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_TX_WATERMARK) {
+    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_WATERMARK_MASK) {
         qemu_set_irq(s->tx_watermark, 1);
     } else {
         qemu_set_irq(s->tx_watermark, 0);
     }
 
-    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_RX_WATERMARK) {
+    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_RX_WATERMARK_MASK) {
         qemu_set_irq(s->rx_watermark, 1);
     } else {
         qemu_set_irq(s->rx_watermark, 0);
     }
 
-    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_TX_EMPTY) {
+    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_TX_EMPTY_MASK) {
         qemu_set_irq(s->tx_empty, 1);
     } else {
         qemu_set_irq(s->tx_empty, 0);
     }
 
-    if (s->uart_intr_state & s->uart_intr_enable & INTR_STATE_RX_OVERFLOW) {
+    if (s->uart_intr_state & s->uart_intr_enable & R_INTR_STATE_RX_OVERFLOW_MASK) {
         qemu_set_irq(s->rx_overflow, 1);
     } else {
         qemu_set_irq(s->rx_overflow, 0);
@@ -65,7 +65,7 @@ static int ibex_uart_can_receive(void *opaque)
 {
     IbexUartState *s = opaque;
 
-    if (s->uart_ctrl & UART_CTRL_RX_ENABLE) {
+    if (s->uart_ctrl & R_CTRL_RX_ENABLE_MASK) {
         return 1;
     }
 
@@ -75,16 +75,16 @@ static int ibex_uart_can_receive(void *opaque)
 static void ibex_uart_receive(void *opaque, const uint8_t *buf, int size)
 {
     IbexUartState *s = opaque;
-    uint8_t rx_fifo_level = (s->uart_fifo_ctrl & FIFO_CTRL_RXILVL)
-                            >> FIFO_CTRL_RXILVL_SHIFT;
+    uint8_t rx_fifo_level = (s->uart_fifo_ctrl & R_FIFO_CTRL_RXILVL_MASK)
+                            >> R_FIFO_CTRL_RXILVL_SHIFT;
 
     s->uart_rdata = *buf;
 
-    s->uart_status &= ~UART_STATUS_RXIDLE;
-    s->uart_status &= ~UART_STATUS_RXEMPTY;
+    s->uart_status &= ~R_STATUS_RXIDLE_MASK;
+    s->uart_status &= ~R_STATUS_RXEMPTY_MASK;
 
     if (size > rx_fifo_level) {
-        s->uart_intr_state |= INTR_STATE_RX_WATERMARK;
+        s->uart_intr_state |= R_INTR_STATE_RX_WATERMARK_MASK;
     }
 
     ibex_uart_update_irqs(s);
@@ -94,8 +94,8 @@ static gboolean ibex_uart_xmit(GIOChannel *chan, GIOCondition cond,
                                void *opaque)
 {
     IbexUartState *s = opaque;
-    uint8_t tx_fifo_level = (s->uart_fifo_ctrl & FIFO_CTRL_TXILVL)
-                            >> FIFO_CTRL_TXILVL_SHIFT;
+    uint8_t tx_fifo_level = (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MASK)
+                            >> R_FIFO_CTRL_TXILVL_SHIFT;
     int ret;
 
     /* instant drain the fifo when there's no back-end */
@@ -105,10 +105,10 @@ static gboolean ibex_uart_xmit(GIOChannel *chan, GIOCondition cond,
     }
 
     if (!s->tx_level) {
-        s->uart_status &= ~UART_STATUS_TXFULL;
-        s->uart_status |= UART_STATUS_TXEMPTY;
-        s->uart_intr_state |= INTR_STATE_TX_EMPTY;
-        s->uart_intr_state &= ~INTR_STATE_TX_WATERMARK;
+        s->uart_status &= ~R_STATUS_TXFULL_MASK;
+        s->uart_status |= R_STATUS_TXEMPTY_MASK;
+        s->uart_intr_state |= R_INTR_STATE_TX_EMPTY_MASK;
+        s->uart_intr_state &= ~R_INTR_STATE_TX_WATERMARK_MASK;
         ibex_uart_update_irqs(s);
         return FALSE;
     }
@@ -131,18 +131,18 @@ static gboolean ibex_uart_xmit(GIOChannel *chan, GIOCondition cond,
 
     /* Clear the TX Full bit */
     if (s->tx_level != IBEX_UART_TX_FIFO_SIZE) {
-        s->uart_status &= ~UART_STATUS_TXFULL;
+        s->uart_status &= ~R_STATUS_TXFULL_MASK;
     }
 
     /* Disable the TX_WATERMARK IRQ */
     if (s->tx_level < tx_fifo_level) {
-        s->uart_intr_state &= ~INTR_STATE_TX_WATERMARK;
+        s->uart_intr_state &= ~R_INTR_STATE_TX_WATERMARK_MASK;
     }
 
     /* Set TX empty */
     if (s->tx_level == 0) {
-        s->uart_status |= UART_STATUS_TXEMPTY;
-        s->uart_intr_state |= INTR_STATE_TX_EMPTY;
+        s->uart_status |= R_STATUS_TXEMPTY_MASK;
+        s->uart_intr_state |= R_INTR_STATE_TX_EMPTY_MASK;
     }
 
     ibex_uart_update_irqs(s);
@@ -153,8 +153,8 @@ static void uart_write_tx_fifo(IbexUartState *s, const uint8_t *buf,
                                int size)
 {
     uint64_t current_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    uint8_t tx_fifo_level = (s->uart_fifo_ctrl & FIFO_CTRL_TXILVL)
-                            >> FIFO_CTRL_TXILVL_SHIFT;
+    uint8_t tx_fifo_level = (s->uart_fifo_ctrl & R_FIFO_CTRL_TXILVL_MASK)
+                            >> R_FIFO_CTRL_TXILVL_SHIFT;
 
     if (size > IBEX_UART_TX_FIFO_SIZE - s->tx_level) {
         size = IBEX_UART_TX_FIFO_SIZE - s->tx_level;
@@ -165,16 +165,16 @@ static void uart_write_tx_fifo(IbexUartState *s, const uint8_t *buf,
     s->tx_level += size;
 
     if (s->tx_level > 0) {
-        s->uart_status &= ~UART_STATUS_TXEMPTY;
+        s->uart_status &= ~R_STATUS_TXEMPTY_MASK;
     }
 
     if (s->tx_level >= tx_fifo_level) {
-        s->uart_intr_state |= INTR_STATE_TX_WATERMARK;
+        s->uart_intr_state |= R_INTR_STATE_TX_WATERMARK_MASK;
         ibex_uart_update_irqs(s);
     }
 
     if (s->tx_level == IBEX_UART_TX_FIFO_SIZE) {
-        s->uart_status |= UART_STATUS_TXFULL;
+        s->uart_status |= R_STATUS_TXFULL_MASK;
     }
 
     timer_mod(s->fifo_trigger_handle, current_time +
@@ -208,7 +208,7 @@ static uint64_t ibex_uart_get_baud(IbexUartState *s)
 {
     uint64_t baud;
 
-    baud = ((s->uart_ctrl & UART_CTRL_NCO) >> 16);
+    baud = ((s->uart_ctrl & R_CTRL_NCO_MASK) >> 16);
     baud *= clock_get_hz(s->f_clk);
     baud >>= 20;
 
@@ -221,43 +221,43 @@ static uint64_t ibex_uart_read(void *opaque, hwaddr addr,
     IbexUartState *s = opaque;
     uint64_t retvalue = 0;
 
-    switch (addr) {
-    case IBEX_UART_INTR_STATE:
+    switch (addr >> 2) {
+    case R_INTR_STATE:
         retvalue = s->uart_intr_state;
         break;
-    case IBEX_UART_INTR_ENABLE:
+    case R_INTR_ENABLE:
         retvalue = s->uart_intr_enable;
         break;
-    case IBEX_UART_INTR_TEST:
+    case R_INTR_TEST:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: wdata is write only\n", __func__);
         break;
 
-    case IBEX_UART_CTRL:
+    case R_CTRL:
         retvalue = s->uart_ctrl;
         break;
-    case IBEX_UART_STATUS:
+    case R_STATUS:
         retvalue = s->uart_status;
         break;
 
-    case IBEX_UART_RDATA:
+    case R_RDATA:
         retvalue = s->uart_rdata;
-        if (s->uart_ctrl & UART_CTRL_RX_ENABLE) {
+        if (s->uart_ctrl & R_CTRL_RX_ENABLE_MASK) {
             qemu_chr_fe_accept_input(&s->chr);
 
-            s->uart_status |= UART_STATUS_RXIDLE;
-            s->uart_status |= UART_STATUS_RXEMPTY;
+            s->uart_status |= R_STATUS_RXIDLE_MASK;
+            s->uart_status |= R_STATUS_RXEMPTY_MASK;
         }
         break;
-    case IBEX_UART_WDATA:
+    case R_WDATA:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: wdata is write only\n", __func__);
         break;
 
-    case IBEX_UART_FIFO_CTRL:
+    case R_FIFO_CTRL:
         retvalue = s->uart_fifo_ctrl;
         break;
-    case IBEX_UART_FIFO_STATUS:
+    case R_FIFO_STATUS:
         retvalue = s->uart_fifo_status;
 
         retvalue |= s->tx_level & 0x1F;
@@ -266,17 +266,17 @@ static uint64_t ibex_uart_read(void *opaque, hwaddr addr,
                       "%s: RX fifos are not supported\n", __func__);
         break;
 
-    case IBEX_UART_OVRD:
+    case R_OVRD:
         retvalue = s->uart_ovrd;
         qemu_log_mask(LOG_UNIMP,
                       "%s: ovrd is not supported\n", __func__);
         break;
-    case IBEX_UART_VAL:
+    case R_VAL:
         retvalue = s->uart_val;
         qemu_log_mask(LOG_UNIMP,
                       "%s: val is not supported\n", __func__);
         break;
-    case IBEX_UART_TIMEOUT_CTRL:
+    case R_TIMEOUT_CTRL:
         retvalue = s->uart_timeout_ctrl;
         qemu_log_mask(LOG_UNIMP,
                       "%s: timeout_ctrl is not supported\n", __func__);
@@ -296,95 +296,95 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
     IbexUartState *s = opaque;
     uint32_t value = val64;
 
-    switch (addr) {
-    case IBEX_UART_INTR_STATE:
+    switch (addr >> 2) {
+    case R_INTR_STATE:
         /* Write 1 clear */
         s->uart_intr_state &= ~value;
         ibex_uart_update_irqs(s);
         break;
-    case IBEX_UART_INTR_ENABLE:
+    case R_INTR_ENABLE:
         s->uart_intr_enable = value;
         ibex_uart_update_irqs(s);
         break;
-    case IBEX_UART_INTR_TEST:
+    case R_INTR_TEST:
         s->uart_intr_state |= value;
         ibex_uart_update_irqs(s);
         break;
 
-    case IBEX_UART_CTRL:
+    case R_CTRL:
         s->uart_ctrl = value;
 
-        if (value & UART_CTRL_NF) {
+        if (value & R_CTRL_NF_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_NF is not supported\n", __func__);
         }
-        if (value & UART_CTRL_SLPBK) {
+        if (value & R_CTRL_SLPBK_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_SLPBK is not supported\n", __func__);
         }
-        if (value & UART_CTRL_LLPBK) {
+        if (value & R_CTRL_LLPBK_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_LLPBK is not supported\n", __func__);
         }
-        if (value & UART_CTRL_PARITY_EN) {
+        if (value & R_CTRL_PARITY_EN_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_PARITY_EN is not supported\n",
                           __func__);
         }
-        if (value & UART_CTRL_PARITY_ODD) {
+        if (value & R_CTRL_PARITY_ODD_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_PARITY_ODD is not supported\n",
                           __func__);
         }
-        if (value & UART_CTRL_RXBLVL) {
+        if (value & R_CTRL_RXBLVL_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: UART_CTRL_RXBLVL is not supported\n", __func__);
         }
-        if (value & UART_CTRL_NCO) {
+        if (value & R_CTRL_NCO_MASK) {
             uint64_t baud = ibex_uart_get_baud(s);
 
             s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
         }
         break;
-    case IBEX_UART_STATUS:
+    case R_STATUS:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: status is read only\n", __func__);
         break;
 
-    case IBEX_UART_RDATA:
+    case R_RDATA:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: rdata is read only\n", __func__);
         break;
-    case IBEX_UART_WDATA:
+    case R_WDATA:
         uart_write_tx_fifo(s, (uint8_t *) &value, 1);
         break;
 
-    case IBEX_UART_FIFO_CTRL:
+    case R_FIFO_CTRL:
         s->uart_fifo_ctrl = value;
 
-        if (value & FIFO_CTRL_RXRST) {
+        if (value & R_FIFO_CTRL_RXRST_MASK) {
             qemu_log_mask(LOG_UNIMP,
                           "%s: RX fifos are not supported\n", __func__);
         }
-        if (value & FIFO_CTRL_TXRST) {
+        if (value & R_FIFO_CTRL_TXRST_MASK) {
             s->tx_level = 0;
         }
         break;
-    case IBEX_UART_FIFO_STATUS:
+    case R_FIFO_STATUS:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: fifo_status is read only\n", __func__);
         break;
 
-    case IBEX_UART_OVRD:
+    case R_OVRD:
         s->uart_ovrd = value;
         qemu_log_mask(LOG_UNIMP,
                       "%s: ovrd is not supported\n", __func__);
         break;
-    case IBEX_UART_VAL:
+    case R_VAL:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: val is read only\n", __func__);
         break;
-    case IBEX_UART_TIMEOUT_CTRL:
+    case R_TIMEOUT_CTRL:
         s->uart_timeout_ctrl = value;
         qemu_log_mask(LOG_UNIMP,
                       "%s: timeout_ctrl is not supported\n", __func__);
@@ -409,7 +409,7 @@ static void fifo_trigger_update(void *opaque)
 {
     IbexUartState *s = opaque;
 
-    if (s->uart_ctrl & UART_CTRL_TX_ENABLE) {
+    if (s->uart_ctrl & R_CTRL_TX_ENABLE_MASK) {
         ibex_uart_xmit(NULL, G_IO_OUT, s);
     }
 }
-- 
2.27.0


