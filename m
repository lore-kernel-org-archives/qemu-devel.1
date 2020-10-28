Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F9C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAD922267
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgtIRaxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAD922267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXe7i-0002NB-5t
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 01:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2l-0005Ip-3J; Wed, 28 Oct 2020 01:30:44 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51746)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2h-0000cn-Eg; Wed, 28 Oct 2020 01:30:42 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a17so1975609pju.1;
 Tue, 27 Oct 2020 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1yfW8ZyF/XKB6FRemHmqM+FcBY5fJa85/VUlM9Ax0zI=;
 b=VgtIRaxSXp9RcUdEooDTYx4bFSaSp+XGl5QOF8xOsVA4imoU+f2haiH4u+jp/87ALK
 9hO+wo4wJQgUOZkFF46XjtYRCV/SLQ3FRL7Lqj14kskZ2eujg5x+6URuWj7YU79WHfWf
 7aXRpHUoatx1nSpUD7YeGLVh8idrFOnGDTG3++ndNeGMT6Gkbs5df+ZSBKhZ+cHozABp
 q2o20XXbf8oPC7W/CFUK9Elso/64NWQeogMZDbD5ho7EHWf4lsNj5HO1ahjgm/HZtiCh
 SV1dRgpQkfQnSQWM6gAg143p43eCJFKBjt50UQgyXGvKb4R6jGNttAGdzGsQ/KmPvLlT
 IOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1yfW8ZyF/XKB6FRemHmqM+FcBY5fJa85/VUlM9Ax0zI=;
 b=jI4qpQTxdJE+m4VZDTmlNB7MmDsQx29qnZHsYd9EkyoQTMHPAYMeiF4TPFLCAUDQzV
 gfCeIY9WjangaI7CdgcQ0YKetPN9udAMxWoT9a91DFfPg+2m+r2IgkuLcc05beN/ZItT
 mnrf1DLt2pTr7KHEyZGglsVS9bHd8Aulhd5FerFD4rkCoSUJgY+MRvHCBs95BL/GCWkx
 Q1QARVs3ay/Z9toyJtoh1Y5q094YM4cy7sBA+u70MJj0xO8m/bGGOu8m3aByzoS7bNSL
 ffYOQMKSvz5W6XaECCu9OGZb4PkroEnuJfFVgMD5ymkz0DM96C3JaSILiqmwZK+teQyj
 ERqg==
X-Gm-Message-State: AOAM533RjpH/R+vWuHeSB0ous6MTk7v1uCmlN1bKA7lhfXf+6Zch+/7J
 DnM76gGiAwg7iaEhHLYmEX4=
X-Google-Smtp-Source: ABdhPJxbgXUjuS1lM+MRvxowadk7vlCOkilLUd0iZ+5vWse24t8k8dzrwCFaeUMPT6qIfJRPEEDfjg==
X-Received: by 2002:a17:90a:488c:: with SMTP id
 b12mr5221287pjh.204.1603863037143; 
 Tue, 27 Oct 2020 22:30:37 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 9sm5031887pjs.1.2020.10.27.22.30.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 22:30:36 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 05/10] hw/riscv: microchip_pfsoc: Connect the IOSCB module
Date: Wed, 28 Oct 2020 13:30:05 +0800
Message-Id: <1603863010-15807-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
References: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1041.google.com
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

Previously IOSCB_CFG was created as an unimplemented device. With
the new IOSCB model, its memory range is already covered by the
IOSCB hence remove the previous unimplemented device creation in
the SoC codes.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 hw/riscv/Kconfig                   |  1 +
 hw/riscv/microchip_pfsoc.c         | 13 ++++++++-----
 include/hw/riscv/microchip_pfsoc.h |  4 +++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index c8e50bd..8f043e3 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -5,6 +5,7 @@ config MICROCHIP_PFSOC
     bool
     select CADENCE_SDHCI
     select MCHP_PFSOC_DMC
+    select MCHP_PFSOC_IOSCB
     select MCHP_PFSOC_MMUART
     select MSI_NONBROKEN
     select SIFIVE_CLINT
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 3c504f7..438e0c4 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -16,6 +16,7 @@
  * 5) SiFive Platform DMA (Direct Memory Access Controller)
  * 6) GEM (Gigabit Ethernet MAC Controller)
  * 7) DMC (DDR Memory Controller)
+ * 8) IOSCB modules
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -118,7 +119,7 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_GPIO2] =           { 0x20122000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
-    [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
+    [MICROCHIP_PFSOC_IOSCB] =           { 0x30000000, 0x10000000 },
     [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
 };
 
@@ -162,6 +163,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
 
     object_initialize_child(obj, "sd-controller", &s->sdhci,
                             TYPE_CADENCE_SDHCI);
+
+    object_initialize_child(obj, "ioscb", &s->ioscb, TYPE_MCHP_PFSOC_IOSCB);
 }
 
 static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
@@ -373,10 +376,10 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
                                 memmap[MICROCHIP_PFSOC_ENVM_DATA].base,
                                 envm_data);
 
-    /* IOSCBCFG */
-    create_unimplemented_device("microchip.pfsoc.ioscb.cfg",
-        memmap[MICROCHIP_PFSOC_IOSCB_CFG].base,
-        memmap[MICROCHIP_PFSOC_IOSCB_CFG].size);
+    /* IOSCB */
+    sysbus_realize(SYS_BUS_DEVICE(&s->ioscb), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioscb), 0,
+                    memmap[MICROCHIP_PFSOC_IOSCB].base);
 }
 
 static void microchip_pfsoc_soc_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 5b81e26..a244ae6 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -25,6 +25,7 @@
 #include "hw/char/mchp_pfsoc_mmuart.h"
 #include "hw/dma/sifive_pdma.h"
 #include "hw/misc/mchp_pfsoc_dmc.h"
+#include "hw/misc/mchp_pfsoc_ioscb.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/sd/cadence_sdhci.h"
 
@@ -40,6 +41,7 @@ typedef struct MicrochipPFSoCState {
     DeviceState *plic;
     MchpPfSoCDdrSgmiiPhyState ddr_sgmii_phy;
     MchpPfSoCDdrCfgState ddr_cfg;
+    MchpPfSoCIoscbState ioscb;
     MchpPfSoCMMUartState *serial0;
     MchpPfSoCMMUartState *serial1;
     MchpPfSoCMMUartState *serial2;
@@ -99,7 +101,7 @@ enum {
     MICROCHIP_PFSOC_GPIO2,
     MICROCHIP_PFSOC_ENVM_CFG,
     MICROCHIP_PFSOC_ENVM_DATA,
-    MICROCHIP_PFSOC_IOSCB_CFG,
+    MICROCHIP_PFSOC_IOSCB,
     MICROCHIP_PFSOC_DRAM,
 };
 
-- 
2.7.4


