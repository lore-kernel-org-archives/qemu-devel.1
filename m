Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A82FC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 23:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CEB20801
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 23:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfeBL1Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CEB20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3pr8-0006HI-6S
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 18:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j3pkh-0001aG-DA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 18:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j3pkf-0006fu-4y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 18:24:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j3pke-0006f2-UI; Mon, 17 Feb 2020 18:24:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id w15so21718516wru.4;
 Mon, 17 Feb 2020 15:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=41qj3NxNfqkJ0KgC1Nh5pVQfq3lgqlg6L+QT/es1QAo=;
 b=OfeBL1QaWu4a63K4yGW5Fg6DA09n0NJGgtO/wIBMunAMzHMtYn3IGpyKIjsijZDJai
 7zk5vIwgNVzmPoyIKMGP5ettS+5KaCZE1olbdWneUsRNJ5rW4jn7tG8diugnttSAHlxu
 3171zbxalHbmXHpwm/j86G490fUG+0aSckwctMIkX94lS/6TTr3LZn7yQyhgs/g9FUbt
 KuPc5fXyfomViiUg2Bm0pM8baoT51uGYfmcy9ZFv8KZUeIyaw24Xw+ITSUfA94OTeuLv
 DflzAOBOrsrjATM8M5+uWxmwvzk4D4MUcxrC+DZSwlNLUEMegEQwfx0tIS2LHqKI4elu
 HR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=41qj3NxNfqkJ0KgC1Nh5pVQfq3lgqlg6L+QT/es1QAo=;
 b=QR3Ou0y0JuoDFURJVQ9i7wNyay3iDOaAoObP0aUcYgccT9GGJNyy6R8Bn5e2oVUOIl
 Yjh7lC7k1T33hjpq3ELoD5l96nyYiWfIcJUaq8KTIWJmke0xn8iMtmuP3et9euwAY90g
 PurmGnEmpxMn2Rd0S+Og815bL6zuzKAIYVcuVN6Y6nJKFIe85DshoA6drh9R+R2GxBrY
 tgHIwO7MnPMsJJgPBZkjI/OWBH8rvvI3hU4N9RbHNcW+DMShls6bTuh4jq03ioTUp8Cs
 II57BEhV5F4EKmdDArrNoFv80RNiym3u+jI/2CQdRKZGorPZEAAM3XJG82Nfhmf23nFd
 VWFg==
X-Gm-Message-State: APjAAAXN7b39c8wPunXHN+UduG0bDHnYUAdRPSxbFsm7H8rogVoR4v0B
 fDlCXmEUrU47zfTou4Zn0gYmdCXen8E=
X-Google-Smtp-Source: APXvYqzssMmwf3HhA2q0J7k+58SRQPfOQBSAKfxj9OIRFZtFogLgD/GEXa2d2+Pt7sbIg8EVXJrNdQ==
X-Received: by 2002:adf:f507:: with SMTP id q7mr24103849wro.384.1581981871437; 
 Mon, 17 Feb 2020 15:24:31 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id w1sm3244831wro.72.2020.02.17.15.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 15:24:31 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/18] hw/arm/allwinner: add Security Identifier device
Date: Tue, 18 Feb 2020 00:24:00 +0100
Message-Id: <20200217232411.30096-8-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217232411.30096-1-nieklinnenbank@gmail.com>
References: <20200217232411.30096-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Security Identifier device found in various Allwinner System on Chip
designs gives applications a per-board unique identifier. This commit
adds support for the Allwinner Security Identifier using a 128-bit
UUID value as input.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 include/hw/arm/allwinner-h3.h   |   3 +
 include/hw/misc/allwinner-sid.h |  60 ++++++++++++
 hw/arm/allwinner-h3.c           |  11 ++-
 hw/arm/orangepi.c               |   9 ++
 hw/misc/allwinner-sid.c         | 168 ++++++++++++++++++++++++++++++++
 hw/misc/Makefile.objs           |   1 +
 hw/misc/trace-events            |   4 +
 7 files changed, 255 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/allwinner-sid.h
 create mode 100644 hw/misc/allwinner-sid.c

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index dc729176ab..85416d9d64 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -42,6 +42,7 @@
 #include "hw/misc/allwinner-h3-ccu.h"
 #include "hw/misc/allwinner-cpucfg.h"
 #include "hw/misc/allwinner-h3-sysctrl.h"
