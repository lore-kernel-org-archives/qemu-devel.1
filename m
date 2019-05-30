Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C74C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 19:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1CB2608D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 19:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGsttYYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1CB2608D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWQTN-0001Sq-5b
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 15:12:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hWQPB-0006V1-35
	for qemu-devel@nongnu.org; Thu, 30 May 2019 15:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hWQP9-0007EH-FL
	for qemu-devel@nongnu.org; Thu, 30 May 2019 15:08:01 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hWQP9-0007Dj-8S
	for qemu-devel@nongnu.org; Thu, 30 May 2019 15:07:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id d17so4600204wmb.3
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=eFr6DMxrFEb/0pHkWce3K9IKLH6aRk1AfZWOrhPs13w=;
	b=JGsttYYLJRo5k9osx+7AgvlygJcrRzXpGLrgBDuKDICXZsV9Hv5qT2pGxFYdhRdx8h
	5NV5SB0Ny3a9EnZOUBafYhD020cug6m0Cm1mJVgteoaoMtClcsLerddYJFmFiB9YF5xe
	E+jFxLKQMJjctvgfBaIKXH67Ff3SH92o+E9zZ3a7tMvQnJRCf0OErQr22gRnWc92xeAU
	jqJpI14RBHX4G4w/LzqIb5xIldrwNX/X0/MkAx4g0H38/ICenAvp5WVNfB92tQgXkGTR
	sNttFuVgXLecsCL91wpUG3XYgEcw9x/yR+K9sTg+ovICbQCvPBM3hagmjF19hesYmXq/
	d7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=eFr6DMxrFEb/0pHkWce3K9IKLH6aRk1AfZWOrhPs13w=;
	b=ozy3LrSnv39a3dEhzBOqs/Ka0JwyBL1jzDnEu0DuBu3aWTW5ORdW0eEPizHUtDyWmv
	X5ZWQQdY7D1cTPe4Z3rHxy5I+YWidgW1xobOTx+JJ61v0DUG/XpQTPFN06YNdN63NGzu
	+J9OG2m5pwCoeccy1td9SHbFShe/Kng1MQtg3t5D6SGnJyxx7W6OGdrVF6iLmm/cCgYG
	sZ7qU7WJinFb/h1K5m6hqIT6o4zmC5OF1mAy4HKcAvBrcmlgRtdXhkGQw6iXYquwpPBh
	u4+EoPNAv2I4hqnS/dxz0LFfvhmsIPes+PF+VhKrlvR7W9It2XxJ8ue0b4yq1lelH2/m
	QweQ==
X-Gm-Message-State: APjAAAWJisQ9kTa3EA6s5VbaMXCcygsxMcO7ApOCyS4HDjBG78975XfS
	AVy4Ydr8VcpMMHMsM2TKt9DROr6CIGg=
X-Google-Smtp-Source: APXvYqwYmzhgfOnJjfPZOiDlWvefY9MeQoOiAqQIp6BfLhPzj/8LZpFfW+EBh7j5j4PwXPB3kVPs1Q==
X-Received: by 2002:a1c:f111:: with SMTP id p17mr3258661wmh.62.1559243277793; 
	Thu, 30 May 2019 12:07:57 -0700 (PDT)
Received: from localhost.localdomain (bzq-109-65-68-81.red.bezeqint.net.
	[109.65.68.81])
	by smtp.gmail.com with ESMTPSA id u9sm8711230wme.48.2019.05.30.12.07.56
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 12:07:57 -0700 (PDT)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 22:07:37 +0300
Message-Id: <20190530190738.22713-8-mrolnik@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190530190738.22713-1-mrolnik@gmail.com>
References: <20190530190738.22713-1-mrolnik@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH RFC v20 7/8] target/avr: Add example board
 configuration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sarah Harris <S.E.Harris@kent.ac.uk>

A simple board setup that configures an AVR CPU to run a given firmware image.
This is all that's useful to implement without peripheral emulation as AVR CPUs include a lot of on-board peripherals.

Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
---
 hw/Kconfig           |   1 +
 hw/avr/Kconfig       |   4 +
 hw/avr/Makefile.objs |   1 +
 hw/avr/sample.c      | 177 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 183 insertions(+)
 create mode 100644 hw/avr/Kconfig
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 hw/avr/sample.c

