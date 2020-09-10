Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B648C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E9B21941
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GKW3/D5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E9B21941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRQr-0006b4-LV
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBe-0004DK-8E
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBZ-0002lX-Co
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762041; x=1631298041;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=73cjRU7ztozjQxYdLAFs7xrITXd+r2BXcfKyNF5PBiU=;
 b=GKW3/D5Y+2XIw+YEGNU4nv9fIwAIn1FWGjITb1aXkvbQjcZTG0SHGhXu
 3BCrr+FTQXEPnt2eIZulwihKPbB8R+tm3+W+L5o6NUN9hCVhwDMVCQS4t
 t0cp0qg0yRYJrdoWAx57KA8X6uwDHmZsUYTTeM10y9gfsNJUXEqmwjGkm
 EEFrGjQyxbNkAkkVh9jql+x6Z/thkSJRrB7N0jz2UlUowjgMqoADUGWOt
 1cgPyUcE7gRCm4Y8Ugiq8M1jWInS9RLKk8gSEwXe6oIokF2mvTVd+zIXM
 fyWfN9PZwqeSQFgMMCsz4pT2Ox4dpmfQtOA7M4Bknu3J+voq7VE9kxlIL Q==;
IronPort-SDR: zGPmd45NZckG+anx9kEvvHJfyDFQTIGfzk3cJDfDsyy2+a3b9jCy2oqzahmA3ma1DxbZAD0bdc
 O2m0Lpbh0O6XCrlQ8g5ZrcZXH/aBeIgVISPllA3V/FZ+GFyHELdxZoUfHispvEx9EOLJsPnG3B
 j58B5sx9JU/UcpbKXF9dk+X5ZsiFqN8PmY0txANoH52qcJMHZH7GSoQKJisnJjJFB1+6KjPz6E
 ohxxCA9CAeTWRveiyvJ0YqckSc3O2/2vw1I/R2U5oqlHN+8+CeijgKhkE+zT52rrLSnjgVehB8
 +2Y=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979228"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:17 +0800
IronPort-SDR: 9+fVLfqhHgg6Y+wCyB5AtRLPbVqpIcT2FBvmkpu3J8lWc3G3UIrrRvDzF452Ed9oFFtzqgUX3c
 ttP2i3CN1GJA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:34 -0700
IronPort-SDR: mKrlZ2BP5QBqiBYlItGSFGoSjYb+oFMPt35T5SdIswT7pSqZ86Rwc78i/H1PTOpTNRGsmI3QEo
 +kXiTN62hTkQ==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 12/30] hw/riscv: microchip_pfsoc: Connect a DMA controller
Date: Thu, 10 Sep 2020 11:09:20 -0700
Message-Id: <20200910180938.584205-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

On the Icicle Kit board, the HSS firmware utilizes the on-chip DMA
controller to move the 2nd stage bootloader in the system memory.
Let's connect a DMA controller to Microchip PolarFire SoC.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1598924352-89526-11-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h | 11 +++++++++++
 hw/riscv/microchip_pfsoc.c         | 15 +++++++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 27 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index d810ee8484..63e786052a 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -23,6 +23,7 @@
 #define HW_MICROCHIP_PFSOC_H
 
 #include "hw/char/mchp_pfsoc_mmuart.h"
+#include "hw/dma/sifive_pdma.h"
 #include "hw/sd/cadence_sdhci.h"
 
 typedef struct MicrochipPFSoCState {
@@ -40,6 +41,7 @@ typedef struct MicrochipPFSoCState {
     MchpPfSoCMMUartState *serial2;
     MchpPfSoCMMUartState *serial3;
     MchpPfSoCMMUartState *serial4;
+    SiFivePDMAState dma;
     CadenceSDHCIState sdhci;
 } MicrochipPFSoCState;
 
@@ -71,6 +73,7 @@ enum {
     MICROCHIP_PFSOC_BUSERR_UNIT4,
     MICROCHIP_PFSOC_CLINT,
     MICROCHIP_PFSOC_L2CC,
+    MICROCHIP_PFSOC_DMA,
     MICROCHIP_PFSOC_L2LIM,
     MICROCHIP_PFSOC_PLIC,
     MICROCHIP_PFSOC_MMUART0,
@@ -88,6 +91,14 @@ enum {
 };
 
 enum {
+    MICROCHIP_PFSOC_DMA_IRQ0 = 5,
+    MICROCHIP_PFSOC_DMA_IRQ1 = 6,
+    MICROCHIP_PFSOC_DMA_IRQ2 = 7,
+    MICROCHIP_PFSOC_DMA_IRQ3 = 8,
+    MICROCHIP_PFSOC_DMA_IRQ4 = 9,
+    MICROCHIP_PFSOC_DMA_IRQ5 = 10,
+    MICROCHIP_PFSOC_DMA_IRQ6 = 11,
+    MICROCHIP_PFSOC_DMA_IRQ7 = 12,
     MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
     MICROCHIP_PFSOC_MMUART0_IRQ = 90,
     MICROCHIP_PFSOC_MMUART1_IRQ = 91,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 0b2e9ca175..d8ec973958 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -13,6 +13,7 @@
  * 2) eNVM (Embedded Non-Volatile Memory)
  * 3) MMUARTs (Multi-Mode UART)
  * 4) Cadence eMMC/SDHC controller and an SD card connected to it
+ * 5) SiFive Platform DMA (Direct Memory Access Controller)
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -71,6 +72,7 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_BUSERR_UNIT4] =    {  0x1704000,     0x1000 },
     [MICROCHIP_PFSOC_CLINT] =           {  0x2000000,    0x10000 },
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,     0x1000 },
+    [MICROCHIP_PFSOC_DMA] =             {  0x3000000,   0x100000 },
     [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,  0x2000000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,  0x4000000 },
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
@@ -114,6 +116,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
                          TYPE_RISCV_CPU_SIFIVE_U54);
     qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR);
 
+    object_initialize_child(obj, "dma-controller", &s->dma,
+                            TYPE_SIFIVE_PDMA);
+
     object_initialize_child(obj, "sd-controller", &s->sdhci,
                             TYPE_CADENCE_SDHCI);
 }
@@ -218,6 +223,16 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_PLIC].size);
     g_free(plic_hart_config);
 
+    /* DMA */
+    sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0,
+                    memmap[MICROCHIP_PFSOC_DMA].base);
+    for (i = 0; i < SIFIVE_PDMA_IRQS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->dma), i,
+                           qdev_get_gpio_in(DEVICE(s->plic),
+                                            MICROCHIP_PFSOC_DMA_IRQ0 + i));
+    }
+
     /* SYSREG */
     create_unimplemented_device("microchip.pfsoc.sysreg",
         memmap[MICROCHIP_PFSOC_SYSREG].base,
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 7412db9ad7..9032cb0cbd 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -55,4 +55,5 @@ config MICROCHIP_PFSOC
     select SIFIVE
     select UNIMP
     select MCHP_PFSOC_MMUART
+    select SIFIVE_PDMA
     select CADENCE_SDHCI
-- 
2.28.0


