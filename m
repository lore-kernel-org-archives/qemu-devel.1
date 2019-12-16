Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69621C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24698206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaTHXOzJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24698206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igooO-0005JE-9P
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoG2-0008CY-Fa
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoG0-0000HS-7X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:46 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFz-0000FL-VN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id p17so6239148wmb.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7nY5MqSyOV50wVoDXR+NSInZ+hJVrBD1WXiJuwo9v6M=;
 b=DaTHXOzJumC0+IcAuAXHHzc5YR2JvQ03z29muaqEuFIMMa4XAvO1cvek2isbIiTI+M
 r2yFUcqmpR5E1BkuxeU2wS6cDI3RSHQ89DlK7+YwsLvw4uplmBitxZOirj4QlYCBkA67
 /Pb7pOD/0rZK8GjCChA/hLJP7sZVsU7llUynA7tueQ67B9S5679nL2T5oF/7R8sCuBBS
 ZY/O6Fi9OBNdFkK/wlNw20Es4eRaPx9ELtltj86NGuft2h89AhvGeVr5S1hDVKGEdKUA
 d/ydaWseicgKVzsIoMcTJ6DwBFieqXGGNiQZWRo9/dcyOQAA3CpNclfCkQEHaXszptwx
 h+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7nY5MqSyOV50wVoDXR+NSInZ+hJVrBD1WXiJuwo9v6M=;
 b=YChoOQy5FMrIH50VN5lXHJnQOeo97foF8l+4kZu+FKKT3vKt9Jji0mLKrJ2o0V9wfk
 anGZrbuggXdfIYpeYOq2fZxGYEEBG2wjmMy9EwoLKMxlRf25aMmJuaF4FXSli2R5u5tz
 BsOQx01yUOrqKIoZTN0SRNTP8+3lxS+QOPbeO68iBLukmuVYrJei5XhLip87ddzV1CMV
 K1SNyALdeWZjgVGdgaxs+0UCutsA7bnjU5Gq/ibBlav30MxSX8+ACsksa+SY9cd/wzk5
 8+F8RXl/Xy3llYJLZeVfwousEgvbybNW6y2A2KVTL1z1QlUF6n7sfQt9jLBK71LOJShE
 +9xg==
X-Gm-Message-State: APjAAAX7Z/uNCV2+Wq2/bsjjbh6Pz8X6oQHmUnuq5LVlgYlI5eMYFeaN
 vJIXNSFUyxaukQvYGQxpqaTsPF9R7TuSQw==
X-Google-Smtp-Source: APXvYqxTSC0TlX65wQsLhVwQMJp5QkI8blFtiHBoodqWTa/QNmBJbdipasDkt95igfFK/D6UK96vsw==
X-Received: by 2002:a1c:a795:: with SMTP id q143mr28405617wme.52.1576494582509; 
 Mon, 16 Dec 2019 03:09:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/34] hw/arm/virt: Simplify by moving the gic in the machine
 state
Date: Mon, 16 Dec 2019 11:09:03 +0000
Message-Id: <20191216110904.30815-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Make the gic a field in the machine state, and instead of filling
an array of qemu_irq and passing it around, directly call
qdev_get_gpio_in() on the gic field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20191209090306.20433-1-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |   1 +
 hw/arm/virt.c         | 109 +++++++++++++++++++++---------------------
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 0b41083e9d5..38f0c33c77c 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -136,6 +136,7 @@ typedef struct {
     uint32_t iommu_phandle;
     int psci_conduit;
     hwaddr highest_gpa;
+    DeviceState *gic;
     DeviceState *acpi_dev;
     Notifier powerdown_notifier;
 } VirtMachineState;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bf4b1cbfb86..6f2a45d1b4c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -531,7 +531,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
     }
 }
 
-static inline DeviceState *create_acpi_ged(VirtMachineState *vms, qemu_irq *pic)
+static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 {
     DeviceState *dev;
     MachineState *ms = MACHINE(vms);
@@ -547,14 +547,14 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms, qemu_irq *pic)
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_ACPI_GED].base);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, vms->memmap[VIRT_PCDIMM_ACPI].base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
 
     qdev_init_nofail(dev);
 
     return dev;
 }
 