+#include "hw/misc/allwinner-sid.h"
 #include "target/arm/cpu.h"
 
 /**
@@ -59,6 +60,7 @@ enum {
     AW_H3_SRAM_A2,
     AW_H3_SRAM_C,
     AW_H3_SYSCTRL,
+    AW_H3_SID,
     AW_H3_EHCI0,
     AW_H3_OHCI0,
     AW_H3_EHCI1,
@@ -114,6 +116,7 @@ typedef struct AwH3State {
     AwH3ClockCtlState ccu;
     AwCpuCfgState cpucfg;
     AwH3SysCtrlState sysctrl;
+    AwSidState sid;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-sid.h b/include/hw/misc/allwinner-sid.h
new file mode 100644
index 0000000000..4c1fa4762b
--- /dev/null
+++ b/include/hw/misc/allwinner-sid.h
@@ -0,0 +1,60 @@
+/*
+ * Allwinner Security ID emulation
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
+#ifndef HW_MISC_ALLWINNER_SID_H
+#define HW_MISC_ALLWINNER_SID_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "qemu/uuid.h"
+
+/**
+ * Object model
+ * @{
+ */
+
+#define TYPE_AW_SID    "allwinner-sid"
+#define AW_SID(obj) \
+    OBJECT_CHECK(AwSidState, (obj), TYPE_AW_SID)
+
+/** @} */
+
+/**
+ * Allwinner Security ID object instance state
+ */
+typedef struct AwSidState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    /** Control register defines how and what to read */
+    uint32_t control;
+
+    /** RdKey register contains the data retrieved by the device */
+    uint32_t rdkey;
+
+    /** Stores the emulated device identifier */
+    QemuUUID identifier;
+
+} AwSidState;
+
+#endif /* HW_MISC_ALLWINNER_SID_H */
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index b9a5597f2a..deeea63f5f 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -38,6 +38,7 @@ const hwaddr allwinner_h3_memmap[] = {
     [AW_H3_SRAM_A2]    = 0x00044000,
     [AW_H3_SRAM_C]     = 0x00010000,
     [AW_H3_SYSCTRL]    = 0x01c00000,
+    [AW_H3_SID]        = 0x01c14000,
     [AW_H3_EHCI0]      = 0x01c1a000,
     [AW_H3_OHCI0]      = 0x01c1a400,
     [AW_H3_EHCI1]      = 0x01c1b000,
@@ -78,7 +79,6 @@ struct AwH3Unimplemented {
     { "mmc0",      0x01c0f000, 4 * KiB },
     { "mmc1",      0x01c10000, 4 * KiB },
     { "mmc2",      0x01c11000, 4 * KiB },
-    { "sid",       0x01c14000, 1 * KiB },
     { "crypto",    0x01c15000, 4 * KiB },
     { "msgbox",    0x01c17000, 4 * KiB },
     { "spinlock",  0x01c18000, 4 * KiB },
@@ -198,6 +198,11 @@ static void allwinner_h3_init(Object *obj)
 
     sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg),
                           TYPE_AW_CPUCFG);
+
+    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
+                          TYPE_AW_SID);
+    object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
+                              "identifier", &error_abort);
 }
 
 static void allwinner_h3_realize(DeviceState *dev, Error **errp)
@@ -315,6 +320,10 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     qdev_init_nofail(DEVICE(&s->cpucfg));
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0, s->memmap[AW_H3_CPUCFG]);
 
