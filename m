Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FC3C38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEC92078C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcB1CVwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEC92078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQi20-00070o-T2
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 21:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQi0A-0005JA-9y
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pauldzim@gmail.com>) id 1jQi09-0003NB-Ci
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:47:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jQi09-0003LM-0Y
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:47:05 -0400
Received: by mail-pg1-x541.google.com with SMTP id t11so6031486pgg.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 18:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=O/2wTU3XwgcDuIXzSAL6G+T/creDeWSuhzs/HV7uMf0=;
 b=DcB1CVwF+KDZSvIcENVg/cGgnjCPzjyqC7fqa+puzPSmw0+Yik0k5a6JXoFrK2RNrg
 CUn1kBo90eZJ+jG1xI1JPbMXZA5SiBnpxdtug+QTfo/lQZA28idpzTwEHqGKZH3ABrft
 yw1nJ5m5s5pM0cI0hhoTQlbLIcWHs/EwtFRID5ekQOf6A2NM31lvpFrvEfyn5NwOrCWF
 dZ565U79Kc7iolZl1tzmKjBfJR1X0bvRS6ltPtQi1pGoTuAijWx8qvjnLf9xReESYmN7
 qMroO/iPymDS43O0ENtyk3/kYwQ/zZR54axWr+4UioCTPZZw4kIi9qm/iJBb/TqYS73L
 fJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=O/2wTU3XwgcDuIXzSAL6G+T/creDeWSuhzs/HV7uMf0=;
 b=YPKBcC/aKpS5yJ22CFGsSH8zhfh7OZqwVDF6pg0pI9JfvUehcfyXFbxCJaGC8g+DsW
 INqi+eyXZA/qtKWycd1nXFBUui5MSDyP8KHXdis0vcwUdqbcFHQNGk4ERPbbjRwo+OOn
 aSbm6rniZKeq0pDfDz1ZcheVnHwdw8f4AsTv5XVoivrnXXsKmpj5K1Xp3sma14rHdOLJ
 6ngmR3cD6wyVjgFcUIpYSnCoktKJsXWLh55oFtPcgXHOSQCr/MexrdPoXS4Rq4PAhTfZ
 hNEPv5bpR7VwdA/8DJufcTgkXQ88J5Pxh5PKltwJggkWbPsy1OgUQlhUcJPeI2OmDSA9
 F2wQ==
X-Gm-Message-State: AGi0PuYF+ffJ1SK10GbwPKBiWFtKgsI6V41Wi5JaS9HudG8lai/IF76k
 8p2s1tuaVIpzZZHqCL5a7Z4=
X-Google-Smtp-Source: APiQypJAAhAzCt71foeMMalvDee5UiW5PQ6OPw+qGKyD60DJAhOCjOdfKJADoy2RS5+/B2LcjoROfw==
X-Received: by 2002:a62:838d:: with SMTP id h135mr1979752pfe.81.1587433623519; 
 Mon, 20 Apr 2020 18:47:03 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id q11sm654868pgs.25.2020.04.20.18.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 18:47:03 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 1/7] raspi: add BCM2835 SOC MPHI emulation
Date: Mon, 20 Apr 2020 18:45:45 -0700
Message-Id: <20200421014551.10426-2-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200421014551.10426-1-pauldzim@gmail.com>
References: <20200421014551.10426-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=pauldzim@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add BCM2835 SOC MPHI (Message-based Parallel Host Interface)
emulation. It is very basic, only providing the FIQ interrupt
needed to allow the dwc-otg USB host controller driver in the
Raspbian kernel to function.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
---
 hw/arm/bcm2835_peripherals.c         |  17 +++
 hw/misc/Makefile.objs                |   1 +
 hw/misc/bcm2835_mphi.c               | 190 +++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h |   2 +
 include/hw/misc/bcm2835_mphi.h       |  48 +++++++
 5 files changed, 258 insertions(+)
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 include/hw/misc/bcm2835_mphi.h

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index edcaa4916d..5e2c832d95 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -124,6 +124,10 @@ static void bcm2835_peripherals_init(Object *obj)
     sysbus_init_child_obj(obj, "gpio", &s->gpio, sizeof(s->gpio),
                           TYPE_BCM2835_GPIO);
 
