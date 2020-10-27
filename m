Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC61C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8165720773
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLm1U+ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8165720773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQ29-0002TT-7Q
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPeq-0007EI-LA; Tue, 27 Oct 2020 10:09:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPeo-0006Kb-M6; Tue, 27 Oct 2020 10:09:04 -0400
Received: by mail-pg1-x544.google.com with SMTP id o7so857167pgv.6;
 Tue, 27 Oct 2020 07:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Eu+qi7ubrml3OA1tTgSmoKt2J/Vib4Ul9XwjcW39VJc=;
 b=gLm1U+epECwOh2FnQke4KEX2q7Xw8UgTXt8e5xOXyP0SuFUWuFRoyuR33aOm1LUf+b
 YG+M2dJzK8XGZ1b4SwqwlcIKLo4rWTvu3f6NIC3UEYkAaNLvhfqdlBxLPschsxFE/Tlk
 FVTBksPPonU0b2BuAKTiJAEuBX0NGzMrF1wmi5jY7Z6unGhv4T/PPxZoKibQIiU6+dIA
 hhkDk7bOh8MtYvZ9F5/Z2yZjm/s8OV8Dkm47sQO+0hsjoplFK/KQeLt1thT319WYknCp
 PfCVHIZs83LSHVdp8khTc6h/o/V+VFImAW36wQXKdjFTPgEI/QpECAwXUsGvPUukLHte
 413Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Eu+qi7ubrml3OA1tTgSmoKt2J/Vib4Ul9XwjcW39VJc=;
 b=TlDBR98GapUfmv0iLhrYeD8SDdKAjkfqzTlRNxhzCgZ0c3F2jIV31aEdV3g7ff17qK
 wcCzbV2vaA5wbGroE1soeQ98WawhUwcMdRGEf9Kx7gvGJnd6SDpmu/Kz44FTp/3a/0Ps
 tSGd/Ef4r5hbF1NYttyR5eAbKqNAwl3rsOw+fHWSrzZEI6PEOe0uK0EkuyDwDx+2Mcwn
 FEx8o+Y38t9ywH9tlzmJIump2E5KxM+k/7Ww/twyEPI/KktawoKjgz2hiERy4mI5GRj1
 zLMmjck/VPlPD3KjwC8cgpzYAILjzmee+yQ8zbM4ZbreyKYKK8m8C04+UVeV73z81bI+
 iFfQ==
X-Gm-Message-State: AOAM533W3g52ntYtFLnkS1zRHlujZSDhu9PXj0Va20CndnwNaDz1frcf
 3rgaLrnxbzOnkpZPkmRQyjk=
X-Google-Smtp-Source: ABdhPJzxe/Ic1oQOvILtw3X6Zcgkp1UatEqW3i7/IF8iexea2QW/HMk/Icoq06IzbLtnHwmI/0wX/w==
X-Received: by 2002:a62:5251:0:b029:164:3604:578d with SMTP id
 g78-20020a6252510000b02901643604578dmr2258475pfb.51.1603807740505; 
 Tue, 27 Oct 2020 07:09:00 -0700 (PDT)
Received: from i9-aorus-gtx1080.localdomain (144.168.56.201.16clouds.com.
 [144.168.56.201])
 by smtp.gmail.com with ESMTPSA id r22sm2540856pfg.51.2020.10.27.07.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 07:09:00 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
X-Google-Original-From: Bin Meng <bin.meng@windriver.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 2/9] hw/riscv: microchip_pfsoc: Connect DDR memory controller
 modules
Date: Tue, 27 Oct 2020 22:08:33 +0800
Message-Id: <20201027140840.18030-3-bin.meng@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027140840.18030-1-bin.meng@windriver.com>
References: <20201027140840.18030-1-bin.meng@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>, Atish Patra <atish.patra@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Connect DDR SGMII PHY module and CFG module to the PolarFire SoC.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/Kconfig                   |  1 +
 hw/riscv/microchip_pfsoc.c         | 18 ++++++++++++++++++
 include/hw/riscv/microchip_pfsoc.h |  5 +++++
 3 files changed, 24 insertions(+)

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
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4627179cd3..85be2bcde8 100644
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
@@ -85,7 +86,9 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
     [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
     [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
+    [MICROCHIP_PFSOC_DDR_SGMII_PHY] =   { 0x20007000,     0x1000 },
     [MICROCHIP_PFSOC_EMMC_SD] =         { 0x20008000,     0x1000 },
+    [MICROCHIP_PFSOC_DDR_CFG] =         { 0x20080000,    0x40000 },
     [MICROCHIP_PFSOC_MMUART1] =         { 0x20100000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
@@ -131,6 +134,11 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "dma-controller", &s->dma,
                             TYPE_SIFIVE_PDMA);
 
+    object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
+                            TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
+    object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
+                            TYPE_MCHP_PFSOC_DDR_CFG);
+
     object_initialize_child(obj, "gem0", &s->gem0, TYPE_CADENCE_GEM);
     object_initialize_child(obj, "gem1", &s->gem1, TYPE_CADENCE_GEM);
 
@@ -260,6 +268,16 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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
-- 
2.25.1


