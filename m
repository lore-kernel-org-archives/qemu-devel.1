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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31DBC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA2E2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaceE4R4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA2E2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXe4a-0007Mt-1s
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 01:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2q-0005KP-Gl; Wed, 28 Oct 2020 01:30:48 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:34654)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2o-0000ef-3d; Wed, 28 Oct 2020 01:30:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id o129so2273493pfb.1;
 Tue, 27 Oct 2020 22:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ljqm7mDbejdOxFlxqdgG44/ktrepZx5NKv48fsnDllU=;
 b=eaceE4R4Kp3/bfqW9j6+MVneVHksNBgfIw5h3Me6/CvP/AHijZcLst3cdJeg5gsyw6
 HzK1rHX2MSgFpCL3rqBNQHEc8YF4G12ZToK81Elvyy2IvZLiLqHohWXYpbXI1dAinx+y
 5ZUMizqZFUs47E7KPOE2l1w+iZhfJY++0w5AOC1lyjUEB2XSrlHXsyFSWwQme3dBg6dY
 yeerkfhW0nw97fttp7THt2DydzgREfZ15FF1nir2pYUIpaXXsJqyhUO3ga+oWICXaQvU
 TZPk0fUVMfhDYlOWADZl85Ut3uC/OwTGzyTTtdvs8RFDy6gnSn+91zlSkISGcZd1t0y6
 dhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ljqm7mDbejdOxFlxqdgG44/ktrepZx5NKv48fsnDllU=;
 b=kwjfq7NI/9Tvb/+9ro5+xJCNY1lKAcfMBk4D3Ll2H6UYaeaLC84gjzn73VXAah7jVJ
 /ToJz2IVB5EWio/vhMYxNNiO8329j4ve8yu/H0/3evt/0E6isDjh9L8cYKjQP6LHZ07S
 5LkSjPcFxgwLhdUdqplwmeiISeZhMAbt1Esrri3BVxJ9dTA3frd+bY5HVpsAet65dTCI
 AMgw5m62VaRC6QR5aCImLo9qjxtYKK5uG04yH+T5d+bhDWSrUcCLNaIMr+Ba64+zqSR/
 iWxy4ncrnuOoZwcQ4nraNyN5H562H+HIRe+3bvQJxAskp4fFpEqO0FUVbEByY8jY7ziC
 yVwA==
X-Gm-Message-State: AOAM530aLrPgJ4ZNO1Vfz2wldaP2oLFGU781uetPIaQ1hzEhYKt/mFa+
 IVCyeG7Yu3r8gZxNOAgDCwk=
X-Google-Smtp-Source: ABdhPJy9S4SV5ju49odRmlD1vTmI9VsBkQe1oKfsh2lAy9a0s5N8Uk6Dmmkshua7APlLeLlVHxz0lA==
X-Received: by 2002:a62:1844:0:b029:152:80d3:8647 with SMTP id
 65-20020a6218440000b029015280d38647mr4955543pfy.18.1603863044516; 
 Tue, 27 Oct 2020 22:30:44 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 9sm5031887pjs.1.2020.10.27.22.30.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 22:30:44 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 07/10] hw/riscv: microchip_pfsoc: Connect the SYSREG module
Date: Wed, 28 Oct 2020 13:30:07 +0800
Message-Id: <1603863010-15807-8-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
References: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x433.google.com
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

Previously SYSREG was created as an unimplemented device. Now that
we have a simple SYSREG module, connect it.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 hw/riscv/Kconfig                   | 1 +
 hw/riscv/microchip_pfsoc.c         | 9 ++++++---
 include/hw/riscv/microchip_pfsoc.h | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 8f043e3..facb0cb 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -7,6 +7,7 @@ config MICROCHIP_PFSOC
     select MCHP_PFSOC_DMC
     select MCHP_PFSOC_IOSCB
     select MCHP_PFSOC_MMUART
+    select MCHP_PFSOC_SYSREG
     select MSI_NONBROKEN
     select SIFIVE_CLINT
     select SIFIVE_PDMA
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 438e0c4..bc908e0 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -153,6 +153,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "dma-controller", &s->dma,
                             TYPE_SIFIVE_PDMA);
 
+    object_initialize_child(obj, "sysreg", &s->sysreg,
+                            TYPE_MCHP_PFSOC_SYSREG);
+
     object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
                             TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
     object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
@@ -280,9 +283,9 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SYSREG */
-    create_unimplemented_device("microchip.pfsoc.sysreg",
-        memmap[MICROCHIP_PFSOC_SYSREG].base,
-        memmap[MICROCHIP_PFSOC_SYSREG].size);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysreg), 0,
+                    memmap[MICROCHIP_PFSOC_SYSREG].base);
 
     /* MPUCFG */
     create_unimplemented_device("microchip.pfsoc.mpucfg",
diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index a244ae6..245c82d 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -26,6 +26,7 @@
 #include "hw/dma/sifive_pdma.h"
 #include "hw/misc/mchp_pfsoc_dmc.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
+#include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/sd/cadence_sdhci.h"
 
@@ -47,6 +48,7 @@ typedef struct MicrochipPFSoCState {
     MchpPfSoCMMUartState *serial2;
     MchpPfSoCMMUartState *serial3;
     MchpPfSoCMMUartState *serial4;
+    MchpPfSoCSysregState sysreg;
     SiFivePDMAState dma;
     CadenceGEMState gem0;
     CadenceGEMState gem1;
-- 
2.7.4


