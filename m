Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFEEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13ED20780
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QpH2nAqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13ED20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyV8-0002AB-Vu
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:45:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJo-0001x2-JG
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:57 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJg-0001EJ-0b
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417628; x=1635953628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2GIx+t0Rp+fA0ib/C5fOILwZ9azhuSUJ4wg+kNar0QY=;
 b=QpH2nAqSylakEXG48ZGT3kC9TvePjI4NXBn1t4KxNr481jgjpyDTmeKo
 7fm/fTndVzYeqrTbKStFD5P7smg1sYNJRtHmyysRCHODB0hH8zhVqR189
 emga2zvCFNY/zrsv76mEsLeWa6pq+vIku8MZ0rtet6Iq56dcMQXLDUaN6
 JTuZBg5zwOfjy0AaPXnITXZTHy9b+ajXXTKv2cB4uV/rnAVf3T5s3GeMb
 zAkR+f22t4Zoj3M13BPqiOlxDdnMG6kTzN1LY95CYp9Pm4A5FOeqwLhF6
 DdRauxxVT+DgeOijPb4OJXDB0GAQCwL4J+4tgZn7R01eafYfDYl6XRaEG w==;
IronPort-SDR: rOA0H88uRN1sBHmoiF6tC6kT3A9ANfgyWbQUuvkWpz3zLQTP+GCK6Mahhc0nT2tmnSvrFYVlcE
 H8AWiz5R2/wbbdRX3e1NNnwAAiGkgGn9Czx5goqnwVPol8tlRZC+luDHIT9uyK0gJzYiRz4LfF
 NblLQiEeXNSfRFw30hVy+yh1GBkktOQxlqSU+nG5WC+1rFOYz+cvMR8Akk0GMjak3/JWBmnpCL
 TTVb5JC7aBrAeiN4+tC2wwncgUC4YBDp8zeRDCICdLE6nzYVhHqdXzciwc02Ssb5PMteaOJQ46
 zPI=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867472"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:26 +0800
IronPort-SDR: BnrdQUJfUstkeaES/zO3f81NJmeVQCPLwSAYSrioJItbbAyaaXglSwUrRRPWt691HBz4XyS+oU
 cVGVNmXAIoU8hc9fU5azFu0KQWtfmhH6RAa4Nk0sukPeC1XpyZYiCI3pmzfN5BjzIvW3gg4zNq
 UPqsWY+KPqx8ui8w0UTFRGkrCxbNuNjsmm2oaHiGZUYVVdjGH4gFHiUtYY+Nk4+HC15CJRpqdk
 wCEqK5IoDUf8gXKVSrlcdWKID54Hwi2CfTD25IeK7/Zx/divNh1kvNqXbwwgyi0kWZPw0AxDDv
 nnp3ciC4Mrp7NvzFsYegh/gc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:35 -0800
IronPort-SDR: VaB6cS9oO56+g0FcdvoubVuhomUSFyVpGdqrU3LN1dbBkuEtvEQxpzjJFvOprOv4a2lHsU3DI5
 5PeguqYZ0/rBq378qd2HmDuOSv5I2zQq82v/xYahjmALS6Wa7WHhZ+no8hbdSD+ON6FFTqiyO5
 uL5ZA6OfJPjYfvsFiU8CdMhclyXfEZXZHhh/oNuFznGY8sMhxsW0VHxUwvbcz78yZo1JbXFJXE
 zrUgj59fftynNiFOeLqOXz/e9KF7m35XbB1+GOs4y5vremncTW3uSw0jxsiGlg8dgI/OqD+tTa
 XKk=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:27 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 11/19] hw/riscv: microchip_pfsoc: Connect DDR memory
 controller modules
Date: Tue,  3 Nov 2020 07:21:42 -0800
Message-Id: <20201103152150.2677566-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
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

Connect DDR SGMII PHY module and CFG module to the PolarFire SoC.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1603863010-15807-4-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h |  5 +++++
 hw/riscv/microchip_pfsoc.c         | 18 ++++++++++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 24 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 8bfc7e1a85..5b81e26241 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -24,6 +24,7 @@
 
 #include "hw/char/mchp_pfsoc_mmuart.h"
 #include "hw/dma/sifive_pdma.h"
+#include "hw/misc/mchp_pfsoc_dmc.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/sd/cadence_sdhci.h"
 
@@ -37,6 +38,8 @@ typedef struct MicrochipPFSoCState {
     RISCVHartArrayState e_cpus;
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
+    MchpPfSoCDdrSgmiiPhyState ddr_sgmii_phy;
+    MchpPfSoCDdrCfgState ddr_cfg;
     MchpPfSoCMMUartState *serial0;
     MchpPfSoCMMUartState *serial1;
     MchpPfSoCMMUartState *serial2;
@@ -82,7 +85,9 @@ enum {
     MICROCHIP_PFSOC_MMUART0,
     MICROCHIP_PFSOC_SYSREG,
     MICROCHIP_PFSOC_MPUCFG,
+    MICROCHIP_PFSOC_DDR_SGMII_PHY,
     MICROCHIP_PFSOC_EMMC_SD,
+    MICROCHIP_PFSOC_DDR_CFG,
     MICROCHIP_PFSOC_MMUART1,
     MICROCHIP_PFSOC_MMUART2,
     MICROCHIP_PFSOC_MMUART3,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 6aac8497fc..3c504f7c03 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -15,6 +15,7 @@
  * 4) Cadence eMMC/SDHC controller and an SD card connected to it
  * 5) SiFive Platform DMA (Direct Memory Access Controller)
  * 6) GEM (Gigabit Ethernet MAC Controller)
+ * 7) DMC (DDR Memory Controller)
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -103,7 +104,9 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
     [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
     [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
+    [MICROCHIP_PFSOC_DDR_SGMII_PHY] =   { 0x20007000,     0x1000 },
     [MICROCHIP_PFSOC_EMMC_SD] =         { 0x20008000,     0x1000 },
+    [MICROCHIP_PFSOC_DDR_CFG] =         { 0x20080000,    0x40000 },
     [MICROCHIP_PFSOC_MMUART1] =         { 0x20100000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
@@ -149,6 +152,11 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "dma-controller", &s->dma,
                             TYPE_SIFIVE_PDMA);
 
+    object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
+                            TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
+    object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
+                            TYPE_MCHP_PFSOC_DDR_CFG);
+
     object_initialize_child(obj, "gem0", &s->gem0, TYPE_CADENCE_GEM);
     object_initialize_child(obj, "gem1", &s->gem1, TYPE_CADENCE_GEM);
 
@@ -278,6 +286,16 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_MPUCFG].base,
         memmap[MICROCHIP_PFSOC_MPUCFG].size);
 
+    /* DDR SGMII PHY */
+    sysbus_realize(SYS_BUS_DEVICE(&s->ddr_sgmii_phy), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddr_sgmii_phy), 0,
+                    memmap[MICROCHIP_PFSOC_DDR_SGMII_PHY].base);
+
+    /* DDR CFG */
+    sysbus_realize(SYS_BUS_DEVICE(&s->ddr_cfg), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ddr_cfg), 0,
+                    memmap[MICROCHIP_PFSOC_DDR_CFG].base);
+
     /* SDHCI */
     sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 2df978fe8d..c8e50bde99 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -4,6 +4,7 @@ config IBEX
 config MICROCHIP_PFSOC
     bool
     select CADENCE_SDHCI
+    select MCHP_PFSOC_DMC
     select MCHP_PFSOC_MMUART
     select MSI_NONBROKEN
     select SIFIVE_CLINT
-- 
2.28.0


