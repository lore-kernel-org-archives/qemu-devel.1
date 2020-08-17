Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6150C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA342067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 10:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQOQqdYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA342067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7c3h-0008A9-Rp
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 06:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7c1J-0004Yb-UQ; Mon, 17 Aug 2020 06:05:37 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:46091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k7c1H-0005w1-Be; Mon, 17 Aug 2020 06:05:37 -0400
Received: by mail-pl1-x630.google.com with SMTP id k13so7236447plk.13;
 Mon, 17 Aug 2020 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=TZSFaUvQ2xQv8zqSVhEg+ZWd2KUAInCeUJORoC/+/eg=;
 b=LQOQqdYX9sR5FYEWnIte8ZJbZvaiunIhQrz1eQlukupORDJdLV952sEj45dcHPDO3T
 OarK/xBKIdavEI8/qDgmH9Pm05BmF584HTRCvLzloqNdj04oXUZQ8lIr1jiU9mvvY8IP
 t0hvWZdPlxkeYg/KeK31wnnC2MH7KsScYag6BjWBzbT4OXCOYeEcF2T84RAZjBBxA6F9
 eSJM7sBh2rYKzTWtJHmCWwJZdrdYTYXn1ZwS2Bm6+HKi3mYt0Fsa1RwSpynw7taqHCpG
 dAeyQvsuHPhUUo+cyZPzrbdtIqske1zV8dXu3UqHFfw/367aQ/aJZdqRAeH4whkQ4PoY
 vhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=TZSFaUvQ2xQv8zqSVhEg+ZWd2KUAInCeUJORoC/+/eg=;
 b=I2kSw7SzZ+OOFK5a31FUqo6/0E96Hb0PhDwdCOSnZMUtsyjg0FzxmbN9L2k/iPjuK7
 Ib0CGl64E8VQvd/5dfRSnpssft3Q9RDrnO2yio46EZKtQwQE3MJJbo7fNwxijxphH2HV
 NpoIleWv79dOArZ/AdpdDCo/5LWdHcvlMt67mVcqdfs6LR+klk2plyBxfExQ1CgpAltC
 ILe3f15fpKf8tK/Va6mEkFwWjrhssAe5YkUo1e1Ns/TRkCcsHKDpA7DRyM00HGDIev3z
 hyYmWScqWDtz+5WGNuTv95/BkZgCN2nQv5KVtXhlAFSd5mWwxcJzMN1KAgW/lTenquSW
 2gvA==
X-Gm-Message-State: AOAM531+v8UjhgNW2iwbmJ5LI+rxObynaestXPUYKF74rc2AXYtSVV8e
 hVv2ArhcE1HhGeeXha1CXaY=
X-Google-Smtp-Source: ABdhPJzSJ6RZWthvbOK5QnW/qcU/O3CZTsz2qQ3XRQEO1/FTXytYT77Wfafon2vk55ws+gnxu4GNJQ==
X-Received: by 2002:a17:902:654c:: with SMTP id
 d12mr11137667pln.147.1597658733544; 
 Mon, 17 Aug 2020 03:05:33 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id e20sm17036743pjr.28.2020.08.17.03.05.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Aug 2020 03:05:33 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
X-Google-Original-From: Bin Meng <bin.meng@windriver.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH v2 3/3] hw/sd: Add Cadence SDHCI emulation
Date: Mon, 17 Aug 2020 18:05:22 +0800
Message-Id: <1597658722-12922-4-git-send-email-bin.meng@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597658722-12922-1-git-send-email-bin.meng@windriver.com>
References: <1597658722-12922-1-git-send-email-bin.meng@windriver.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x630.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cadence SD/SDIO/eMMC Host Controller (SD4HC) is an SDHCI compatible
controller. The SDHCI compatible registers start from offset 0x200,
which are called Slot Register Set (SRS) in its datasheet.

This creates a Cadence SDHCI model built on top of the existing
generic SDHCI model. Cadence specific Host Register Set (HRS) is
implemented to make guest software happy.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- use 's' for the model state
- call device_cold_reset() in cadence_sdhci_reset()
- add .impl in cadence_sdhci_ops
- move Cadence specific register defines to cadence_sdhci.c
- use 'sdhci' instead of 'slot' to represent SDHCIState
- use sysbus_mmio_get_region() to access SDHCI model's memory region
- initialize TYPE_SYSBUS_SDHCI in the instance_init() so that users
  of Cadence SDHCI do not have to do that themselves