+    /* Mphi */
+    sysbus_init_child_obj(obj, "mphi", &s->mphi, sizeof(s->mphi),
+                          TYPE_BCM2835_MPHI);
+
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
                                    OBJECT(&s->sdhci.sdbus), &error_abort);
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
@@ -368,6 +372,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
index 0000000000..66fc4a9cd3
--- /dev/null
+++ b/hw/misc/bcm2835_mphi.c
@@ -0,0 +1,190 @@
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
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+#include "qemu/main-loop.h"
+
+static inline void mphi_raise_irq(BCM2835MphiState *s)
+{
+    qemu_set_irq(s->irq, 1);
+}
+
+static inline void mphi_lower_irq(BCM2835MphiState *s)
+{
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
+    return val;
+}
+
+static void mphi_reg_write(void *ptr, hwaddr addr, uint64_t val, unsigned size)
+{
+    BCM2835MphiState *s = ptr;
+    uint32_t reg = s->regbase + addr;
+    int do_irq = 0;
+
+    val &= 0xffffffff;
+
+    switch (reg) {
+    case 0x28:  /* outdda */
+        s->outdda = val;
+        break;
+    case 0x2c:  /* outddb */
+        s->outddb = val;
+        if (val & (1 << 29)) {
+            do_irq = 1;
+        }
+        break;
+    case 0x4c:  /* ctrl */
+        s->ctrl = val;
+        if (val & (1 << 16)) {
+            do_irq = -1;
+        }
+        break;
+    case 0x50:  /* intstat */
+        s->intstat = val;
+        if (val & ((1 << 16) | (1 << 29))) {
+            do_irq = -1;
+        }
+        break;
+    case 0x1f0: /* swirq_set */
+        s->swirq_set = val;
+        do_irq = 1;
+        break;
+    case 0x1f4: /* swirq_clr */
+        s->swirq_clr = val;
+        do_irq = -1;
+        break;
+    default:
+        break;
+    }
+
+    if (do_irq > 0) {
+        mphi_raise_irq(s);
+    } else if (do_irq < 0) {
+        mphi_lower_irq(s);
+    }
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
+static void mphi_reset(DeviceState *dev)
+{
+}
+
+static void mphi_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    BCM2835MphiState *s = BCM2835_MPHI(dev);
+
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void mphi_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    BCM2835MphiState *s = BCM2835_MPHI(obj);
+
+    s->regbase = 0;
+    memory_region_init(&s->mem, obj, "mphi", MPHI_MMIO_SIZE);
+    memory_region_init_io(&s->mem_reg, obj, &mphi_mmio_ops, s, "global", 0x200);
+    memory_region_add_subregion(&s->mem, s->regbase, &s->mem_reg);
+    sysbus_init_mmio(sbd, &s->mem);
+}
+
+const VMStateDescription vmstate_mphi_state = {
+    .name = "mphi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(regbase, BCM2835MphiState),
+        VMSTATE_UINT32(outdda, BCM2835MphiState),
+        VMSTATE_UINT32(outddb, BCM2835MphiState),
+        VMSTATE_UINT32(ctrl, BCM2835MphiState),
+        VMSTATE_UINT32(intstat, BCM2835MphiState),
+        VMSTATE_UINT32(swirq_set, BCM2835MphiState),
+        VMSTATE_UINT32(swirq_clr, BCM2835MphiState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void mphi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = mphi_realize;
+    dc->reset = mphi_reset;
+    dc->vmsd = &vmstate_mphi_state;
+}
+
+static const TypeInfo bcm2835_mphi_type_info = {
+    .name          = TYPE_BCM2835_MPHI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835MphiState),
+    .instance_init = mphi_init,
+    .class_init    = mphi_class_init,
+};
+
+static void bcm2835_mphi_register_types(void)
+{
+    type_register_static(&bcm2835_mphi_type_info);
+}
+
+type_init(bcm2835_mphi_register_types)
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 2e8655a7c2..7a7a8f6141 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -21,6 +21,7 @@
 #include "hw/misc/bcm2835_property.h"
 #include "hw/misc/bcm2835_rng.h"
 #include "hw/misc/bcm2835_mbox.h"
+#include "hw/misc/bcm2835_mphi.h"
 #include "hw/misc/bcm2835_thermal.h"
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
@@ -42,6 +43,7 @@ typedef struct BCM2835PeripheralState {
     qemu_irq irq, fiq;
 
     BCM2835SystemTimerState systmr;
+    BCM2835MphiState mphi;
     UnimplementedDeviceState armtmr;
     UnimplementedDeviceState cprman;
     UnimplementedDeviceState a2w;
diff --git a/include/hw/misc/bcm2835_mphi.h b/include/hw/misc/bcm2835_mphi.h
new file mode 100644
index 0000000000..6d070b04a5
--- /dev/null
+++ b/include/hw/misc/bcm2835_mphi.h
@@ -0,0 +1,48 @@
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
+    qemu_irq irq;
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


