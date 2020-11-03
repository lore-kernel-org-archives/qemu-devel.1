Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF48C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC74E20756
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XQUa8WMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC74E20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyNB-00075T-Rp
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJp-0001xW-O1
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:57 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJg-0001FT-48
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:33:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417628; x=1635953628;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FUh/JVqOCLT6kfbvDNCum6wBBK4GMTnxNOtvXM/5D88=;
 b=XQUa8WMFOiW92Crdl4Jumzq7HSe/wgUXG/v/ZVf0iSzats5Wf2qfUKcY
 3PnBfGwIh2XJ+SjymYGAvSUkLb41vxvRBt2ffAeHcMLsrUcimuVxetOT2
 6GuVJe40lRb6776k8CgMIc4EM/8T8De/pZuQwjBa/GwgukN/iwjxU3m8D
 T6aS+iqpanwzdV2QgU4HmfvjQ7+FFICBM896SVOfNYMkyTEY1f6unwSb0
 LzIPSKu3sDnmNq9eqeYlwErGnuzDnZcvvwmMHmiyKJBCvTGRHHSCZ7KDS
 9YSBOm2NpKe8QaLWVoGGSwffm/7CqTbjNw8AvwTwbff+MFcf2vx2xAh0O w==;
IronPort-SDR: fuAm6qAf0IXACj4QQyC4uB4MymFNknkmjIpOR6sz0vXdJA1aPiLEi3iEFxywOhxhRwTZFCGfoX
 qG32un85PyqylwbdsrhaDJbX6AXePJCgZVorSZRp0hDg+pVh5N3kbaC2yajXMO2CKtrsHqVO4j
 6g7T9C51yAj1+9iCOJLjX1APQB0K4hy5j4LhCm47Kqxt++4vY73JxCF6mGoVndecV1kPZzV26O
 rCsLLoNIA2ouXAQZCvzSwbFTQk/IbMSkiMOjzHPL2aqVGpjbfPa8LlbVYjor4rv9pEPtml0g4j
 9NE=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867474"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:27 +0800
IronPort-SDR: ujIdcjs/v2l9kzOlG4E2cHlr0c2lL83INaU7viWbaHLyf+xd+qEoKtB06fCKE+v40X/RfGIKoe
 nO00MqhjBu5LxEiL5yYTw/Oetm3lZYxCyvJI4rjRgE+Vm6J6clrBHziDlRQKvWi3rwtBEJCcSY
 BGkbtW57U6wKNm7t5DczmYH5GEc7f3m1aX1hU0Z1O1/F9VEmY5yceot10cQ+EEbujZgekgnT56
 uNKUpQkmn3fI/EW4TzEfECpjTir/ylnUtbdWZBjub2Aj8/3QHu0YbGmXWpOFFvGCInTPM0PxHm
 p6l94ysAkU5Xl618fzbhcxk9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:35 -0800
IronPort-SDR: ogilT1I68x2IjS+MWSgQ2JhiaA+IMi89JGdmwIGWVd9qx6SKukqRTXyHtsOAaJp/SEUGvsappf
 tf1VJ00DrnMAMdURXv9sLJgXy477jd6+KYUlvAhMiX69D1HwLdeLp/ofpfazi/RberEB/uBbmD
 h7L26SPjPBEFmcymtdOSRR7PsvFYeZIWiW5UBy2VlaLdx5/G2C7jHQAp38xPNGjHWAIpZkW2fy
 /nBH57ue6kqZWdx904cZ4oHKAqI667abDo5cHsL3txTWtFxQBPSy/N/kNqEG/6qk8hls8c4wKf
 Q50=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:27 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 12/19] hw/misc: Add Microchip PolarFire SoC IOSCB module
 support
Date: Tue,  3 Nov 2020 07:21:43 -0800
Message-Id: <20201103152150.2677566-13-alistair.francis@wdc.com>
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

