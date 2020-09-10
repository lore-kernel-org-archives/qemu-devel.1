Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1C3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC503207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jk+JCmZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC503207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRIr-0007Ue-Ih
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBQ-0003tu-0Y
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:32 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBM-0002iJ-Nt
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762028; x=1631298028;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jl1QY3CZyppQuWzflLHAKCho7h0VBeksQL78FFZEPhc=;
 b=jk+JCmZMCpIAb8KSkiFmor1syeIxQopHH3+RN828uIzcL9hWtxf5PGJt
 0e5jpoZdX052raW/M3uGVNdY1nun+FDYG2wYpQrJ4sS7vlda9v2bTepWX
 fFS2aTrXN7qOaBaN83ZE9imRKZKgbXZuY17weuhHXYjBDHmSYKNRPIOTX
 ywDFZAJDnkJ1aBfQKb+83FKZ7UdbIahVoSwGLemYxVoUD6D+xCINjCft5
 D4BX+J1VkhmIFDD/jCNLTejiby3v4HuLPFPfoNBgijX1CLEs8tGKs00IN
 wYwmDeGik2tSezmLGGlg2m7FtOHQVbHZP7WUthuD3Ovsgq8MsghNKVanE g==;
IronPort-SDR: wwNtq3LRTxhGO/eAvtw7MRv0to+4KIhoQ+dEoNGvbeC+oTy28aXRaQc9ISVSeJ9ibkM9qBieZp
 oRtRN33aR6sQGnNXzJjkmqeaebvZYjbxGlikxWk5FDbJaBeieRU1yCVg74z0FSj7StzF2jIeS6
 jyqR6siqPPcvaCc5aaaUMWOlgp3SgX0d3seERWWMWX0jLNn/uLpR3siRs1EKkFFtncQKn/OHpE
 zBjqK612/z2RmUZHsYexeZMKcp2xXJV5GxboPk3cT4Ouiqv3gIQvDsAte6jOA9eoRRVdpCHvuG
 TFg=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979222"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:16 +0800
IronPort-SDR: HUC0UHjwb8FBYb6LJfbA/XHU27WcwTPlbAuzuy0IrAgisU8+uMbffg/Z+DnA6/+lVbeWnKj/lN
 H270KsYQ9brw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:33 -0700
IronPort-SDR: 1sVVeGVzZmhzIo1kVIEOtxWEYjBTPS5becA99sQVXX5y9AzrqfWg6eyuZdiD5L2KoaI/+dRMsg
 dtENCRcBdctQ==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 09/30] hw/sd: Add Cadence SDHCI emulation
Date: Thu, 10 Sep 2020 11:09:17 -0700
Message-Id: <20200910180938.584205-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
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
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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
Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1598924352-89526-8-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/sd/cadence_sdhci.h |  47 +++++++++
 hw/sd/cadence_sdhci.c         | 193 ++++++++++++++++++++++++++++++++++
 hw/sd/Kconfig                 |   4 +
 hw/sd/meson.build             |   1 +
 4 files changed, 245 insertions(+)
 create mode 100644 include/hw/sd/cadence_sdhci.h
 create mode 100644 hw/sd/cadence_sdhci.c

diff --git a/include/hw/sd/cadence_sdhci.h b/include/hw/sd/cadence_sdhci.h
new file mode 100644
index 0000000000..cd8288b7d8
--- /dev/null
+++ b/include/hw/sd/cadence_sdhci.h
@@ -0,0 +1,47 @@
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
+    MemoryRegion container;
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
diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
new file mode 100644
index 0000000000..0b371c843d
--- /dev/null
+++ b/hw/sd/cadence_sdhci.c
@@ -0,0 +1,193 @@
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
+    object_initialize_child(OBJECT(s), "generic-sdhci",
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
+    CadenceSDHCIState *s = opaque;
+    uint32_t val;
+
+    val = s->regs[TO_REG(addr)];
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
+        s->regs[TO_REG(addr)] = val32;
+        break;
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
+    memory_region_init(&s->container, OBJECT(s),
+                       "cadence.sdhci-container", 0x1000);
+    sysbus_init_mmio(sbd, &s->container);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &cadence_sdhci_ops,
+                          s, TYPE_CADENCE_SDHCI, CADENCE_SDHCI_REG_SIZE);
+    memory_region_add_subregion(&s->container, 0, &s->iomem);
+
+    sysbus_realize(sbd_sdhci, errp);
+    memory_region_add_subregion(&s->container, CADENCE_SDHCI_SRS_BASE,
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
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index c5e1e5581c..633b9afec9 100644
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
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index b43e59bd00..9c29691e13 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -10,3 +10,4 @@ softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_mmci.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_sdhost.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
+softmmu_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdhci.c'))
-- 
2.28.0


