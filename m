Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B411BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCA022280
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDzQ2ANg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCA022280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFjo-0007K5-94
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFij-00060i-Sh; Sun, 18 Oct 2020 16:56:02 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFii-0003pj-1u; Sun, 18 Oct 2020 16:56:01 -0400
Received: by mail-wm1-x343.google.com with SMTP id 13so8393568wmf.0;
 Sun, 18 Oct 2020 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xybSrKSg2KE6ujJ+C2r6JVR07E7WgYnPSHZlCpKgLHE=;
 b=gDzQ2ANgYTh98m6qjcaz1tLYnAs0XnX6uZ9MvJhD3l7iVZ8I/qOtD238/d245Qdc6U
 RW32s/pY5lT2BIsGfr0zBW3eySqthcwg/RY12lQ8n7Pii2uXNmh2t61llgS2YM+/GxBz
 hzXJPxPqyAQH25dZKzSjEU2ySRLriLjS2PtxkT3DssaIj4LmmUHuF7p+F9yynbLoT0FO
 OaRy2qTV6Ejc3XxZVWQiZjQFYwdpNGmXxIIvoBcfxiL+I9Crb6s3yEgpgdUJxbCRzbSI
 /tZrQRXklf5/fuwPOdb21sXHGvsPd5NWgdvxSpVJFXO6pg5Tq/QwJ/9yabbW9ce5jhVs
 47kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xybSrKSg2KE6ujJ+C2r6JVR07E7WgYnPSHZlCpKgLHE=;
 b=kAGtHCZmL3u7/+ejsXFtdPKD2djLB9rtI1wth7nBM5W2WcKk9+jRa4UsjwcKl3Xz00
 kXIGtb4w1ym7s5IeYIz9b0HgowaDmvK6btKFfqerpU6h6eCxq3fgTQqY/eHh/I+XcFuu
 uMaegY07q9LYD5l3XILlJRGMWMszOz4W4xRhqOjNZQbqbxmsP45FezGq1J5cJiJqqtCb
 BtMylgR92jJ9u190smaO9Sgn+BZdaH6+37g3gZTxslsy+fI0cmGrocucxviLm8Y9qkQg
 w0er8iUK6s7otZxO/tkaRmeuMacbCvKyVtaF3XJ22az6hLtirf/kdZ5ZVcci8ZRrnpjN
 OHFQ==
X-Gm-Message-State: AOAM532R/o3sTOJrn96hqCTG6Ha395G10Nsgj140m/es7N0onc6Kbq3z
 ulaLLEM5eGdVqGXrAHsY/iMnDxxXVgc=
X-Google-Smtp-Source: ABdhPJyyCnet80EvJyHgJZlJM4gIWHqH1WmLQj+Bo9Q2Yk/eJMKVIHwKpkHTgEtZhTbAKboRRHgOWA==
X-Received: by 2002:a1c:a983:: with SMTP id s125mr14851221wme.50.1603054558048; 
 Sun, 18 Oct 2020 13:55:58 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id q2sm14827420wrw.40.2020.10.18.13.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 13:55:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 1/3] hw/arm/bcm2836: Add the ARMv8 BCM2838
Date: Sun, 18 Oct 2020 22:55:49 +0200
Message-Id: <20201018205551.1537927-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201018205551.1537927-1-f4bug@amsat.org>
References: <20201018205551.1537927-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>,
 Johnny Sun <psunjohnny@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BCM2838 share the same peripheral base block from the BCM283x
family, but connects 4 Cortex-A72 cores via a GICv2.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h |   3 +
 hw/arm/bcm2836.c         | 179 +++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |   2 +
 3 files changed, 184 insertions(+)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 6f90cabfa3a..92561e96aa2 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -14,6 +14,7 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/intc/bcm2836_control.h"
+#include "hw/intc/arm_gic.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
 
@@ -29,6 +30,7 @@ OBJECT_DECLARE_TYPE(BCM283XState, BCM283XClass, BCM283X)
 #define TYPE_BCM2835 "bcm2835"
 #define TYPE_BCM2836 "bcm2836"
 #define TYPE_BCM2837 "bcm2837"
