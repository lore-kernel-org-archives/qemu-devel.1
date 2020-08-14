Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C21C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8562078D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoQflcKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8562078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ctL-0004CF-1z
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cmC-0008Mg-5U; Fri, 14 Aug 2020 12:41:56 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cmA-0002jP-Ex; Fri, 14 Aug 2020 12:41:55 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t6so4643297pjr.0;
 Fri, 14 Aug 2020 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ypar0ej4TvEEf95rRUUSazBC6MGwvwdLxXN4saosWNU=;
 b=AoQflcKAnHoQGs389FJn1npINdb38HAWSfyEay6VmmOfnsaR1WENT2f3wB78jOCTHp
 yhZEXN4FIGjW3BCwWrh3P5vYNUDbEdRNAmN4AWREADlTNJs15Zx3AnUjW/r63TTM8Sp5
 ulSVtLNWTeymDgwAr5zzVl7x4FKM7e7N0bG7fpPjOhEKxQpf2OCVRvbDzxWj6mGheHSf
 ffDED0IAgKQuLX1DXwv1t+GJtRd1OePGZMtjSxkUONgJqVSMyWGQd6lDrqiv7s4dy4H0
 sDF1fUK3GlrtlyILzS6AzYKGGh0xOpKpkyXOeDyvT/Y4KNxgRuF6y8MCI4QYdj5//HGd
 0JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ypar0ej4TvEEf95rRUUSazBC6MGwvwdLxXN4saosWNU=;
 b=Q7f0akWiw73CrGTuERUWaVEoQ6XCunMWOEnzWCL59n7/5qKTPfqef/dtSu0pwd75iy
 ea0YwnBunADvmpdp7Y76Tkeaevfzq5nUDDPOZxuFuwqVN2HmQNG6CA4WWHsVUok2RraJ
 zqA2aUu77M8TdhjNlnPq6lOCyt+KBR7yNnDgWJHo4JLZVTD1E0ndE+4xADdb8zgzGw0w
 xDhLXmSRMui6XtGMCPCdVJh67f9o32e2S9EVKefJftGfEuh3PC97Mlv2K0/0mWz0E4hp
 FR2HaNBJFUZ1f5tDjB4ck2Gihah9nrhqsmVd7kfZlMpcBHBRJA29Ml2gWzK5ADghKlrw
 Vbag==
X-Gm-Message-State: AOAM530NrgLRuEme7SSIRKlwZyQcOmLskaCuNfMB1NJABDk42X6DniGZ
 4L9vbGZaFbv59xO6ASC+w0IQugnY2aUIDUe+
X-Google-Smtp-Source: ABdhPJylzTeEaP8XlrgRz40Jlnt3brYtmaQaR5pcrVjnlB6Qd1g2JhZ4/RkY6gU8FYFkbhooRZeiIA==
X-Received: by 2002:a17:902:be12:: with SMTP id
 r18mr2544536pls.116.1597423312997; 
 Fri, 14 Aug 2020 09:41:52 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.41.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:52 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 13/18] hw/riscv: microchip_pfsoc: Connect a DMA controller
Date: Sat, 15 Aug 2020 00:40:51 +0800
Message-Id: <1597423256-14847-14-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1043.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Connect a DMA controller to Microchip PolarFire SoC. Note interrupt
has not been connected due to missing information in the manual how
interrupts are routed to PLIC.

On the Icicle Kit board, the HSS firmware utilizes the on-chip DMA
controller to move the 2nd stage bootloader in the system memory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/Kconfig                   |  1 +
 hw/riscv/microchip_pfsoc.c         | 10 ++++++++++
 include/hw/riscv/microchip_pfsoc.h |  3 +++
 3 files changed, 14 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 7412db9..9323701 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -55,4 +55,5 @@ config MICROCHIP_PFSOC
     select SIFIVE
     select UNIMP
     select MCHP_PFSOC_MMUART
+    select MCHP_PFSOC_DMA
     select CADENCE_SDHCI
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 7c09078..1c67cbc 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -13,6 +13,7 @@
  * 2) eNVM (Embedded Non-Volatile Memory)
  * 3) MMUARTs (Multi-Mode UART)
  * 4) Cadence eMMC/SDHC controller and an SD card connected to it
+ * 5) DMA (Direct Memory Access Controller)
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
+                            TYPE_MCHP_PFSOC_DMA);
+
     object_initialize_child(obj, "sd-controller", &s->sdhci,
                             TYPE_CADENCE_SDHCI);
     object_initialize_child(OBJECT(&s->sdhci), "sd-controller.sdhci",
@@ -220,6 +225,11 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_PLIC].size);
     g_free(plic_hart_config);
 
+    /* DMA */
+    sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0,
+                    memmap[MICROCHIP_PFSOC_DMA].base);
+
     /* SYSREG */
     create_unimplemented_device("microchip.pfsoc.sysreg",
         memmap[MICROCHIP_PFSOC_SYSREG].base,
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index d810ee8..7825935 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -23,6 +23,7 @@
 #define HW_MICROCHIP_PFSOC_H
 
 #include "hw/char/mchp_pfsoc_mmuart.h"
+#include "hw/dma/mchp_pfsoc_dma.h"
 #include "hw/sd/cadence_sdhci.h"
 
 typedef struct MicrochipPFSoCState {
@@ -40,6 +41,7 @@ typedef struct MicrochipPFSoCState {
     MchpPfSoCMMUartState *serial2;
     MchpPfSoCMMUartState *serial3;
     MchpPfSoCMMUartState *serial4;
+    MchpPfSoCDMAState dma;
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
-- 
2.7.4


