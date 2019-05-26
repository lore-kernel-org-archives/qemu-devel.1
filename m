Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF53C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:53:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4412075E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4412075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49525 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiLo-00089o-J6
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:53:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxV-0003Hg-6g
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhfn-0005jv-Dm
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhfn-0005jM-5g
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so5307276pfd.2
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=ShT6p9ZehnPe/9Skhaq4MZxb578jO9dlO2C7Voqa/IU=;
	b=sKAX18HCWNVu1I5fSinMteVkR1nAELZ4UDmvPw67zfgTTUep40ldXDX+SBjO5l9U6O
	T0sOgJxKQsexuHrgWCYlLZueRDGaHvhqlwGF3137QlfFIXHUvKJv4DWbqzvacJaxH+y4
	SB+zDRxAPLFd5q0zcVrCC9tKVwIwEix+xKL9ntG+Jl7pjCujcbbNwcqxfGTIrBmc71Uo
	D9yei2ViudvYiaTMD+4HMcjzHZsQfilbr2UKnNe8JatKNjlOx9PTpkkYJhGPKN80ePeM
	XZ2+UKv1R7nrmzVbI+P9ZP5W16/f8Y8QSEFuIh/cTO20HkpkODvezHY/pDVNehYlLEfa
	QuLA==
X-Gm-Message-State: APjAAAUvJcChjqu5BucB8t2DwtVmjQvEUCNf28Pm/cDOAN4pJj2HD1Fm
	kZCIdx4e0qhNQN9QmruCjEh+Hw==
X-Google-Smtp-Source: APXvYqzPpIesQ7dBdooqF2wpjEpce4HnqS2k2syIwgeMB5JcjgSu5fkrqJWHiLQaQRW6xHP0C91UPw==
X-Received: by 2002:a63:1e62:: with SMTP id p34mr29942832pgm.49.1558833001733; 
	Sat, 25 May 2019 18:10:01 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	p16sm8760442pfq.153.2019.05.25.18.10.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:01 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:20 -0700
Message-Id: <20190526010948.3923-2-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.196
Subject: [Qemu-devel] [PULL 01/29] SiFive RISC-V GPIO Device
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
Cc: Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org, Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fabien Chouteau <chouteau@adacore.com>

QEMU model of the GPIO device on the SiFive E300 series SOCs.

The pins are not used by a board definition yet, however this
implementation can already be used to trigger GPIO interrupts from the
software by configuring a pin as both output and input.

Signed-off-by: Fabien Chouteau <chouteau@adacore.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 Makefile.objs                  |   1 +
 hw/riscv/Makefile.objs         |   1 +
 hw/riscv/sifive_e.c            |  28 ++-
 hw/riscv/sifive_gpio.c         | 388 +++++++++++++++++++++++++++++++++
 hw/riscv/trace-events          |   7 +
 include/hw/riscv/sifive_e.h    |   8 +-
 include/hw/riscv/sifive_gpio.h |  72 ++++++
 7 files changed, 501 insertions(+), 4 deletions(-)
 create mode 100644 hw/riscv/sifive_gpio.c
 create mode 100644 hw/riscv/trace-events
 create mode 100644 include/hw/riscv/sifive_gpio.h

diff --git a/Makefile.objs b/Makefile.objs
index d7491413c1c1..b61568ad0610 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -182,6 +182,7 @@ trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/watchdog
 trace-events-subdirs += hw/xen
 trace-events-subdirs += hw/gpio
+trace-events-subdirs += hw/riscv
 trace-events-subdirs += migration
 trace-events-subdirs += net
 trace-events-subdirs += ui
diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index 79bfb3abf90a..a65027304a2c 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -2,6 +2,7 @@ obj-$(CONFIG_SPIKE) += riscv_htif.o
 obj-$(CONFIG_HART) += riscv_hart.o
 obj-$(CONFIG_SIFIVE_E) += sifive_e.o
 obj-$(CONFIG_SIFIVE) += sifive_clint.o
+obj-$(CONFIG_SIFIVE) += sifive_gpio.o
 obj-$(CONFIG_SIFIVE) += sifive_prci.o
 obj-$(CONFIG_SIFIVE) += sifive_plic.o
 obj-$(CONFIG_SIFIVE) += sifive_test.o
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index b1cd11363c93..80ac56fa7d5e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -146,11 +146,15 @@ static void riscv_sifive_e_soc_init(Object *obj)
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpus), smp_cpus, "num-harts",
                             &error_abort);
