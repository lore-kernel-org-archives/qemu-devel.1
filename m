Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E795C1975A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:29:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EC52070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 22:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNX8GcxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EC52070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG963-0006MK-Ad
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 18:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jG952-0005Hm-J7
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pauldzim@gmail.com>) id 1jG950-0001fx-Pi
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:28 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:51956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pauldzim@gmail.com>) id 1jG950-0001fa-Je
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 18:28:26 -0400
Received: by mail-pj1-x1042.google.com with SMTP id hg10so5214741pjb.1
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OdBk7fBl+khEi1+sSGi994OMCvR7ndIiJGrmG/gZmGo=;
 b=UNX8GcxDDpXI2Tf02unvG94JXmfhmrkgajRcBhFXxyd+2BPcs3A//osXmWONViISTZ
 TdRldqhA4LW97JPzbvnfHe5VQ0OpUxNR+Kisr8FFL3vTeLZmeZFF1fMDXeAm8DKXeD9t
 PJNSNo+8Q6/bwryEbAk0dP3mQ9m9FRP0bB1PRF9e4OhfV6Q2nDJ9cC44AbLpkpj0V2rb
 ByxIdt4OnzzCBqoDmAouefS6Sy6QOSWxEBKwKZXU5BNdBmMfkPsx34p6H3FoPC7pSFJz
 ZTnvvIOD24d7GPTeA3qjJRvZAKjgjsM+kiYY78oHt62UykqV2TJlyVW1dP9mWzYa42mQ
 R9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OdBk7fBl+khEi1+sSGi994OMCvR7ndIiJGrmG/gZmGo=;
 b=q5Jz1lbf7QSdVgMStBixWpVhj3BsKTW7WRVK/Tzt03AzQdao9vo5GJNVZlWKL2R1qJ
 JI4KctC/PALAHm3OODbVLW27G7W9ipMsBsGHaBRygrYSKmUWQn8gMMG/5xzSYNomJCVP
 xtpUvv8BmvRst5beIcX33lhmeR2Zq69E0ZgJnHPqWmA5lDdFo7M24Bfb4IWreRlBiR6g
 LJeFfITU9O/g2lrB/P+0ptIfAghJy381VpxJfYwmIlQynyarG735ukzmNrVT4seBMGY9
 zQm6gUiJAu1b8LXYUJZQhkIU70lXgTAGmh687qcMbhjZWYGIWT/kHzyvIBdo4ZPTuKeJ
 Wq+A==
X-Gm-Message-State: ANhLgQ3ziDPGVgvF99LxLbLSJmqBwlZzPutsaFwexRWSe0be6ovlofK+
 L9xYOqor8Lgw5BobejZZses=
X-Google-Smtp-Source: ADFU+vvII6vv7jEiiNg7n1ZgEpsQckUqS3ly3m5BCnbMsrtl7cIYmh1JfQaMPAVvU30Weg+sR7ubOQ==
X-Received: by 2002:a17:90a:3acc:: with SMTP id
 b70mr21568068pjc.179.1584916105582; 
 Sun, 22 Mar 2020 15:28:25 -0700 (PDT)
Received: from localhost.localdomain ([75.167.220.149])
 by smtp.gmail.com with ESMTPSA id e10sm11440315pfm.121.2020.03.22.15.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2020 15:28:25 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: kraxel@redhat.com
Subject: [PATCH 1/6] Add BCM2835 SOC MPHI emulation
Date: Sun, 22 Mar 2020 15:27:21 -0700
Message-Id: <20200322222726.10244-2-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200322222726.10244-1-pauldzim@gmail.com>
References: <20200322222726.10244-1-pauldzim@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org, stefanha@gmail.com, qemu-devel@nongnu.org,
 Paul Zimmerman <pauldzim@gmail.com>, jsnow@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add BCM2835 SOC MPHI emulation. It is very basic, only providing
the FIQ interrupt needed to allow the dwc-otg USB host controller
driver in the Raspbian kernel to function.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         |  17 +++
 hw/misc/Makefile.objs                |   1 +
 hw/misc/bcm2835_mphi.c               | 215 +++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h |   2 +
 include/hw/misc/bcm2835_mphi.h       |  50 +++++++
 5 files changed, 285 insertions(+)
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 include/hw/misc/bcm2835_mphi.h

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 17207ae07e..dd7e6883cb 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -123,6 +123,10 @@ static void bcm2835_peripherals_init(Object *obj)
     sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
                           TYPE_BCM2835_GPIO);
 
+    /* Mphi */
+    sysbus_init_child_obj(obj, "mphi", &s->mphi, sizeof(s->mphi),
+                          TYPE_BCM2835_MPHI);
+
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
                                    OBJECT(&s->sdhci.sdbus), &error_abort);
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
@@ -367,6 +371,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Mphi */
+    object_property_set_bool(OBJECT(&s->mphi), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, MPHI_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mphi), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mphi), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_HOSTPORT));
+
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, 0x40);
     create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
     create_unimp(s, &s->a2w, "bcm2835-a2w", A2W_OFFSET, 0x1000);
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 68aae2eabb..91085cc21b 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -57,6 +57,7 @@ common-obj-$(CONFIG_OMAP) += omap_l4.o
 common-obj-$(CONFIG_OMAP) += omap_sdrc.o
 common-obj-$(CONFIG_OMAP) += omap_tap.o
 common-obj-$(CONFIG_RASPI) += bcm2835_mbox.o
