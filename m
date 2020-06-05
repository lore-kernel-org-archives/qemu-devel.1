Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BAEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:57:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7347B2077D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 16:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbUtEpb6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7347B2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhFet-00006s-O4
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 12:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY4-0001du-Eo
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhFY3-0001gI-4d
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 12:50:28 -0400
Received: by mail-wm1-x335.google.com with SMTP id y20so2051789wmi.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=R3dF63zgdE0fDZP+pS5/jJ34uuilYhEcirCm7ZOAzm8=;
 b=hbUtEpb6xHWus1kC34Nv/NVs+MdyVY8pvywZUaEskom4R0+TwX6N+EjuO/nm98HQ+b
 nTRdgVXt+JwzI5wi/I/EXSlw5gpaidAi6Knt73nPXFR3cUnbKuz0h3jpSfimHDQxwAZi
 gzx/ZZfwIr1vtBxkYTSeLJYhiOpyAm+sMxp2ssCXLzERjmZalenAXydb5eqYTX2IGuwf
 qgzyuSvDp+cxim+gQVztCA/FatPFaPLyvwLkPzVqNVDu2jhxF+WVGFC4Qquu0ZVzzMir
 9IaegJ41hcItmMbSQ8bYwTHWmEGiYfjXU0Po6Uvgv72w2ShWxP2N1xSYj9mKIRb6Lt59
 5cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R3dF63zgdE0fDZP+pS5/jJ34uuilYhEcirCm7ZOAzm8=;
 b=psaV84T/MZlVMgD0KiM7BLB1B1VUm9WCR/VZGSbsb5av6DjkiMjraSz0wEdR6FWh23
 b1oY+RmteB4vPYoegyozMiYRCb+k33wDtcEkGmQJalnOWJuXo9sfBgLAqwR3vivTTWg+
 IlZP8JeCL6pRJiEHLlQlr5JbLDAg2D/5yIa2Ti8NCFpboa/00MBfMYHX1lLrm3n4L5Z0
 yBG4eaaujLhJmTL9asrcZFQKpInHKSjtekdiMRGeSgQnKKnEEqxIzL2hLneO1W7eV6tP
 a819h5umwUiSLQIw2znxiP+AYXWComxRoslYj6KCGrrcCW+x6oxqcNJRRIqvQVTSYwrB
 hK4A==
X-Gm-Message-State: AOAM531SfEEr5lCTiLYWyw7sUI21gxSPLmOwaNTVSTreB1I18NL9j5SL
 vJJfoxJCErK7gK0wR+c/8Vosiz9jsqv6lw==
X-Google-Smtp-Source: ABdhPJy5Ti/usopEM4psqqDowPTd+qHRCo0qoIkq9hZri0xNjAEYpYJClUVMqmQMhhtwMmNKd8cSBA==
X-Received: by 2002:a1c:3d05:: with SMTP id k5mr3589444wma.160.1591375824940; 
 Fri, 05 Jun 2020 09:50:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c140sm12272724wmd.18.2020.06.05.09.50.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 09:50:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/29] raspi: add BCM2835 SOC MPHI emulation
Date: Fri,  5 Jun 2020 17:49:52 +0100
Message-Id: <20200605165007.12095-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605165007.12095-1-peter.maydell@linaro.org>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Paul Zimmerman <pauldzim@gmail.com>

Add BCM2835 SOC MPHI (Message-based Parallel Host Interface)
emulation. It is very basic, only providing the FIQ interrupt
needed to allow the dwc-otg USB host controller driver in the
Raspbian kernel to function.

Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
Acked-by: Philippe Mathieu-Daude <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200520235349.21215-2-pauldzim@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/bcm2835_peripherals.h |   2 +
 include/hw/misc/bcm2835_mphi.h       |  44 ++++++
 hw/arm/bcm2835_peripherals.c         |  17 +++
 hw/misc/bcm2835_mphi.c               | 191 +++++++++++++++++++++++++++
 hw/misc/Makefile.objs                |   1 +
 5 files changed, 255 insertions(+)
 create mode 100644 include/hw/misc/bcm2835_mphi.h
 create mode 100644 hw/misc/bcm2835_mphi.c

diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 2e8655a7c2d..7a7a8f61414 100644
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
index 00000000000..e084314d0f0
--- /dev/null
+++ b/include/hw/misc/bcm2835_mphi.h
@@ -0,0 +1,44 @@
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
+
+#define MPHI_MMIO_SIZE      0x1000
+
+typedef struct BCM2835MphiState BCM2835MphiState;
+
+struct BCM2835MphiState {
+    SysBusDevice parent_obj;
+    qemu_irq irq;
+    MemoryRegion iomem;
+
+    uint32_t outdda;
+    uint32_t outddb;
+    uint32_t ctrl;
+    uint32_t intstat;
+    uint32_t swirq;
+};
+
+#define TYPE_BCM2835_MPHI   "bcm2835-mphi"
+
+#define BCM2835_MPHI(obj) \
+    OBJECT_CHECK(BCM2835MphiState, (obj), TYPE_BCM2835_MPHI)
+
+#endif
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index f1bcc14f553..b3e0495040d 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -125,6 +125,10 @@ static void bcm2835_peripherals_init(Object *obj)
                                    OBJECT(&s->sdhci.sdbus));
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
                                    OBJECT(&s->sdhost.sdbus));
+
+    /* Mphi */
+    sysbus_init_child_obj(obj, "mphi", &s->mphi, sizeof(s->mphi),
+                          TYPE_BCM2835_MPHI);
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -360,6 +364,19 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
 
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
diff --git a/hw/misc/bcm2835_mphi.c b/hw/misc/bcm2835_mphi.c
new file mode 100644
index 00000000000..0428e10ba5c
--- /dev/null
+++ b/hw/misc/bcm2835_mphi.c
@@ -0,0 +1,191 @@
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
+#include "qemu/log.h"
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
+    uint32_t val = 0;
+
+    switch (addr) {
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
+        val = s->swirq;
+        break;
+    case 0x1f4: /* swirq_clr */
+        val = s->swirq;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "read from unknown register");
+        break;
+    }
+
+    return val;
+}
+
+static void mphi_reg_write(void *ptr, hwaddr addr, uint64_t val, unsigned size)
+{
+    BCM2835MphiState *s = ptr;
+    int do_irq = 0;
+
+    switch (addr) {
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
+        s->swirq |= val;
+        do_irq = 1;
+        break;
+    case 0x1f4: /* swirq_clr */
+        s->swirq &= ~val;
+        do_irq = -1;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "write to unknown register");
+        return;
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
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void mphi_reset(DeviceState *dev)
+{
+    BCM2835MphiState *s = BCM2835_MPHI(dev);
+
+    s->outdda = 0;
+    s->outddb = 0;
+    s->ctrl = 0;
+    s->intstat = 0;
+    s->swirq = 0;
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
+    memory_region_init_io(&s->iomem, obj, &mphi_mmio_ops, s, "mphi", MPHI_MMIO_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+const VMStateDescription vmstate_mphi_state = {
+    .name = "mphi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(outdda, BCM2835MphiState),
+        VMSTATE_UINT32(outddb, BCM2835MphiState),
+        VMSTATE_UINT32(ctrl, BCM2835MphiState),
+        VMSTATE_UINT32(intstat, BCM2835MphiState),
+        VMSTATE_UINT32(swirq, BCM2835MphiState),
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
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index b25181b7113..60a9d80b742 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -56,6 +56,7 @@ common-obj-$(CONFIG_OMAP) += omap_l4.o
 common-obj-$(CONFIG_OMAP) += omap_sdrc.o
 common-obj-$(CONFIG_OMAP) += omap_tap.o
 common-obj-$(CONFIG_RASPI) += bcm2835_mbox.o
+common-obj-$(CONFIG_RASPI) += bcm2835_mphi.o
 common-obj-$(CONFIG_RASPI) += bcm2835_property.o
 common-obj-$(CONFIG_RASPI) += bcm2835_rng.o
 common-obj-$(CONFIG_RASPI) += bcm2835_thermal.o
-- 
2.20.1


