Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2180CC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D072620658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oi+qusW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D072620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izW9A-0005FJ-2D
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVox-0001bw-8o
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVou-00058R-De
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:19:07 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37975)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVot-0004zb-59; Wed, 05 Feb 2020 20:19:04 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so5137963wrh.5;
 Wed, 05 Feb 2020 17:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YKntEz0YWqvXEnpxZehSJURd2wV0yMHHN+VgGwbeMbQ=;
 b=oi+qusW0M9ReYlUYlgK0Tx/WRBFwFBdJ3G492nLXQLtnq6cGlfgg6IhU+8Q1KX6NzW
 teDpuwygyQFRiAY1Bzhvjk0EGqbVz9KYTaTxwGhK/j+amIwnTRpxU2SIJvMuV4HGjAaW
 uEp3GKynLjsBGBbR9XhcYJZWrJqckktTU7lOW+LXYjrnoVa122Niz0U/9OoMMri6G0Nh
 9B5mbOdkBEhkSkewOp3IWx5a9VezotBoyF2DpZCYJrccs4O3bi5UT+RacKHELvRxujR9
 A2XK/Kp2QYYkb77vhJVlyXqGX55cUQB7+fpwlg7JccbeTvKPyBU0o5SLoLVlrBY+qob/
 0Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YKntEz0YWqvXEnpxZehSJURd2wV0yMHHN+VgGwbeMbQ=;
 b=RVX/foTZTBlE5I0PLAHyswFbCCyW957lSZTMwNL7RXOLHQUXCgYZfqP1yBiYlu9l82
 MsG8uk5SHa4n+wHRqE7sR5UATxTy5q63MwYdbWX8ZtTgkJC0brUwEQRD/dOfMX+lafsA
 6Lnj3cKjWqk3eaDlPTXIljabH7TDeBFlru592ugUrGrnutDHpl5wd2bp/X/KXf4/YfGv
 5W2/3An59btzT92rzqy29GERysDhWs0rJqWU1ZqaK5Xnup/T4/kKGvKdqfPxpV9eT9m3
 jkmckUfty90ATeG+CYzqFjGrjFjPFo0uS95qxn/ycigRl7olyPAcrvuL19DV1+56w8Z0
 7+lw==
X-Gm-Message-State: APjAAAVXL1JxyqoKN98Nvz+XVL3WWrlk5IqnfOrBBtqbdSBs2Ejqcknd
 WaLepIB2ImJ4Isjx/oxlUdkh9Oz+
X-Google-Smtp-Source: APXvYqzjzkRkWsdkmEJArnKRTQ/9c7Y4rLTb8y9Vil6zbtoT1OUHB54512MrBgRxHGvWpNWdlMFJ0g==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr303703wro.279.1580951940799;
 Wed, 05 Feb 2020 17:19:00 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:19:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [NOTFORMERGE PATCH v2 29/30] hw/arm/bcm2836: Add the BCM2838 (ARMv8)
Date: Thu,  6 Feb 2020 02:17:55 +0100
Message-Id: <20200206011756.2413-30-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Setup the GICv2.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h |   3 +
 hw/arm/bcm2836.c         | 206 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 3d46469a73..7c1f79911c 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -13,6 +13,7 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/intc/bcm2836_control.h"
+#include "hw/intc/arm_gic.h"
 #include "target/arm/cpu.h"
 
 #define TYPE_BCM283X "bcm283x"
@@ -27,6 +28,7 @@
 #define TYPE_BCM2835 "bcm2835"
 #define TYPE_BCM2836 "bcm2836"
 #define TYPE_BCM2837 "bcm2837"
+#define TYPE_BCM2838 "bcm2838"
 
 typedef struct BCM283XState {
     /*< private >*/
@@ -39,6 +41,7 @@ typedef struct BCM283XState {
     struct {
         ARMCPU core;
     } cpu[BCM283X_NCPUS];
+    GICState gic;
     BCM2836ControlState control;
     BCM2835PeripheralState peripherals;
 } BCM283XState;
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index bce5f8a866..f09cd25caf 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -24,6 +24,7 @@ typedef struct BCM283XClass {
     int core_count;
     hwaddr peri_base; /* Peripheral base address seen by the CPU */
     hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
+    hwaddr gic_base;
     int clusterid;
 } BCM283XClass;
 
@@ -51,6 +52,11 @@ static void bcm2836_init(Object *obj)
         qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
     }
 
+    if (bc->gic_base) {
+        sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
+                              TYPE_ARM_GIC);
+    }
+
     if (bc->ctrl_base) {
         sysbus_init_child_obj(obj, "control", &s->control,
                               sizeof(s->control), TYPE_BCM2836_CONTROL);
@@ -201,6 +207,188 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     }
 }
 