diff --git a/hw/Kconfig b/hw/Kconfig
index 195f541e50..1f25636855 100644
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
index 0000000000..c6ca8fe775
--- /dev/null
+++ b/hw/avr/Kconfig
@@ -0,0 +1,4 @@
+config AVR_SAMPLE
+    bool
+    select AVR_TIMER16
+    select AVR_USART
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
new file mode 100644
index 0000000000..626b7064b3
--- /dev/null
+++ b/hw/avr/Makefile.objs
@@ -0,0 +1 @@
+obj-y += sample.o
diff --git a/hw/avr/sample.c b/hw/avr/sample.c
new file mode 100644
index 0000000000..21b384b3b3
--- /dev/null
+++ b/hw/avr/sample.c
@@ -0,0 +1,177 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
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
+#include "elf.h"
+
+#define SIZE_FLASH 0x00040000
+#define SIZE_SRAM 0x00002200
+/*
+ * Size of additional "external" memory, as if the AVR were configured to use
+ * an external RAM chip.
+ * Note that the configuration registers that normally enable this feature are
+ * unimplemented.
+ */
+#define SIZE_EXMEM 0x00000000
+
+/* Offsets of periphals in emulated memory space (i.e. not host addresses)  */
+#define PRR0 0x64
+#define PRR1 0x65
+#define USART_BASE 0xc0
+#define USART_PRR PRR0
+#define USART_PRR_MASK 0b00000010
+#define TIMER1_BASE 0x80
+#define TIMER1_IMSK_BASE 0x6f
+#define TIMER1_IFR_BASE 0x36
+#define TIMER1_PRR PRR0
+#define TIMER1_PRR_MASK 0b01000000
+
+/* Interrupt numbers used by peripherals */
+#define TIMER1_CAPT_IRQ 15
+#define TIMER1_COMPA_IRQ 16
+#define TIMER1_COMPB_IRQ 17
+#define TIMER1_COMPC_IRQ 18
+#define TIMER1_OVF_IRQ 19
+
+static void sample_init(MachineState *machine)
+{
+    MemoryRegion *address_space_mem;
+    MemoryRegion *ram;
+    MemoryRegion *flash;
+    AVRCPU *cpu_avr;
+    const char *firmware = NULL;
+    const char *filename;
+    int bytes_loaded;
+    AVRUsartState *usart0;
+    AVRTimer16State *timer1;
+    SysBusDevice *busdev;
+
+    address_space_mem = get_system_memory();
+    ram = g_new(MemoryRegion, 1);
+    flash = g_new(MemoryRegion, 1);
+
+    /* ATmega2560. */
+    cpu_avr = AVR_CPU(cpu_create("avr6-avr"));
+
+    memory_region_allocate_system_memory(
+        ram, NULL, "avr.ram", SIZE_SRAM + SIZE_EXMEM);
+    memory_region_add_subregion(address_space_mem, OFFSET_DATA, ram);
+
+    memory_region_init_rom(flash, NULL, "avr.flash", SIZE_FLASH, &error_fatal);
+    memory_region_add_subregion(address_space_mem, OFFSET_CODE, flash);
+
+    /* USART 0 built-in peripheral */
+    usart0 = AVR_USART(object_new(TYPE_AVR_USART));
+    busdev = SYS_BUS_DEVICE(usart0);
+    sysbus_mmio_map(busdev, 0, OFFSET_DATA + USART_BASE);
+    /*
+     * These IRQ numbers don't match the datasheet because we're counting from
+     * zero and not including reset.
+     */
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(cpu_avr), 24));
+    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(DEVICE(cpu_avr), 25));
+    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(DEVICE(cpu_avr), 26));
+    usart0->prr_address = OFFSET_DATA + PRR0;
+    usart0->prr_mask = USART_PRR_MASK;
+    qdev_prop_set_chr(DEVICE(usart0), "chardev", serial_hd(0));
+    object_property_set_bool(OBJECT(usart0), true, "realized", &error_fatal);
+
+    /* Timer 1 built-in periphal */
+    timer1 = AVR_TIMER16(object_new(TYPE_AVR_TIMER16));
+    busdev = SYS_BUS_DEVICE(timer1);
+    sysbus_mmio_map(busdev, 0, OFFSET_DATA + TIMER1_BASE);
+    sysbus_mmio_map(busdev, 1, OFFSET_DATA + TIMER1_IMSK_BASE);
+    sysbus_mmio_map(busdev, 2, OFFSET_DATA + TIMER1_IFR_BASE);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(
+        DEVICE(cpu_avr), TIMER1_CAPT_IRQ));
+    sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(
+        DEVICE(cpu_avr), TIMER1_COMPA_IRQ));
+    sysbus_connect_irq(busdev, 2, qdev_get_gpio_in(
+        DEVICE(cpu_avr), TIMER1_COMPB_IRQ));
+    sysbus_connect_irq(busdev, 3, qdev_get_gpio_in(
+        DEVICE(cpu_avr), TIMER1_COMPC_IRQ));
+    sysbus_connect_irq(busdev, 4, qdev_get_gpio_in(
+        DEVICE(cpu_avr), TIMER1_OVF_IRQ));
+    timer1->prr_address = OFFSET_DATA + TIMER1_PRR;
+    timer1->prr_mask = TIMER1_PRR_MASK;
+    object_property_set_bool(OBJECT(timer1), true, "realized", &error_fatal);
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
+            error_report(
+                "Unable to load %s as ELF, trying again as raw binary",
+                firmware);
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
+static void sample_machine_init(MachineClass *mc)
+{
+    mc->desc = "AVR sample/example board";
+    mc->init = sample_init;
+    mc->is_default = 1;
+}
+
+DEFINE_MACHINE("sample", sample_machine_init)
-- 
2.18.0