-static void create_its(VirtMachineState *vms, DeviceState *gicdev)
+static void create_its(VirtMachineState *vms)
 {
     const char *itsclass = its_class_name();
     DeviceState *dev;
@@ -566,7 +566,7 @@ static void create_its(VirtMachineState *vms, DeviceState *gicdev)
 
     dev = qdev_create(NULL, itsclass);
 
-    object_property_set_link(OBJECT(dev), OBJECT(gicdev), "parent-gicv3",
+    object_property_set_link(OBJECT(dev), OBJECT(vms->gic), "parent-gicv3",
                              &error_abort);
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
@@ -574,7 +574,7 @@ static void create_its(VirtMachineState *vms, DeviceState *gicdev)
     fdt_add_its_gic_node(vms);
 }
 
-static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
+static void create_v2m(VirtMachineState *vms)
 {
     int i;
     int irq = vms->irqmap[VIRT_GIC_V2M];
@@ -587,17 +587,17 @@ static void create_v2m(VirtMachineState *vms, qemu_irq *pic)
     qdev_init_nofail(dev);
 
     for (i = 0; i < NUM_GICV2M_SPIS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic, irq + i));
     }
 
     fdt_add_v2m_gic_node(vms);
 }
 
-static void create_gic(VirtMachineState *vms, qemu_irq *pic)
+static void create_gic(VirtMachineState *vms)
 {
     MachineState *ms = MACHINE(vms);
     /* We create a standalone GIC */
-    DeviceState *gicdev;
     SysBusDevice *gicbusdev;
     const char *gictype;
     int type = vms->gic_version, i;
@@ -606,15 +606,15 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 
     gictype = (type == 3) ? gicv3_class_name() : gic_class_name();
 
-    gicdev = qdev_create(NULL, gictype);
-    qdev_prop_set_uint32(gicdev, "revision", type);
-    qdev_prop_set_uint32(gicdev, "num-cpu", smp_cpus);
+    vms->gic = qdev_create(NULL, gictype);
+    qdev_prop_set_uint32(vms->gic, "revision", type);
+    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
     /* Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
-    qdev_prop_set_uint32(gicdev, "num-irq", NUM_IRQS + 32);
+    qdev_prop_set_uint32(vms->gic, "num-irq", NUM_IRQS + 32);
     if (!kvm_irqchip_in_kernel()) {
-        qdev_prop_set_bit(gicdev, "has-security-extensions", vms->secure);
+        qdev_prop_set_bit(vms->gic, "has-security-extensions", vms->secure);
     }
 
     if (type == 3) {
@@ -624,25 +624,25 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 
         nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
-        qdev_prop_set_uint32(gicdev, "len-redist-region-count",
+        qdev_prop_set_uint32(vms->gic, "len-redist-region-count",
                              nb_redist_regions);
-        qdev_prop_set_uint32(gicdev, "redist-region-count[0]", redist0_count);
+        qdev_prop_set_uint32(vms->gic, "redist-region-count[0]", redist0_count);
 
         if (nb_redist_regions == 2) {
             uint32_t redist1_capacity =
                     vms->memmap[VIRT_HIGH_GIC_REDIST2].size / GICV3_REDIST_SIZE;
 
-            qdev_prop_set_uint32(gicdev, "redist-region-count[1]",
+            qdev_prop_set_uint32(vms->gic, "redist-region-count[1]",
                 MIN(smp_cpus - redist0_count, redist1_capacity));
         }
     } else {
         if (!kvm_irqchip_in_kernel()) {
-            qdev_prop_set_bit(gicdev, "has-virtualization-extensions",
+            qdev_prop_set_bit(vms->gic, "has-virtualization-extensions",
                               vms->virt);
         }
     }
-    qdev_init_nofail(gicdev);
-    gicbusdev = SYS_BUS_DEVICE(gicdev);
+    qdev_init_nofail(vms->gic);
+    gicbusdev = SYS_BUS_DEVICE(vms->gic);
     sysbus_mmio_map(gicbusdev, 0, vms->memmap[VIRT_GIC_DIST].base);
     if (type == 3) {
         sysbus_mmio_map(gicbusdev, 1, vms->memmap[VIRT_GIC_REDIST].base);
@@ -678,23 +678,23 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
 
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
             qdev_connect_gpio_out(cpudev, irq,
-                                  qdev_get_gpio_in(gicdev,
+                                  qdev_get_gpio_in(vms->gic,
                                                    ppibase + timer_irq[irq]));
         }
 
         if (type == 3) {
-            qemu_irq irq = qdev_get_gpio_in(gicdev,
+            qemu_irq irq = qdev_get_gpio_in(vms->gic,
                                             ppibase + ARCH_GIC_MAINT_IRQ);
             qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
                                         0, irq);
         } else if (vms->virt) {
-            qemu_irq irq = qdev_get_gpio_in(gicdev,
+            qemu_irq irq = qdev_get_gpio_in(vms->gic,
                                             ppibase + ARCH_GIC_MAINT_IRQ);
             sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
         }
 
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(gicdev, ppibase
+                                    qdev_get_gpio_in(vms->gic, ppibase
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
@@ -706,20 +706,16 @@ static void create_gic(VirtMachineState *vms, qemu_irq *pic)
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
 
-    for (i = 0; i < NUM_IRQS; i++) {
-        pic[i] = qdev_get_gpio_in(gicdev, i);
-    }
-
     fdt_add_gic_node(vms);
 
     if (type == 3 && vms->its) {
-        create_its(vms, gicdev);
+        create_its(vms);
     } else if (type == 2) {
-        create_v2m(vms, pic);
+        create_v2m(vms);
     }
 }
 
-static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
+static void create_uart(const VirtMachineState *vms, int uart,
                         MemoryRegion *mem, Chardev *chr)
 {
     char *nodename;
@@ -735,7 +731,7 @@ static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
     qdev_init_nofail(dev);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
-    sysbus_connect_irq(s, 0, pic[irq]);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
 
     nodename = g_strdup_printf("/pl011@%" PRIx64, base);
     qemu_fdt_add_subnode(vms->fdt, nodename);
@@ -767,7 +763,7 @@ static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
     g_free(nodename);
 }
 
-static void create_rtc(const VirtMachineState *vms, qemu_irq *pic)
+static void create_rtc(const VirtMachineState *vms)
 {
     char *nodename;
     hwaddr base = vms->memmap[VIRT_RTC].base;
@@ -775,7 +771,7 @@ static void create_rtc(const VirtMachineState *vms, qemu_irq *pic)
     int irq = vms->irqmap[VIRT_RTC];
     const char compat[] = "arm,pl031\0arm,primecell";
 
-    sysbus_create_simple("pl031", base, pic[irq]);
+    sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq));
 
     nodename = g_strdup_printf("/pl031@%" PRIx64, base);
     qemu_fdt_add_subnode(vms->fdt, nodename);
@@ -803,7 +799,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
     }
 }
 
-static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
+static void create_gpio(const VirtMachineState *vms)
 {
     char *nodename;
     DeviceState *pl061_dev;
@@ -812,7 +808,8 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
     int irq = vms->irqmap[VIRT_GPIO];
     const char compat[] = "arm,pl061\0arm,primecell";
 
-    pl061_dev = sysbus_create_simple("pl061", base, pic[irq]);
+    pl061_dev = sysbus_create_simple("pl061", base,
+                                     qdev_get_gpio_in(vms->gic, irq));
 
     uint32_t phandle = qemu_fdt_alloc_phandle(vms->fdt);
     nodename = g_strdup_printf("/pl061@%" PRIx64, base);
@@ -846,7 +843,7 @@ static void create_gpio(const VirtMachineState *vms, qemu_irq *pic)
     g_free(nodename);
 }
 
-static void create_virtio_devices(const VirtMachineState *vms, qemu_irq *pic)
+static void create_virtio_devices(const VirtMachineState *vms)
 {
     int i;
     hwaddr size = vms->memmap[VIRT_MMIO].size;
@@ -882,7 +879,8 @@ static void create_virtio_devices(const VirtMachineState *vms, qemu_irq *pic)
         int irq = vms->irqmap[VIRT_MMIO] + i;
         hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
 
-        sysbus_create_simple("virtio-mmio", base, pic[irq]);
+        sysbus_create_simple("virtio-mmio", base,
+                             qdev_get_gpio_in(vms->gic, irq));
     }
 
     /* We add dtb nodes in reverse order so that they appear in the finished
@@ -1131,7 +1129,7 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
                            0x7           /* PCI irq */);
 }
 