+#ifdef TARGET_AARCH64
+
+#define GIC400_MAINTAINANCE_IRQ  9
+#define GIC400_TIMER_NS_EL2_IRQ 10
+#define GIC400_TIMER_VIRT_IRQ   11
+#define GIC400_LEGACY_FIQ       12
+#define GIC400_TIMER_S_EL1_IRQ  13
+#define GIC400_TIMER_NS_EL1_IRQ 14
+#define GIC400_LEGACY_IRQ       15
+
+/* Number of external interrupt lines to configure the GIC with */
+#define GIC_NUM_IRQS                128
+
+#define PPI(cpu, irq) (GIC_NUM_IRQS + (cpu) * GIC_INTERNAL + GIC_NR_SGIS + irq)
+
+#define GIC_BASE_OFS                0x0000
+#define GIC_DIST_OFS                0x1000
+#define GIC_CPU_OFS                 0x2000
+#define GIC_VIFACE_THIS_OFS         0x4000
+#define GIC_VIFACE_OTHER_OFS(cpu)  (0x5000 + (cpu) * 0x200)
+#define GIC_VCPU_OFS                0x6000
+
+#define NUM_GICV2M_SPIS       64
+
+#define VIRTUAL_PMU_IRQ 7
+
+static void bcm2838_gic_set_irq(void *opaque, int irq, int level)
+{
+    BCM283XState *s = (BCM283XState *)opaque;
+
+    printf("bcm2838_gic_set_irq irq:%d lvl:%d\n", irq, level);
+    qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->gic), irq), level);
+}
+
+static void bcm2838_realize(DeviceState *dev, Error **errp)
+{
+    BCM283XState *s = BCM283X(dev);
+    BCM283XClass *bc = BCM283X_GET_CLASS(dev);
+    Error *err = NULL;
+    int n;
+
+    bcm283x_common_realize(dev, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
+                            bc->peri_base, 1);
+
+    /* bcm2836 interrupt controller (and mailboxes, etc.) */
+    object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, bc->ctrl_base);
+
+    /* Create cores */
+    for (n = 0; n < bc->core_count; n++) {
+        /* TODO: this should be converted to a property of ARM_CPU */
+        s->cpu[n].core.mp_affinity = (bc->clusterid << 8) | n;
+
+        /* set periphbase/CBAR value for CPU-local registers */
+        object_property_set_int(OBJECT(&s->cpu[n]),
+                                bc->peri_base,
+                                "reset-cbar", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        /* start powered off if not enabled */
+        object_property_set_bool(OBJECT(&s->cpu[n]), n >= s->enabled_cpus,
+                                 "start-powered-off", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        object_property_set_bool(OBJECT(&s->cpu[n]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+
+    object_property_set_uint(OBJECT(&s->gic), 2, "revision", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_uint(OBJECT(&s->gic),
+                             BCM283X_NCPUS, "num-cpu", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_uint(OBJECT(&s->gic),
+                             GIC_NUM_IRQS + GIC_INTERNAL, "num-irq", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_bool(OBJECT(&s->gic),
+                             true, "has-virtualization-extensions", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
+                    bc->ctrl_base + bc->gic_base + GIC_DIST_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
+                    bc->ctrl_base + bc->gic_base + GIC_CPU_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
+                    bc->ctrl_base + bc->gic_base + GIC_VIFACE_THIS_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
+                    bc->ctrl_base + bc->gic_base + GIC_VCPU_OFS);
+
+    for (n = 0; n < BCM283X_NCPUS; n++) {
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 4 + n,
+                        bc->ctrl_base + bc->gic_base
+                        + GIC_VIFACE_OTHER_OFS(n));
+    }
+
+    for (n = 0; n < BCM283X_NCPUS; n++) {
+        DeviceState *cpudev = DEVICE(&s->cpu[n]);
+        DeviceState *gicdev = DEVICE(&s->gic);
+
+        /* Connect the GICv2 outputs to the CPU */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + BCM283X_NCPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 2 * BCM283X_NCPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 3 * BCM283X_NCPUS,
+                        qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 4 * BCM283X_NCPUS,
+                        qdev_get_gpio_in(gicdev,
+                                         PPI(n, GIC400_MAINTAINANCE_IRQ)));
+
+        /* Connect timers from the CPU to the interrupt controller */
+        qdev_connect_gpio_out(cpudev, GTIMER_PHYS,
+              qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_NS_EL1_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
+              qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_VIRT_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_HYP,
+              qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_NS_EL2_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_SEC,
+              qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_S_EL1_IRQ)));
+        /* PMU interrupt */
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+            qdev_get_gpio_in(gicdev, PPI(n, VIRTUAL_PMU_IRQ)));
+    }
+
+    /* Pass through inbound GPIO lines to the GIC */
+    qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
+
+    /* Pass through outbound IRQ lines from the GIC */
+    qdev_pass_gpios(DEVICE(&s->gic), DEVICE(&s->peripherals), NULL);
+
+    object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+}
+#endif /* TARGET_AARCH64 */
+
 static void bcm283x_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -246,6 +434,20 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
 };
+
+static void bcm2838_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    BCM283XClass *bc = BCM283X_CLASS(oc);
+
+    bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a72");
+    bc->core_count = BCM283X_NCPUS;
+    bc->peri_base = 0xfe000000;
+    bc->ctrl_base = 0xff800000;
+    bc->gic_base = 0x40000;
+    bc->clusterid = 0x0;
+    dc->realize = bcm2838_realize;
+};
 #endif
 
 static const TypeInfo bcm283x_types[] = {
@@ -262,6 +464,10 @@ static const TypeInfo bcm283x_types[] = {
         .name           = TYPE_BCM2837,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2837_class_init,
+    }, {
+        .name           = TYPE_BCM2838,
+        .parent         = TYPE_BCM283X,
+        .class_init     = bcm2838_class_init,
 #endif
     }, {
         .name           = TYPE_BCM283X,
-- 
2.21.1


