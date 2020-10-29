Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B25C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A495920825
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V+E3v1If"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A495920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY90d-0005VH-Cn
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sC-0001gs-Gy
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8s8-0005fB-9x
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981548; x=1635517548;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WvADYYedkma8m60qQ3t6k724o1/TYGhkM1vMq0xUXvM=;
 b=V+E3v1IfICxW7kBno5U8dMTUxzawxx928/7DemFnQnG/vc90pHnquYHF
 VB2/ecc40BxJ9EQ1enPnvGR1gqcPPvGLWGqwO2pBvDr4LOiptnu0+xeyN
 pigVJEvegc9ggFA5PZoUKMtMra97t9heY+GWAQqidamCa4zeFHRCWaIIs
 nIx+0DXAfYMEbrAENP6R+Snc/KTICv3sdlsZnwRShQX0pQJ6+XV/YYBte
 NR5Xq1tc+KE+1ibpvgaFSfzkTuwjJhrr2Da5mLYQqI+XpZd2tWFwNLmZm
 lhOo6XAynp11nfQqWiE0qOIGKRA1ps5bcQmlDfg0WE5ygvUvRnB/6YxnT Q==;
IronPort-SDR: mvpqD6UXuNKRgKYdsZHvDo3yGKFwF2Fo2g4YV6UsFtHxpPHrBXLJ1lePQpz4RSnoyEoUHlkviP
 ICEKrRSSFkLx5AACHir2omuMF4U+xyrKaAnPgJNlabhlYlu8QrUuxGpc1ajWEU5/IMmUt75gWW
 idjCWEEKfGvaZ0iuVpZDyw1kH1ioPsHA3f4ZlCJhHa4KLZJl7obZec8u8+0KML4pNebIpqJmiC
 OZUqOpuKc525mzF3m1V4nrtWRaf56hMrjDv//CA04HDBFBMNgdwx74vRcgAG8FKnjHeRJWqbWt
 ih8=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317887"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:28 +0800
IronPort-SDR: eBvwgRd8j0kIDjQHNr8cgJxwqn0byS5zUm9Kp+9sMivZ3TvTyJfqWQ0p6WuchlUhO3jCHC3l8e
 Zr3RLPzw013tPIqM1pZrW6Xfe1VqZKKUxef1gC/cboXygYLXMNMB2sPgBgeB4LSymbRM0rnHHh
 FxxcLM2p/mo0odbNAw1iAOIdFX+qY/1GxQk88K4sEplItLT1CbuTNSYdfgI3/mX4aJYTtBQxrJ
 G+o3xuXJy2hhuRJ57XPLrtkcpleSMqmFlQIGYE4U0AW2P4Jtl0MCsaFGiIjihldKz9A5jiXBft
 IyqULoisUFw3BvAjiWK5tB7f
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:44 -0700
IronPort-SDR: +in0Krq7FERTOvQFfwvleGhjDOJW6Tqg5wosKiW6YoPDdfoJ1lvsGsprlLhlaeOM+5NJGlXb/m
 uRxE5r9U5RWfrYCDvmzU9wwuSdaUaPCkQCevR9yx7dwHm5x17c3ndf+OIsismXjWjImCzYZ3C8
 10VE07Y1yK9ZpgDPoPTiDvMxFJ1Bl8BGKaT5EhLG8S1mTR3WH/OW3cSLuqZ3ZqxX+RK9dmVM+g
 pgZwzt6YdKDgnhMoT57C2z+0y6/BQBhlFVmlnmwEXWeLgBTnk2WMbuysgWz8k8lNrwKyNp/8F8
 dBI=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 10/18] hw/misc: Add Microchip PolarFire SoC DDR Memory
 Controller support
Date: Thu, 29 Oct 2020 07:13:50 -0700
Message-Id: <20201029141358.3102636-11-alistair.francis@wdc.com>
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

The PolarFire SoC DDR Memory Controller mainly includes 2 modules,
called SGMII PHY module and the CFG module, as documented in the
chipset datasheet.

This creates a single file that groups these 2 modules, providing
the minimum functionalities that make the HSS DDR initialization
codes happy.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1603863010-15807-3-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/mchp_pfsoc_dmc.h |  56 ++++++++
 hw/misc/mchp_pfsoc_dmc.c         | 216 +++++++++++++++++++++++++++++++
 MAINTAINERS                      |   2 +
 hw/misc/Kconfig                  |   3 +
 hw/misc/meson.build              |   1 +
 5 files changed, 278 insertions(+)
 create mode 100644 include/hw/misc/mchp_pfsoc_dmc.h
 create mode 100644 hw/misc/mchp_pfsoc_dmc.c

