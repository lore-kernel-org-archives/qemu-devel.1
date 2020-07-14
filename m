Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E48C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5925C217BA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qp67todI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5925C217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv9AC-00043x-Mk
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv925-0006TP-S4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv923-0008Oh-S2
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687372; x=1626223372;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eJuI/xgJPInWsjTF4jNx4z44v3zWVAvX+59uzEw7dd0=;
 b=qp67todIUPPlwgUh4DCZNSEDrr0sGbHtBG3BDKEtvIjVGBV9DisQkLEL
 zVpnSuFOsjyP8vAU1fusPqoOW2GFYqlRkg/gle617WLu3XKqgN8DBJ3yy
 kmtB1NYF6EFfxtgsR9KFV1eL7CuviUi1breoVOk4C77aCHBavMxpxGO6y
 JOb6QixN8QpvbymJDVVP+oEP+QErroOYI1re2ILaQV/czHQGVEHdebjbh
 VTVsbKcTUy+rmLECcEQzhDPtL7hc+SQI1Vb+BI6HBlvIKgsmka/k/RSBZ
 Jb4ErSTY4ILiuj6KFsS0uq793hqpbpJn+vtsk1CIQM7RQ7JpscgjNI27w w==;
IronPort-SDR: iZqZXMwfYQTC5BG2VhEjDxC9QVx6uif+r5dv/QH+L9CVkcWLimj7k2+u/qlDWANPOxvW4rUgP/
 1ZQPHjFQhiSbnIuRaV7jiJDDkl38oST+e7BauZhpiFyI+wKA6SvU76A6rcEfUP2pd19If0ZFvz
 3ydGLLDDDfMxW4FPs6B9N/x2427gRIkOeddePo76L4kKgqE71XZZgUkviRXVhzE7/BkxuZodcf
 Rpi0Nbnh/9cRL9ipVnl85SZP5mtgZYrD3dvthjv9euNpL2pjQsFvpspcTONgMNXRX7yM/fWvOM
 RqU=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511934"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:30 +0800
IronPort-SDR: 6pkjxlKrrh4YZ6g9/H/O8U01+saRxHzmSS1a6hlF45CXADDbVMzaYf24uxbjlsKzSeHYULNDt4
 qHbw6aLPBVlf1O0/HM3yg8IXYRWg5CB5Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:58 -0700
IronPort-SDR: yCsm/9T0NwhCbcBgohvfYMRGk4jhyYZ6kk+nfFeU8lFZL+hrWdK6NfoAUAVJYRidePzbzCD+zi
 7AHi/AdYgoRA==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] hw/char: Convert the Ibex UART to use the qdev Clock
 model
Date: Mon, 13 Jul 2020 17:32:51 -0700
Message-Id: <20200714003254.4044149-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714003254.4044149-1-alistair.francis@wdc.com>
References: <20200714003254.4044149-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=457b4eeb6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 20:42:28
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Conver the Ibex UART to use the recently added qdev-clock functions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: b0136fad870a29049959ec161c1217b967d7e19d.1594332223.git.alistair.francis@wdc.com
Message-Id: <b0136fad870a29049959ec161c1217b967d7e19d.1594332223.git.alistair.francis@wdc.com>
---
 include/hw/char/ibex_uart.h |  3 +++
 hw/char/ibex_uart.c         | 30 +++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/include/hw/char/ibex_uart.h b/include/hw/char/ibex_uart.h
index 2bec772615..6d81051161 100644
--- a/include/hw/char/ibex_uart.h
+++ b/include/hw/char/ibex_uart.h
@@ -72,6 +72,7 @@
 #define IBEX_UART_TIMEOUT_CTRL 0x2c
 
 #define IBEX_UART_TX_FIFO_SIZE 16
+#define IBEX_UART_CLOCK 50000000 /* 50MHz clock */
 
 #define TYPE_IBEX_UART "ibex-uart"
 #define IBEX_UART(obj) \
@@ -101,6 +102,8 @@ typedef struct {
     uint32_t uart_val;
     uint32_t uart_timeout_ctrl;
 
+    Clock *f_clk;
+
     CharBackend chr;
     qemu_irq tx_watermark;
     qemu_irq rx_watermark;
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index 45cd724998..ab6247de89 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/ibex_uart.h"
 #include "hw/irq.h"
+#include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
@@ -203,6 +204,17 @@ static void ibex_uart_reset(DeviceState *dev)
     ibex_uart_update_irqs(s);
 }
 
+static uint64_t ibex_uart_get_baud(IbexUartState *s)
+{
+    uint64_t baud;
+
+    baud = ((s->uart_ctrl & UART_CTRL_NCO) >> 16);
+    baud *= clock_get_hz(s->f_clk);
+    baud >>= 20;
+
+    return baud;
+}
+
 static uint64_t ibex_uart_read(void *opaque, hwaddr addr,
                                        unsigned int size)
 {
@@ -329,9 +341,7 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
                           "%s: UART_CTRL_RXBLVL is not supported\n", __func__);
         }
         if (value & UART_CTRL_NCO) {
-            uint64_t baud = ((value & UART_CTRL_NCO) >> 16);
-            baud *= 1000;
-            baud >>= 20;
+            uint64_t baud = ibex_uart_get_baud(s);
 
             s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
         }
@@ -385,6 +395,16 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
     }
 }
 
+static void ibex_uart_clk_update(void *opaque)
+{
+    IbexUartState *s = opaque;
+
+    /* recompute uart's speed on clock change */
+    uint64_t baud = ibex_uart_get_baud(s);
+
+    s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
+}
+
 static void fifo_trigger_update(void *opaque)
 {
     IbexUartState *s = opaque;
@@ -444,6 +464,10 @@ static void ibex_uart_init(Object *obj)
 {
     IbexUartState *s = IBEX_UART(obj);
 
+    s->f_clk = qdev_init_clock_in(DEVICE(obj), "f_clock",
+                                  ibex_uart_clk_update, s);
+    clock_set_hz(s->f_clk, IBEX_UART_CLOCK);
+
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_watermark);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->rx_watermark);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->tx_empty);
-- 
2.27.0


