Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E83BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CC2206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUE3wTae"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CC2206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibtdQ-00084U-Hz
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 16:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxj-0002kA-Rl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxg-0000mN-8Q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:31 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33689)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ibsxY-0000YO-Ji; Mon, 02 Dec 2019 16:10:22 -0500
Received: by mail-wm1-x342.google.com with SMTP id y23so780786wma.0;
 Mon, 02 Dec 2019 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vNPnXm90420wfmia3L0ifKw7OOjXJ8KY6gwGS45HUo8=;
 b=jUE3wTae+CEXqBH+qobldNTykiKtKaI5y024fUALUm85+MBqeKaWT8wYx7isud0qlO
 ZG7n7o7ce3Kv+YtVH46HXLo1lIPR42HlGeihxjRQfzQ/S5ISAPpwtYO/dYFLPpaFfCKg
 4xLjVJ4DAxaVYI+QxqBc71XJkTACs57pawYNnayTBycco/8R3uB6c32URRV+0mxh1BY5
 Ljtmc6yy4aAzF07ZXBIaSo4XcFOWtgyuu4ndOunZ0etsfpio+yS6lrSuznf5dUIL1uRi
 OIWfxLmbV1i/DKljVEhqlqA2lH6nDqaGZCJoSHb/XixqSI7KPtsGJvl5ZdnmyZlFYE6O
 cawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vNPnXm90420wfmia3L0ifKw7OOjXJ8KY6gwGS45HUo8=;
 b=bU5Ghv34ozKgj1FBhdt7ZK1rr04uu9CUlqmu7ORhoBMA9LdXR7cxO3TW1A7V8MqKi7
 kDn9MLGWwiTmvd+Wk8G+IfmI40wQwB+177Gfd+v0wADkIyIX1ODx+zmRFz7GMuN12Gx8
 xEN6rwupgsFQVvMVfelbqfWBVuRhW28wFeNFayNQ6LU8OJwItZ0+vGsJbB1HYEG1Ib0r
 iOEqhbB7ViUYKFGxEgKSkYAYl1N3JcD05c5s+JjukWfoCzabqx/1zIslUQcgTz9zkcAc
 9jTlHJv/m8JMoBkZfNFzjBe9ynzdthijBTUvYrRnU4jePEoBimEHwcFcmVIa45LrRopS
 gxpQ==
X-Gm-Message-State: APjAAAVDvVxUWWBioggDQSbmQ+IqccJeR2HjxBeOPoBefZ7eaNcRtHV9
 c1o63W2BYsPwm0t4yq2J81freb38
X-Google-Smtp-Source: APXvYqxeBoOb/sPHDEPYgUAT813SkyzEU6elzQvDLZAJpyE+HN96qGj+sGLy4QLAEmUNclTPbBDOCw==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr29848373wma.72.1575320997882; 
 Mon, 02 Dec 2019 13:09:57 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id f1sm770859wrp.93.2019.12.02.13.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 13:09:56 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/10] hw: arm: add Allwinner H3 System-on-Chip
Date: Mon,  2 Dec 2019 22:09:38 +0100
Message-Id: <20191202210947.3603-2-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202210947.3603-1-nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
X-Mailman-Approved-At: Mon, 02 Dec 2019 16:38:23 -0500
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Allwinner H3 is a System on Chip containing four ARM Cortex A7
processor cores. Features and specifications include DDR2/DDR3 memory,
SD/MMC storage cards, 10/100/1000Mbit ethernet, USB 2.0, HDMI and
various I/O modules. This commit adds support for the Allwinner H3
System on Chip.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 MAINTAINERS                     |   7 ++
 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Kconfig                  |   8 ++
 hw/arm/Makefile.objs            |   1 +
 hw/arm/allwinner-h3.c           | 215 ++++++++++++++++++++++++++++++++
 include/hw/arm/allwinner-h3.h   | 118 ++++++++++++++++++
 6 files changed, 350 insertions(+)
 create mode 100644 hw/arm/allwinner-h3.c
 create mode 100644 include/hw/arm/allwinner-h3.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e3e52d6..29c9936037 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -479,6 +479,13 @@ F: hw/*/allwinner*
 F: include/hw/*/allwinner*
 F: hw/arm/cubieboard.c
 
+Allwinner-h3
+M: Niek Linnenbank <nieklinnenbank@gmail.com>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/*/allwinner-h3*
+F: include/hw/*/allwinner-h3*
+
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 1f2e0e7fde..d75a239c2c 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -40,3 +40,4 @@ CONFIG_FSL_IMX25=y
 CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
 CONFIG_SEMIHOSTING=y
