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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDC5C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 487A924672
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1WXKp6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487A924672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igzxh-0003NF-CY
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 18:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuI-0006fG-Ks
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuG-0002mM-03
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:06 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1igzuF-0002ix-PD; Mon, 16 Dec 2019 18:36:03 -0500
Received: by mail-wm1-x342.google.com with SMTP id b72so1095767wme.4;
 Mon, 16 Dec 2019 15:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KgJxQ3LjCLFLnWv58xt5yNS0nKdFJ3g6xvCyzpqE8X4=;
 b=M1WXKp6fZxUthtIB492QWEUpCNnaTWHA21awHIsJxtuEMqSNqv0hKpd9xfVRLXppW7
 IMy3+Ex3D8rqRUJ6O2eA8/LpAcLlMlxDTnfraeLHuWzIlTGj1cjiuj9suLegp2AtyYRw
 AKW+N8yVO4iBz7HgJ1P9ZHMo1Z1+N7Lht1rbah3gOwXsjy6/EzQJT8gen9mUhqkfo4NF
 H5af2XAcvT3G6dk8oh2VrsEtThzJWLaQ0USJ4wcj1VOrlN/uEykWkaG7X+W3Rq8MYoVZ
 JfW/vIY09k7Hm4Ct2LjZ6G2dxJ4zTv1kcVwcmwIgzIe/g9tm4GI+AjowiH4183ex253I
 nPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KgJxQ3LjCLFLnWv58xt5yNS0nKdFJ3g6xvCyzpqE8X4=;
 b=NB8/5xQBNreBx5joxRkAtwWOq3bfoa/xLMCzk147LbhkH5+te44hf08ZGMgvoep92i
 s8Wd4sBWAsbosWLcEcZzTKIavositCAJkGJrfzxOIgqD9ZqlWOuEFKRg8GwqMh1C+5um
 mQErV3RN3Ubuj0pc47uVyQnevOjEX03EgLYoqJWRw3cN+TFRaSru+at2YccOR3I1GuIh
 8rRBQKQj2nu6tawhsCBD4SkQyBhGE632MGjUH3IL0dB1OUTtX4FsQ9wazqPLaQsDzs+6
 AWo1ugbdE0mERDRA6MsVzpp1413Ts3M3bMskZtEBGDpxgMf9MYhyDM0eGOSQarx3dg5r
 9PCQ==
X-Gm-Message-State: APjAAAV/KPbjEi+0fWzJLYxJ0wg07FEp+QoE1S8wMgfLWBRGOpzZjyti
 Malh5gtlMTKsYZT0kJ/bBtd4u57f
X-Google-Smtp-Source: APXvYqzMhqcUw29hPAlGb+/ZtFIFjCincL+XSAbbhdMUbVWTgwrJVO46zzHT+FvX1FlilJDPnRLxdg==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr1746618wma.62.1576539362453;
 Mon, 16 Dec 2019 15:36:02 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id z83sm984501wmg.2.2019.12.16.15.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 15:36:02 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/10] arm: allwinner-h3: add Security Identifier device
Date: Tue, 17 Dec 2019 00:35:17 +0100
Message-Id: <20191216233519.29030-9-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216233519.29030-1-nieklinnenbank@gmail.com>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

The Security Identifier device in Allwinner H3 System on Chip
gives applications a per-board unique identifier. This commit
adds support for the Allwinner H3 Security Identifier using
a 128-bit UUID value as input.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 include/hw/arm/allwinner-h3.h      |   2 +
 include/hw/misc/allwinner-h3-sid.h |  40 +++++++
 hw/arm/allwinner-h3.c              |   7 ++
 hw/arm/orangepi.c                  |   4 +
 hw/misc/allwinner-h3-sid.c         | 179 +++++++++++++++++++++++++++++
 hw/misc/Makefile.objs              |   1 +
 hw/misc/trace-events               |   4 +
 7 files changed, 237 insertions(+)
 create mode 100644 include/hw/misc/allwinner-h3-sid.h
 create mode 100644 hw/misc/allwinner-h3-sid.c

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 8128ae6131..c98c1972a6 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -29,6 +29,7 @@
 #include "hw/misc/allwinner-h3-clk.h"
 #include "hw/misc/allwinner-h3-cpucfg.h"
 #include "hw/misc/allwinner-h3-syscon.h"
