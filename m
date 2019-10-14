Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B29C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A89020854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9AQeyhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A89020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4Op-0005Dn-IJ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iK34H-0006Tc-3z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iK34F-0007Zc-0N
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:19:32 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iK34E-0007ZO-PT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:19:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id v8so20446181wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KnzwXm9DGa8updfHvfNXSEz/qG/OHlkhJSqLyJjiNdY=;
 b=V9AQeyhC0l3o2Sz99RSspTvObtz//epdo3L1D+Iq0fMMo4xqVZqzQ3PODkN2eeeyi1
 bdZH3X6/ER2k7U36KCw7BsmEXfv/uubWylmjIPBUY6/nuxytosAwXKuITyl9Zg0sGOTS
 Mhob5VhyyJMPX0iQg8XN/ANIbDR67QgEXCa/bqaO69xJQqndSW/yxDEtrRrVlRvNQ1Tj
 Oj7f26B6l927I56GifcZcFGQnHYSMRaeCC8vkJgCscN7xXCeGZg/DgCjkEAU4Q7MpDNC
 3GYaB45S0ioTdT43FjiTkDEVIZEUDtQ2eGQF3WwdVxyA2qEX6Ajr9KQ4VcCBLzXHR6QE
 ArUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KnzwXm9DGa8updfHvfNXSEz/qG/OHlkhJSqLyJjiNdY=;
 b=TGMw99tWi2nZFd7ue+G2UeRWKr7tsFGXfAK/NUM6FLJzIMPluyp61+oKtP8juZdCqm
 jfTqiF3Tjs0+xgQMyMmpQYSGnisHpyqskVAjalwAYcrSVngjNZ7EJXEOG9sMbBkDG+W6
 4sDk+7D0qmXLSjVE4igpLfTLG6dngxJ5Ph+UlKQBK0/DamlWJBOzfqEA1pymAl+R99f2
 LAS6lssiV4xe+bOLXj0EUTNZbxPoxUi/uz7syLn/5JiSqKLflhkaFiapOdJGPl0RpcLi
 AM0mpKKtHNrIHPj58TE0Y6wjz5Qkkzqv0SBEuZLVLMPG4EDZx6Xou3ErG43zYyvM3jLF
 KBYQ==
X-Gm-Message-State: APjAAAUIdmxp/Nj0fZi1Yg9GltmtZgfOOK4kYZhKejvs+fLXY705CYkr
 dkDXr3Ax9DGKVly3HPuPX3nQUsAT8WE=
X-Google-Smtp-Source: APXvYqzPX1hvRWnwVOrjYr3/58exYvLASORxwQfq1ccTZt0bUuVrg7+sMoiZLEEVrUmaaUsB1tcb7A==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr25425502wrv.168.1571069969294; 
 Mon, 14 Oct 2019 09:19:29 -0700 (PDT)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-11-117.red.bezeqint.net. [79.178.11.117])
 by smtp.gmail.com with ESMTPSA id c132sm28050861wme.27.2019.10.14.09.19.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 14 Oct 2019 09:19:28 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v32 11/13] target/avr: Add example board configuration
Date: Mon, 14 Oct 2019 19:18:41 +0300
Message-Id: <20191014161843.84845-12-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191014161843.84845-1-mrolnik@gmail.com>
References: <20191014161843.84845-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A simple board setup that configures an AVR CPU to run a given firmware image.
This is all that's useful to implement without peripheral emulation as AVR CPUs include a lot of on-board peripherals.

NOTE: this is not a real board !!!!
NOTE: it's used for CPU testing!!!!

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 hw/Kconfig           |   1 +
 hw/avr/Kconfig       |   6 +
 hw/avr/Makefile.objs |   1 +
 hw/avr/sample.c      | 282 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+)
 create mode 100644 hw/avr/Kconfig
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 hw/avr/sample.c

diff --git a/hw/Kconfig b/hw/Kconfig
index b45db3c813..f185fcb19e 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -42,6 +42,7 @@ source watchdog/Kconfig
 # arch Kconfig
 source arm/Kconfig
 source alpha/Kconfig
