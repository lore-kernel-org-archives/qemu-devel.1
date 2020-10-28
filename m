Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD18C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FC622267
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUfExeb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FC622267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXe7J-0002Bx-58
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 01:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2c-0005Fl-9L; Wed, 28 Oct 2020 01:30:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2a-0000Zj-0j; Wed, 28 Oct 2020 01:30:33 -0400
Received: by mail-pf1-x441.google.com with SMTP id w65so2266285pfd.3;
 Tue, 27 Oct 2020 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=s8ll2bsPNgWQUAl7T4yOzhgvD48k6MDEKSSttFnjPvk=;
 b=pUfExeb/I7bzKYX08ugTb5FByRj/vTgYY4peGrs//g8kRWxGY5/2iQ1+3B4I4suTvy
 j6PjyYeEW2EXmOT0rJa+G3QQ2s1gmkOfz/scU2r++PjdOuVXk0TZRSv7b+zAW1zi6qH0
 Rxi9HDSv10YBp5GEaoxgi6lBvfCnzR8wzBoXiXtwU6xY9sZFhdvepYS0LEpAX/ZgqJc6
 J6jNOPm+qUGEp6KjItjXwmKwHc3JO4O3qVJ1YCRMeyWtgdBgy/M0pdqS2hdxD41htmkC
 SOTD53XSgy9t5BfTJUAnF+8AcwFN1cS2JxYAmQfb2oj5V7L8mf8EGLcB13uJ0dlhDwy+
 Tx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=s8ll2bsPNgWQUAl7T4yOzhgvD48k6MDEKSSttFnjPvk=;
 b=rbjkR78XGGpN4ewnMsgrlSJzFoGmG9x9NMCtfY2tXKwHSXThRrPQ7css4Z5kMSab1x
 TP3XsG787gHXpI52OXYcGNob6rvbbp4uM8v0QJu4og3ZGp44zESzCL7MC7V5woyit+qa
 liCf6xStpbGmMYf6Sze7VrFUoSmpUIy5CoF6uoraGZBFQe+uIawOMgCIfXRDioDwd3Em
 gf7PyBN8CtuG4vyNi6ab149hPZhMLxOdj8OvkNxuGlcfRi2ujv31qMRlYk0sT4jpoIL2
 PMIwgshgXIoqMX2YvFnM69XnKJ2V2Wg07wBOQTxm4ury5KzdFWsrMzsnGM5G2N+MIDVA
 VBjw==
X-Gm-Message-State: AOAM530eWzW+pwtbucpKRcf4XFPWpEWAp7oWxI0Jaw1+mOLEXhdIhmBt
 qr8ySvqi9BPg4QSHEHl1S5Q=
X-Google-Smtp-Source: ABdhPJw3PlLt5yiU9OiDvE57rTdw1VVRDsFCe54JldzW7WL5SCISsIeHFP6Q0mVLXIOTIW9S7wjQAQ==
X-Received: by 2002:aa7:9404:0:b029:163:a093:70ba with SMTP id
 x4-20020aa794040000b0290163a09370bamr5872738pfo.80.1603863030181; 
 Tue, 27 Oct 2020 22:30:30 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 9sm5031887pjs.1.2020.10.27.22.30.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 22:30:29 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 03/10] hw/riscv: microchip_pfsoc: Connect DDR memory
 controller modules
Date: Wed, 28 Oct 2020 13:30:03 +0800
Message-Id: <1603863010-15807-4-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
References: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x441.google.com
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

From: Bin Meng <bin.meng@windriver.com>

Connect DDR SGMII PHY module and CFG module to the PolarFire SoC.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

(no changes since v1)

 hw/riscv/Kconfig                   |  1 +
 hw/riscv/microchip_pfsoc.c         | 18 ++++++++++++++++++
 include/hw/riscv/microchip_pfsoc.h |  5 +++++
 3 files changed, 24 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 2df978f..c8e50bd 100644
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
index 6aac849..3c504f7 100644
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
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 8bfc7e1..5b81e26 100644
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
2.7.4