+common-obj-$(CONFIG_RASPI) += bcm2835_mphi.o
 common-obj-$(CONFIG_RASPI) += bcm2835_property.o
 common-obj-$(CONFIG_RASPI) += bcm2835_rng.o
 common-obj-$(CONFIG_RASPI) += bcm2835_thermal.o
diff --git a/hw/misc/bcm2835_mphi.c b/hw/misc/bcm2835_mphi.c
new file mode 100644
index 0000000000..32433ce156
--- /dev/null
+++ b/hw/misc/bcm2835_mphi.c
@@ -0,0 +1,215 @@
+/*
+ * BCM2835 SOC MPHI emulation
+ *
+ * Very basic emulation, only providing the FIQ interrupt needed to
+ * allow the dwc-otg USB host controller driver in the Raspbian kernel
+ * to function.
+ *
+ * Copyright (c) 2020 Paul Zimmerman <pauldzim@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/misc/bcm2835_mphi.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+
+//#define MPHI_DEBUG      1
+
+#ifdef MPHI_DEBUG
+#define DPRINTF(fmt, ...) fprintf(stderr, fmt, ## __VA_ARGS__)
+#else
+#define DPRINTF(fmt, ...) do {} while(0)
+#endif
+
+static inline void mphi_raise_irq(BCM2835MphiState *s)
+{
+    DPRINTF("mphi_raise_irq, s %p\n", s);
+    qemu_set_irq(s->irq, 1);
+}
+
+static inline void mphi_lower_irq(BCM2835MphiState *s)
+{
+    DPRINTF("mphi_lower_irq, s %p\n", s);
+    qemu_set_irq(s->irq, 0);
+}
+
+static uint64_t mphi_reg_read(void *ptr, hwaddr addr, unsigned size)
+{
+    BCM2835MphiState *s = ptr;
+    uint32_t reg = s->regbase + addr;
+    uint32_t val = 0;
+
+    switch (reg) {
+    case 0x28:  /* outdda */
+        val = s->outdda;
+        break;
+    case 0x2c:  /* outddb */
+        val = s->outddb;
+        break;
+    case 0x4c:  /* ctrl */
+        val = s->ctrl;
+        val |= 1 << 17;
+        break;
+    case 0x50:  /* intstat */
+        val = s->intstat;
+        break;
+    case 0x1f0: /* swirq_set */
+        val = s->swirq_set;
+        break;
+    case 0x1f4: /* swirq_clr */
+        val = s->swirq_clr;
+        break;
+    default:
+        break;
+    }
+
+    DPRINTF("mphi_reg_read   0x%04lx val 0x%08x\n", addr, val);
+    return val;
+}
+
+static void mphi_reg_write(void *ptr, hwaddr addr, uint64_t val, unsigned size)
+{
+    BCM2835MphiState *s = ptr;
+    uint32_t reg = s->regbase + addr;
+    uint32_t old;
+    int do_irq = 0;
+
+    DPRINTF("mphi_reg_write  0x%04lx val 0x%08lx ", addr, val);
+    val &= 0xffffffff;
+
+    switch (reg) {
+    case 0x28:  /* outdda */
+        old = s->outdda;
+        s->outdda = val;
+        break;
+    case 0x2c:  /* outddb */
+        old = s->outddb;
+        s->outddb = val;
+        if (val & (1 << 29))
+            do_irq = 1;
+        break;
+    case 0x4c:  /* ctrl */
+        old = s->ctrl;
+        s->ctrl = val;
+        if (val & (1 << 16))
+            do_irq = -1;
+        break;
+    case 0x50:  /* intstat */
+        old = s->intstat;
+        s->intstat = val;
+        if (val & ((1 << 16) | (1 << 29)))
+            do_irq = -1;
+        break;
+    case 0x1f0: /* swirq_set */
+        old = s->swirq_set;
+        s->swirq_set = val;
+        do_irq = 1;
+        break;
+    case 0x1f4: /* swirq_clr */
+        old = s->swirq_clr;
+        s->swirq_clr = val;
+        do_irq = -1;
+        break;
+    default:
+        break;
+    }
+
+    DPRINTF("old 0x%08x result 0x%08lx\n", old, val);
+    old = old;
+    if (do_irq > 0)
+        mphi_raise_irq(s);
+    else if (do_irq < 0)
+        mphi_lower_irq(s);
+}
+
+static const MemoryRegionOps mphi_mmio_ops = {
+    .read = mphi_reg_read,
+    .write = mphi_reg_write,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void mphi_realize(BCM2835MphiState *s, DeviceState *dev, Error **errp)
+{
+    DPRINTF("mphi_realize, s %p dev %p\n", s, dev);
+    s->device = dev;
+}
+
+static void mphi_init(BCM2835MphiState *s, DeviceState *dev)
+{
+    DPRINTF("usb_mphi_init, s %p dev %p\n", s, dev);
+
+    memory_region_init(&s->mem, OBJECT(dev), "mphi", MPHI_MMIO_SIZE);
+    memory_region_init_io(&s->mem_reg, OBJECT(dev), &mphi_mmio_ops, s,
+                          "global", 0x200);
+    memory_region_add_subregion(&s->mem, s->regbase, &s->mem_reg);
+}
+
+static void mphi_sysbus_reset(DeviceState *dev)
+{
+#ifdef MPHI_DEBUG
+    SysBusDevice *d = SYS_BUS_DEVICE(dev);
+    BCM2835MphiState *s = BCM2835_MPHI(d);
+#endif
+
+    DPRINTF("mphi_sysbus_reset, dev %p d %p s %p\n", dev, d, s);
+}
+
+static void mphi_sysbus_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(dev);
+    BCM2835MphiState *s = BCM2835_MPHI(dev);
+
+    DPRINTF("mphi_sysbus_realize, dev %p d %p s %p\n", dev, d, s);
+    mphi_realize(s, dev, errp);
+    sysbus_init_irq(d, &s->irq);
+}
+
+static void mphi_sysbus_init(Object *obj)
+{
+    SysBusDevice *d = SYS_BUS_DEVICE(obj);
+    BCM2835MphiState *s = BCM2835_MPHI(obj);
+
+    DPRINTF("mphi_sysbus_init, obj %p d %p s %p\n", obj, d, s);
+    s->regbase = 0;
+    s->as = &address_space_memory;
+    mphi_init(s, DEVICE(obj));
+    sysbus_init_mmio(d, &s->mem);
+}
+
+static void mphi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    DPRINTF("mphi_class_init, class %p dc %p\n", klass, dc);
+    dc->realize = mphi_sysbus_realize;
+    dc->reset = mphi_sysbus_reset;
+}
+
+static const TypeInfo bcm2835_mphi_type_info = {
+     .name          = TYPE_BCM2835_MPHI,
+     .parent        = TYPE_SYS_BUS_DEVICE,
+     .instance_size = sizeof(BCM2835MphiState),
+     .instance_init = mphi_sysbus_init,
+     .class_init    = mphi_class_init,
+};
+
+static void bcm2835_mphi_register_types(void)
+{
+    DPRINTF("bcm2835_mphi_register_types\n");
+    type_register_static(&bcm2835_mphi_type_info);
+}
+
+type_init(bcm2835_mphi_register_types)
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 7859281e11..77958ca60e 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -20,6 +20,7 @@
 #include "hw/misc/bcm2835_property.h"
 #include "hw/misc/bcm2835_rng.h"
 #include "hw/misc/bcm2835_mbox.h"