+#define TYPE_BCM2838 "bcm2838"
 
 struct BCM283XState {
     /*< private >*/
@@ -40,6 +42,7 @@ struct BCM283XState {
     struct {
         ARMCPU core;
     } cpu[BCM283X_NCPUS];
+    GICState gic;
     BCM2836ControlState control;
     BCM2835PeripheralState peripherals;
 };
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index de7ade2878e..fe795217e26 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -16,6 +16,7 @@
 #include "hw/arm/bcm2836.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
+#include "trace.h"
 
 typedef struct BCM283XClass {
     /*< private >*/
@@ -26,6 +27,7 @@ typedef struct BCM283XClass {
     unsigned core_count;
     hwaddr peri_base; /* Peripheral base address seen by the CPU */
     hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
+    hwaddr gic_base;
     int clusterid;
 } BCM283XClass;
 
@@ -52,6 +54,10 @@ static void bcm2836_init(Object *obj)
         qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
     }
 
+    if (bc->gic_base) {
+        object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
+    }
+
     if (bc->ctrl_base) {
         object_initialize_child(obj, "control", &s->control,
                                 TYPE_BCM2836_CONTROL);
@@ -170,6 +176,161 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     }
 }
 
+#ifdef TARGET_AARCH64
+
+#define GIC400_MAINTAINANCE_IRQ      9
+#define GIC400_TIMER_NS_EL2_IRQ     10
+#define GIC400_TIMER_VIRT_IRQ       11
+#define GIC400_LEGACY_FIQ           12
+#define GIC400_TIMER_S_EL1_IRQ      13
+#define GIC400_TIMER_NS_EL1_IRQ     14
+#define GIC400_LEGACY_IRQ           15
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
+#define VIRTUAL_PMU_IRQ 7
+
+static void bcm2838_gic_set_irq(void *opaque, int irq, int level)
+{
+    BCM283XState *s = (BCM283XState *)opaque;
+
+    trace_bcm2838_gic_set_irq(irq, level);
+    qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->gic), irq), level);
+}
+
+static void bcm2838_realize(DeviceState *dev, Error **errp)
+{
+    BCM283XState *s = BCM283X(dev);
+    BCM283XClass *bc = BCM283X_GET_CLASS(dev);
+    int n;
+
+    if (!bcm283x_common_realize(dev, errp)) {
+        return;
+    }
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
+                            bc->peri_base, 1);
+
+    /* bcm2836 interrupt controller (and mailboxes, etc.) */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->control), errp)) {
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
+        if (!object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
+                                     bc->peri_base, errp)) {
+            return;
+        }
+
+        /* start powered off if not enabled */
+        if (!object_property_set_bool(OBJECT(&s->cpu[n].core),
+                                      "start-powered-off",
+                                      n >= s->enabled_cpus,
+                                      errp)) {
+            return;
+        }
+
+        if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
+            return;
+        }
+    }
+
+    if (!object_property_set_uint(OBJECT(&s->gic), "revision", 2, errp)) {
+        return;
+    }
+
+    if (!object_property_set_uint(OBJECT(&s->gic), "num-cpu", BCM283X_NCPUS,
+                                  errp)) {
+        return;
+    }
+
+    if (!object_property_set_uint(OBJECT(&s->gic),
+                                  "num-irq", GIC_NUM_IRQS + GIC_INTERNAL,
+                                  errp)) {
+        return;
+    }
+
+    if (!object_property_set_bool(OBJECT(&s->gic),
+                                  "has-virtualization-extensions",
+                                  true, errp)) {
+        return;
+    }
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
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
+                        bc->ctrl_base + bc->gic_base + GIC_VIFACE_OTHER_OFS(n));
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
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 4 * BCM283X_NCPUS,
+                           qdev_get_gpio_in(gicdev,
+                                            PPI(n, GIC400_MAINTAINANCE_IRQ)));
+
+        /* Connect timers from the CPU to the interrupt controller */
+        qdev_connect_gpio_out(cpudev, GTIMER_PHYS,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_NS_EL1_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_VIRT_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_HYP,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_NS_EL2_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_SEC,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_S_EL1_IRQ)));
+        /* PMU interrupt */
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                    qdev_get_gpio_in(gicdev, PPI(n, VIRTUAL_PMU_IRQ)));
+    }
+
+    /* Pass through inbound GPIO lines to the GIC */
+    qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
+
+    /* Pass through outbound IRQ lines from the GIC */
+    qdev_pass_gpios(DEVICE(&s->gic), DEVICE(&s->peripherals), NULL);
+}
+#endif /* TARGET_AARCH64 */
+
 static void bcm283x_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -215,6 +376,20 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
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
@@ -231,6 +406,10 @@ static const TypeInfo bcm283x_types[] = {
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
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index c8a4d80f6bd..37487424b28 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -53,3 +53,5 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
+# bcm2836.c
+bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
-- 
2.26.2