- propergate irq and 'sd-bus' from generic-sdhci

 hw/sd/Kconfig                 |   4 +
 hw/sd/Makefile.objs           |   1 +
 hw/sd/cadence_sdhci.c         | 200 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/sd/cadence_sdhci.h |  46 ++++++++++
 4 files changed, 251 insertions(+)
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
index 0000000..4f01d63
--- /dev/null
+++ b/hw/sd/cadence_sdhci.c
@@ -0,0 +1,200 @@
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
+#include "qemu/bitops.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "hw/sd/cadence_sdhci.h"
+#include "sdhci-internal.h"
+
+/* HRS - Host Register Set (specific to Cadence) */
+
+#define CADENCE_SDHCI_HRS00             0x00    /* general information */
+#define CADENCE_SDHCI_HRS00_SWR             BIT(0)
+#define CADENCE_SDHCI_HRS00_POR_VAL         0x00010000
+
+#define CADENCE_SDHCI_HRS04             0x10    /* PHY access port */
+#define CADENCE_SDHCI_HRS04_WR              BIT(24)
+#define CADENCE_SDHCI_HRS04_RD              BIT(25)
+#define CADENCE_SDHCI_HRS04_ACK             BIT(26)
+
+#define CADENCE_SDHCI_HRS06             0x18    /* eMMC control */
+#define CADENCE_SDHCI_HRS06_TUNE_UP         BIT(15)
+
+/* SRS - Slot Register Set (SDHCI-compatible) */
+
+#define CADENCE_SDHCI_SRS_BASE          0x200
+
+#define TO_REG(addr)    ((addr) / sizeof(uint32_t))
+
+static void cadence_sdhci_instance_init(Object *obj)
+{
+    CadenceSDHCIState *s = CADENCE_SDHCI(obj);
+
+    object_initialize_child(OBJECT(s), "cadence-sdhci.sdhci",
+                            &s->sdhci, TYPE_SYSBUS_SDHCI);
+}
+
+static void cadence_sdhci_reset(DeviceState *dev)
+{
+    CadenceSDHCIState *s = CADENCE_SDHCI(dev);
+
+    memset(s->regs, 0, CADENCE_SDHCI_REG_SIZE);
+    s->regs[TO_REG(CADENCE_SDHCI_HRS00)] = CADENCE_SDHCI_HRS00_POR_VAL;
+
+    device_cold_reset(DEVICE(&s->sdhci));
+}
+
+static uint64_t cadence_sdhci_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    uint32_t val = 0;
+    CadenceSDHCIState *s = opaque;
+
+    if (addr < CADENCE_SDHCI_REG_SIZE) {
+        val = s->regs[TO_REG(addr)];
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
+    CadenceSDHCIState *s = opaque;
+    uint32_t val32 = (uint32_t)val;
+
+    switch (addr) {
+    case CADENCE_SDHCI_HRS00:
+        /*
+         * The only writable bit is SWR (software reset) and it automatically
+         * clears to zero, so essentially this register remains unchanged.
+         */
+        if (val32 & CADENCE_SDHCI_HRS00_SWR) {
+            cadence_sdhci_reset(DEVICE(s));
+        }
+
+        break;
+    case CADENCE_SDHCI_HRS04:
+        /*
+         * Only emulate the ACK bit behavior when read or write transaction
+         * are requested.
+         */
+        if (val32 & (CADENCE_SDHCI_HRS04_WR | CADENCE_SDHCI_HRS04_RD)) {
+            val32 |= CADENCE_SDHCI_HRS04_ACK;
+        } else {
+            val32 &= ~CADENCE_SDHCI_HRS04_ACK;
+        }
+
+        s->regs[TO_REG(addr)] = val32;
+        break;
+    case CADENCE_SDHCI_HRS06:
+        if (val32 & CADENCE_SDHCI_HRS06_TUNE_UP) {
+            val32 &= ~CADENCE_SDHCI_HRS06_TUNE_UP;
+        }
+
+        s->regs[TO_REG(addr)] = val32;
+        break;
+    default:
+        if (addr < CADENCE_SDHCI_REG_SIZE) {
+            s->regs[TO_REG(addr)] = val32;
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
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static void cadence_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    CadenceSDHCIState *s = CADENCE_SDHCI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SysBusDevice *sbd_sdhci = SYS_BUS_DEVICE(&s->sdhci);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &cadence_sdhci_ops,
+                          s, TYPE_CADENCE_SDHCI, 0x1000);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    sysbus_realize(sbd_sdhci, errp);
+    memory_region_add_subregion(&s->iomem, CADENCE_SDHCI_SRS_BASE,
+                                sysbus_mmio_get_region(sbd_sdhci, 0));
+
+    /* propagate irq and "sd-bus" from generic-sdhci */
+    sysbus_pass_irq(sbd, sbd_sdhci);
+    s->bus = qdev_get_child_bus(DEVICE(sbd_sdhci), "sd-bus");
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
+    dc->desc = "Cadence SD/SDIO/eMMC Host Controller (SD4HC)";
+    dc->realize = cadence_sdhci_realize;
+    dc->reset = cadence_sdhci_reset;
+    dc->vmsd = &vmstate_cadence_sdhci;
+}
+
+static TypeInfo cadence_sdhci_info = {
+    .name          = TYPE_CADENCE_SDHCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(CadenceSDHCIState),
+    .instance_init = cadence_sdhci_instance_init,
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
index 0000000..9b52115
--- /dev/null
+++ b/include/hw/sd/cadence_sdhci.h
@@ -0,0 +1,46 @@
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
+#include "hw/sd/sdhci.h"
+
+#define CADENCE_SDHCI_REG_SIZE  0x100
+#define CADENCE_SDHCI_NUM_REGS  (CADENCE_SDHCI_REG_SIZE / sizeof(uint32_t))
+
+typedef struct CadenceSDHCIState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+    BusState *bus;
+
+    uint32_t regs[CADENCE_SDHCI_NUM_REGS];
+
+    SDHCIState sdhci;
+} CadenceSDHCIState;
+
+#define TYPE_CADENCE_SDHCI  "cadence.sdhci"
+#define CADENCE_SDHCI(obj)  OBJECT_CHECK(CadenceSDHCIState, (obj), \
+                                         TYPE_CADENCE_SDHCI)
+
+#endif /* CADENCE_SDHCI_H */
-- 
2.7.4