+#include "hw/misc/allwinner-h3-sid.h"
 #include "target/arm/cpu.h"
 
 enum {
@@ -77,6 +78,7 @@ typedef struct AwH3State {
     AwH3ClockState ccu;
     AwH3CpuCfgState cpucfg;
     AwH3SysconState syscon;
+    AwH3SidState sid;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-h3-sid.h b/include/hw/misc/allwinner-h3-sid.h
new file mode 100644
index 0000000000..79c9a24459
--- /dev/null
+++ b/include/hw/misc/allwinner-h3-sid.h
@@ -0,0 +1,40 @@
+/*
+ * Allwinner H3 Security ID emulation
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
+#ifndef HW_MISC_ALLWINNER_H3_SID_H
+#define HW_MISC_ALLWINNER_H3_SID_H
+
+#include "hw/sysbus.h"
+#include "qemu/uuid.h"
+
+#define TYPE_AW_H3_SID    "allwinner-h3-sid"
+#define AW_H3_SID(obj)    OBJECT_CHECK(AwH3SidState, (obj), TYPE_AW_H3_SID)
+
+typedef struct AwH3SidState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion iomem;
+    uint32_t control;
+    uint32_t rdkey;
+    QemuUUID identifier;
+} AwH3SidState;
+
+#endif
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 1a9748ab2e..ba34f905cd 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -196,6 +196,9 @@ static void aw_h3_init(Object *obj)
 
     sysbus_init_child_obj(obj, "cpucfg", &s->cpucfg, sizeof(s->cpucfg),
                           TYPE_AW_H3_CPUCFG);
+
+    sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
+                          TYPE_AW_H3_SID);
 }
 
 static void aw_h3_realize(DeviceState *dev, Error **errp)
@@ -332,6 +335,10 @@ static void aw_h3_realize(DeviceState *dev, Error **errp)
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
index 62cefc8c06..b01c4b4f01 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -62,6 +62,10 @@ static void orangepi_init(MachineState *machine)
         exit(1);
     }
 
+    /* Setup SID properties */
+    qdev_prop_set_string(DEVICE(&s->h3->sid), "identifier",
+                         "8100c002-0001-0002-0003-000044556677");
+
     /* Mark H3 object realized */
     object_property_set_bool(OBJECT(s->h3), true, "realized", &error_abort);
     if (error_abort != NULL) {
diff --git a/hw/misc/allwinner-h3-sid.c b/hw/misc/allwinner-h3-sid.c
new file mode 100644
index 0000000000..c472f2bcc6
--- /dev/null
+++ b/hw/misc/allwinner-h3-sid.c
@@ -0,0 +1,179 @@
+/*
+ * Allwinner H3 Security ID emulation
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
+#include "hw/misc/allwinner-h3-sid.h"
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
+static uint64_t allwinner_h3_sid_read(void *opaque, hwaddr offset,
+                                      unsigned size)
+{
+    const AwH3SidState *s = (AwH3SidState *)opaque;
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
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_h3_sid_read(offset, val, size);
+
+    return val;
+}
+
+static void allwinner_h3_sid_write(void *opaque, hwaddr offset,
+                                   uint64_t val, unsigned size)
+{
+    AwH3SidState *s = (AwH3SidState *)opaque;
+
+    trace_allwinner_h3_sid_write(offset, val, size);
+
+    switch (offset) {
+    case REG_PRCTL:    /* Control */
+        s->control = val;
+
+        if ((s->control & REG_PRCTL_OP_LOCK) &&
+            (s->control & REG_PRCTL_WRITE)) {
+            uint32_t id = s->control >> 16;
+
+            if (id < sizeof(QemuUUID)) {
+                s->rdkey = (s->identifier.data[id]) |
+                           (s->identifier.data[id + 1] << 8) |
+                           (s->identifier.data[id + 2] << 16) |
+                           (s->identifier.data[id + 3] << 24);
+            }
+        }
+        s->control &= ~REG_PRCTL_WRITE;
+        break;
+    case REG_RDKEY:    /* Read Key */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps allwinner_h3_sid_ops = {
+    .read = allwinner_h3_sid_read,
+    .write = allwinner_h3_sid_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_h3_sid_reset(DeviceState *dev)
+{
+    AwH3SidState *s = AW_H3_SID(dev);
+
+    /* Set default values for registers */
+    s->control = 0;
+    s->rdkey = 0;
+}
+
+static void allwinner_h3_sid_realize(DeviceState *dev, Error **errp)
+{
+}
+
+static void allwinner_h3_sid_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwH3SidState *s = AW_H3_SID(obj);
+
+    /* Fill UUID with zeroes by default */
+    qemu_uuid_parse(UUID_NONE, &s->identifier);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_h3_sid_ops, s,
+                          TYPE_AW_H3_SID, 1 * KiB);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static Property allwinner_h3_sid_properties[] = {
+    DEFINE_PROP_UUID_NODEFAULT("identifier", AwH3SidState, identifier),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static const VMStateDescription allwinner_h3_sid_vmstate = {
+    .name = "allwinner-h3-sid",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(control, AwH3SidState),
+        VMSTATE_UINT32(rdkey, AwH3SidState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_h3_sid_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_h3_sid_reset;
+    dc->realize = allwinner_h3_sid_realize;
+    dc->vmsd = &allwinner_h3_sid_vmstate;
+    dc->props = allwinner_h3_sid_properties;
+}
+
+static const TypeInfo allwinner_h3_sid_info = {
+    .name          = TYPE_AW_H3_SID,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_h3_sid_init,
+    .instance_size = sizeof(AwH3SidState),
+    .class_init    = allwinner_h3_sid_class_init,
+};
+
+static void allwinner_h3_sid_register(void)
+{
+    type_register_static(&allwinner_h3_sid_info);
+}
+
+type_init(allwinner_h3_sid_register)
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index c4ca2ed689..f3620eee4e 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -31,6 +31,7 @@ common-obj-$(CONFIG_IVSHMEM_DEVICE) += ivshmem.o
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-clk.o
 obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-cpucfg.o
 common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-syscon.o
+common-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3-sid.o
 common-obj-$(CONFIG_REALVIEW) += arm_sysctl.o
 common-obj-$(CONFIG_NSERIES) += cbus.o
 common-obj-$(CONFIG_ECCMEMCTL) += eccmemctl.o
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index b93089d010..a777844ca3 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -5,6 +5,10 @@ allwinner_h3_cpucfg_cpu_reset(uint8_t cpu_id, uint32_t reset_addr) "H3-CPUCFG: c
 allwinner_h3_cpucfg_read(uint64_t offset, uint64_t data, unsigned size) "H3-CPUCFG: read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 allwinner_h3_cpucfg_write(uint64_t offset, uint64_t data, unsigned size) "H3-CPUCFG: write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 
+# allwinner-h3-sid.c
+allwinner_h3_sid_read(uint64_t offset, uint64_t data, unsigned size) "H3-SID: read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_h3_sid_write(uint64_t offset, uint64_t data, unsigned size) "H3-SID: write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+
 # eccmemctl.c
 ecc_mem_writel_mer(uint32_t val) "Write memory enable 0x%08x"
 ecc_mem_writel_mdr(uint32_t val) "Write memory delay 0x%08x"
-- 
2.17.1


