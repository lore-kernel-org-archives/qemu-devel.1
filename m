Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7051CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177C224676
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbOOAYwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177C224676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igzvn-0008SN-Co
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 18:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuG-0006b3-17
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuE-0002hD-3h
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:03 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1igzuD-0002fA-TJ; Mon, 16 Dec 2019 18:36:02 -0500
Received: by mail-wm1-x331.google.com with SMTP id t14so1089609wmi.5;
 Mon, 16 Dec 2019 15:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TcOYVTpCVkXGz0jIEMCLCDxOkSGJsOIC7WroRTfuzB0=;
 b=SbOOAYwzbLGfQRwiKSM3GUvFUfzoHG9T1HXIgcRWtGmDN3bw7WowLRRI7vfqBGF4da
 nIEtcrPA/UPtDRyoHgzJymV4/zub4ZkpnOzazSkkEfupzUX6phyYfPQw7oKRDG/lRDrG
 /XYrFlSPOrxSPmS24Qc0fwUkCNLGXFft+p0vP5PNo6NILGQ3wlWgLvTrKZqOr7vPxyL1
 iRoVc0Vh2Zbm6XYlpCbImuIXJG7pXuIkXddsaMl9iE6xHOR+6WCYfCByPblVRza/7ta+
 oq9BFAcztKU5VVsEvYBtaUN8GT7erItBjcLSxdygjyQHj3kKawkRp73aGBBABapbdDAL
 tTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TcOYVTpCVkXGz0jIEMCLCDxOkSGJsOIC7WroRTfuzB0=;
 b=rROoPG28e1+d/ICmRZxtotDVq7hYe353iHPLt34ieX0mlU3c6m2ecpHV8E0aPri4xd
 ErIGoGJWSQj37yf8SByu7aacBwCxlfNi2nS0FS+gRa8F/DpbqzGz2EW/6bZV/pJdMEDY
 ciJX55dIZ0CV5Dht8ybn7j0qKfuGg61Q7LoLUpjXK3dnaKG0LsQ3GGMTxXg+3vhEiovM
 dYIF+pi7HWQ2CQD4ZbEArl4DcGYY60IjjPcS0Fu8u1lTBJgDrt1bRW2d1f0UynMGS0Gz
 qb7HrMN/r5RMoEMbDA+IDbXDCuhwczhdv5WcUqtX+FhWSo010oZ7HEGW2X1m168ev3wo
 Nd4Q==
X-Gm-Message-State: APjAAAUVL16XhbGhmeMLuRhwTw2OemcD9yu3QnCmCVBvkgyNa8kyoPoN
 sXfNwSPLU2k6I7ouOd2P/BcRfu7n
X-Google-Smtp-Source: APXvYqyMRcYzQicdA6wA2DkNohCL7m2haz/AEuE3n1SVQcO4KKChmXTpchLtLBPAjl7/x/h2Z/ygnA==
X-Received: by 2002:a05:600c:211:: with SMTP id
 17mr1724746wmi.60.1576539360467; 
 Mon, 16 Dec 2019 15:36:00 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id z83sm984501wmg.2.2019.12.16.15.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 15:35:59 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/10] arm: allwinner-h3: add System Control module
Date: Tue, 17 Dec 2019 00:35:14 +0100
Message-Id: <20191216233519.29030-6-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216233519.29030-1-nieklinnenbank@gmail.com>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Allwinner H3 System on Chip has an System Control
module that provides system wide generic controls and
device information. This commit adds support for the
Allwinner H3 System Control module.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 include/hw/arm/allwinner-h3.h         |   2 +
 include/hw/misc/allwinner-h3-syscon.h |  42 ++++++++
 hw/arm/allwinner-h3.c                 |   7 ++
 hw/misc/allwinner-h3-syscon.c         | 146 ++++++++++++++++++++++++++
 hw/misc/Makefile.objs                 |   1 +
 5 files changed, 198 insertions(+)
 create mode 100644 include/hw/misc/allwinner-h3-syscon.h
 create mode 100644 hw/misc/allwinner-h3-syscon.c

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 47d6f82cc4..bead6d4f85 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -27,6 +27,7 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/misc/allwinner-h3-clk.h"
+#include "hw/misc/allwinner-h3-syscon.h"
 #include "target/arm/cpu.h"
 
 enum {
@@ -73,6 +74,7 @@ typedef struct AwH3State {
     const hwaddr *memmap;
     AwA10PITState timer;
     AwH3ClockState ccu;
+    AwH3SysconState syscon;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-h3-syscon.h b/include/hw/misc/allwinner-h3-syscon.h
new file mode 100644
index 0000000000..830e1a5061
--- /dev/null
+++ b/include/hw/misc/allwinner-h3-syscon.h
@@ -0,0 +1,42 @@
+/*
+ * Allwinner H3 System Control emulation
+ *
+ * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_MISC_ALLWINNER_H3_SYSCON_H
+#define HW_MISC_ALLWINNER_H3_SYSCON_H
+
+#include "hw/sysbus.h"
+
+#define AW_H3_SYSCON_REGS_MAX_ADDR  (0x30)
+#define AW_H3_SYSCON_REGS_NUM       ((AW_H3_SYSCON_REGS_MAX_ADDR / \
+                                      sizeof(uint32_t)) + 1)
+
+#define TYPE_AW_H3_SYSCON    "allwinner-h3-syscon"
+#define AW_H3_SYSCON(obj)    OBJECT_CHECK(AwH3SysconState, (obj), \
+                                          TYPE_AW_H3_SYSCON)
+
+typedef struct AwH3SysconState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion iomem;
+    uint32_t regs[AW_H3_SYSCON_REGS_NUM];
+} AwH3SysconState;
+
+#endif
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index f0ea088852..8482d616e7 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -190,6 +190,9 @@ static void aw_h3_init(Object *obj)
 
     sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
                           TYPE_AW_H3_CLK);
+
+    sysbus_init_child_obj(obj, "syscon", &s->syscon, sizeof(s->syscon),
+                          TYPE_AW_H3_SYSCON);
 }
 
 static void aw_h3_realize(DeviceState *dev, Error **errp)
@@ -318,6 +321,10 @@ static void aw_h3_realize(DeviceState *dev, Error **errp)
     qdev_init_nofail(DEVICE(&s->ccu));
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
 
+    /* System Control */
+    qdev_init_nofail(DEVICE(&s->syscon));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->syscon), 0, s->memmap[AW_H3_SYSCON]);
+
     /* Universal Serial Bus */
     sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
