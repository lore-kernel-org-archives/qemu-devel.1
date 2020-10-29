Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D95C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E175C2151B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ynlro3m+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E175C2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8ww-0007rE-QE
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sH-0001hl-N5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sA-0005fQ-Ce
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981550; x=1635517550;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2GIx+t0Rp+fA0ib/C5fOILwZ9azhuSUJ4wg+kNar0QY=;
 b=Ynlro3m+ShmGRP/QgqkVXQtzNYb7QS6bMxMtuD8dv+V9KzfUAo4XlgPA
 aahD/dnLZtI3omJHNSyVABOJQKQCmmU0GEW6qW9FWZYgw9pFwDbtL60yx
 PbIy+LSnplyi4HZssfMatTWIIO4add7dQnqCcArj7Z+dEE+rLNOXk4m96
 DGsQG6nmGbP2Ym/bCUtPFEmGh+bHNnP4Rd9o2PNp3SP1cI/HHMWnlVU4E
 YVhH6lk7w8QNZUKs1kU9p1KYstbO6arCLwyvur2fXtyDUHo13UNX8tAod
 Yy74/zX16e0iBJSgXt/AFVD6SiHZ9GpKSZlp4P+EvrDOE08UuuNnkIMaR g==;
IronPort-SDR: 5H4JYIbucQNKRRqr8uzuWMvQLr6xXbUmZLAXK/1JEtvT9t9ZK+TOqA9sY3hPiPHESO7Fqs+HA9
 ABD7HIX1A8/Sco1zHIhXwZ2LuCgTElEGLR/sPzKmKaaRai96ilEU0torUpr6WmrxbpVH9zBzYP
 uXufh+rqQe1FfeM4NkH/h8xhiaNDNArJtbb2jzuCO5x3Ai7hK8F+xzfpKBsPcWWXO+bzbFI7XY
 mtJz8Z8LacClHezqCd9+xGLupu95TcIY9rkkKH7UCwck6ofDH3jnBdbL4+bp+LwJEmpPl1rsDK
 HQ0=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317889"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:28 +0800
IronPort-SDR: rA6Ojv6AP0n/8hbH72DhiTNJBt3AACAJxN5P25/4HftVbjWkvQzIpWJil8vYO+HzASrI6uWqGa
 Zp7zEIbWIYEZFQXuUyGZMoZibc+ym2BOf3NY0203bxIf3OY39kVa0QEL1JBaa76dn7CedZ4Q+2
 We0/PbykOnQ/urgSlaIKCyLZbbPtZWWHHbgO/GZ/ovrf0pXfz4cffZhHMW/kd7r9YR9RgtMSNd
 U4RRWzoTSQ4iiZx+TiZfaXQqtL0lCSKmgLvJznyVnpfsqmfxwbisCyAkoZDM3966QpUZPLAfCr
 i9Q+RmOvFf3ykm+RdSxbJGf6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:44 -0700
IronPort-SDR: TKEONT9XzMA30PvXBAHMWMg2RyrMsunRJJUfXJ4up6Zz7NoRY3YEaqhrz9/60delWviMGhgoUM
 VMgD1pqMQvsh7mZiRQb8FfDN3AecuHtjUaXF2tHFvHiIsq6na2IHSgDT6ClbGJUkezPCfsn7B8
 6pJAztyLOZ5DNDxpOkVFw8AvrNjffUGQR93vzssweJVgE6PxAw5+l6b//vIuMdivq8/YaZHxUE
 7BdusxXKzFNwlif6i/4RaryncRcHg+s2Bs/BkWDI4QQz6wd6nEFP+GXUKPT3NmQnvrTO01+nDm
 kmI=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 11/18] hw/riscv: microchip_pfsoc: Connect DDR memory controller
 modules
Date: Thu, 29 Oct 2020 07:13:51 -0700
Message-Id: <20201029141358.3102636-12-alistair.francis@wdc.com>
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


