Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D90AC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5E8206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdDYmJZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5E8206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igocj-0004ne-EB
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFz-00087j-NX
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFy-0000Dv-02
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:43 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:35108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFx-0000CI-O4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:41 -0500
Received: by mail-wr1-x42f.google.com with SMTP id g17so6738305wro.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uo8Ah3uFvL8+RhHBpsGXzAml5UmoCilXIxueeFhD5+Q=;
 b=GdDYmJZI03tVZlsDbsRUIztsrspnFH1I8SOYXvGi6wjp7Th5EkkgG91VsJQD8SDhxo
 F2DHw3H9ZCmDwPdk/UjSOxMKkjyWCRMBEo9rBAGy6x5O63XGCLeZJWZLNHG+eRTiGeYi
 wgSDt5WukRYBXEgKJ8JI2mjZ8dTSugVlZTPUr6BO9hSpDT7YAvH793ZEGZnVaaE0+MKp
 8KAXEKJmpdL9FwqMfcz/tx4Su8QakcgkYaPYC3sUjTMSp7d5T8u5oIfftwHoGq2lVlzT
 /RCcdeU5hVQFf2nF2Id0AXSA2vXoTGw0wrDima3zABUW6P8kRBSu+ASUU2wfBcxuOYkj
 2Xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uo8Ah3uFvL8+RhHBpsGXzAml5UmoCilXIxueeFhD5+Q=;
 b=TpbkLWs4A5bJFZNrOSb5x1eeV3A8ZoLh6kSknq1M7WO3FVWn1Oze5fBgpDflOk3/b6
 nfSMCgEMgF2EMHjSQYAj3zshGcIPTl+wUBZ6UTfk4s+KVaQv19f6Hn36MbUf3It9nUeT
 SKz8LrArGaXJtVovjW8JX+IBcQeGaOEEwElfI5bAX54U5wlvAUWYNU4MWceDvhaEae3g
 8WLfg5txZ2Vd5UntdJ/wx+zaQWmBg/B3JkkwI3FzITIIJHv3SZfUQ4alX4nQ+Kl8Nxaj
 YYqfyvjaQuyAbktY+JspuHKaBtLqQE0XS5gB0qPVGp1AhT6OcOBcnQtckH28Nj3z1ZN5
 XL6Q==
X-Gm-Message-State: APjAAAX1KvHamT715XxqYR803Lh6boyByvk75nE4YWviZ/yQREUdVYBp
 DV0uHy06uHWCIXh82pXXL3evdOPpZx6LFA==
X-Google-Smtp-Source: APXvYqx0IPC3btzcmVk57Y+/FNLHkN/UVhk5FX0KCvIOPkljIt2rXgrneZ7nd0zU46RDvwAGmf9Iag==
X-Received: by 2002:adf:eb09:: with SMTP id s9mr30682652wrn.61.1576494579277; 
 Mon, 16 Dec 2019 03:09:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/34] hw/arm/sbsa-ref: Simplify by moving the gic in the
 machine state
Date: Mon, 16 Dec 2019 11:09:00 +0000
Message-Id: <20191216110904.30815-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Message-id: 20191206162303.30338-1-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 86 +++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 44 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 27046cc284f..5853bdee5ce 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -89,6 +89,7 @@ typedef struct {
     void *fdt;
     int fdt_size;
     int psci_conduit;
+    DeviceState *gic;
     PFlashCFI01 *flash[2];
 } SBSAMachineState;
 
@@ -328,10 +329,9 @@ static void create_secure_ram(SBSAMachineState *sms,
     memory_region_add_subregion(secure_sysmem, base, secram);
 }
 