+    /* Security Identifier */
+    qdev_init_nofail(DEVICE(&s->sid));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
+
     /* Universal Serial Bus */
     sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
                          qdev_get_gpio_in(DEVICE(&s->gic),
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 839cd4873c..44a5beebfa 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -67,6 +67,15 @@ static void orangepi_init(MachineState *machine)
     object_property_set_int(OBJECT(s->h3), 24 * 1000 * 1000, "clk1-freq",
                             &error_abort);
 
+    /* Setup SID properties. Currently using a default fixed SID identifier. */
+    if (qemu_uuid_is_null(&s->h3->sid.identifier)) {
+        qdev_prop_set_string(DEVICE(s->h3), "identifier",
+                             "02c00081-1111-2222-3333-000044556677");
+    } else if (ldl_be_p(&s->h3->sid.identifier.data[0]) != 0x02c00081) {
+        fprintf(stderr, "WARNING: Security Identifier value does "
+                        "not include H3 prefix\n");
+    }
+
     /* Mark H3 object realized */
     object_property_set_bool(OBJECT(s->h3), true, "realized", &error_abort);
 
diff --git a/hw/misc/allwinner-sid.c b/hw/misc/allwinner-sid.c
new file mode 100644
index 0000000000..196380c33a
--- /dev/null
+++ b/hw/misc/allwinner-sid.c
@@ -0,0 +1,168 @@
+/*
+ * Allwinner Security ID emulation
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
+#include "qemu/guest-random.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/allwinner-sid.h"
+#include "trace.h"
+
+/* SID register offsets */
+enum {
+    REG_PRCTL = 0x40,   /* Control */
+    REG_RDKEY = 0x60,   /* Read Key */
+};
+
+/* SID register flags */
+enum {
+    REG_PRCTL_WRITE   = 0x0002, /* Unknown write flag */
+    REG_PRCTL_OP_LOCK = 0xAC00, /* Lock operation */
+};
+
+static uint64_t allwinner_sid_read(void *opaque, hwaddr offset,
+                                   unsigned size)
+{
+    const AwSidState *s = AW_SID(opaque);
+    uint64_t val = 0;
+
+    switch (offset) {
+    case REG_PRCTL:    /* Control */
+        val = s->control;
+        break;
+    case REG_RDKEY:    /* Read Key */
+        val = s->rdkey;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_sid_read(offset, val, size);
+
+    return val;
+}
+
+static void allwinner_sid_write(void *opaque, hwaddr offset,
+                                uint64_t val, unsigned size)
+{
+    AwSidState *s = AW_SID(opaque);
+
+    trace_allwinner_sid_write(offset, val, size);
+
+    switch (offset) {
+    case REG_PRCTL:    /* Control */
+        s->control = val;
+
+        if ((s->control & REG_PRCTL_OP_LOCK) &&
+            (s->control & REG_PRCTL_WRITE)) {
+            uint32_t id = s->control >> 16;
+
+            if (id <= sizeof(QemuUUID) - sizeof(s->rdkey)) {
+                s->rdkey = ldl_be_p(&s->identifier.data[id]);
+            }
+        }
+        s->control &= ~REG_PRCTL_WRITE;
+        break;
+    case REG_RDKEY:    /* Read Key */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps allwinner_sid_ops = {
+    .read = allwinner_sid_read,
+    .write = allwinner_sid_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_sid_reset(DeviceState *dev)
+{
+    AwSidState *s = AW_SID(dev);
+
+    /* Set default values for registers */
+    s->control = 0;
+    s->rdkey = 0;
+}
+
+static void allwinner_sid_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwSidState *s = AW_SID(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_sid_ops, s,
+                           TYPE_AW_SID, 1 * KiB);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static Property allwinner_sid_properties[] = {
+    DEFINE_PROP_UUID_NODEFAULT("identifier", AwSidState, identifier),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static const VMStateDescription allwinner_sid_vmstate = {
+    .name = "allwinner-sid",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(control, AwSidState),
+        VMSTATE_UINT32(rdkey, AwSidState),
+        VMSTATE_UINT8_ARRAY_V(identifier.data, AwSidState, sizeof(QemuUUID), 1),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_sid_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_sid_reset;
+    dc->vmsd = &allwinner_sid_vmstate;
+    device_class_set_props(dc, allwinner_sid_properties);
+}
+
+static const TypeInfo allwinner_sid_info = {
+    .name          = TYPE_AW_SID,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_sid_init,
+    .instance_size = sizeof(AwSidState),
+    .class_init    = allwinner_sid_class_init,
+};
+
+static void allwinner_sid_register(void)
+{
+    type_register_static(&allwinner_sid_info);
+}
+
+type_init(allwinner_sid_register)
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index f3788a5903..daa734036e 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-ccu.o
 obj-$(CONFIG_ALLWINNER_H3) += allwinner-cpucfg.o
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-sysctrl.o
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-sid.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
 common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index ede1650672..4f38328d9c 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -5,6 +5,10 @@ allwinner_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t reset_addr) "id %u, reset_ad
 allwinner_cpucfg_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 allwinner_cpucfg_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 
+# allwinner-sid.c
+allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+
 # eccmemctl.c
 ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
 ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
-- 
2.17.1


