Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A326C5517A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AAB22281
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdN2Kclf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AAB22281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQMk-0004dv-9Y
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPnx-0002SK-Rm; Tue, 27 Oct 2020 10:18:29 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPnv-0007gM-U4; Tue, 27 Oct 2020 10:18:29 -0400
Received: by mail-pf1-x444.google.com with SMTP id x13so987364pfa.9;
 Tue, 27 Oct 2020 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tIOGbOL2UT6zJWqjm6jM577hFFhdN+GskjyMoK+iUzY=;
 b=MdN2KclfwaJgLqITVljCPJF1W3etq+Oq4S3nRglvkK2M8w9N3cdBMXlAlm3iCDAGX+
 1L8IftVv9Rn2z6LoopplxF8I33x8i6Jf+MG8sWS8y9cKHpbX/Za/7dUoSKRrDdr9V3ry
 UEXUcxOo1wBls8BRTZpldzmxP0xurg6/e8Ce0eKS3rLG9kp+FwBykceraKneIkqT//+U
 GqI+1E5pDfL3PWgoUpwvhC5g5HAZMtxdW18N/GCzrRAfjtLlDnzExw0C9bitvwfzoc51
 ohHPEj/e/wRBF1esgu7IqWL7EesVRNgzjgFwtw7jtVpaaDGCijLGAwscAN7FVct62sOO
 ZunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tIOGbOL2UT6zJWqjm6jM577hFFhdN+GskjyMoK+iUzY=;
 b=IgGzoqHGDvzh8l0P466RB6QwhEo/6uWpxQf6yFZiMJFeBx0yPz/dBligx5TLuoLdlX
 f3H7zMWx3vu9KvsEYi6IjIFqa7esM2DWN/yXHM1JO/TY9X8BQiIXdzEKqGRCtpmDq75y
 fpdj7wz4+u6+Z4jSucND00Aaf3zdnddvktso9eZ4NKEUG3zJdCg6kX35Bt6V8cgPgono
 dZnaQj1HTgI1zwmWffSAO2ITsMR3HkaNTX8jrcPUoc1H9fSr7AIGs7o5OF9+idzsLvzF
 0daK5+w1oe4f95r0vihFiMmbt6oJK4CFZIJioNoZoOHCswtLgq/C4VvkbUoVGP8b9sIP
 svmg==
X-Gm-Message-State: AOAM533746DzY6YhBMZg5IJyo0NHMVFr8lN6kYxQjJ1j2uvvHUx35JMv
 XOr0cKvq5ZJHfJqKWoxSTE0=
X-Google-Smtp-Source: ABdhPJz8NsIvlJFArZTGTzvYRt+OlPVOF1TWJHD107AXTTeF1AhrsBTEoPaWaHg1PveGYS89CUv3Lg==
X-Received: by 2002:a63:1604:: with SMTP id w4mr2092757pgl.148.1603808305969; 
 Tue, 27 Oct 2020 07:18:25 -0700 (PDT)
Received: from i9-aorus-gtx1080.localdomain (144.168.56.201.16clouds.com.
 [144.168.56.201])
 by smtp.gmail.com with ESMTPSA id mn15sm1600297pjb.21.2020.10.27.07.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 07:18:25 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [RESEND PATCH 4/9] hw/riscv: microchip_pfsoc: Connect the IOSCB module
Date: Tue, 27 Oct 2020 22:17:35 +0800
Message-Id: <20201027141740.18336-5-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027141740.18336-1-bmeng.cn@gmail.com>
References: <20201027141740.18336-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x444.google.com
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
---

 hw/riscv/Kconfig                   |  1 +
 hw/riscv/microchip_pfsoc.c         | 13 ++++++++-----
 include/hw/riscv/microchip_pfsoc.h |  4 +++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index c8e50bde99..8f043e38e0 100644
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
index 85be2bcde8..05fb5004a1 100644
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
@@ -100,7 +101,7 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_GPIO2] =           { 0x20122000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
-    [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
+    [MICROCHIP_PFSOC_IOSCB] =           { 0x30000000, 0x10000000 },
     [MICROCHIP_PFSOC_DRAM] =            { 0x80000000,        0x0 },
 };
 
@@ -144,6 +145,8 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
 
     object_initialize_child(obj, "sd-controller", &s->sdhci,
                             TYPE_CADENCE_SDHCI);
+
+    object_initialize_child(obj, "ioscb", &s->ioscb, TYPE_MCHP_PFSOC_IOSCB);
 }
 
 static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
@@ -355,10 +358,10 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
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
index 5b81e26241..a244ae6d39 100644
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
2.25.1


