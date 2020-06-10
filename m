Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495A0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12157206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ODdaP6Bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12157206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj98i-0000C6-AO
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4234ccaf3=alistair.francis@wdc.com>)
 id 1jj962-0004Xi-Ag; Wed, 10 Jun 2020 18:21:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4234ccaf3=alistair.francis@wdc.com>)
 id 1jj961-00024C-6G; Wed, 10 Jun 2020 18:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591827680; x=1623363680;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4DL/dtShyfrUriwfPCj9ft4we7CjJK0RVJvz0+UA9EQ=;
 b=ODdaP6BkhophXcJAtqiFc0iDD5fNyt4psZUZAyadpyqgJI1tuFagJb4O
 RXhOw0lsKHIwfzUNQJ+rYfSgkHxmi3SdNVf/fqhHnS9XIrE5OeRqwwmRg
 hX1WKQodOoRWW1ia+qsyCTsEZAG0Sw4uZ6ee823WY/eDX3+I90R/BFNiZ
 S35xHP70gKZMOYsitNyZAem+ImcpDN7bNmc817YCgJsM+MifB8ik+f9bB
 4sPDZY7OaMLkAus9P/FqJwLgg5ooOfIF5kmUH2AMRLM9l4WWoea9WHckl
 DfTKW1JJipQtFZRgUd0e36hy8ABZpS4fHkIn4HX0/zIKYcZJEpmXjsQiI g==;
IronPort-SDR: Mm1LmeXMnTsipEAFwJPBnddmltgIqCWxSKhKWcqdkmndVRTxTXlMVm2QeSP2DzYBUOyoDkbAOe
 7NRJ06HSJyeC3z1kMeUIw/MJKGRRin9ewyknIxVgjt926K1OeNJjh/7KjB4HMAsNtiPNINi0OX
 7MNPo4+2FeFSpIKmmxCX97AS/OdS9E6ORaNkNKOtaOc2Ckg/iwiOziffHiT/UI2A6mcJPEz7HU
 J4D8EwPC6mZfXosjKO7qorx52ixsNptzQD3x7oWA0Ia+/1l8TYt4YeIYxwkYu7ZnvjZsitzY/I
 HDI=
X-IronPort-AV: E=Sophos;i="5.73,497,1583164800"; d="scan'208";a="248819321"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2020 06:21:19 +0800
IronPort-SDR: KeFmZPLzyuPqW88tWnF9KGdbI7+BGX8LlzcLmn/1ZJgiGKJJd38U7EAl3VxacSEBmb2B+GHHwS
 XElIHxxqZAOzKc9tkwYr7uWuiSzwcOKbU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2020 15:10:45 -0700
IronPort-SDR: Pgpx9fkR//rP7B77n1ZW3Rz5iW0bnT+g4eK4dEtrhIUs/QnJj01pTFBwloYmIncKTYVtikbrtl
 ewXa/XLZrloQ==
WDCIronportException: Internal
Received: from us4qd5p12.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.34])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Jun 2020 15:21:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v6 5/6] riscv/opentitan: Connect the UART device
Date: Wed, 10 Jun 2020 15:12:22 -0700
Message-Id: <d9501983de454e6d405c284104049c83a282fa2b.1591827110.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591827110.git.alistair.francis@wdc.com>
References: <cover.1591827110.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4234ccaf3=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 18:21:06
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/riscv/opentitan.h | 13 +++++++++++++
 hw/riscv/opentitan.c         | 24 ++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

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
index 1fc0327cb5..c8b6d2e7df 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -101,6 +101,9 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
 
     sysbus_init_child_obj(obj, "plic", &s->plic,
                           sizeof(s->plic), TYPE_IBEX_PLIC);
+
+    sysbus_init_child_obj(obj, "uart", &s->uart,
+                          sizeof(s->uart), TYPE_IBEX_UART);
 }
 
 static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -142,8 +145,25 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, memmap[IBEX_PLIC].base);
 
-    create_unimplemented_device("riscv.lowrisc.ibex.uart",
-        memmap[IBEX_UART].base, memmap[IBEX_UART].size);
+    /* UART */
+    dev = DEVICE(&(s->uart));
+    qdev_prop_set_chr(dev, "chardev", serial_hd(0));
+    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, memmap[IBEX_UART].base);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(&s->plic),
+                       IBEX_UART_TX_WATERMARK_IRQ));
+    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(DEVICE(&s->plic),
+                       IBEX_UART_RX_WATERMARK_IRQ));
+    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(DEVICE(&s->plic),
+                       IBEX_UART_TX_EMPTY_IRQ));
+    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(DEVICE(&s->plic),
+                       IBEX_UART_RX_OVERFLOW_IRQ));
+
     create_unimplemented_device("riscv.lowrisc.ibex.gpio",
         memmap[IBEX_GPIO].base, memmap[IBEX_GPIO].size);
     create_unimplemented_device("riscv.lowrisc.ibex.spi",
-- 
2.26.2


