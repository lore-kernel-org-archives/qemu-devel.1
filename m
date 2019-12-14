Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7EDC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F1A214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 02:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="10N3/GNr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5yBGaXw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F1A214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifxRs-0005xD-Sm
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 21:46:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1ifxQ5-0004TB-QC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 21:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1ifxQ2-00017Z-Uv
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 21:44:37 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59299)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1ifxPw-0000qq-7y; Fri, 13 Dec 2019 21:44:28 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id BE2FB2243D;
 Fri, 13 Dec 2019 21:44:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Fri, 13 Dec 2019 21:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=m26QZkWz9KVnh
 sN6dgmfQqejETGJJk4nedcDJhtvacM=; b=10N3/GNrgTMyQyKsiLxpMr56YXvcL
 RDBBfPqDKddCwlxT+j02wbAZdJLWHZOrtQrMvb8hM9hbWGiwiInNL7bKwyuHh3tx
 Ck4ItYTmVN22I4r5dxG+N7aGaY0Q1N8lmYSxkj2yCwz/5kYP8HEzfZLzuthrQB2d
 gd3wmL8V7+vLicOmqRnWEYN5PYw/tiXF/ZFObq6U+07Jl0pW9J5S8Eh0yR/Xikj5
 KmW2D5X6Bna+4MN6YfUtVLrmfC5QlnjGRubVwglj5LvZ5U/t42xv717SedQX+hnF
 tukNSA4LqncAfwSl01ktifQGIyCe3uWnG+yIxS1+2pHgfirylMsPUo3tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=m26QZkWz9KVnhsN6dgmfQqejETGJJk4nedcDJhtvacM=; b=G5yBGaXw
 jK9pfoqiMoLduCMLBSFRQc3U4vWZ86Az19VdC6ROCadAgvRMg2gH0GkXq+TEpacy
 CjtqE1z5UsV29I64TARdtYvmt62qLmVYsNDwTFItofGKSUZwXLzpTNEOvBzqmR5i
 3OQ52SQomvS8d9rlAAoPyxVh8k4kbNzu93lRkrlSF+BgFk+VNNxVPnlaN/dGY5Vx
 usKlRyGSWwe88zJM8LBgJyKLz5bc49nfhUQzWVuj7+PEvGgaaehDzvQ07uuFVT/P
 cq+0Q/ktXen4fpkGbPYqbuuZO03vQdl17X+qUzAbdWLZju3Tkb6IhVRUSlvVIWIF
 sSZubzgBuLqTdA==
X-ME-Sender: <xms:i0z0XfoveIHPKtCssxclhXfVlsc1XQWE52PostS5h61ZHjUWGMRrkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddttddggeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
 ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdef
 rdhmvgenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:i0z0XZyaemTAzZGVmhqnH_JDtWr2jsmIOPNyLCrpbrlMPzJUeryOLA>
 <xmx:i0z0XToRIUZqAYAjWFtB3D3VKySsHO-lSj6-3i-ugbqiHfULVBlSqw>
 <xmx:i0z0XZcRzWvZz8MtIbOQ1Vk4O83UmE8mQGyOLkB1T9fycvR5cadDyw>
 <xmx:i0z0XbnULhAwmOP3wZgjwqy3YWatRvCFfFBtjoL9N9Utb8JJ_h81YA>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id E19FE8005A;
 Fri, 13 Dec 2019 21:44:26 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v6 3/4] hw/arm: Add the STM32F4xx SoC
Date: Fri, 13 Dec 2019 18:44:26 -0800
Message-Id: <b9f9cedf59427375deb33329df43af9ca12514b7.1576227325.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1576227325.git.alistair@alistair23.me>
References: <cover.1576227325.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.29
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
Cc: alistair23@gmail.com, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair@alistair23.me>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                    |   8 +
 hw/arm/Kconfig                 |   3 +
 hw/arm/Makefile.objs           |   1 +
 hw/arm/stm32f405_soc.c         | 302 +++++++++++++++++++++++++++++++++
 include/hw/arm/stm32f405_soc.h |  73 ++++++++
 5 files changed, 387 insertions(+)
 create mode 100644 hw/arm/stm32f405_soc.c
 create mode 100644 include/hw/arm/stm32f405_soc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e5e3e52d6..10230b3212 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -814,6 +814,14 @@ F: hw/adc/*
 F: hw/ssi/stm32f2xx_spi.c
 F: include/hw/*/stm32*.h
 
