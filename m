Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FA7C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CB2208D6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 19:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RwYC1IUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CB2208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWm8T-0006VG-4J
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 15:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm5Y-0000GD-Le; Thu, 07 May 2020 15:21:45 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=38990af3b=alistair.francis@wdc.com>)
 id 1jWm5W-0005Gx-S9; Thu, 07 May 2020 15:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588879302; x=1620415302;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1QnIZzfJPyvjmGu8MRNUzjlVLuF2ar1jxoO/8AhLKR8=;
 b=RwYC1IUF0VqsMaHKglLWUjozip6j+/ReNlktebKk/AVcSMY7r9C0WVeE
 WjU5irqhA5kPRoBlN6q/ohJhtmvq3X6hET9ovx6cZHm/zK7PSKLQHCDia
 Eg3L8O6use0aPCU/Iq7i4vxv1RFdrn6OiSJEBjrVDDUj/5F77W9sV9MG+
 i2E1A037bylWSPtHIrc6mEXXvzUTVGTUFSyzp41paf8L6Ihjw3RVW6Qi/
 SYe0v1hnddde+V2pFhrHK07yiF+dMGLhySOgIOL4luMGA/VVOxlwYcaAj
 F8IGPujIxrSMFOVm9GkWLK9XNOquGjElcxyQYLfCzNkmGslwXiHUXZE5b A==;
IronPort-SDR: wJNOMFvMP3FWpARvdHvDzkyK25hvizoJDLFm1JrsLsAwVCzgNUkgaOpNP7K9pQM2X50g3q2LKr
 vMs1lD3Im4xGkJ5Wb4ijev99tH5z4ZCA1Tm8cL/IsqRbuOUmJx10c4vYM/aguyrQ2kfU2snZrl
 8SXdg7NQ/G6GPL61HQrHhsuiWfSaSmXmw0QkhxkWAN3HF2eMNDnryvUXqIqMYV+Ws/bQJfIV0H
 T5Jyy4AR21zRYfDdICmW+KH9PwExHl4Tx4FzOrpGy+hKPpOL0QFcKwGF1myJVtcZbdQ5rFEA3j
 yxQ=
X-IronPort-AV: E=Sophos;i="5.73,364,1583164800"; d="scan'208";a="246038062"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 03:21:40 +0800
IronPort-SDR: THgD52DhqIFTI8ChgJSV5dc9/E/ymIM71Fbzn+ZW82Cj1pt3Vy2suI+b2JWNoc1XLIIUdZwfLW
 oE3WtZUSE/oYf5ePAk4CuFh+68w85XsTw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 12:12:04 -0700
IronPort-SDR: ICdgwENKepVcT4y1PkQSwzRz+p3gtY4o5LAmLsoCA7XqnPdqEF0ryoDTOpLjc43mFrZmjio9rG
 DRTok1F2VQIg==
WDCIronportException: Internal
Received: from uscxm6l72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.6])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 May 2020 12:21:39 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 8/9] riscv/opentitan: Connect the UART device
Date: Thu,  7 May 2020 12:13:20 -0700
Message-Id: <786141c80bd14a93395d68e693060d89530d9d3d.1588878756.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1588878756.git.alistair.francis@wdc.com>
References: <cover.1588878756.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=38990af3b=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 15:21:18
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
---
 hw/riscv/opentitan.c         | 24 ++++++++++++++++++++++--
 include/hw/riscv/opentitan.h | 13 +++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 3926321d8c..a6c0b949ca 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -96,6 +96,9 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
 
     sysbus_init_child_obj(obj, "plic", &s->plic,
                           sizeof(s->plic), TYPE_IBEX_PLIC);
+
+    sysbus_init_child_obj(obj, "uart", &s->uart,
+                          sizeof(s->uart), TYPE_IBEX_UART);
 }
 
 static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -137,8 +140,25 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
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
diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 8d6a09b696..825a3610bc 100644
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
@@ -63,4 +65,15 @@ enum {
     IBEX_USBDEV,
 };
 
+enum {
+    IBEX_UART_RX_PARITY_ERR_IRQ = 0x28,
+    IBEX_UART_RX_TIMEOUT_IRQ = 0x27,
+    IBEX_UART_RX_BREAK_ERR_IRQ = 0x26,
+    IBEX_UART_RX_FRAME_ERR_IRQ = 0x25,
+    IBEX_UART_RX_OVERFLOW_IRQ = 0x24,
+    IBEX_UART_TX_EMPTY_IRQ = 0x23,
+    IBEX_UART_RX_WATERMARK_IRQ = 0x22,
+    IBEX_UART_TX_WATERMARK_IRQ = 0x21
+};
+
 #endif
-- 
2.26.2