diff --git a/include/hw/misc/mchp_pfsoc_dmc.h b/include/hw/misc/mchp_pfsoc_dmc.h
new file mode 100644
index 0000000000..2baa1413b0
--- /dev/null
+++ b/include/hw/misc/mchp_pfsoc_dmc.h
@@ -0,0 +1,56 @@
+/*
+ * Microchip PolarFire SoC DDR Memory Controller module emulation
+ *
+ * Copyright (c) 2020 Wind River Systems, Inc.
+ *
+ * Author:
+ *   Bin Meng <bin.meng@windriver.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef MCHP_PFSOC_DMC_H
+#define MCHP_PFSOC_DMC_H
+
+/* DDR SGMII PHY module */
+
+#define MCHP_PFSOC_DDR_SGMII_PHY_REG_SIZE   0x1000
+
+typedef struct MchpPfSoCDdrSgmiiPhyState {
+    SysBusDevice parent;
+    MemoryRegion sgmii_phy;
+} MchpPfSoCDdrSgmiiPhyState;
+
+#define TYPE_MCHP_PFSOC_DDR_SGMII_PHY "mchp.pfsoc.ddr_sgmii_phy"
+
+#define MCHP_PFSOC_DDR_SGMII_PHY(obj) \
+    OBJECT_CHECK(MchpPfSoCDdrSgmiiPhyState, (obj), \
+                 TYPE_MCHP_PFSOC_DDR_SGMII_PHY)
+
+/* DDR CFG module */
+
+#define MCHP_PFSOC_DDR_CFG_REG_SIZE         0x40000
+
+typedef struct MchpPfSoCDdrCfgState {
+    SysBusDevice parent;
+    MemoryRegion cfg;
+} MchpPfSoCDdrCfgState;
+
+#define TYPE_MCHP_PFSOC_DDR_CFG "mchp.pfsoc.ddr_cfg"
+
+#define MCHP_PFSOC_DDR_CFG(obj) \
+    OBJECT_CHECK(MchpPfSoCDdrCfgState, (obj), \
+                 TYPE_MCHP_PFSOC_DDR_CFG)
+
+#endif /* MCHP_PFSOC_DMC_H */
diff --git a/hw/misc/mchp_pfsoc_dmc.c b/hw/misc/mchp_pfsoc_dmc.c
new file mode 100644
index 0000000000..15cf3d7725
--- /dev/null
+++ b/hw/misc/mchp_pfsoc_dmc.c
@@ -0,0 +1,216 @@
+/*
+ * Microchip PolarFire SoC DDR Memory Controller module emulation
+ *
+ * Copyright (c) 2020 Wind River Systems, Inc.
+ *
+ * Author:
+ *   Bin Meng <bin.meng@windriver.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/misc/mchp_pfsoc_dmc.h"
+
+/* DDR SGMII PHY module */
+
+#define SGMII_PHY_IOC_REG1              0x208
+#define SGMII_PHY_TRAINING_STATUS       0x814
+#define SGMII_PHY_DQ_DQS_ERR_DONE       0x834
+#define SGMII_PHY_DQDQS_STATUS1         0x84c
+#define SGMII_PHY_PVT_STAT              0xc20
+
+static uint64_t mchp_pfsoc_ddr_sgmii_phy_read(void *opaque, hwaddr offset,
+                                              unsigned size)
+{
+    uint32_t val = 0;
+    static int training_status_bit;
+
+    switch (offset) {
+    case SGMII_PHY_IOC_REG1:
+        /* See ddr_pvt_calibration() in HSS */
+        val = BIT(4) | BIT(2);
+        break;
+    case SGMII_PHY_TRAINING_STATUS:
+        /*
+         * The codes logic emulates the training status change from
+         * DDR_TRAINING_IP_SM_BCLKSCLK to DDR_TRAINING_IP_SM_DQ_DQS.
+         *
+         * See ddr_setup() in mss_ddr.c in the HSS source codes.
+         */
+        val = 1 << training_status_bit;
+        training_status_bit = (training_status_bit + 1) % 5;
+        break;
+    case SGMII_PHY_DQ_DQS_ERR_DONE:
+        /*
+         * DDR_TRAINING_IP_SM_VERIFY state in ddr_setup(),
+         * check that DQ/DQS training passed without error.
+         */
+        val = 8;
+        break;
+    case SGMII_PHY_DQDQS_STATUS1:
+        /*
+         * DDR_TRAINING_IP_SM_VERIFY state in ddr_setup(),
+         * check that DQ/DQS calculated window is above 5 taps.
+         */
+        val = 0xff;
+        break;
+    case SGMII_PHY_PVT_STAT:
+        /* See sgmii_channel_setup() in HSS */
+        val = BIT(14) | BIT(6);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
+                      "(size %d, offset 0x%" HWADDR_PRIx ")\n",
+                      __func__, size, offset);
+        break;
+    }
+
+    return val;
+}
+
+static void mchp_pfsoc_ddr_sgmii_phy_write(void *opaque, hwaddr offset,
+                                           uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                  "(size %d, value 0x%" PRIx64
+                  ", offset 0x%" HWADDR_PRIx ")\n",
+                  __func__, size, value, offset);
+}
+
+static const MemoryRegionOps mchp_pfsoc_ddr_sgmii_phy_ops = {
+    .read = mchp_pfsoc_ddr_sgmii_phy_read,
+    .write = mchp_pfsoc_ddr_sgmii_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void mchp_pfsoc_ddr_sgmii_phy_realize(DeviceState *dev, Error **errp)
+{
+    MchpPfSoCDdrSgmiiPhyState *s = MCHP_PFSOC_DDR_SGMII_PHY(dev);
+
+    memory_region_init_io(&s->sgmii_phy, OBJECT(dev),
+                          &mchp_pfsoc_ddr_sgmii_phy_ops, s,
+                          "mchp.pfsoc.ddr_sgmii_phy",
+                          MCHP_PFSOC_DDR_SGMII_PHY_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->sgmii_phy);
+}
+
+static void mchp_pfsoc_ddr_sgmii_phy_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Microchip PolarFire SoC DDR SGMII PHY module";
+    dc->realize = mchp_pfsoc_ddr_sgmii_phy_realize;
+}
+
+static const TypeInfo mchp_pfsoc_ddr_sgmii_phy_info = {
+    .name          = TYPE_MCHP_PFSOC_DDR_SGMII_PHY,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MchpPfSoCDdrSgmiiPhyState),
+    .class_init    = mchp_pfsoc_ddr_sgmii_phy_class_init,
+};
+
+static void mchp_pfsoc_ddr_sgmii_phy_register_types(void)
+{
+    type_register_static(&mchp_pfsoc_ddr_sgmii_phy_info);
+}
+
+type_init(mchp_pfsoc_ddr_sgmii_phy_register_types)
+
+/* DDR CFG module */
+
+#define CFG_MT_DONE_ACK                 0x4428
+#define CFG_STAT_DFI_INIT_COMPLETE      0x10034
+#define CFG_STAT_DFI_TRAINING_COMPLETE  0x10038
+
+static uint64_t mchp_pfsoc_ddr_cfg_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    uint32_t val = 0;
+
+    switch (offset) {
+    case CFG_MT_DONE_ACK:
+        /* memory test in MTC_test() */
+        val = BIT(0);
+        break;
+    case CFG_STAT_DFI_INIT_COMPLETE:
+        /* DDR_TRAINING_IP_SM_START_CHECK state in ddr_setup() */
+        val = BIT(0);
+        break;
+    case CFG_STAT_DFI_TRAINING_COMPLETE:
+        /* DDR_TRAINING_IP_SM_VERIFY state in ddr_setup() */
+        val = BIT(0);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
+                      "(size %d, offset 0x%" HWADDR_PRIx ")\n",
+                      __func__, size, offset);
+        break;
+    }
+
+    return val;
+}
+
+static void mchp_pfsoc_ddr_cfg_write(void *opaque, hwaddr offset,
+                                     uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                  "(size %d, value 0x%" PRIx64
+                  ", offset 0x%" HWADDR_PRIx ")\n",
+                  __func__, size, value, offset);
+}
+
+static const MemoryRegionOps mchp_pfsoc_ddr_cfg_ops = {
+    .read = mchp_pfsoc_ddr_cfg_read,
+    .write = mchp_pfsoc_ddr_cfg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void mchp_pfsoc_ddr_cfg_realize(DeviceState *dev, Error **errp)
+{
+    MchpPfSoCDdrCfgState *s = MCHP_PFSOC_DDR_CFG(dev);
+
+    memory_region_init_io(&s->cfg, OBJECT(dev),
+                          &mchp_pfsoc_ddr_cfg_ops, s,
+                          "mchp.pfsoc.ddr_cfg",
+                          MCHP_PFSOC_DDR_CFG_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->cfg);
+}
+
+static void mchp_pfsoc_ddr_cfg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Microchip PolarFire SoC DDR CFG module";
+    dc->realize = mchp_pfsoc_ddr_cfg_realize;
+}
+
+static const TypeInfo mchp_pfsoc_ddr_cfg_info = {
+    .name          = TYPE_MCHP_PFSOC_DDR_CFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MchpPfSoCDdrCfgState),
+    .class_init    = mchp_pfsoc_ddr_cfg_class_init,
+};
+
+static void mchp_pfsoc_ddr_cfg_register_types(void)
+{
+    type_register_static(&mchp_pfsoc_ddr_cfg_info);
+}
+
+type_init(mchp_pfsoc_ddr_cfg_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 7e442b5247..252284f005 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1326,8 +1326,10 @@ L: qemu-riscv@nongnu.org
 S: Supported
 F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
+F: hw/misc/mchp_pfsoc_dmc.c
 F: include/hw/riscv/microchip_pfsoc.h
 F: include/hw/char/mchp_pfsoc_mmuart.h
+F: include/hw/misc/mchp_pfsoc_dmc.h
 
 RX Machines
 -----------
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 877ecff447..32ab718cd3 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -139,6 +139,9 @@ config MAC_VIA
 config AVR_POWER
     bool
 
+config MCHP_PFSOC_DMC
+    bool
+
 config SIFIVE_TEST
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index aa8ec3bca9..c63066be4f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -23,6 +23,7 @@ softmmu_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
 softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 
 # RISC-V devices
+softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
-- 
2.28.0


