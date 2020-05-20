Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A527C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43291206F6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXnBKn7F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43291206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbYYX-0002xc-CQ
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 19:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbYXi-0001yG-Fw
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:54:34 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jbYXh-0008VY-99
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:54:34 -0400
Received: by mail-pl1-x642.google.com with SMTP id x18so933837pll.6
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 16:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gjv4Z4L7XtmFqZBSSI931Hzj1JVb2LbXs7HKtP48bN0=;
 b=ZXnBKn7Fez5jDO9U6wxx4rhk+1p2Lj5wN19rCic1hNtR+1xRijV314hVvKyNZDdtWX
 Ja8FfcrrWDh+XwVIOLutgOq858urusaff6wPn5JYqIdW5gUIe60vwet1z7hyYjSMMAq5
 Sq1EXlIavoz/oCfPp2SYXPh60kXn2YG+kqvzDKEYN+jnAQRRaLE3novTpRV6oyoFn3QE
 mPWdmLMyKU/FDS5JJcRlnRkAc6UBXcCzQMekO832NuAUuWo6in5NoTldg3ihWf2QkwOC
 Z2tuYjGjMQ+grubK1UbpGSlgdhNtunotzn17fiN9fwCoMkg62xE8FDHIwKpQV+pTxxTz
 10YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Gjv4Z4L7XtmFqZBSSI931Hzj1JVb2LbXs7HKtP48bN0=;
 b=WubdDPS5gzIEZG8jDrfQAlH/x63mH4t/e4N+dEczQgEG8BDXb9mWCUIbIiRkPsvkQv
 8i+czdFkWnrBzxqvJLH633PDs3f4PPn1vrhSrLBlW7/Q9ekdNVDR3MMx9OAu/DubNWOK
 yuyyfwsQSXw33SlqmMhey2dbCWDJFhZJh0iQlhe1ahuYpatnVpLPQgXK66BpnIrnIjhV
 uaBx+X29Vn7U4rb2QJlsxDSOzdLV5JrtMBbmZkolN6Q+8GWmWxz+UuJ5xSKqbagAOjhT
 VruHQvaAk9+9wZBaISpEbh/Uv0jv44XsH84rLhKmZsZex/8j/pLie7phvrhM/6hjrcID
 HT/g==
X-Gm-Message-State: AOAM530WG30CVTo1aan9pGuJq8TTB44a9MUdQcZi60OsJJPY00D+9Str
 DP3MOO5Z+4cYOSrMRpQY+qg=
X-Google-Smtp-Source: ABdhPJzZljpwk89dybxbBgTAsVSo9tL95z0yUEkFr+0opd/+IbGlPHah17GLM6cJcEY+ss/2VVSdRA==
X-Received: by 2002:a17:90a:2a8e:: with SMTP id
 j14mr7954646pjd.136.1590018871824; 
 Wed, 20 May 2020 16:54:31 -0700 (PDT)
Received: from localhost.localdomain ([75.167.104.59])
 by smtp.gmail.com with ESMTPSA id d20sm2761882pjs.12.2020.05.20.16.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 16:54:31 -0700 (PDT)
From: Paul Zimmerman <pauldzim@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v6 1/7] raspi: add BCM2835 SOC MPHI emulation
Date: Wed, 20 May 2020 16:53:43 -0700
Message-Id: <20200520235349.21215-2-pauldzim@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200520235349.21215-1-pauldzim@gmail.com>
References: <20200520235349.21215-1-pauldzim@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=pauldzim@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Acked-by: Philippe Mathieu-Daude <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2835_peripherals.c         |  17 +++
 hw/misc/Makefile.objs                |   1 +
 hw/misc/bcm2835_mphi.c               | 191 +++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h |   2 +
 include/hw/misc/bcm2835_mphi.h       |  44 ++++++
 5 files changed, 255 insertions(+)
 create mode 100644 hw/misc/bcm2835_mphi.c
 create mode 100644 include/hw/misc/bcm2835_mphi.h

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index f1bcc14f55..b3e0495040 100644
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
index 0000000000..0428e10ba5
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
index 0000000000..e084314d0f
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
-- 
2.17.1