+CONFIG_ALLWINNER_H3=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c6e7782580..ebf8d2325f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -291,6 +291,14 @@ config ALLWINNER_A10
     select SERIAL
     select UNIMP
 
+config ALLWINNER_H3
+    bool
+    select ALLWINNER_A10_PIT
+    select SERIAL
+    select ARM_TIMER
+    select ARM_GIC
+    select UNIMP
+
 config RASPI
     bool
     select FRAMEBUFFER
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index fe749f65fd..956e496052 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -34,6 +34,7 @@ obj-$(CONFIG_DIGIC) += digic.o
 obj-$(CONFIG_OMAP) += omap1.o omap2.o
 obj-$(CONFIG_STRONGARM) += strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
+obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
 obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
new file mode 100644
index 0000000000..470fdfebef
--- /dev/null
+++ b/hw/arm/allwinner-h3.c
@@ -0,0 +1,215 @@
+/*
+ * Allwinner H3 System on Chip emulation
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
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "cpu.h"
+#include "hw/sysbus.h"
+#include "hw/arm/allwinner-h3.h"
+#include "hw/misc/unimp.h"
+#include "sysemu/sysemu.h"
+
+static void aw_h3_init(Object *obj)
+{
+    AwH3State *s = AW_H3(obj);
+
+    sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
+                          TYPE_ARM_GIC);
+
+    sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
+                          TYPE_AW_A10_PIT);
+}
+
+static void aw_h3_realize(DeviceState *dev, Error **errp)
+{
+    AwH3State *s = AW_H3(dev);
+    SysBusDevice *sysbusdev = NULL;
+    Error *err = NULL;
+    unsigned i = 0;
+
+    /* CPUs */
+    for (i = 0; i < AW_H3_NUM_CPUS; i++) {
+        Object *cpuobj = object_new(ARM_CPU_TYPE_NAME("cortex-a7"));
+        CPUState *cpustate = CPU(cpuobj);
+
+        /* Set the proper CPU index */
+        cpustate->cpu_index = i;
+
+        /* Provide Power State Coordination Interface */
+        object_property_set_int(cpuobj, QEMU_PSCI_CONDUIT_HVC,
+                                "psci-conduit", &error_abort);
+
+        /* Disable secondary CPUs */
+        object_property_set_bool(cpuobj, i > 0, "start-powered-off", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+
+        /* All exception levels required */
+        object_property_set_bool(cpuobj,
+                                 true, "has_el3", NULL);
+        object_property_set_bool(cpuobj,
+                                 true, "has_el2", NULL);
+
+        /* Mark realized */
+        object_property_set_bool(cpuobj, true, "realized", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+        object_unref(cpuobj);
+    }
+
+    /* Generic Interrupt Controller */
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", AW_H3_GIC_NUM_SPI +
+                                                     GIC_INTERNAL);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", AW_H3_NUM_CPUS);
+    qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", false);
+    qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions", true);
+
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    sysbusdev = SYS_BUS_DEVICE(&s->gic);
+    sysbus_mmio_map(sysbusdev, 0, AW_H3_GIC_DIST_BASE);
+    sysbus_mmio_map(sysbusdev, 1, AW_H3_GIC_CPU_BASE);
+    sysbus_mmio_map(sysbusdev, 2, AW_H3_GIC_HYP_BASE);
+    sysbus_mmio_map(sysbusdev, 3, AW_H3_GIC_VCPU_BASE);
+
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv3
+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
+     */
+    for (i = 0; i < AW_H3_NUM_CPUS; i++) {
+        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
+        int ppibase = AW_H3_GIC_NUM_SPI + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int irq;
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs used for this board.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = AW_H3_GIC_PPI_ARM_PHYSTIMER,
+            [GTIMER_VIRT] = AW_H3_GIC_PPI_ARM_VIRTTIMER,
+            [GTIMER_HYP]  = AW_H3_GIC_PPI_ARM_HYPTIMER,
+            [GTIMER_SEC]  = AW_H3_GIC_PPI_ARM_SECTIMER,
+        };
+
+        /* Connect CPU timer outputs to GIC PPI inputs */
+        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                                  qdev_get_gpio_in(DEVICE(&s->gic),
+                                                   ppibase + timer_irq[irq]));
+        }
+
+        /* Connect GIC outputs to CPU interrupt inputs */
+        sysbus_connect_irq(sysbusdev, i,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(sysbusdev, i + AW_H3_NUM_CPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(sysbusdev, i + (2 * AW_H3_NUM_CPUS),
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(sysbusdev, i + (3 * AW_H3_NUM_CPUS),
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        /* GIC maintenance signal */
+        sysbus_connect_irq(sysbusdev, i + (4 * AW_H3_NUM_CPUS),
+                           qdev_get_gpio_in(DEVICE(&s->gic),
+                                            ppibase + AW_H3_GIC_PPI_MAINT));
+    }
+
+    for (i = 0; i < AW_H3_GIC_NUM_SPI; i++) {
+        s->irq[i] = qdev_get_gpio_in(DEVICE(&s->gic), i);
+    }
+
+    /* Timer */
+    object_property_set_bool(OBJECT(&s->timer), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbusdev = SYS_BUS_DEVICE(&s->timer);
+    sysbus_mmio_map(sysbusdev, 0, AW_H3_PIT_REG_BASE);
+    sysbus_connect_irq(sysbusdev, 0, s->irq[AW_H3_GIC_SPI_TIMER0]);
+    sysbus_connect_irq(sysbusdev, 1, s->irq[AW_H3_GIC_SPI_TIMER1]);
+
+    /* SRAM */
+    memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
+                            AW_H3_SRAM_A1_SIZE, &error_fatal);
+    memory_region_init_ram(&s->sram_a2, OBJECT(dev), "sram A2",
+                            AW_H3_SRAM_A2_SIZE, &error_fatal);
+    memory_region_init_ram(&s->sram_c, OBJECT(dev), "sram C",
+                            AW_H3_SRAM_C_SIZE, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_A1_BASE,
+                                &s->sram_a1);
+    memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_A2_BASE,
+                                &s->sram_a2);
+    memory_region_add_subregion(get_system_memory(), AW_H3_SRAM_C_BASE,
+                                &s->sram_c);
+
+    /* UART */
+    if (serial_hd(0)) {
+        serial_mm_init(get_system_memory(), AW_H3_UART0_REG_BASE, 2,
+                       s->irq[AW_H3_GIC_SPI_UART0], 115200, serial_hd(0),
+                       DEVICE_NATIVE_ENDIAN);
+    }
+
+    /* Unimplemented devices */
+    create_unimplemented_device("display-engine", AW_H3_DE_BASE, AW_H3_DE_SIZE);
+    create_unimplemented_device("dma", AW_H3_DMA_BASE, AW_H3_DMA_SIZE);
+    create_unimplemented_device("lcd0", AW_H3_LCD0_BASE, AW_H3_LCD0_SIZE);
+    create_unimplemented_device("lcd1", AW_H3_LCD1_BASE, AW_H3_LCD1_SIZE);
+    create_unimplemented_device("gpu", AW_H3_GPU_BASE, AW_H3_GPU_SIZE);
+    create_unimplemented_device("hdmi", AW_H3_HDMI_BASE, AW_H3_HDMI_SIZE);
+    create_unimplemented_device("rtc", AW_H3_RTC_BASE, AW_H3_RTC_SIZE);
+    create_unimplemented_device("audio-codec", AW_H3_AC_BASE, AW_H3_AC_SIZE);
+}
+
+static void aw_h3_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = aw_h3_realize;
+    /* Reason: uses serial_hds and nd_table */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo aw_h3_type_info = {
+    .name = TYPE_AW_H3,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(AwH3State),
+    .instance_init = aw_h3_init,
+    .class_init = aw_h3_class_init,
+};
+
+static void aw_h3_register_types(void)
+{
+    type_register_static(&aw_h3_type_info);
+}
+
+type_init(aw_h3_register_types)
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
new file mode 100644
index 0000000000..af368c2254
--- /dev/null
+++ b/include/hw/arm/allwinner-h3.h
@@ -0,0 +1,118 @@
+/*
+ * Allwinner H3 System on Chip emulation
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
+#ifndef HW_ARM_ALLWINNER_H3_H
+#define HW_ARM_ALLWINNER_H3_H
+
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "hw/char/serial.h"
+#include "hw/arm/boot.h"
+#include "hw/timer/allwinner-a10-pit.h"
+#include "hw/intc/arm_gic.h"
+#include "target/arm/cpu.h"
+
+#define AW_H3_SRAM_A1_BASE     (0x00000000)
+#define AW_H3_SRAM_A2_BASE     (0x00044000)
+#define AW_H3_SRAM_C_BASE      (0x00010000)
+#define AW_H3_DE_BASE          (0x01000000)
+#define AW_H3_SYSCON_BASE      (0x01c00000)
+#define AW_H3_DMA_BASE         (0x01c02000)
+#define AW_H3_LCD0_BASE        (0x01c0c000)
+#define AW_H3_LCD1_BASE        (0x01c0d000)
+#define AW_H3_SID_BASE         (0x01c14000)
+#define AW_H3_CCU_BASE         (0x01c20000)
+#define AW_H3_PIC_REG_BASE     (0x01c20400)
+#define AW_H3_PIT_REG_BASE     (0x01c20c00)
+#define AW_H3_AC_BASE          (0x01c22c00)
+#define AW_H3_UART0_REG_BASE   (0x01c28000)
+#define AW_H3_EMAC_BASE        (0x01c30000)
+#define AW_H3_MMC0_BASE        (0x01c0f000)
+#define AW_H3_EHCI0_BASE       (0x01c1a000)
+#define AW_H3_OHCI0_BASE       (0x01c1a400)
+#define AW_H3_EHCI1_BASE       (0x01c1b000)
+#define AW_H3_OHCI1_BASE       (0x01c1b400)
+#define AW_H3_EHCI2_BASE       (0x01c1c000)
+#define AW_H3_OHCI2_BASE       (0x01c1c400)
+#define AW_H3_EHCI3_BASE       (0x01c1d000)
+#define AW_H3_OHCI3_BASE       (0x01c1d400)
+#define AW_H3_GPU_BASE         (0x01c40000)
+#define AW_H3_GIC_DIST_BASE    (0x01c81000)
+#define AW_H3_GIC_CPU_BASE     (0x01c82000)
+#define AW_H3_GIC_HYP_BASE     (0x01c84000)
+#define AW_H3_GIC_VCPU_BASE    (0x01c86000)
+#define AW_H3_HDMI_BASE        (0x01ee0000)
+#define AW_H3_RTC_BASE         (0x01f00000)
+#define AW_H3_CPUCFG_BASE      (0x01f01c00)
+#define AW_H3_SDRAM_BASE       (0x40000000)
+
+#define AW_H3_SRAM_A1_SIZE     (64 * KiB)
+#define AW_H3_SRAM_A2_SIZE     (32 * KiB)
+#define AW_H3_SRAM_C_SIZE      (44 * KiB)
+#define AW_H3_DE_SIZE          (4 * MiB)
+#define AW_H3_DMA_SIZE         (4 * KiB)
+#define AW_H3_LCD0_SIZE        (4 * KiB)
+#define AW_H3_LCD1_SIZE        (4 * KiB)
+#define AW_H3_GPU_SIZE         (64 * KiB)
+#define AW_H3_HDMI_SIZE        (128 * KiB)
+#define AW_H3_RTC_SIZE         (1 * KiB)
+#define AW_H3_AC_SIZE          (2 * KiB)
+
+#define AW_H3_GIC_PPI_MAINT          (9)
+#define AW_H3_GIC_PPI_ARM_HYPTIMER  (10)
+#define AW_H3_GIC_PPI_ARM_VIRTTIMER (11)
+#define AW_H3_GIC_PPI_ARM_SECTIMER  (13)
+#define AW_H3_GIC_PPI_ARM_PHYSTIMER (14)
+
+#define AW_H3_GIC_SPI_UART0         (0)
+#define AW_H3_GIC_SPI_TIMER0        (18)
+#define AW_H3_GIC_SPI_TIMER1        (19)
+#define AW_H3_GIC_SPI_MMC0          (60)
+#define AW_H3_GIC_SPI_MMC1          (61)
+#define AW_H3_GIC_SPI_MMC2          (62)
+#define AW_H3_GIC_SPI_EHCI0         (72)
+#define AW_H3_GIC_SPI_OHCI0         (73)
+#define AW_H3_GIC_SPI_EHCI1         (74)
+#define AW_H3_GIC_SPI_OHCI1         (75)
+#define AW_H3_GIC_SPI_EHCI2         (76)
+#define AW_H3_GIC_SPI_OHCI2         (77)
+#define AW_H3_GIC_SPI_EHCI3         (78)
+#define AW_H3_GIC_SPI_OHCI3         (79)
+#define AW_H3_GIC_SPI_EMAC          (82)
+
+#define AW_H3_GIC_NUM_SPI           (128)
+#define AW_H3_NUM_CPUS              (4)
+
+#define TYPE_AW_H3 "allwinner-h3"
+#define AW_H3(obj) OBJECT_CHECK(AwH3State, (obj), TYPE_AW_H3)
+
+typedef struct AwH3State {
+    /*< private >*/
+    DeviceState parent_obj;
+    /*< public >*/
+
+    qemu_irq irq[AW_H3_GIC_NUM_SPI];
+    AwA10PITState timer;
+    GICState gic;
+    MemoryRegion sram_a1;
+    MemoryRegion sram_a2;
+    MemoryRegion sram_c;
+} AwH3State;
+
+#endif
-- 
2.17.1


