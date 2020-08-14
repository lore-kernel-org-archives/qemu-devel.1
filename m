Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C92C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A482820716
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjAqpr6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A482820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cps-0006Lk-PW
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cm3-0007zj-AO; Fri, 14 Aug 2020 12:41:47 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cm1-0002iJ-71; Fri, 14 Aug 2020 12:41:46 -0400
Received: by mail-pj1-x1042.google.com with SMTP id kr4so4665656pjb.2;
 Fri, 14 Aug 2020 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9ASlt84VPNpgMOgTGGDjknhiaN8WnaW8vF8XcV6uIN0=;
 b=mjAqpr6GUGFAtHvQKyMNQh+Y1xxmukmxKuF/thKgdsL4Uc8Gn6SsNCrmfob3AuClny
 ASgj90YQMx7N7iNoyTrAb8eCCDNzduz6VkzpqZWNQVsv9Ze0sdWGwZVlJe8xjL/GavgS
 KG7Qh+49qws+IB7h91fT0Y+nh3VOR52ZAItSdA0QzphbgrcghetjngfD2FzXZDSyx0Q3
 UzgxG/Yd4LXxk4mwZPb9MPhtcFvhgc2CcI9CmuBvr5fqIdzggKEzMLxVektv808gtb2w
 b62lSwjHnJG/8gpIlOwdGA0K9aZ1o+hn7M/nlmACy3YulesPvZZjV8W/tdmkrPBIaiA7
 ryLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9ASlt84VPNpgMOgTGGDjknhiaN8WnaW8vF8XcV6uIN0=;
 b=IkYAlpnIZVG2ZdBDC3LHytDVbMkvDE8IypPyO1jN/F4S9zPKb9G4G9J7Z3EIinElgQ
 ZoDjY7lqSfFjyDpC/ig5SmvU5hbUVtlCGd1faCAepehTOn3w+DS3XWtRzjL/AfVLE93U
 ricy76C8t2gK32YGbjMaj9LQJ9c1ASSMVOfj0FaxusHTES8IItxlwubmr/m3doCiE4dp
 q6j1OMLxdLHR6FkcKxm1P8/pv6fgFOE6D2l6Dn04ZjTXBg7whxheVZ24deg7jYyxSc1D
 A8W14HO4l4Q69kSWy0AHIMht2arnz9/BPehZaOzYT2ibx6fFRz4rDGH+HH/7PQ4TNi1T
 0Z6A==
X-Gm-Message-State: AOAM531KoF3OZS1/JAzfltFR0GWWzor39szX0+YQniUSHxPfYC3QRD/G
 D7ppjK1jkEIDtnoDLGw1ad8=
X-Google-Smtp-Source: ABdhPJy7zG1SPvhcc0cMql5ijKKSaD37auSGzKz14JKlycTTtS7CoRbdvO0sVuk0c7PMQTICBVjasA==
X-Received: by 2002:a17:90b:241:: with SMTP id
 fz1mr979491pjb.213.1597423303296; 
 Fri, 14 Aug 2020 09:41:43 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.41.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:42 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 10/18] hw/sd: Add Cadence SDHCI emulation
Date: Sat, 15 Aug 2020 00:40:48 +0800
Message-Id: <1597423256-14847-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1042.google.com
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Cadence SD/SDIO/eMMC Host Controller (SD4HC) is an SDHCI compatible
controller. The SDHCI compatible registers start from offset 0x200,
which are called Slot Register Set (SRS) in its datasheet.

This creates a Cadence SDHCI model built on top of the existing
generic SDHCI model. Cadence specific Host Register Set (HRS) is
implemented to make guest software happy.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/sd/Kconfig                 |   4 ++
 hw/sd/Makefile.objs           |   1 +
 hw/sd/cadence_sdhci.c         | 162 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/sd/cadence_sdhci.h |  65 +++++++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 hw/sd/cadence_sdhci.c
 create mode 100644 include/hw/sd/cadence_sdhci.h

diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index c5e1e55..633b9af 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -19,3 +19,7 @@ config SDHCI_PCI
     default y if PCI_DEVICES
     depends on PCI
     select SDHCI
+
+config CADENCE_SDHCI
+    bool
+    select SDHCI
diff --git a/hw/sd/Makefile.objs b/hw/sd/Makefile.objs
index 0d1df17..4d500a6 100644
--- a/hw/sd/Makefile.objs
+++ b/hw/sd/Makefile.objs
@@ -10,3 +10,4 @@ common-obj-$(CONFIG_OMAP) += omap_mmc.o
 common-obj-$(CONFIG_PXA2XX) += pxa2xx_mmci.o
 common-obj-$(CONFIG_RASPI) += bcm2835_sdhost.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_sdhci.o
+common-obj-$(CONFIG_CADENCE_SDHCI) += cadence_sdhci.o
diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
new file mode 100644
index 0000000..67ffd14
--- /dev/null
+++ b/hw/sd/cadence_sdhci.c
@@ -0,0 +1,162 @@
+/*
+ * Cadence SDHCI emulation
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
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/sd/cadence_sdhci.h"
+#include "sdhci-internal.h"
+
+#define TO_REG(addr)    ((addr) / sizeof(uint32_t))
+
+static void cadence_sdhci_reset(DeviceState *dev)
+{
+    CadenceSDHCIState *sdhci = CADENCE_SDHCI(dev);
+
+    memset(sdhci->regs, 0, CADENCE_SDHCI_REG_SIZE);
+    sdhci->regs[TO_REG(SDHCI_CDNS_HRS00)] = SDHCI_CDNS_HRS00_POR_VAL;
+}
+
+static uint64_t cadence_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    uint32_t val = 0;
+    CadenceSDHCIState *sdhci = opaque;
+
+    if (addr < CADENCE_SDHCI_REG_SIZE) {
+        val = sdhci->regs[TO_REG(addr)];
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+    }
+
+    return (uint64_t)val;
+}
+
+static void cadence_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned int size)
+{
+    CadenceSDHCIState *sdhci = opaque;
+    uint32_t val32 = (uint32_t)val;
+
+    switch (addr) {
+    case SDHCI_CDNS_HRS00:
+        /*
+         * The only writable bit is SWR (software reset) and it automatically
+         * clears to zero, so essentially this register remains unchanged.
+         */
+        if (val32 & SDHCI_CDNS_HRS00_SWR) {
+            cadence_sdhci_reset(DEVICE(sdhci));
+            sdhci_poweron_reset(DEVICE(&sdhci->slot));
+        }
+
+        break;
+    case SDHCI_CDNS_HRS04:
+        /*
+         * Only emulate the ACK bit behavior when read or write transaction
+         * are requested.
+         */
+        if (val32 & (SDHCI_CDNS_HRS04_WR | SDHCI_CDNS_HRS04_RD)) {
+            val32 |= SDHCI_CDNS_HRS04_ACK;
+        } else {
+            val32 &= ~SDHCI_CDNS_HRS04_ACK;
+        }
+
+        sdhci->regs[TO_REG(addr)] = val32;
+        break;
+    case SDHCI_CDNS_HRS06:
+        if (val32 & SDHCI_CDNS_HRS06_TUNE_UP) {
+            val32 &= ~SDHCI_CDNS_HRS06_TUNE_UP;
+        }
+
+        sdhci->regs[TO_REG(addr)] = val32;
+        break;
+    default:
+        if (addr < CADENCE_SDHCI_REG_SIZE) {
+            sdhci->regs[TO_REG(addr)] = val32;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Out-of-bounds write at 0x%" HWADDR_PRIx "\n",
+                          __func__, addr);
+        }
+    }
+}
+
+static const MemoryRegionOps cadence_sdhci_ops = {
+    .read = cadence_sdhci_read,
+    .write = cadence_sdhci_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static void cadence_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    CadenceSDHCIState *sdhci = CADENCE_SDHCI(dev);
+    SysBusDevice *sbd_slot = SYS_BUS_DEVICE(&sdhci->slot);
+
+    memory_region_init_io(&sdhci->iomem, OBJECT(sdhci), &cadence_sdhci_ops,
+                          sdhci, TYPE_CADENCE_SDHCI, 0x1000);
+    sysbus_init_mmio(sbd, &sdhci->iomem);
+
+    sysbus_realize(sbd_slot, errp);
+    memory_region_add_subregion(&sdhci->iomem, SDHCI_CDNS_SRS_BASE,
+                                &sdhci->slot.iomem);
+}
+
+static const VMStateDescription vmstate_cadence_sdhci = {
+    .name = TYPE_CADENCE_SDHCI,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, CadenceSDHCIState, CADENCE_SDHCI_NUM_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void cadence_sdhci_class_init(ObjectClass *classp, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(classp);
+
+    dc->realize = cadence_sdhci_realize;
+    dc->reset = cadence_sdhci_reset;
+    dc->vmsd = &vmstate_cadence_sdhci;
+}
+
+static TypeInfo cadence_sdhci_info = {
+    .name          = TYPE_CADENCE_SDHCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CadenceSDHCIState),
+    .class_init    = cadence_sdhci_class_init,
+};
+
+static void cadence_sdhci_register_types(void)
+{
+    type_register_static(&cadence_sdhci_info);
+}
+
+type_init(cadence_sdhci_register_types)
diff --git a/include/hw/sd/cadence_sdhci.h b/include/hw/sd/cadence_sdhci.h
new file mode 100644
index 0000000..9ff78a9
--- /dev/null
+++ b/include/hw/sd/cadence_sdhci.h
@@ -0,0 +1,65 @@
+/*
+ * Cadence SDHCI emulation
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
+#ifndef CADENCE_SDHCI_H
+#define CADENCE_SDHCI_H
+
+#include "qemu/bitops.h"
+#include "hw/sd/sdhci.h"
+
+/* HRS - Host Register Set (specific to Cadence) */
+
+#define SDHCI_CDNS_HRS00                0x00    /* general information */
+#define SDHCI_CDNS_HRS00_SWR                BIT(0)
+#define SDHCI_CDNS_HRS00_POR_VAL            0x00010000
+
+#define SDHCI_CDNS_HRS04                0x10    /* PHY access port */
+#define SDHCI_CDNS_HRS04_WR                 BIT(24)
+#define SDHCI_CDNS_HRS04_RD                 BIT(25)
+#define SDHCI_CDNS_HRS04_ACK                BIT(26)
+
+#define SDHCI_CDNS_HRS06                0x18    /* eMMC control */
+#define SDHCI_CDNS_HRS06_TUNE_UP            BIT(15)
+
+/* SRS - Slot Register Set (SDHCI-compatible) */
+#define SDHCI_CDNS_SRS_BASE             0x200
+
+#define CADENCE_SDHCI_CAPABILITIES 0x01E80080
+#define CADENCE_SDHCI_REG_SIZE     0x100
+#define CADENCE_SDHCI_NUM_REGS     (CADENCE_SDHCI_REG_SIZE / sizeof(uint32_t))
+
+typedef struct CadenceSDHCIState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    uint32_t regs[CADENCE_SDHCI_NUM_REGS];
+
+    SDHCIState slot;
+} CadenceSDHCIState;
+
+#define TYPE_CADENCE_SDHCI  "cadence.sdhci"
+#define CADENCE_SDHCI(obj)  OBJECT_CHECK(CadenceSDHCIState, (obj), \
+                                         TYPE_CADENCE_SDHCI)
+
+#endif /* CADENCE_SDHCI_H */
-- 
2.7.4