+#include "hw/misc/bcm2835_mphi.h"
 #include "hw/misc/bcm2835_thermal.h"
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
@@ -41,6 +42,7 @@ typedef struct BCM2835PeripheralState {
     qemu_irq irq, fiq;
 
     BCM2835SystemTimerState systmr;
+    BCM2835MphiState mphi;
     UnimplementedDeviceState armtmr;
     UnimplementedDeviceState cprman;
     UnimplementedDeviceState a2w;
diff --git a/include/hw/misc/bcm2835_mphi.h b/include/hw/misc/bcm2835_mphi.h
new file mode 100644
index 0000000000..826ae2af3b
--- /dev/null
+++ b/include/hw/misc/bcm2835_mphi.h
@@ -0,0 +1,50 @@
+/*
+ * BCM2835 SOC MPHI state definitions
+ *
+ * Copyright (c) 2020 Paul Zimmerman <pauldzim@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef HW_MISC_BCM2835_MPHI_H
+#define HW_MISC_BCM2835_MPHI_H
+
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "sysemu/dma.h"
+
+#define MPHI_MMIO_SIZE      0x1000
+
+typedef struct BCM2835MphiState BCM2835MphiState;
+
+struct BCM2835MphiState {
+    SysBusDevice parent_obj;
+    DeviceState *device;
+    qemu_irq irq;
+    AddressSpace *as;
+    MemoryRegion mem;
+    MemoryRegion mem_reg;
+    uint16_t regbase;
+
+    uint32_t outdda;
+    uint32_t outddb;
+    uint32_t ctrl;
+    uint32_t intstat;
+    uint32_t swirq_set;
+    uint32_t swirq_clr;
+};
+
+#define TYPE_BCM2835_MPHI   "bcm2835-mphi"
+
+#define BCM2835_MPHI(obj) \
+    OBJECT_CHECK(BCM2835MphiState, (obj), TYPE_BCM2835_MPHI)
+
+#endif
-- 
2.17.1