-static void create_smmu(const VirtMachineState *vms, qemu_irq *pic,
+static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
     char *node;
@@ -1154,7 +1152,8 @@ static void create_smmu(const VirtMachineState *vms, qemu_irq *pic,
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic, irq + i));
     }
 
     node = g_strdup_printf("/smmuv3@%" PRIx64, base);
@@ -1181,7 +1180,7 @@ static void create_smmu(const VirtMachineState *vms, qemu_irq *pic,
     g_free(node);
 }
 
-static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
+static void create_pcie(VirtMachineState *vms)
 {
     hwaddr base_mmio = vms->memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = vms->memmap[VIRT_PCIE_MMIO].size;
@@ -1241,7 +1240,8 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
 
     for (i = 0; i < GPEX_NUM_IRQS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(vms->gic, irq + i));
         gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
     }
 
@@ -1301,7 +1301,7 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
     if (vms->iommu) {
         vms->iommu_phandle = qemu_fdt_alloc_phandle(vms->fdt);
 
-        create_smmu(vms, pic, pci->bus);
+        create_smmu(vms, pci->bus);
 
         qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
                                0x0, vms->iommu_phandle, 0x0, 0x10000);
@@ -1310,7 +1310,7 @@ static void create_pcie(VirtMachineState *vms, qemu_irq *pic)
     g_free(nodename);
 }
 
