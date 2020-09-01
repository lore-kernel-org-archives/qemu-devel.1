Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58557C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D88B20707
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 01:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIN/cq8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D88B20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCvQu-0000xm-8K
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 21:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvIE-0004yQ-IU; Mon, 31 Aug 2020 21:41:02 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kCvIC-0005c1-Mo; Mon, 31 Aug 2020 21:41:02 -0400
Received: by mail-pl1-x643.google.com with SMTP id j11so4124082plk.9;
 Mon, 31 Aug 2020 18:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=xMIwxaAxhwPQjdCBKW50uMD0iT9RYj+VHkRUFlWF9Ww=;
 b=IIN/cq8Ta5gBqiJAMNpCY2hqA9OngVfLnoTlk+dCccffoP3LnhoofJ7ldENuLJhuGF
 Joch9Z/Fho0IDLfg5gAsDDKJFarKTLl9tgX3zfNUh1fjRCppcZmt1UhXfI1AmgKWlaaK
 DoCCdAOumqGi80giXLF1+fpBshXyxbwiaMS/eriCb1y3nTkt1vHzwmAi1adVonbF+lZe
 RdepjrpQH5q/dHDLY46cPZwUO4nzs9Hh3ES2bTzD8hE/0GHyuTbZp+AVkNLot/GCZIQ7
 yjX42rPxtHbMN/0R5EO/bbcn9ri4V3T7V9gy+AxBzh9fxORNEg4mNFbZ5eCypRlma2CD
 palg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=xMIwxaAxhwPQjdCBKW50uMD0iT9RYj+VHkRUFlWF9Ww=;
 b=dFNx1Jmld/PYOUDSGkH5LLm3//9nTkF7bLVn5DaH2NQpGEQOo0tVYSA+vdneq+Empj
 p3YUPelCoMawC3E0muOX8qH+k1fO7LPXfXnoHQ9KboXOBGwwAIJo92HD1kXU3aNc7AaV
 UUDTMiYtMbXVo84o22tT+d9cAMLl2iM6JjLxcMLJeCiOOfGs/9uxXgr0G7u7pz4UBpVk
 Ida465aVEMRX+91EPbDU0VspgXwFAgfARG+fID1WaJ7QVLBXvDSusoJOPz0ixQGnfLSQ
 twc/BGAj2/WzEIMlESRDmX5gn9LSdbixzl085h/ZiDy9Z/Mx6bkk8U/uxz3NyHYAVgkB
 AyCw==
X-Gm-Message-State: AOAM532ho/FGvQhrK0OUHy32CHR1KtoINbhXoyF7Tigt2XTizaOMItga
 jCuwq0fnkOYwZFdkYx1VPCQ=
X-Google-Smtp-Source: ABdhPJy92z6RieVN6IQvYCcZmzMAt6OvNWLQSRotJnDyvQm9eFF8XdOfq/7mbPkRWCEZtzyWSwqWTQ==
X-Received: by 2002:a17:90a:a101:: with SMTP id
 s1mr1819625pjp.205.1598924459025; 
 Mon, 31 Aug 2020 18:40:59 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id l13sm8887520pgq.33.2020.08.31.18.40.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Aug 2020 18:40:58 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 10/16] hw/riscv: microchip_pfsoc: Connect a DMA controller
Date: Tue,  1 Sep 2020 09:39:05 +0800
Message-Id: <1598924352-89526-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x643.google.com
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

On the Icicle Kit board, the HSS firmware utilizes the on-chip DMA
controller to move the 2nd stage bootloader in the system memory.
Let's connect a DMA controller to Microchip PolarFire SoC.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

(no changes since v2)

Changes in v2:
- connect 8 IRQs to the PLIC

 include/hw/riscv/microchip_pfsoc.h | 11 +++++++++++
 hw/riscv/microchip_pfsoc.c         | 15 +++++++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 27 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index d810ee8..63e7860 100644
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
index 0b2e9ca..d8ec973 100644
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
index 7412db9..9032cb0 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -55,4 +55,5 @@ config MICROCHIP_PFSOC
     select SIFIVE
     select UNIMP
     select MCHP_PFSOC_MMUART
+    select SIFIVE_PDMA
     select CADENCE_SDHCI
-- 
2.7.4