+STM32F405
+M: Alistair Francis <alistair@alistair23.me>
+M: Peter Maydell <peter.maydell@linaro.org>
+S: Maintained
+F: hw/arm/stm32f405_soc.c
+F: hw/misc/stm32f4xx_syscfg.c
+F: hw/misc/stm32f4xx_exti.c
+
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3d86691ae0..7bfdc3a7ac 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -317,6 +317,9 @@ config STM32F405_SOC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
 
+config STM32F405_SOC
+    bool
+
 config XLNX_ZYNQMP_ARM
     bool
     select AHCI
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index fe749f65fd..d9d54da7cf 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -36,6 +36,7 @@ obj-$(CONFIG_STRONGARM) += strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
+obj-$(CONFIG_STM32F405_SOC) += stm32f405_soc.o
 obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
 obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
new file mode 100644
index 0000000000..f22516fdf7
--- /dev/null
+++ b/hw/arm/stm32f405_soc.c
@@ -0,0 +1,302 @@
+/*
+ * STM32F405 SoC
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/arm/stm32f405_soc.h"
+#include "hw/misc/unimp.h"
+
+#define SYSCFG_ADD                     0x40013800
+static const uint32_t usart_addr[] = { 0x40011000, 0x40004400, 0x40004800,
+                                       0x40004C00, 0x40005000, 0x40011400,
+                                       0x40007800, 0x40007C00 };
+/* At the moment only Timer 2 to 5 are modelled */
+static const uint32_t timer_addr[] = { 0x40000000, 0x40000400,
+                                       0x40000800, 0x40000C00 };
+#define ADC_ADDR                       0x40012000
+static const uint32_t spi_addr[] =   { 0x40013000, 0x40003800, 0x40003C00,
+                                       0x40013400, 0x40015000, 0x40015400 };
+#define EXTI_ADDR                      0x40013C00
+
+#define SYSCFG_IRQ               71
+static const int usart_irq[] = { 37, 38, 39, 52, 53, 71, 82, 83 };
+static const int timer_irq[] = { 28, 29, 30, 50 };
+#define ADC_IRQ 18
+static const int spi_irq[] =   { 35, 36, 51, 0, 0, 0 };
+static const int exti_irq[] =  { 6, 7, 8, 9, 10, 23, 23, 23, 23, 23, 40,
+                                 40, 40, 40, 40, 40} ;
+
+
+static void stm32f405_soc_initfn(Object *obj)
+{
+    STM32F405State *s = STM32F405_SOC(obj);
+    int i;
+
+    sysbus_init_child_obj(obj, "armv7m", &s->armv7m, sizeof(s->armv7m),
+                          TYPE_ARMV7M);
+
+    sysbus_init_child_obj(obj, "syscfg", &s->syscfg, sizeof(s->syscfg),
+                          TYPE_STM32F4XX_SYSCFG);
+
+    for (i = 0; i < STM_NUM_USARTS; i++) {
+        sysbus_init_child_obj(obj, "usart[*]", &s->usart[i],
+                              sizeof(s->usart[i]), TYPE_STM32F2XX_USART);
+    }
+
+    for (i = 0; i < STM_NUM_TIMERS; i++) {
+        sysbus_init_child_obj(obj, "timer[*]", &s->timer[i],
+                              sizeof(s->timer[i]), TYPE_STM32F2XX_TIMER);
+    }
+
+    for (i = 0; i < STM_NUM_ADCS; i++) {
+        sysbus_init_child_obj(obj, "adc[*]", &s->adc[i], sizeof(s->adc[i]),
+                              TYPE_STM32F2XX_ADC);
+    }
+
+    for (i = 0; i < STM_NUM_SPIS; i++) {
+        sysbus_init_child_obj(obj, "spi[*]", &s->spi[i], sizeof(s->spi[i]),
+                              TYPE_STM32F2XX_SPI);
+    }
+
+    sysbus_init_child_obj(obj, "exti", &s->exti, sizeof(s->exti),
+                          TYPE_STM32F4XX_EXTI);
+}
+
+static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    STM32F405State *s = STM32F405_SOC(dev_soc);
+    MemoryRegion *system_memory = get_system_memory();
+    DeviceState *dev, *armv7m;
+    SysBusDevice *busdev;
+    Error *err = NULL;
+    int i;
+
+    memory_region_init_ram(&s->flash, NULL, "STM32F405.flash", FLASH_SIZE,
+                           &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_init_alias(&s->flash_alias, NULL, "STM32F405.flash.alias",
+                             &s->flash, 0, FLASH_SIZE);
+
+    memory_region_set_readonly(&s->flash, true);
+    memory_region_set_readonly(&s->flash_alias, true);
+
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
+    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
+
+    memory_region_init_ram(&s->sram, NULL, "STM32F405.sram", SRAM_SIZE,
+                           &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
+
+    armv7m = DEVICE(&s->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 96);
+    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    object_property_set_link(OBJECT(&s->armv7m), OBJECT(system_memory),
+                                     "memory", &error_abort);
+    object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* System configuration controller */
+    dev = DEVICE(&s->syscfg);
+    object_property_set_bool(OBJECT(&s->syscfg), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, SYSCFG_ADD);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, SYSCFG_IRQ));
+
+    /* Attach UART (uses USART registers) and USART controllers */
+    for (i = 0; i < STM_NUM_USARTS; i++) {
+        dev = DEVICE(&(s->usart[i]));
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        object_property_set_bool(OBJECT(&s->usart[i]), true, "realized", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, usart_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq[i]));
+    }
+
+    /* Timer 2 to 5 */
+    for (i = 0; i < STM_NUM_TIMERS; i++) {
+        dev = DEVICE(&(s->timer[i]));
+        qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
+        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, timer_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, timer_irq[i]));
+    }
+
+    /* ADC device, the IRQs are ORed together */
+    object_initialize_child(OBJECT(s), "adc-orirq", &s->adc_irqs,
+                            sizeof(s->adc_irqs), TYPE_OR_IRQ,
+                            &err, NULL);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
+                            "num-lines", &err);
+    object_property_set_bool(OBJECT(&s->adc_irqs), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
+                          qdev_get_gpio_in(armv7m, ADC_IRQ));
+
+    dev = DEVICE(&(s->adc[i]));
+    object_property_set_bool(OBJECT(&s->adc[i]), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, ADC_ADDR);
+    sysbus_connect_irq(busdev, 0,
+                       qdev_get_gpio_in(DEVICE(&s->adc_irqs), i));
+
+    /* SPI devices */
+    for (i = 0; i < STM_NUM_SPIS; i++) {
+        dev = DEVICE(&(s->spi[i]));
+        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized", &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, spi_addr[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, spi_irq[i]));
+    }
+
+    /* EXTI device */
+    dev = DEVICE(&s->exti);
+    object_property_set_bool(OBJECT(&s->exti), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, EXTI_ADDR);
+    for (i = 0; i < 16; i++) {
+        sysbus_connect_irq(busdev, i, qdev_get_gpio_in(armv7m, exti_irq[i]));
+    }
+    for (i = 0; i < 16; i++) {
+        qdev_connect_gpio_out(DEVICE(&s->syscfg), i, qdev_get_gpio_in(dev, i));
+    }
+
+    create_unimplemented_device("timer[7]",    0x40001400, 0x400);
+    create_unimplemented_device("timer[12]",   0x40001800, 0x400);
+    create_unimplemented_device("timer[6]",    0x40001000, 0x400);
+    create_unimplemented_device("timer[13]",   0x40001C00, 0x400);
+    create_unimplemented_device("timer[14]",   0x40002000, 0x400);
+    create_unimplemented_device("RTC and BKP", 0x40002800, 0x400);
+    create_unimplemented_device("WWDG",        0x40002C00, 0x400);
+    create_unimplemented_device("IWDG",        0x40003000, 0x400);
+    create_unimplemented_device("I2S2ext",     0x40003000, 0x400);
+    create_unimplemented_device("I2S3ext",     0x40004000, 0x400);
+    create_unimplemented_device("I2C1",        0x40005400, 0x400);
+    create_unimplemented_device("I2C2",        0x40005800, 0x400);
+    create_unimplemented_device("I2C3",        0x40005C00, 0x400);
+    create_unimplemented_device("CAN1",        0x40006400, 0x400);
+    create_unimplemented_device("CAN2",        0x40006800, 0x400);
+    create_unimplemented_device("PWR",         0x40007000, 0x400);
+    create_unimplemented_device("DAC",         0x40007400, 0x400);
+    create_unimplemented_device("timer[1]",    0x40010000, 0x400);
+    create_unimplemented_device("timer[8]",    0x40010400, 0x400);
+    create_unimplemented_device("SDIO",        0x40012C00, 0x400);
+    create_unimplemented_device("timer[9]",    0x40014000, 0x400);
+    create_unimplemented_device("timer[10]",   0x40014400, 0x400);
+    create_unimplemented_device("timer[11]",   0x40014800, 0x400);
+    create_unimplemented_device("GPIOA",       0x40020000, 0x400);
+    create_unimplemented_device("GPIOB",       0x40020400, 0x400);
+    create_unimplemented_device("GPIOC",       0x40020800, 0x400);
+    create_unimplemented_device("GPIOD",       0x40020C00, 0x400);
+    create_unimplemented_device("GPIOE",       0x40021000, 0x400);
+    create_unimplemented_device("GPIOF",       0x40021400, 0x400);
+    create_unimplemented_device("GPIOG",       0x40021800, 0x400);
+    create_unimplemented_device("GPIOH",       0x40021C00, 0x400);
+    create_unimplemented_device("GPIOI",       0x40022000, 0x400);
+    create_unimplemented_device("CRC",         0x40023000, 0x400);
+    create_unimplemented_device("RCC",         0x40023800, 0x400);
+    create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
+    create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
+    create_unimplemented_device("DMA1",        0x40026000, 0x400);
+    create_unimplemented_device("DMA2",        0x40026400, 0x400);
+    create_unimplemented_device("Ethernet",    0x40028000, 0x1400);
+    create_unimplemented_device("USB OTG HS",  0x40040000, 0x30000);
+    create_unimplemented_device("USB OTG FS",  0x50000000, 0x31000);
+    create_unimplemented_device("DCMI",        0x50050000, 0x400);
+    create_unimplemented_device("RNG",         0x50060800, 0x400);
+}
+
+static Property stm32f405_soc_properties[] = {
+    DEFINE_PROP_STRING("cpu-type", STM32F405State, cpu_type),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void stm32f405_soc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = stm32f405_soc_realize;
+    dc->props = stm32f405_soc_properties;
+    /* No vmstate or reset required: device has no internal state */
+}
+
+static const TypeInfo stm32f405_soc_info = {
+    .name          = TYPE_STM32F405_SOC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F405State),
+    .instance_init = stm32f405_soc_initfn,
+    .class_init    = stm32f405_soc_class_init,
+};
+
+static void stm32f405_soc_types(void)
+{
+    type_register_static(&stm32f405_soc_info);
+}
+
+type_init(stm32f405_soc_types)
diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.h
new file mode 100644
index 0000000000..1fe97f8c3a
--- /dev/null
+++ b/include/hw/arm/stm32f405_soc.h
@@ -0,0 +1,73 @@
+/*
+ * STM32F405 SoC
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_ARM_STM32F405_SOC_H
+#define HW_ARM_STM32F405_SOC_H
+
+#include "hw/misc/stm32f4xx_syscfg.h"
+#include "hw/timer/stm32f2xx_timer.h"
+#include "hw/char/stm32f2xx_usart.h"
+#include "hw/adc/stm32f2xx_adc.h"
+#include "hw/misc/stm32f4xx_exti.h"
+#include "hw/or-irq.h"
+#include "hw/ssi/stm32f2xx_spi.h"
+#include "hw/arm/armv7m.h"
+
+#define TYPE_STM32F405_SOC "stm32f405-soc"
+#define STM32F405_SOC(obj) \
+    OBJECT_CHECK(STM32F405State, (obj), TYPE_STM32F405_SOC)
+
+#define STM_NUM_USARTS 7
+#define STM_NUM_TIMERS 4
+#define STM_NUM_ADCS 6
+#define STM_NUM_SPIS 6
+
+#define FLASH_BASE_ADDRESS 0x08000000
+#define FLASH_SIZE (1024 * 1024)
+#define SRAM_BASE_ADDRESS 0x20000000
+#define SRAM_SIZE (192 * 1024)
+
+typedef struct STM32F405State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    char *cpu_type;
+
+    ARMv7MState armv7m;
+
+    STM32F4xxSyscfgState syscfg;
+    STM32F4xxExtiState exti;
+    STM32F2XXUsartState usart[STM_NUM_USARTS];
+    STM32F2XXTimerState timer[STM_NUM_TIMERS];
+    qemu_or_irq adc_irqs;
+    STM32F2XXADCState adc[STM_NUM_ADCS];
+    STM32F2XXSPIState spi[STM_NUM_SPIS];
+
+    MemoryRegion sram;
+    MemoryRegion flash;
+    MemoryRegion flash_alias;
+} STM32F405State;
+
+#endif
-- 
2.24.0