-static void create_platform_bus(VirtMachineState *vms, qemu_irq *pic)
+static void create_platform_bus(VirtMachineState *vms)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -1326,8 +1326,8 @@ static void create_platform_bus(VirtMachineState *vms, qemu_irq *pic)
 
     s = SYS_BUS_DEVICE(dev);
     for (i = 0; i < PLATFORM_BUS_NUM_IRQS; i++) {
-        int irqn = vms->irqmap[VIRT_PLATFORM_BUS] + i;
-        sysbus_connect_irq(s, i, pic[irqn]);
+        int irq = vms->irqmap[VIRT_PLATFORM_BUS] + i;
+        sysbus_connect_irq(s, i, qdev_get_gpio_in(vms->gic, irq));
     }
 
     memory_region_add_subregion(sysmem,
@@ -1509,7 +1509,6 @@ static void machvirt_init(MachineState *machine)
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(machine);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *possible_cpus;
-    qemu_irq pic[NUM_IRQS];
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
     int n, virt_max_cpus;
@@ -1712,27 +1711,27 @@ static void machvirt_init(MachineState *machine)
 
     virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
-    create_gic(vms, pic);
+    create_gic(vms);
 
     fdt_add_pmu_nodes(vms);
 
-    create_uart(vms, pic, VIRT_UART, sysmem, serial_hd(0));
+    create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
 
     if (vms->secure) {
         create_secure_ram(vms, secure_sysmem);
-        create_uart(vms, pic, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
+        create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
     }
 
     vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
 
-    create_rtc(vms, pic);
+    create_rtc(vms);
 
-    create_pcie(vms, pic);
+    create_pcie(vms);
 
     if (has_ged && aarch64 && firmware_loaded && acpi_enabled) {
-        vms->acpi_dev = create_acpi_ged(vms, pic);
+        vms->acpi_dev = create_acpi_ged(vms);
     } else {
-        create_gpio(vms, pic);
+        create_gpio(vms);
     }
 
      /* connect powerdown request */
@@ -1743,12 +1742,12 @@ static void machvirt_init(MachineState *machine)
      * (which will be automatically plugged in to the transports). If
      * no backend is created the transport will just sit harmlessly idle.
      */
-    create_virtio_devices(vms, pic);
+    create_virtio_devices(vms);
 
     vms->fw_cfg = create_fw_cfg(vms, &address_space_memory);
     rom_set_fw(vms->fw_cfg);
 
-    create_platform_bus(vms, pic);
+    create_platform_bus(vms);
 
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.nb_cpus = smp_cpus;
-- 
2.20.1


