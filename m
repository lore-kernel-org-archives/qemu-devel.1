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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09194C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2974F2225E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TebldxL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2974F2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQJi-0000tm-4p
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPnx-0002RC-4V; Tue, 27 Oct 2020 10:18:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXPns-0007fz-OY; Tue, 27 Oct 2020 10:18:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id o3so859027pgr.11;
 Tue, 27 Oct 2020 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ktc+Y+hdXNHlnXcxFcEguOC2w+S2+2dPWy/HZ/V0+zQ=;
 b=TebldxL+EtwPsulkujghWwLLaTdgmOBNvMnOtcd77U5/AUcG8X9sjeIvCeLvHeB/0B
 PijuvuFhnEKx3DSOKFMWUtb8vPyTsoA6djQOsInnNXPVGefkf0N6+Wv0BdjXaEbhkOtU
 aHCuR7StUG3nWZryTUFrXuiLihOqlRNrPByN9lN27YjLS+bipD836gucyV7kCVtdCjEq
 3+IQdIzC6RwMtlREZ+TfKQTu8itFRXZDJjrXt8kvbF/qe9wVFCEha/Vqw4QadiQlKe1n
 PC9AM6VpYtFMp69IEDTlHKoIZ0jcSagkf96xeHLcIPqcbmkzICeUEeveqOjV4YMKgdcF
 WOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ktc+Y+hdXNHlnXcxFcEguOC2w+S2+2dPWy/HZ/V0+zQ=;
 b=BA1JJV9GtIICc0fZZfjXaP8Flom2IaPKypFGQtFThaUJtmhKiV18Ys2di1FKJTVMKa
 Yh9oRMUEFNrJ5APNgctaK7cvj5RaGXDygLx7X+ySmG8B6DcUeeGi+UNmTZCm/IH8X1xZ
 9V+6+XQdPyDXJcF81bM1AGwc1h0fxNE2lZhlDOaXLiSQ0nbkQaA3D9Kn0YUtjjB1pohP
 eQOij09UshIMiRRYWlAWrlZ+Pf8RhcDNqDFRDLo3xfMv9iA8m5LxuvRhKdqqkmxmdv8w
 dpRH1txN/5ry/3TYIA7VkbLTwT0ooL2TA8SVVZu+zHKiyFdv39DjhPXdaG5R+J2fy6I8
 dGxw==
X-Gm-Message-State: AOAM530HjwasYrMghMZNWjT9i+FEbTg3ml7AlsN9d+xs21qikoD1wj4A
 FXzkUbxyH1Qpd/f+NXbd6uofEB5/XdI=
X-Google-Smtp-Source: ABdhPJzgCD6xE5zHQfUEntKDzXlEjObFmPzvsaH+li3AxTt1bCrqYiGty5qbH8IgMZLYSfYkXBvH6Q==
X-Received: by 2002:a63:e544:: with SMTP id z4mr2079558pgj.430.1603808302991; 
 Tue, 27 Oct 2020 07:18:22 -0700 (PDT)
Received: from i9-aorus-gtx1080.localdomain (144.168.56.201.16clouds.com.
 [144.168.56.201])
 by smtp.gmail.com with ESMTPSA id mn15sm1600297pjb.21.2020.10.27.07.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 07:18:22 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [RESEND PATCH 3/9] hw/misc: Add Microchip PolarFire SoC IOSCB module
 support
Date: Tue, 27 Oct 2020 22:17:34 +0800
Message-Id: <20201027141740.18336-4-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027141740.18336-1-bmeng.cn@gmail.com>
References: <20201027141740.18336-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x541.google.com
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

This creates a model for PolarFire SoC IOSCB [1] module. It actually
contains lots of sub-modules like various PLLs to control different
peripherals. Only the mininum capabilities are emulated to make the
HSS DDR memory initialization codes happy. Lots of sub-modules are
created as an unimplemented devices.

[1] PF_SoC_RegMap_V1_1/MPFS250T/mpfs250t_ioscb_memmap_dri.htm in
    https://www.microsemi.com/document-portal/doc_download/1244581-polarfire-soc-register-map

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 MAINTAINERS                        |   2 +
 hw/misc/Kconfig                    |   3 +
 hw/misc/mchp_pfsoc_ioscb.c         | 242 +++++++++++++++++++++++++++++
 hw/misc/meson.build                |   1 +
 include/hw/misc/mchp_pfsoc_ioscb.h |  50 ++++++
 5 files changed, 298 insertions(+)
 create mode 100644 hw/misc/mchp_pfsoc_ioscb.c
 create mode 100644 include/hw/misc/mchp_pfsoc_ioscb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index caacec401c..ebbc62a62f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1327,9 +1327,11 @@ S: Supported
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
index 198bb1c6ba..3db15e06b4 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -137,6 +137,9 @@ config AVR_POWER
 config MCHP_PFSOC_DMC
     bool
 
+config MCHP_PFSOC_IOSCB
+    bool
+
 config SIFIVE_TEST
     bool
 
diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
new file mode 100644
index 0000000000..32b88f53c1
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
+    dc->desc = "Microchip PolarFire SoC IOSCB";
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
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2d79a657e0..6d3c1a3455 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -23,6 +23,7 @@ softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 
 # RISC-V devices
 softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
+softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
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
-- 
2.25.1


