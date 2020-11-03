Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE2BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6041F206F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OJcIgCSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6041F206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyVo-00039u-DV
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJx-00029s-57
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:05 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJv-0001Fa-1P
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417643; x=1635953643;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=o8QV0Me158q9SB0wiG+MH22S5sqXbxbb5FbSRzMEA74=;
 b=OJcIgCSHhxmouy7R+SEAhviFxByHet/3htk1I0461YqWjCzg4CX9Ap3f
 H6Mwz+7LtN0SXZmaiYVY99FGE/y2MEviA2OOgxJcBXb9OKza3ZRqbkVoc
 MM+mSsaBvTYfvGN2FiZ3KlM6r9E4dm2iS5ezouoK36yiyLZ1o+ul7d0C6
 48+rtBF09/NlnMikxw3M4bK9RBsxc0Aba9117qAaxpZoLRAsuCNZckOAb
 LCfneuou/elYiJrQP7IgvD9g0eheS9dqSWAQ2XSMW0gj0QOwPbJ5e8YLa
 mHFkhJfnFK1O8x3Bg1P92c0kKycusqd2V3KPGUkInB1p4ZI+1MZ6F06vW A==;
IronPort-SDR: R0QAT2hE7cnuY23srIFacNo3z28mKebo4umYvnqRPgTn9/Ydo+xpdSJFhULPUpk0KXZULWeitw
 2yagp8dKmy4ywLQgTZvlrhXG8P0H/0RtCtNTGJwvAsX8vHTf2ElRp27SyAwXJmsV6jkJXLfAtW
 D0RJWHazCWvI5ypkENhpo0Ki2y7XVQSPCT+vrBqaG2ehLUaqSC/Uv+1KRuWeBl5fgmQRUHo37O
 H6clodwyAMyJrQDAGuXAGVCdVzx2XAGVmvdYVChJ+I4N7zjPGdoxJPptmrwtz0p1Lmi5vzvqbh
 ces=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867477"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:27 +0800
IronPort-SDR: rAIayDd/7eHgy8sNjat7Klt8T0phDXaI4h0jYkGL++oO5LH79DXKl0aT22frz7HDBxKT5iJAmG
 OSHVvrOKHEruZCI8zYDeXp3WSUo7osX4Hi1zcSf2iaQjPc+JNveOuW430dFlbfknrSMoYCGT5q
 Ez/oXOoxy2QUkt2tD9GXuM35InIUMruObZ/A5pLBYFLYXu5edGvWdKgcuXREGfHpffDlr47tcE
 z1ABYMuEwBtLKjHe/axG4z9k9EWFhzHEw81+ChFt1DbB9BZyAF+mKqcpuTnDI3yoEe3Ry2w7He
 CPDjAt8XkQKlnhrsWwOFFsoF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:35 -0800
IronPort-SDR: c+YPWVcfGbxr8+UbFLK2oYATqnuf57mP/P5+HLjg/Edc0vkTn86vc4aqUeiIFYtR5+cA7v5pjP
 HBk8OWHhPXfDuXarmrHTi76Ke2DSFdS/GMLwr5fiu1nv4anihbNQ50HXkFqpSrYuPu5DMs2cOl
 fL3vw8/LJ+TOQ+iQ+EmiwruXIV2QLiH1QdR7Ig6yINp4K/uZ8oI3t3tqVlvZRCj6nCd4rBm+4Q
 F+QBPSLfQTtOs4TwjXEm/kGQ4LUlbYWoHuy4C91xrKmnTuKsdppyj0YXDkElkoqdExrTsXIEkH
 ihg=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:27 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 13/19] hw/riscv: microchip_pfsoc: Connect the IOSCB module
Date: Tue,  3 Nov 2020 07:21:44 -0800
Message-Id: <20201103152150.2677566-14-alistair.francis@wdc.com>
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