+source avr/Kconfig
 source cris/Kconfig
 source hppa/Kconfig
 source i386/Kconfig
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
new file mode 100644
index 0000000000..92aa1e6afb
--- /dev/null
+++ b/hw/avr/Kconfig
@@ -0,0 +1,6 @@
+config AVR_SAMPLE
+    bool
+    select AVR_TIMER16
+    select AVR_USART
+    select AVR_MASK
+    select UNIMP
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
new file mode 100644
index 0000000000..626b7064b3
--- /dev/null
+++ b/hw/avr/Makefile.objs
@@ -0,0 +1 @@
+obj-y += sample.o
diff --git a/hw/avr/sample.c b/hw/avr/sample.c
new file mode 100644
index 0000000000..2295ec1b79
--- /dev/null
+++ b/hw/avr/sample.c
@@ -0,0 +1,282 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+/*
+ *  NOTE:
+ *      This is not a real AVR board, this is an example!
+ *      The CPU is an approximation of an ATmega2560, but is missing various
+ *      built-in peripherals.
+ *
+ *      This example board loads provided binary file into flash memory and
+ *      executes it from 0x00000000 address in the code memory space.
+ *
+ *      Currently used for AVR CPU validation
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
+#include "ui/console.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "qemu/error-report.h"
+#include "exec/address-spaces.h"
+#include "include/hw/sysbus.h"
+#include "include/hw/char/avr_usart.h"
+#include "include/hw/timer/avr_timer16.h"
+#include "include/hw/misc/avr_mask.h"
+#include "elf.h"
+#include "hw/misc/unimp.h"
+
+#define SIZE_FLASH 0x00040000
+#define SIZE_SRAM 0x00002000
+/*
+ * Size of additional "external" memory, as if the AVR were configured to use
+ * an external RAM chip.
+ * Note that the configuration registers that normally enable this feature are
+ * unimplemented.
+ */
+#define SIZE_EXMEM 0x00000000
+
+/* Offsets of peripherals in emulated memory space (i.e. not host addresses)  */
+#define PRR0_BASE 0x64
+#define PRR1_BASE 0x65
+#define USART_BASE 0xc0
+#define TIMER1_BASE 0x80
+#define TIMER1_IMSK_BASE 0x6f
+#define TIMER1_IFR_BASE 0x36
+
+/* Interrupt numbers used by peripherals */
+#define USART_RXC_IRQ 24
+#define USART_DRE_IRQ 25
+#define USART_TXC_IRQ 26
+
+#define TIMER1_CAPT_IRQ 15
+#define TIMER1_COMPA_IRQ 16
+#define TIMER1_COMPB_IRQ 17
+#define TIMER1_COMPC_IRQ 18
+#define TIMER1_OVF_IRQ 19
+
+/*  Power reduction     */
+#define PRR1_BIT_PRTIM5     0x05    /*  Timer/Counter5  */
+#define PRR1_BIT_PRTIM4     0x04    /*  Timer/Counter4  */
+#define PRR1_BIT_PRTIM3     0x03    /*  Timer/Counter3  */
+#define PRR1_BIT_PRUSART3   0x02    /*  USART3  */
+#define PRR1_BIT_PRUSART2   0x01    /*  USART2  */
+#define PRR1_BIT_PRUSART1   0x00    /*  USART1  */
+
+#define PRR0_BIT_PRTWI      0x06    /*  TWI */
+#define PRR0_BIT_PRTIM2     0x05    /*  Timer/Counter2  */
+#define PRR0_BIT_PRTIM0     0x04    /*  Timer/Counter0  */
+#define PRR0_BIT_PRTIM1     0x03    /*  Timer/Counter1  */
+#define PRR0_BIT_PRSPI      0x02    /*  Serial Peripheral Interface */
+#define PRR0_BIT_PRUSART0   0x01    /*  USART0  */
+#define PRR0_BIT_PRADC      0x00    /*  ADC */
+
+typedef struct {
+    MachineClass parent;
+} SampleMachineClass;
+
+typedef struct {
+    MachineState parent;
+    MemoryRegion *ram;
+    MemoryRegion *flash;
+    AVRUsartState *usart0;
+    AVRTimer16State *timer1;
+    AVRMaskState *prr[2];
+} SampleMachineState;
+
+#define TYPE_SAMPLE_MACHINE MACHINE_TYPE_NAME("sample")
+
+#define SAMPLE_MACHINE(obj) \
+    OBJECT_CHECK(SampleMachineState, obj, TYPE_SAMPLE_MACHINE)
+#define SAMPLE_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(SampleMachineClass, obj, TYPE_SAMPLE_MACHINE)
+#define SAMPLE_MACHINE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(SampleMachineClass, klass, TYPE_SAMPLE_MACHINE)
+
+static void sample_init(MachineState *machine)
+{
+    SampleMachineState *sms = SAMPLE_MACHINE(machine);
+    MemoryRegion *system_memory = get_system_memory();
+    AVRCPU *cpu;
+    const char *firmware = NULL;
+    const char *filename;
+    int bytes_loaded;
+    SysBusDevice *busdev;
+    DeviceState *cpudev;
+
+    system_memory = get_system_memory();
+    sms->ram = g_new(MemoryRegion, 1);
+    sms->flash = g_new(MemoryRegion, 1);
+
+    cpu = AVR_CPU(cpu_create(machine->cpu_type));
+    cpudev = DEVICE(cpu);
+
+
+    memory_region_init_rom(sms->flash, NULL, "avr.flash", SIZE_FLASH,
+            &error_fatal);
+    memory_region_add_subregion(system_memory, OFFSET_CODE, sms->flash);
+
+    /* following are atmel2560 device */
+    create_unimplemented_device("usart 3", OFFSET_DATA + 0x0130, 0x0007);
+    create_unimplemented_device("timer-counter-16bit 5",
+            OFFSET_DATA + 0x0120, 0x000e);
+    create_unimplemented_device("gpio L", OFFSET_DATA + 0x0109, 0x0003);
+    create_unimplemented_device("gpio K", OFFSET_DATA + 0x0106, 0x0003);
+    create_unimplemented_device("gpio J", OFFSET_DATA + 0x0103, 0x0003);
+    create_unimplemented_device("gpio H", OFFSET_DATA + 0x0100, 0x0003);
+    create_unimplemented_device("usart 2", OFFSET_DATA + 0x00d0, 0x0007);
+    create_unimplemented_device("usart 1", OFFSET_DATA + 0x00c8, 0x0007);
+    create_unimplemented_device("usart 0", OFFSET_DATA + 0x00c0, 0x0007);
+    create_unimplemented_device("twi", OFFSET_DATA + 0x00b8, 0x0006);
+    create_unimplemented_device("timer-counter-async-8bit 2",
+            OFFSET_DATA + 0x00b0, 0x0007);
+    create_unimplemented_device("timer-counter-16bit 4",
+            OFFSET_DATA + 0x00a0, 0x000e);
+    create_unimplemented_device("timer-counter-16bit 3",
+            OFFSET_DATA + 0x0090, 0x000e);
+    create_unimplemented_device("timer-counter-16bit 1",
+            OFFSET_DATA + 0x0080, 0x000e);
+    create_unimplemented_device("ac / adc",
+            OFFSET_DATA + 0x0078, 0x0008);
+    create_unimplemented_device("ext-mem-iface",
+            OFFSET_DATA + 0x0074, 0x0002);
+    create_unimplemented_device("int-controller",
+            OFFSET_DATA + 0x0068, 0x000c);
+    create_unimplemented_device("sys",
+            OFFSET_DATA + 0x0060, 0x0007);
+    create_unimplemented_device("spi",
+            OFFSET_DATA + 0x004c, 0x0003);
+    create_unimplemented_device("ext-mem-iface",
+            OFFSET_DATA + 0x004a, 0x0002);
+    create_unimplemented_device("timer-counter-pwm-8bit 0",
+            OFFSET_DATA + 0x0043, 0x0006);
+    create_unimplemented_device("ext-mem-iface",
+            OFFSET_DATA + 0x003e, 0x0005);
+    create_unimplemented_device("int-controller",
+            OFFSET_DATA + 0x0035, 0x0009);
+    create_unimplemented_device("gpio G", OFFSET_DATA + 0x0032, 0x0003);
+    create_unimplemented_device("gpio F", OFFSET_DATA + 0x002f, 0x0003);
+    create_unimplemented_device("gpio E", OFFSET_DATA + 0x002c, 0x0003);
+    create_unimplemented_device("gpio D", OFFSET_DATA + 0x0029, 0x0003);
+    create_unimplemented_device("gpio C", OFFSET_DATA + 0x0026, 0x0003);
+    create_unimplemented_device("gpio B", OFFSET_DATA + 0x0023, 0x0003);
+    create_unimplemented_device("gpio A", OFFSET_DATA + 0x0020, 0x0003);
+
+    memory_region_allocate_system_memory(
+        sms->ram, NULL, "avr.ram", SIZE_SRAM + SIZE_EXMEM);
+    memory_region_add_subregion(system_memory, OFFSET_DATA + 0x200, sms->ram);
+
+    /* Power Reduction built-in peripheral */
+    sms->prr[0] = AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
+                    OFFSET_DATA + PRR0_BASE, NULL));
+    sms->prr[1] = AVR_MASK(sysbus_create_simple(TYPE_AVR_MASK,
+                    OFFSET_DATA + PRR1_BASE, NULL));
+
+    /* USART 0 built-in peripheral */
+    sms->usart0 = AVR_USART(object_new(TYPE_AVR_USART));
+    busdev = SYS_BUS_DEVICE(sms->usart0);
+    qdev_prop_set_chr(DEVICE(sms->usart0), "chardev", serial_hd(0));
+    object_property_set_bool(OBJECT(sms->usart0), true, "realized",
+            &error_fatal);
+    sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);
+    /*
+     * These IRQ numbers don't match the datasheet because we're counting from
+     * zero and not including reset.
+     */
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, USART_RXC_IRQ));
+    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, USART_DRE_IRQ));
+    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, USART_TXC_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[1]), PRR1_BIT_PRUSART1,
+            qdev_get_gpio_in(DEVICE(sms->usart0), 0));
+
+    /* Timer 1 built-in periphal */
+    sms->timer1 = AVR_TIMER16(object_new(TYPE_AVR_TIMER16));
+    object_property_set_bool(OBJECT(sms->timer1), true, "realized",
+            &error_fatal);
+    busdev = SYS_BUS_DEVICE(sms->timer1);
+    sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);
+    sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BASE);
+    sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BASE);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(cpudev, TIMER1_CAPT_IRQ));
+    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(cpudev, TIMER1_COMPA_IRQ));
+    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(cpudev, TIMER1_COMPB_IRQ));
+    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(cpudev, TIMER1_COMPC_IRQ));
+    sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(cpudev, TIMER1_OVF_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(sms->prr[0]), PRR0_BIT_PRTIM1,
+            qdev_get_gpio_in(DEVICE(sms->timer1), 0));
+
+    /* Load firmware (contents of flash) trying to auto-detect format */
+    firmware = machine->firmware;
+    if (firmware != NULL) {
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
+        if (filename == NULL) {
+            error_report("Unable to find %s", firmware);
+            exit(1);
+        }
+
+        bytes_loaded = load_elf(
+            filename, NULL, NULL, NULL, NULL, NULL, NULL, 0, EM_NONE, 0, 0);
+        if (bytes_loaded < 0) {
+            bytes_loaded = load_image_targphys(
+                filename, OFFSET_CODE, SIZE_FLASH);
+        }
+        if (bytes_loaded < 0) {
+            error_report(
+                "Unable to load firmware image %s as ELF or raw binary",
+                firmware);
+            exit(1);
+        }
+    }
+}
+
+static void sample_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "AVR sample/example board (ATmega2560)";
+    mc->init = sample_init;
+    mc->default_cpus = 1;
+    mc->min_cpus = mc->default_cpus;
+    mc->max_cpus = mc->default_cpus;
+    mc->default_cpu_type = "avr6-avr-cpu"; /* ATmega2560. */
+    mc->is_default = 1;
+}
+
+static const TypeInfo sample_info = {
+    .name = TYPE_SAMPLE_MACHINE,
+    .parent = TYPE_MACHINE,
+    .instance_size = sizeof(SampleMachineState),
+    .class_size = sizeof(SampleMachineClass),
+    .class_init = sample_class_init,
+};
+
+static void sample_machine_init(void)
+{
+    type_register_static(&sample_info);
+}
+
+type_init(sample_machine_init);
-- 
2.17.2 (Apple Git-113)