+    sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0",
+                          &s->gpio, sizeof(s->gpio),
+                          TYPE_SIFIVE_GPIO);
 }
 
 static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
 {
     const struct MemmapEntry *memmap = sifive_e_memmap;
+    Error *err = NULL;
 
     SiFiveESoCState *s = RISCV_E_SOC(dev);
     MemoryRegion *sys_mem = get_system_memory();
@@ -184,8 +188,28 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
         memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
     sifive_prci_create(memmap[SIFIVE_E_PRCI].base);
-    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.gpio0",
-        memmap[SIFIVE_E_GPIO0].base, memmap[SIFIVE_E_GPIO0].size);
+
+    /* GPIO */
+
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* Map GPIO registers */
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, memmap[SIFIVE_E_GPIO0].base);
+
+    /* Pass all GPIOs to the SOC layer so they are available to the board */
+    qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
+
+    /* Connect GPIO interrupts to the PLIC */
+    for (int i = 0; i < 32; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), i,
+                           qdev_get_gpio_in(DEVICE(s->plic),
+                                            SIFIVE_E_GPIO0_IRQ0 + i));
+    }
+
     sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART0_IRQ));
     sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi0",
diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
new file mode 100644
index 000000000000..06bd8112d7e7
--- /dev/null
+++ b/hw/riscv/sifive_gpio.c
@@ -0,0 +1,388 @@
+/*
+ * sifive System-on-Chip general purpose input/output register definition
+ *
+ * Copyright 2019 AdaCore
+ *
+ * Base on nrf51_gpio.c:
+ *
+ * Copyright 2018 Steffen Görtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/riscv/sifive_gpio.h"
+#include "trace.h"
+
+static void update_output_irq(SIFIVEGPIOState *s)
+{
+
+    uint32_t pending;
+    uint32_t pin;
+
+    pending = s->high_ip & s->high_ie;
+    pending |= s->low_ip & s->low_ie;
+    pending |= s->rise_ip & s->rise_ie;
+    pending |= s->fall_ip & s->fall_ie;
+
+    for (int i = 0; i < SIFIVE_GPIO_PINS; i++) {
+        pin = 1 << i;
+        qemu_set_irq(s->irq[i], (pending & pin) != 0);
+        trace_sifive_gpio_update_output_irq(i, (pending & pin) != 0);
+    }
+}
+
+static void update_state(SIFIVEGPIOState *s)
+{
+    size_t i;
+    bool prev_ival, in, in_mask, port, out_xor, pull, output_en, input_en,
+        rise_ip, fall_ip, low_ip, high_ip, oval, actual_value, ival;
+
+    for (i = 0; i < SIFIVE_GPIO_PINS; i++) {
+
+        prev_ival = extract32(s->value, i, 1);
+        in        = extract32(s->in, i, 1);
+        in_mask   = extract32(s->in_mask, i, 1);
+        port      = extract32(s->port, i, 1);
+        out_xor   = extract32(s->out_xor, i, 1);
+        pull      = extract32(s->pue, i, 1);
+        output_en = extract32(s->output_en, i, 1);
+        input_en  = extract32(s->input_en, i, 1);
+        rise_ip   = extract32(s->rise_ip, i, 1);
+        fall_ip   = extract32(s->fall_ip, i, 1);
+        low_ip    = extract32(s->low_ip, i, 1);
+        high_ip   = extract32(s->high_ip, i, 1);
+
+        /* Output value (IOF not supported) */
+        oval = output_en && (port ^ out_xor);
+
+        /* Pin both driven externally and internally */
+        if (output_en && in_mask) {
+            qemu_log_mask(LOG_GUEST_ERROR, "GPIO pin %zu short circuited\n", i);
+        }
+
+        if (in_mask) {
+            /* The pin is driven by external device */
+            actual_value = in;
+        } else if (output_en) {
+            /* The pin is driven by internal circuit */
+            actual_value = oval;
+        } else {
+            /* Floating? Apply pull-up resistor */
+            actual_value = pull;
+        }
+
+        qemu_set_irq(s->output[i], actual_value);
+
+        /* Input value */
+        ival = input_en && actual_value;
+
+        /* Interrupts */
+        high_ip = high_ip || ival;
+        s->high_ip = deposit32(s->high_ip, i, 1, high_ip);
+
+        low_ip = low_ip || !ival;
+        s->low_ip = deposit32(s->low_ip,  i, 1, low_ip);
+
+        rise_ip = rise_ip || (ival && !prev_ival);
+        s->rise_ip = deposit32(s->rise_ip, i, 1, rise_ip);
+
+        fall_ip = fall_ip || (!ival && prev_ival);
+        s->fall_ip = deposit32(s->fall_ip, i, 1, fall_ip);
+
+        /* Update value */
+        s->value = deposit32(s->value, i, 1, ival);
+    }
+    update_output_irq(s);
+}
+
+static uint64_t sifive_gpio_read(void *opaque, hwaddr offset, unsigned int size)
+{
+    SIFIVEGPIOState *s = SIFIVE_GPIO(opaque);
+    uint64_t r = 0;
+
+    switch (offset) {
+    case SIFIVE_GPIO_REG_VALUE:
+        r = s->value;
+        break;
+
+    case SIFIVE_GPIO_REG_INPUT_EN:
+        r = s->input_en;
+        break;
+
+    case SIFIVE_GPIO_REG_OUTPUT_EN:
+        r = s->output_en;
+        break;
+
+    case SIFIVE_GPIO_REG_PORT:
+        r = s->port;
+        break;
+
+    case SIFIVE_GPIO_REG_PUE:
+        r = s->pue;
+        break;
+
+    case SIFIVE_GPIO_REG_DS:
+        r = s->ds;
+        break;
+
+    case SIFIVE_GPIO_REG_RISE_IE:
+        r = s->rise_ie;
+        break;
+
+    case SIFIVE_GPIO_REG_RISE_IP:
+        r = s->rise_ip;
+        break;
+
+    case SIFIVE_GPIO_REG_FALL_IE:
+        r = s->fall_ie;
+        break;
+
+    case SIFIVE_GPIO_REG_FALL_IP:
+        r = s->fall_ip;
+        break;
+
+    case SIFIVE_GPIO_REG_HIGH_IE:
+        r = s->high_ie;
+        break;
+
+    case SIFIVE_GPIO_REG_HIGH_IP:
+        r = s->high_ip;
+        break;
+
+    case SIFIVE_GPIO_REG_LOW_IE:
+        r = s->low_ie;
+        break;
+
+    case SIFIVE_GPIO_REG_LOW_IP:
+        r = s->low_ip;
+        break;
+
+    case SIFIVE_GPIO_REG_IOF_EN:
+        r = s->iof_en;
+        break;
+
+    case SIFIVE_GPIO_REG_IOF_SEL:
+        r = s->iof_sel;
+        break;
+
+    case SIFIVE_GPIO_REG_OUT_XOR:
+        r = s->out_xor;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: bad read offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    trace_sifive_gpio_read(offset, r);
+
+    return r;
+}
+
+static void sifive_gpio_write(void *opaque, hwaddr offset,
+                       uint64_t value, unsigned int size)
+{
+    SIFIVEGPIOState *s = SIFIVE_GPIO(opaque);
+
+    trace_sifive_gpio_write(offset, value);
+
+    switch (offset) {
+
+    case SIFIVE_GPIO_REG_INPUT_EN:
+        s->input_en = value;
+        break;
+
+    case SIFIVE_GPIO_REG_OUTPUT_EN:
+        s->output_en = value;
+        break;
+
+    case SIFIVE_GPIO_REG_PORT:
+        s->port = value;
+        break;
+
+    case SIFIVE_GPIO_REG_PUE:
+        s->pue = value;
+        break;
+
+    case SIFIVE_GPIO_REG_DS:
+        s->ds = value;
+        break;
+
+    case SIFIVE_GPIO_REG_RISE_IE:
+        s->rise_ie = value;
+        break;
+
+    case SIFIVE_GPIO_REG_RISE_IP:
+         /* Write 1 to clear */
+        s->rise_ip &= ~value;
+        break;
+
+    case SIFIVE_GPIO_REG_FALL_IE:
+        s->fall_ie = value;
+        break;
+
+    case SIFIVE_GPIO_REG_FALL_IP:
+         /* Write 1 to clear */
+        s->fall_ip &= ~value;
+        break;
+
+    case SIFIVE_GPIO_REG_HIGH_IE:
+        s->high_ie = value;
+        break;
+
+    case SIFIVE_GPIO_REG_HIGH_IP:
+         /* Write 1 to clear */
+        s->high_ip &= ~value;
+        break;
+
+    case SIFIVE_GPIO_REG_LOW_IE:
+        s->low_ie = value;
+        break;
+
+    case SIFIVE_GPIO_REG_LOW_IP:
+         /* Write 1 to clear */
+        s->low_ip &= ~value;
+        break;
+
+    case SIFIVE_GPIO_REG_IOF_EN:
+        s->iof_en = value;
+        break;
+
+    case SIFIVE_GPIO_REG_IOF_SEL:
+        s->iof_sel = value;
+        break;
+
+    case SIFIVE_GPIO_REG_OUT_XOR:
+        s->out_xor = value;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: bad write offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+    }
+
+    update_state(s);
+}
+
+static const MemoryRegionOps gpio_ops = {
+    .read =  sifive_gpio_read,
+    .write = sifive_gpio_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
+static void sifive_gpio_set(void *opaque, int line, int value)
+{
+    SIFIVEGPIOState *s = SIFIVE_GPIO(opaque);
+
+    trace_sifive_gpio_set(line, value);
+
+    assert(line >= 0 && line < SIFIVE_GPIO_PINS);
+
+    s->in_mask = deposit32(s->in_mask, line, 1, value >= 0);
+    if (value >= 0) {
+        s->in = deposit32(s->in, line, 1, value != 0);
+    }
+
+    update_state(s);
+}
+
+static void sifive_gpio_reset(DeviceState *dev)
+{
+    SIFIVEGPIOState *s = SIFIVE_GPIO(dev);
+
+    s->value = 0;
+    s->input_en = 0;
+    s->output_en = 0;
+    s->port = 0;
+    s->pue = 0;
+    s->ds = 0;
+    s->rise_ie = 0;
+    s->rise_ip = 0;
+    s->fall_ie = 0;
+    s->fall_ip = 0;
+    s->high_ie = 0;
+    s->high_ip = 0;
+    s->low_ie = 0;
+    s->low_ip = 0;
+    s->iof_en = 0;
+    s->iof_sel = 0;
+    s->out_xor = 0;
+    s->in = 0;
+    s->in_mask = 0;
+
+}
+
+static const VMStateDescription vmstate_sifive_gpio = {
+    .name = TYPE_SIFIVE_GPIO,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(value,     SIFIVEGPIOState),
+        VMSTATE_UINT32(input_en,  SIFIVEGPIOState),
+        VMSTATE_UINT32(output_en, SIFIVEGPIOState),
+        VMSTATE_UINT32(port,      SIFIVEGPIOState),
+        VMSTATE_UINT32(pue,       SIFIVEGPIOState),
+        VMSTATE_UINT32(rise_ie,   SIFIVEGPIOState),
+        VMSTATE_UINT32(rise_ip,   SIFIVEGPIOState),
+        VMSTATE_UINT32(fall_ie,   SIFIVEGPIOState),
+        VMSTATE_UINT32(fall_ip,   SIFIVEGPIOState),
+        VMSTATE_UINT32(high_ie,   SIFIVEGPIOState),
+        VMSTATE_UINT32(high_ip,   SIFIVEGPIOState),
+        VMSTATE_UINT32(low_ie,    SIFIVEGPIOState),
+        VMSTATE_UINT32(low_ip,    SIFIVEGPIOState),
+        VMSTATE_UINT32(iof_en,    SIFIVEGPIOState),
+        VMSTATE_UINT32(iof_sel,   SIFIVEGPIOState),
+        VMSTATE_UINT32(out_xor,   SIFIVEGPIOState),
+        VMSTATE_UINT32(in, SIFIVEGPIOState),
+        VMSTATE_UINT32(in_mask, SIFIVEGPIOState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void sifive_gpio_init(Object *obj)
+{
+    SIFIVEGPIOState *s = SIFIVE_GPIO(obj);
+
+    memory_region_init_io(&s->mmio, obj, &gpio_ops, s,
+            TYPE_SIFIVE_GPIO, SIFIVE_GPIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+
+    for (int i = 0; i < SIFIVE_GPIO_PINS; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
+    }
+
+    qdev_init_gpio_in(DEVICE(s), sifive_gpio_set, SIFIVE_GPIO_PINS);
+    qdev_init_gpio_out(DEVICE(s), s->output, SIFIVE_GPIO_PINS);
+}
+
+static void sifive_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_sifive_gpio;
+    dc->reset = sifive_gpio_reset;
+    dc->desc = "sifive GPIO";
+}
+
+static const TypeInfo sifive_gpio_info = {
+    .name = TYPE_SIFIVE_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SIFIVEGPIOState),
+    .instance_init = sifive_gpio_init,
+    .class_init = sifive_gpio_class_init
+};
+
+static void sifive_gpio_register_types(void)
+{
+    type_register_static(&sifive_gpio_info);
+}
+
+type_init(sifive_gpio_register_types)
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
new file mode 100644
index 000000000000..6d59233e23d2
--- /dev/null
+++ b/hw/riscv/trace-events
@@ -0,0 +1,7 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# hw/gpio/sifive_gpio.c
+sifive_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value 0x%" PRIx64
+sifive_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
+sifive_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
+sifive_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index f715f8606fa6..3b14eb74621f 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -19,6 +19,8 @@
 #ifndef HW_SIFIVE_E_H
 #define HW_SIFIVE_E_H
 
+#include "hw/riscv/sifive_gpio.h"
+
 #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
 #define RISCV_E_SOC(obj) \
     OBJECT_CHECK(SiFiveESoCState, (obj), TYPE_RISCV_E_SOC)
@@ -30,6 +32,7 @@ typedef struct SiFiveESoCState {
     /*< public >*/
     RISCVHartArrayState cpus;
     DeviceState *plic;
+    SIFIVEGPIOState gpio;
 } SiFiveESoCState;
 
 typedef struct SiFiveEState {
@@ -63,8 +66,9 @@ enum {
 };
 
 enum {
-    SIFIVE_E_UART0_IRQ = 3,
-    SIFIVE_E_UART1_IRQ = 4
+    SIFIVE_E_UART0_IRQ  = 3,
+    SIFIVE_E_UART1_IRQ  = 4,
+    SIFIVE_E_GPIO0_IRQ0 = 8
 };
 
 #define SIFIVE_E_PLIC_HART_CONFIG "M"
diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/riscv/sifive_gpio.h
new file mode 100644
index 000000000000..fce03d6c410e
--- /dev/null
+++ b/include/hw/riscv/sifive_gpio.h
@@ -0,0 +1,72 @@
+/*
+ * sifive System-on-Chip general purpose input/output register definition
+ *
+ * Copyright 2019 AdaCore
+ *
+ * Base on nrf51_gpio.c:
+ *
+ * Copyright 2018 Steffen Görtz <contrib@steffen-goertz.de>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+#ifndef SIFIVE_GPIO_H
+#define SIFIVE_GPIO_H
+
+#include "hw/sysbus.h"
+#define TYPE_SIFIVE_GPIO "sifive_soc.gpio"
+#define SIFIVE_GPIO(obj) OBJECT_CHECK(SIFIVEGPIOState, (obj), TYPE_SIFIVE_GPIO)
+
+#define SIFIVE_GPIO_PINS 32
+
+#define SIFIVE_GPIO_SIZE 0x100
+
+#define SIFIVE_GPIO_REG_VALUE      0x000
+#define SIFIVE_GPIO_REG_INPUT_EN   0x004
+#define SIFIVE_GPIO_REG_OUTPUT_EN  0x008
+#define SIFIVE_GPIO_REG_PORT       0x00C
+#define SIFIVE_GPIO_REG_PUE        0x010
+#define SIFIVE_GPIO_REG_DS         0x014
+#define SIFIVE_GPIO_REG_RISE_IE    0x018
+#define SIFIVE_GPIO_REG_RISE_IP    0x01C
+#define SIFIVE_GPIO_REG_FALL_IE    0x020
+#define SIFIVE_GPIO_REG_FALL_IP    0x024
+#define SIFIVE_GPIO_REG_HIGH_IE    0x028
+#define SIFIVE_GPIO_REG_HIGH_IP    0x02C
+#define SIFIVE_GPIO_REG_LOW_IE     0x030
+#define SIFIVE_GPIO_REG_LOW_IP     0x034
+#define SIFIVE_GPIO_REG_IOF_EN     0x038
+#define SIFIVE_GPIO_REG_IOF_SEL    0x03C
+#define SIFIVE_GPIO_REG_OUT_XOR    0x040
+
+typedef struct SIFIVEGPIOState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    qemu_irq irq[SIFIVE_GPIO_PINS];
+    qemu_irq output[SIFIVE_GPIO_PINS];
+
+    uint32_t value;             /* Actual value of the pin */
+    uint32_t input_en;
+    uint32_t output_en;
+    uint32_t port;              /* Pin value requested by the user */
+    uint32_t pue;
+    uint32_t ds;
+    uint32_t rise_ie;
+    uint32_t rise_ip;
+    uint32_t fall_ie;
+    uint32_t fall_ip;
+    uint32_t high_ie;
+    uint32_t high_ip;
+    uint32_t low_ie;
+    uint32_t low_ip;
+    uint32_t iof_en;
+    uint32_t iof_sel;
+    uint32_t out_xor;
+    uint32_t in;
+    uint32_t in_mask;
+
+} SIFIVEGPIOState;
+
+#endif
-- 
2.21.0