This creates a model for PolarFire SoC IOSCB [1] module. It actually
contains lots of sub-modules like various PLLs to control different
peripherals. Only the mininum capabilities are emulated to make the
HSS DDR memory initialization codes happy. Lots of sub-modules are
created as an unimplemented devices.

[1] PF_SoC_RegMap_V1_1/MPFS250T/mpfs250t_ioscb_memmap_dri.htm in
    https://www.microsemi.com/document-portal/doc_download/1244581-polarfire-soc-register-map

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1603863010-15807-5-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/mchp_pfsoc_ioscb.h |  50 ++++++
 hw/misc/mchp_pfsoc_ioscb.c         | 242 +++++++++++++++++++++++++++++
 MAINTAINERS                        |   2 +
 hw/misc/Kconfig                    |   3 +
 hw/misc/meson.build                |   1 +
 5 files changed, 298 insertions(+)
 create mode 100644 include/hw/misc/mchp_pfsoc_ioscb.h
 create mode 100644 hw/misc/mchp_pfsoc_ioscb.c

diff --git a/include/hw/misc/mchp_pfsoc_ioscb.h b/include/hw/misc/mchp_pfsoc_ioscb.h
new file mode 100644
index 0000000000..9235523e33
--- /dev/null
+++ b/include/hw/misc/mchp_pfsoc_ioscb.h
@@ -0,0 +1,50 @@
+/*
+ * Microchip PolarFire SoC IOSCB module emulation
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
+#ifndef MCHP_PFSOC_IOSCB_H
+#define MCHP_PFSOC_IOSCB_H
+
+typedef struct MchpPfSoCIoscbState {
+    SysBusDevice parent;
+    MemoryRegion container;
+    MemoryRegion lane01;
+    MemoryRegion lane23;
+    MemoryRegion ctrl;
+    MemoryRegion cfg;
+    MemoryRegion pll_mss;
+    MemoryRegion cfm_mss;
+    MemoryRegion pll_ddr;
+    MemoryRegion bc_ddr;
+    MemoryRegion io_calib_ddr;
+    MemoryRegion pll_sgmii;
+    MemoryRegion dll_sgmii;
+    MemoryRegion cfm_sgmii;
+    MemoryRegion bc_sgmii;
+    MemoryRegion io_calib_sgmii;
+} MchpPfSoCIoscbState;
+
+#define TYPE_MCHP_PFSOC_IOSCB "mchp.pfsoc.ioscb"
+
+#define MCHP_PFSOC_IOSCB(obj) \
+    OBJECT_CHECK(MchpPfSoCIoscbState, (obj), TYPE_MCHP_PFSOC_IOSCB)
+
+#endif /* MCHP_PFSOC_IOSCB_H */
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
new file mode 100644
index 0000000000..8b0d1cacd7
--- /dev/null
+++ b/hw/misc/mchp_pfsoc_ioscb.c
@@ -0,0 +1,242 @@
+/*
+ * Microchip PolarFire SoC IOSCB module emulation
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
+#include "hw/misc/mchp_pfsoc_ioscb.h"
+
+/*
+ * The whole IOSCB module registers map into the system address at 0x3000_0000,
+ * named as "System Port 0 (AXI-D0)".
+ */
+#define IOSCB_WHOLE_REG_SIZE        0x10000000
+#define IOSCB_SUBMOD_REG_SIZE       0x1000
+
+/*
+ * There are many sub-modules in the IOSCB module.
+ * See Microchip PolarFire SoC documentation (Register_Map.zip),
+ * Register Map/PF_SoC_RegMap_V1_1/MPFS250T/mpfs250t_ioscb_memmap_dri.htm
+ *
+ * The following are sub-modules offsets that are of concern.
+ */
+#define IOSCB_LANE01_BASE           0x06500000
+#define IOSCB_LANE23_BASE           0x06510000
+#define IOSCB_CTRL_BASE             0x07020000
+#define IOSCB_CFG_BASE              0x07080000
+#define IOSCB_PLL_MSS_BASE          0x0E001000
+#define IOSCB_CFM_MSS_BASE          0x0E002000
+#define IOSCB_PLL_DDR_BASE          0x0E010000
+#define IOSCB_BC_DDR_BASE           0x0E020000
+#define IOSCB_IO_CALIB_DDR_BASE     0x0E040000
+#define IOSCB_PLL_SGMII_BASE        0x0E080000
+#define IOSCB_DLL_SGMII_BASE        0x0E100000
+#define IOSCB_CFM_SGMII_BASE        0x0E200000
+#define IOSCB_BC_SGMII_BASE         0x0E400000
+#define IOSCB_IO_CALIB_SGMII_BASE   0x0E800000
+
+static uint64_t mchp_pfsoc_dummy_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
+                  "(size %d, offset 0x%" HWADDR_PRIx ")\n",
+                  __func__, size, offset);
+
+    return 0;
+}
+
+static void mchp_pfsoc_dummy_write(void *opaque, hwaddr offset,
+                                   uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                  "(size %d, value 0x%" PRIx64
+                  ", offset 0x%" HWADDR_PRIx ")\n",
+                  __func__, size, value, offset);
+}
+
+static const MemoryRegionOps mchp_pfsoc_dummy_ops = {
+    .read = mchp_pfsoc_dummy_read,
+    .write = mchp_pfsoc_dummy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+/* All PLL modules in IOSCB have the same register layout */
+
+#define PLL_CTRL    0x04
+
+static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    uint32_t val = 0;
+
+    switch (offset) {
+    case PLL_CTRL:
+        /* PLL is locked */
+        val = BIT(25);
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
+static const MemoryRegionOps mchp_pfsoc_pll_ops = {
+    .read = mchp_pfsoc_pll_read,
+    .write = mchp_pfsoc_dummy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+/* IO_CALIB_DDR submodule */
+
+#define IO_CALIB_DDR_IOC_REG1   0x08
+
+static uint64_t mchp_pfsoc_io_calib_ddr_read(void *opaque, hwaddr offset,
+                                             unsigned size)
+{
+    uint32_t val = 0;
+
+    switch (offset) {
+    case IO_CALIB_DDR_IOC_REG1:
+        /* calibration completed */
+        val = BIT(2);
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
+static const MemoryRegionOps mchp_pfsoc_io_calib_ddr_ops = {
+    .read = mchp_pfsoc_io_calib_ddr_read,
+    .write = mchp_pfsoc_dummy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void mchp_pfsoc_ioscb_realize(DeviceState *dev, Error **errp)
+{
+    MchpPfSoCIoscbState *s = MCHP_PFSOC_IOSCB(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init(&s->container, OBJECT(s),
+                       "mchp.pfsoc.ioscb", IOSCB_WHOLE_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->container);
+
+    /* add subregions for all sub-modules in IOSCB */
+
+    memory_region_init_io(&s->lane01, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+                          "mchp.pfsoc.ioscb.lane01", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_LANE01_BASE, &s->lane01);
+
+    memory_region_init_io(&s->lane23, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+                          "mchp.pfsoc.ioscb.lane23", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_LANE23_BASE, &s->lane23);
+
+    memory_region_init_io(&s->ctrl, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+                          "mchp.pfsoc.ioscb.ctrl", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_CTRL_BASE, &s->ctrl);
+
+    memory_region_init_io(&s->cfg, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+                          "mchp.pfsoc.ioscb.cfg", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_CFG_BASE, &s->cfg);
+
+    memory_region_init_io(&s->pll_mss, OBJECT(s), &mchp_pfsoc_pll_ops, s,
+                          "mchp.pfsoc.ioscb.pll_mss", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_PLL_MSS_BASE, &s->pll_mss);
+
+    memory_region_init_io(&s->cfm_mss, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+                          "mchp.pfsoc.ioscb.cfm_mss", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_CFM_MSS_BASE, &s->cfm_mss);
+
+    memory_region_init_io(&s->pll_ddr, OBJECT(s), &mchp_pfsoc_pll_ops, s,
+                          "mchp.pfsoc.ioscb.pll_ddr", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_PLL_DDR_BASE, &s->pll_ddr);
+
+    memory_region_init_io(&s->bc_ddr, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+                          "mchp.pfsoc.ioscb.bc_ddr", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_BC_DDR_BASE, &s->bc_ddr);
+
+    memory_region_init_io(&s->io_calib_ddr, OBJECT(s),
+                          &mchp_pfsoc_io_calib_ddr_ops, s,
+                          "mchp.pfsoc.ioscb.io_calib_ddr",
+                          IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_IO_CALIB_DDR_BASE,
+                                &s->io_calib_ddr);
+
+    memory_region_init_io(&s->pll_sgmii, OBJECT(s), &mchp_pfsoc_pll_ops, s,
+                          "mchp.pfsoc.ioscb.pll_sgmii", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_PLL_SGMII_BASE,
+                                &s->pll_sgmii);
+
+    memory_region_init_io(&s->dll_sgmii, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+                          "mchp.pfsoc.ioscb.dll_sgmii", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_DLL_SGMII_BASE,
+                                &s->dll_sgmii);
+
+    memory_region_init_io(&s->cfm_sgmii, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+                          "mchp.pfsoc.ioscb.cfm_sgmii", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_CFM_SGMII_BASE,
+                                &s->cfm_sgmii);
+
+    memory_region_init_io(&s->bc_sgmii, OBJECT(s), &mchp_pfsoc_dummy_ops, s,
+                          "mchp.pfsoc.ioscb.bc_sgmii", IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_BC_SGMII_BASE,
+                                &s->bc_sgmii);
+
+    memory_region_init_io(&s->io_calib_sgmii, OBJECT(s), &mchp_pfsoc_dummy_ops,
+                          s, "mchp.pfsoc.ioscb.io_calib_sgmii",
+                          IOSCB_SUBMOD_REG_SIZE);
+    memory_region_add_subregion(&s->container, IOSCB_IO_CALIB_SGMII_BASE,
+                                &s->io_calib_sgmii);
+}
+
+static void mchp_pfsoc_ioscb_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Microchip PolarFire SoC IOSCB modules";
+    dc->realize = mchp_pfsoc_ioscb_realize;
+}
+
+static const TypeInfo mchp_pfsoc_ioscb_info = {
+    .name          = TYPE_MCHP_PFSOC_IOSCB,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MchpPfSoCIoscbState),
+    .class_init    = mchp_pfsoc_ioscb_class_init,
+};
+
+static void mchp_pfsoc_ioscb_register_types(void)
+{
+    type_register_static(&mchp_pfsoc_ioscb_info);
+}
+
+type_init(mchp_pfsoc_ioscb_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index d370158069..0e597c2989 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1328,9 +1328,11 @@ S: Supported
 F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
 F: hw/misc/mchp_pfsoc_dmc.c
+F: hw/misc/mchp_pfsoc_ioscb.c
 F: include/hw/riscv/microchip_pfsoc.h
 F: include/hw/char/mchp_pfsoc_mmuart.h
 F: include/hw/misc/mchp_pfsoc_dmc.h
+F: include/hw/misc/mchp_pfsoc_ioscb.h
 
 RX Machines
 -----------
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 32ab718cd3..4ff01ec4be 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -142,6 +142,9 @@ config AVR_POWER
 config MCHP_PFSOC_DMC
     bool
 
+config MCHP_PFSOC_IOSCB
+    bool
+
 config SIFIVE_TEST
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2d7a517265..770149e47a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -24,6 +24,7 @@ softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 
 # RISC-V devices
 softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
+softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
-- 
2.28.0


