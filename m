Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22335C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83F9A20838
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QnIK6YiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83F9A20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8z9-0002zz-E9
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sS-0001o9-2A
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sP-0005fB-AI
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981565; x=1635517565;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o8QV0Me158q9SB0wiG+MH22S5sqXbxbb5FbSRzMEA74=;
 b=QnIK6YiUn93Onb0zIUtw7AmnkzIgxl/oYrl1G0+5hujWn1DG2b158B7A
 HpgfBcfF1enFD0BNxi4ZBDeWbtpK7R7PpZwaLORylBchWCgUpFGd2T0Lz
 VH8+vBTLkWR7nIN2+GlH1h3Nao3yJMMr6KAtVH3Rg3TTg3gItpY8kE5ec
 re1NqP59vHq5P0F8iKX1eoL5T7WJ47a+k3UiA3po+48aCi2bDSkGO1Tk0
 EFbwQvYCKHT3Ualggh/XMaKQJJ0xlCHyk2IfqQ0TlkLbdYZFS0E4ucet0
 A8xqQXjNdAgjsFh2vWfoDVXZXqLpDq9hxcnWpJPpKUo57y28KQ0euhXyS g==;
IronPort-SDR: bBO1iDi9yOg3GRZoE0M7g2JKdJis3Q/GxT/oi4ncF5fLxQ62XtjDCT38RUFCSMbUhF8O3BXOUE
 d6NHQrgPnRKe/MxmJzo9hPONfxjQd1t4Ocv2cMEGNZ/0pRqiIoH3AwyToL5x/MKylvCVE3Jszt
 cIRro1OLQfKakp6bVeibcNhmZby9O4sHMACZJc6PbLaFmDFDhtMtiOpw7XuWsKoBQgJPOPqwTa
 KyAZcWMgmtjy6vYHpXaXP6dxMGHSTtAP0cjNY3l7sBGV6kaUFVy+D/YuFAns07QiclxyQiszcs
 T0c=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317893"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:29 +0800
IronPort-SDR: 8GbEy6CTauH9BJU/qi7S+y1lXISaVc46o1V4l8SWw80eMHjehnq+3GV7AoGbfPIYbG3qcNvalZ
 fUEpPFHWtbPXSAN5JlmTZsCmYHR47Di2qQAH6rfAyF7iOxt1XBTEOz2pEELIhM2603067hZ0d1
 A47jIPuvewof6/Abko5PV1V7LeLaaFliZjL7gnN6nFrI1esYjZrYHYxZg/VEGOZZa1Ur0GBo+H
 0SJy5wYr8Nt/JbIv1JjpnEM842ehQ1KtquMzc5BxyNpdwLhBmcefUs45Qmeyw404/ZpOIq2SRf
 id6doxuyiTAW0GU4oJNZwBis
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:44 -0700
IronPort-SDR: IkrHZHO77l3o9we5BDAt5i9Um4qPNk+RfDQF/Pzs1xOlxmVWejTnLhFNX5BC75I95op+YYQ8C4
 JAGbjpBNNK3TFVsbI+CVMexie9J0OOCiCzjBWfP98Ye07MS0s+hUKrLuQxIfTdPFejYOfhDMFy
 ffMLIRCMsdI0A0cb6eXLc40sEmhWChEg6WiyAm9XwChEN9+7CsYHz5otC8ifuYxpQccEF0/8oH
 ksABGi3ABwW/YLHMui52bLYCi/41U8gyQ5HotZwYNSaz/fqPEaBk5yZvhi/R6O21ifpf9LgKaw
 kE4=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 13/18] hw/riscv: microchip_pfsoc: Connect the IOSCB module
Date: Thu, 29 Oct 2020 07:13:53 -0700
Message-Id: <20201029141358.3102636-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029141358.3102636-1-alistair.francis@wdc.com>
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=56447669b=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:25:26
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

Previously IOSCB_CFG was created as an unimplemented device. With
the new IOSCB model, its memory range is already covered by the
IOSCB hence remove the previous unimplemented device creation in
the SoC codes.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1603863010-15807-6-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h |  4 +++-
 hw/riscv/microchip_pfsoc.c         | 13 ++++++++-----
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 12 insertions(+), 6 deletions(-)

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
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 3c504f7c03..438e0c464d 100644
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
-- 
2.28.0