diff --git a/hw/misc/allwinner-h3-syscon.c b/hw/misc/allwinner-h3-syscon.c
new file mode 100644
index 0000000000..9c5d42dd49
--- /dev/null
+++ b/hw/misc/allwinner-h3-syscon.c
@@ -0,0 +1,146 @@
+/*
+ * Allwinner H3 System Control emulation
+ *
+ * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/misc/allwinner-h3-syscon.h"
+
+/* SYSCON register offsets */
+enum {
+    REG_VER               = 0x24,  /* Version */
+    REG_EMAC_PHY_CLK      = 0x30,  /* EMAC PHY Clock */
+};
+
+#define REG_INDEX(offset)   (offset / sizeof(uint32_t))
+
+/* SYSCON register reset values */
+enum {
+    REG_VER_RST           = 0x0,
+    REG_EMAC_PHY_CLK_RST  = 0x58000,
+};
+
+static uint64_t allwinner_h3_syscon_read(void *opaque, hwaddr offset,
+                                         unsigned size)
+{
+    const AwH3SysconState *s = (AwH3SysconState *)opaque;
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_SYSCON_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    return s->regs[idx];
+}
+
+static void allwinner_h3_syscon_write(void *opaque, hwaddr offset,
+                                      uint64_t val, unsigned size)
+{
+    AwH3SysconState *s = (AwH3SysconState *)opaque;
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_H3_SYSCON_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+
+    switch (offset) {
+    case REG_VER:       /* Version */
+        break;
+    default:
+        s->regs[idx] = (uint32_t) val;
+        break;
+    }
+}
+
+static const MemoryRegionOps allwinner_h3_syscon_ops = {
+    .read = allwinner_h3_syscon_read,
+    .write = allwinner_h3_syscon_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_h3_syscon_reset(DeviceState *dev)
+{
+    AwH3SysconState *s = AW_H3_SYSCON(dev);
+
+    /* Set default values for registers */
+    s->regs[REG_INDEX(REG_VER)] = REG_VER_RST;
+    s->regs[REG_INDEX(REG_EMAC_PHY_CLK)] = REG_EMAC_PHY_CLK_RST;
+}
+
+static void allwinner_h3_syscon_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void allwinner_h3_syscon_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwH3SysconState *s = AW_H3_SYSCON(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_syscon_ops, s,
+                          TYPE_AW_H3_SYSCON, 4 * KiB);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_h3_syscon_vmstate = {
+    .name = "allwinner-h3-syscon",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwH3SysconState, AW_H3_SYSCON_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_h3_syscon_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_h3_syscon_reset;
+    dc->realize = allwinner_h3_syscon_realize;
+    dc->vmsd = &allwinner_h3_syscon_vmstate;
+}
+
+static const TypeInfo allwinner_h3_syscon_info = {
+    .name          = TYPE_AW_H3_SYSCON,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_h3_syscon_init,
+    .instance_size = sizeof(AwH3SysconState),
+    .class_init    = allwinner_h3_syscon_class_init,
+};
+
+static void allwinner_h3_syscon_register(void)
+{
+    type_register_static(&allwinner_h3_syscon_info);
+}
+
+type_init(allwinner_h3_syscon_register)
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 200ed44ce1..b234aefba5 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -29,6 +29,7 @@ common-obj-$(CONFIG_MACIO) += macio/
 common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-clk.o
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-syscon.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
 common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
-- 
2.17.1


