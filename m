Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BC9207DD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S52Ge1op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BC9207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAfQ-0002hz-2t
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbi-0005Tz-Lo
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbg-00028f-Gt
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548473; x=1624084473;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wj2tmgrLszFAAngO5h43Czzs+HrNQaJZBg5sgRJ6o9o=;
 b=S52Ge1op17Z+jOW++zF92+2FBjlLmkxUhUWVsl0U200549m1WLoGL5m9
 Z/xw4rJXub5xgbEWY4tN1/3V0R+YgwhhO8eodWjSsRFrOWnPzDHggFNDx
 xHEe4sjpPoPu94rKA118OlvUkRwchFY9ibPa+0Vl+ADGF5D56A3+pGFj9
 e3lN2Uf8u7apKdKVzvgv7J6xXgp6nGPOydaKN4TWP1GizFvUHJ8KMcftd
 MOR9MtQ+tIpeVTqM9U67GfWtrXX7CmAjjPCxy0FyavhHyyvXcMQfBvSBu
 P6wOVhEXqe8DBwqNU/EtPMqqGJawRJFhsZ7WGCG6afx9fVQlzpB4pIiGv Q==;
IronPort-SDR: 7GFrai3RbGF1kWPy0aGDqhsLxISswOpe4Py3pWnQSqapN72azZFmVfDAoQQgslf1PuB2ChceRl
 5gheyu6UyT+9X1WM5FmJ8rsAc8sotMjzVWHjFM4dyHd2PbrrXObezKHwY81hZokqqFQBc8q8HI
 4haNgNTm31fZ0CM13H+uCI8FRAUx4wK4FN16SiiQbiGZ3boxCG/WD5AUA0uOqulkMAhjCQ0BHi
 /gOsF4EPXjkZQcPebfqXgjwSbj4zQ3ujPg4wzCrSr611DhUAQerMGZXBUR3y5W82UDH6wVOVz9
 fYE=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141781920"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:30 +0800
IronPort-SDR: 9+Ox1jYGBaef3cynlznllRre/envWCwKlr7FryYqiTu7M7jTCGwto0vPaEOF0AgJv3SdwikaVP
 HlRF0MuB4e/EYvrqo7Kz/+IdZ/AyniQWA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:40 -0700
IronPort-SDR: YLyn/k8TQWXPJgUbZrIflakEmmmeoVcHMAYu2TZBvMe/K/LqImIoEqu7PTElE8d6u/ZdK3ETvN
 FQTo8Ulf9JOQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 15/32] riscv/opentitan: Connect the UART device
Date: Thu, 18 Jun 2020 23:25:01 -0700
Message-Id: <20200619062518.1718523-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/riscv/opentitan.h | 13 +++++++++++++
 hw/riscv/opentitan.c         | 25 +++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 76f72905a8..8f29b9cbbf 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -21,6 +21,7 @@
 
 #include "hw/riscv/riscv_hart.h"
 #include "hw/intc/ibex_plic.h"
+#include "hw/char/ibex_uart.h"
 
 #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
 #define RISCV_IBEX_SOC(obj) \
@@ -33,6 +34,7 @@ typedef struct LowRISCIbexSoCState {
     /*< public >*/
     RISCVHartArrayState cpus;
     IbexPlicState plic;
+    IbexUartState uart;
 
     MemoryRegion flash_mem;
     MemoryRegion rom;
@@ -68,4 +70,15 @@ enum {
     IBEX_PADCTRL,
 };
 
+enum {
+    IBEX_UART_RX_PARITY_ERR_IRQ = 0x28,
+    IBEX_UART_RX_TIMEOUT_IRQ = 0x27,
+    IBEX_UART_RX_BREAK_ERR_IRQ = 0x26,
+    IBEX_UART_RX_FRAME_ERR_IRQ = 0x25,
+    IBEX_UART_RX_OVERFLOW_IRQ = 0x24,
+    IBEX_UART_TX_EMPTY_IRQ = 0x23,
+    IBEX_UART_RX_WATERMARK_IRQ = 0x22,
+    IBEX_UART_TX_WATERMARK_IRQ = 0x21,
+};
+
 #endif
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 835b2c503f..675ce900bd 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -97,6 +97,8 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
 
     object_initialize_child(obj, "plic", &s->plic, TYPE_IBEX_PLIC);
+
+    object_initialize_child(obj, "uart", &s->uart, TYPE_IBEX_UART);
 }
 
 static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -133,8 +135,27 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->plic), 0, memmap[IBEX_PLIC].base);
 
-    create_unimplemented_device("riscv.lowrisc.ibex.uart",
-        memmap[IBEX_UART].base, memmap[IBEX_UART].size);
+    /* UART */
+    qdev_prop_set_chr(DEVICE(&(s->uart)), "chardev", serial_hd(0));
+    sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart), 0, memmap[IBEX_UART].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart),
+                       0, qdev_get_gpio_in(DEVICE(&s->plic),
+                       IBEX_UART_TX_WATERMARK_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart),
+                       1, qdev_get_gpio_in(DEVICE(&s->plic),
+                       IBEX_UART_RX_WATERMARK_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart),
+                       2, qdev_get_gpio_in(DEVICE(&s->plic),
+                       IBEX_UART_TX_EMPTY_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart),
+                       3, qdev_get_gpio_in(DEVICE(&s->plic),
+                       IBEX_UART_RX_OVERFLOW_IRQ));
+
     create_unimplemented_device("riscv.lowrisc.ibex.gpio",
         memmap[IBEX_GPIO].base, memmap[IBEX_GPIO].size);
     create_unimplemented_device("riscv.lowrisc.ibex.spi",
-- 
2.27.0