-static void create_gic(SBSAMachineState *sms, qemu_irq *pic)
+static void create_gic(SBSAMachineState *sms)
 {
     unsigned int smp_cpus = MACHINE(sms)->smp.cpus;
-    DeviceState *gicdev;
     SysBusDevice *gicbusdev;
     const char *gictype;
     uint32_t redist0_capacity, redist0_count;
@@ -339,25 +339,25 @@ static void create_gic(SBSAMachineState *sms, qemu_irq *pic)
 
     gictype = gicv3_class_name();
 
-    gicdev = qdev_create(NULL, gictype);
-    qdev_prop_set_uint32(gicdev, "revision", 3);
-    qdev_prop_set_uint32(gicdev, "num-cpu", smp_cpus);
+    sms->gic = qdev_create(NULL, gictype);
+    qdev_prop_set_uint32(sms->gic, "revision", 3);
+    qdev_prop_set_uint32(sms->gic, "num-cpu", smp_cpus);
     /*
      * Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
-    qdev_prop_set_uint32(gicdev, "num-irq", NUM_IRQS + 32);
-    qdev_prop_set_bit(gicdev, "has-security-extensions", true);
+    qdev_prop_set_uint32(sms->gic, "num-irq", NUM_IRQS + 32);
+    qdev_prop_set_bit(sms->gic, "has-security-extensions", true);
 
     redist0_capacity =
                 sbsa_ref_memmap[SBSA_GIC_REDIST].size / GICV3_REDIST_SIZE;
     redist0_count = MIN(smp_cpus, redist0_capacity);
 
-    qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
-    qdev_prop_set_uint32(gicdev, "redist-region-count[0]", redist0_count);
+    qdev_prop_set_uint32(sms->gic, "len-redist-region-count", 1);
+    qdev_prop_set_uint32(sms->gic, "redist-region-count[0]", redist0_count);
 
-    qdev_init_nofail(gicdev);
-    gicbusdev = SYS_BUS_DEVICE(gicdev);
+    qdev_init_nofail(sms->gic);
+    gicbusdev = SYS_BUS_DEVICE(sms->gic);
     sysbus_mmio_map(gicbusdev, 0, sbsa_ref_memmap[SBSA_GIC_DIST].base);
     sysbus_mmio_map(gicbusdev, 1, sbsa_ref_memmap[SBSA_GIC_REDIST].base);
 
@@ -383,15 +383,15 @@ static void create_gic(SBSAMachineState *sms, qemu_irq *pic)
 
         for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
             qdev_connect_gpio_out(cpudev, irq,
-                                  qdev_get_gpio_in(gicdev,
+                                  qdev_get_gpio_in(sms->gic,
                                                    ppibase + timer_irq[irq]));
         }
 
         qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt", 0,
-                                    qdev_get_gpio_in(gicdev, ppibase
+                                    qdev_get_gpio_in(sms->gic, ppibase
                                                      + ARCH_GIC_MAINT_IRQ));
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(gicdev, ppibase
+                                    qdev_get_gpio_in(sms->gic, ppibase
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
@@ -402,13 +402,9 @@ static void create_gic(SBSAMachineState *sms, qemu_irq *pic)
         sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
-
-    for (i = 0; i < NUM_IRQS; i++) {
-        pic[i] = qdev_get_gpio_in(gicdev, i);
-    }
 }
 
-static void create_uart(const SBSAMachineState *sms, qemu_irq *pic, int uart,
+static void create_uart(const SBSAMachineState *sms, int uart,
                         MemoryRegion *mem, Chardev *chr)
 {
     hwaddr base = sbsa_ref_memmap[uart].base;
@@ -420,15 +416,15 @@ static void create_uart(const SBSAMachineState *sms, qemu_irq *pic, int uart,
     qdev_init_nofail(dev);
     memory_region_add_subregion(mem, base,
                                 sysbus_mmio_get_region(s, 0));
-    sysbus_connect_irq(s, 0, pic[irq]);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(sms->gic, irq));
 }
 
-static void create_rtc(const SBSAMachineState *sms, qemu_irq *pic)
+static void create_rtc(const SBSAMachineState *sms)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_RTC].base;
     int irq = sbsa_ref_irqmap[SBSA_RTC];
 
-    sysbus_create_simple("pl031", base, pic[irq]);
+    sysbus_create_simple("pl031", base, qdev_get_gpio_in(sms->gic, irq));
 }
 
 static DeviceState *gpio_key_dev;
@@ -442,13 +438,14 @@ static Notifier sbsa_ref_powerdown_notifier = {
     .notify = sbsa_ref_powerdown_req
 };
 
-static void create_gpio(const SBSAMachineState *sms, qemu_irq *pic)
+static void create_gpio(const SBSAMachineState *sms)
 {
     DeviceState *pl061_dev;
     hwaddr base = sbsa_ref_memmap[SBSA_GPIO].base;
     int irq = sbsa_ref_irqmap[SBSA_GPIO];
 
-    pl061_dev = sysbus_create_simple("pl061", base, pic[irq]);
+    pl061_dev = sysbus_create_simple("pl061", base,
+                                     qdev_get_gpio_in(sms->gic, irq));
 
     gpio_key_dev = sysbus_create_simple("gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev, 3));
@@ -457,7 +454,7 @@ static void create_gpio(const SBSAMachineState *sms, qemu_irq *pic)
     qemu_register_powerdown_notifier(&sbsa_ref_powerdown_notifier);
 }
 
-static void create_ahci(const SBSAMachineState *sms, qemu_irq *pic)
+static void create_ahci(const SBSAMachineState *sms)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_AHCI].base;
     int irq = sbsa_ref_irqmap[SBSA_AHCI];
@@ -471,7 +468,7 @@ static void create_ahci(const SBSAMachineState *sms, qemu_irq *pic)
     qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irq]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
 
     sysahci = SYSBUS_AHCI(dev);
     ahci = &sysahci->ahci;
@@ -484,16 +481,16 @@ static void create_ahci(const SBSAMachineState *sms, qemu_irq *pic)
     }
 }
 
-static void create_ehci(const SBSAMachineState *sms, qemu_irq *pic)
+static void create_ehci(const SBSAMachineState *sms)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_EHCI].base;
     int irq = sbsa_ref_irqmap[SBSA_EHCI];
 
-    sysbus_create_simple("platform-ehci-usb", base, pic[irq]);
+    sysbus_create_simple("platform-ehci-usb", base,
+                         qdev_get_gpio_in(sms->gic, irq));
 }
 
-static void create_smmu(const SBSAMachineState *sms, qemu_irq *pic,
-                        PCIBus *bus)
+static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
 {
     hwaddr base = sbsa_ref_memmap[SBSA_SMMU].base;
     int irq =  sbsa_ref_irqmap[SBSA_SMMU];
@@ -507,11 +504,12 @@ static void create_smmu(const SBSAMachineState *sms, qemu_irq *pic,
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(sms->gic, irq + 1));
     }
 }
 
-static void create_pcie(SBSAMachineState *sms, qemu_irq *pic)
+static void create_pcie(SBSAMachineState *sms)
 {
     hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
     hwaddr size_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].size;
@@ -555,7 +553,8 @@ static void create_pcie(SBSAMachineState *sms, qemu_irq *pic)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
 
     for (i = 0; i < GPEX_NUM_IRQS; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pic[irq + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           qdev_get_gpio_in(sms->gic, irq + 1));
         gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
     }
 
@@ -574,7 +573,7 @@ static void create_pcie(SBSAMachineState *sms, qemu_irq *pic)
 
     pci_create_simple(pci->bus, -1, "VGA");
 
-    create_smmu(sms, pic, pci->bus);
+    create_smmu(sms, pci->bus);
 }
 
 static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
@@ -598,7 +597,6 @@ static void sbsa_ref_init(MachineState *machine)
     bool firmware_loaded;
     const CPUArchIdList *possible_cpus;
     int n, sbsa_max_cpus;
-    qemu_irq pic[NUM_IRQS];
 
     if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a57"))) {
         error_report("sbsa-ref: CPU type other than the built-in "
@@ -695,22 +693,22 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_secure_ram(sms, secure_sysmem);
 
-    create_gic(sms, pic);
+    create_gic(sms);
 
-    create_uart(sms, pic, SBSA_UART, sysmem, serial_hd(0));
-    create_uart(sms, pic, SBSA_SECURE_UART, secure_sysmem, serial_hd(1));
+    create_uart(sms, SBSA_UART, sysmem, serial_hd(0));
+    create_uart(sms, SBSA_SECURE_UART, secure_sysmem, serial_hd(1));
     /* Second secure UART for RAS and MM from EL0 */
-    create_uart(sms, pic, SBSA_SECURE_UART_MM, secure_sysmem, serial_hd(2));
+    create_uart(sms, SBSA_SECURE_UART_MM, secure_sysmem, serial_hd(2));
 
-    create_rtc(sms, pic);
+    create_rtc(sms);
 
-    create_gpio(sms, pic);
+    create_gpio(sms);
 
-    create_ahci(sms, pic);
+    create_ahci(sms);
 
-    create_ehci(sms, pic);
+    create_ehci(sms);
 
-    create_pcie(sms, pic);
+    create_pcie(sms);
 
     sms->bootinfo.ram_size = machine->ram_size;
     sms->bootinfo.nb_cpus = smp_cpus;
-- 
2.20.1


