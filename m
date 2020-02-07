Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF40C35247
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3041821927
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 02:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3041821927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izt9z-0007tH-9l
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 21:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvq-0006Uh-1A
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1izsvj-0001N3-PB
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:45 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53194 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1izsvj-0001AF-6R
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 20:59:39 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C2E4D1A2129;
 Fri,  7 Feb 2020 02:58:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 5C48B1A2107;
 Fri,  7 Feb 2020 02:58:23 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc5 24/32] hw/avr: Add some ATmega microcontrollers
Date: Fri,  7 Feb 2020 02:57:52 +0100
Message-Id: <1581040680-308-25-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1581040680-308-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Add some AVR microcontrollers from the ATmega family:

  - middle range: ATmega168 and ATmega328
  - high range: ATmega1280 and ATmega2560

For product comparison:
  https://www.microchip.com/wwwproducts/ProductCompare/ATmega168P/ATmega3=
28P
  https://www.microchip.com/wwwproducts/ProductCompare/ATmega1280/ATmega2=
560

Datasheets:
  http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-168=
A-PA-328-P-DS-DS40002061A.pdf
  http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-Mi=
crocontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf

[AM: Remove word 'Atmel' from filenames and all elements of code]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 hw/avr/atmega.h      |  48 ++++++
 hw/avr/atmega.c      | 470 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
 MAINTAINERS          |   3 +
 hw/avr/Kconfig       |   5 +
 hw/avr/Makefile.objs |   1 +
 5 files changed, 527 insertions(+)
 create mode 100644 hw/avr/atmega.h
 create mode 100644 hw/avr/atmega.c
 create mode 100644 hw/avr/Kconfig

diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
new file mode 100644
index 0000000..1cfbb6b
--- /dev/null
+++ b/hw/avr/atmega.h
@@ -0,0 +1,48 @@
+/*
+ * QEMU ATmega MCU
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
+ *
+ * This work is licensed under the terms of the GNU GPLv2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_AVR_ATMEGA_H
+#define HW_AVR_ATMEGA_H
+
+#include "hw/char/avr_usart.h"
+#include "hw/timer/avr_timer16.h"
+#include "hw/misc/avr_power.h"
+#include "target/avr/cpu.h"
+
+#define TYPE_ATMEGA_MCU     "ATmega"
+#define TYPE_ATMEGA168_MCU  "ATmega168"
+#define TYPE_ATMEGA328_MCU  "ATmega328"
+#define TYPE_ATMEGA1280_MCU "ATmega1280"
+#define TYPE_ATMEGA2560_MCU "ATmega2560"
+
+#define ATMEGA_MCU(obj) OBJECT_CHECK(AtmegaMcuState, (obj), TYPE_ATMEGA_=
MCU)
+
+#define POWER_MAX 2
+#define USART_MAX 4
+#define TIMER_MAX 6
+#define GPIO_MAX 12
+
+typedef struct AtmegaMcuState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    AVRCPU cpu;
+    MemoryRegion flash;
+    MemoryRegion eeprom;
+    MemoryRegion sram;
+    DeviceState *io;
+    AVRMaskState pwr[POWER_MAX];
+    AVRUsartState usart[USART_MAX];
+    AVRTimer16State timer[TIMER_MAX];
+    uint64_t xtal_freq_hz;
+} AtmegaMcuState;
+
+#endif /* HW_AVR_ATMEGA_H */
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
new file mode 100644
index 0000000..8cdf28b
--- /dev/null
+++ b/hw/avr/atmega.c
@@ -0,0 +1,470 @@
+/*
+ * QEMU ATmega MCU
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daud=C3=A9
+ *
+ * This work is licensed under the terms of the GNU GPLv2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "hw/boards.h" /* FIXME memory_region_allocate_system_memory for=
 sram */
+#include "hw/misc/unimp.h"
+#include "atmega.h"
+
+enum AtmegaPeripheral {
+    POWER0, POWER1,
+    GPIOA, GPIOB, GPIOC, GPIOD, GPIOE, GPIOF,
+    GPIOG, GPIOH, GPIOI, GPIOJ, GPIOK, GPIOL,
+    USART0, USART1, USART2, USART3,
+    TIMER0, TIMER1, TIMER2, TIMER3, TIMER4, TIMER5,
+    PERIFMAX
+};
+
+#define GPIO(n)     (n + GPIOA)
+#define USART(n)    (n + USART0)
+#define TIMER(n)    (n + TIMER0)
+#define POWER(n)    (n + POWER0)
+
+typedef struct {
+    uint16_t addr;
+    enum AtmegaPeripheral power_index;
+    uint8_t power_bit;
+    /* timer specific */
+    uint16_t intmask_addr;
+    uint16_t intflag_addr;
+    bool is_timer16;
+} peripheral_cfg;
+
+typedef struct AtmegaMcuClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+    /*< public >*/
+    const char *uc_name;
+    const char *cpu_type;
+    size_t flash_size;
+    size_t eeprom_size;
+    size_t sram_size;
+    size_t io_size;
+    size_t gpio_count;
+    size_t adc_count;
+    const uint8_t *irq;
+    const peripheral_cfg *dev;
+} AtmegaMcuClass;
+
+#define ATMEGA_MCU_CLASS(klass) \
+    OBJECT_CLASS_CHECK(AtmegaMcuClass, (klass), TYPE_ATMEGA_MCU)
+#define ATMEGA_MCU_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(AtmegaMcuClass, (obj), TYPE_ATMEGA_MCU)
+
+static const peripheral_cfg dev168_328[PERIFMAX] =3D {
+    [USART0]        =3D {  0xc0, POWER0, 1 },
+    [TIMER2]        =3D {  0xb0, POWER0, 6, 0x70, 0x37, false },
+    [TIMER1]        =3D {  0x80, POWER0, 3, 0x6f, 0x36, true },
+    [POWER0]        =3D {  0x64 },
+    [TIMER0]        =3D {  0x44, POWER0, 5, 0x6e, 0x35, false },
+    [GPIOD]         =3D {  0x29 },
+    [GPIOC]         =3D {  0x26 },
+    [GPIOB]         =3D {  0x23 },
+}, dev1280_2560[PERIFMAX] =3D {
+    [USART3]        =3D { 0x130, POWER1, 2 },
+    [TIMER5]        =3D { 0x120, POWER1, 5, 0x73, 0x3a, true },
+    [GPIOL]         =3D { 0x109 },
+    [GPIOK]         =3D { 0x106 },
+    [GPIOJ]         =3D { 0x103 },
+    [GPIOH]         =3D { 0x100 },
+    [USART2]        =3D {  0xd0, POWER1, 1 },
+    [USART1]        =3D {  0xc8, POWER1, 0 },
+    [USART0]        =3D {  0xc0, POWER0, 1 },
+    [TIMER2]        =3D {  0xb0, POWER0, 6, 0x70, 0x37, false }, /* TODO=
 async */
+    [TIMER4]        =3D {  0xa0, POWER1, 4, 0x72, 0x39, true },
+    [TIMER3]        =3D {  0x90, POWER1, 3, 0x71, 0x38, true },
+    [TIMER1]        =3D {  0x80, POWER0, 3, 0x6f, 0x36, true },
+    [POWER1]        =3D {  0x65 },
+    [POWER0]        =3D {  0x64 },
+    [TIMER0]        =3D {  0x44, POWER0, 5, 0x6e, 0x35, false },
+    [GPIOG]         =3D {  0x32 },
+    [GPIOF]         =3D {  0x2f },
+    [GPIOE]         =3D {  0x2c },
+    [GPIOD]         =3D {  0x29 },
+    [GPIOC]         =3D {  0x26 },
+    [GPIOB]         =3D {  0x23 },
+    [GPIOA]         =3D {  0x20 },
+};
+
+enum AtmegaIrq {
+    USART0_RXC_IRQ, USART0_DRE_IRQ, USART0_TXC_IRQ,
+    USART1_RXC_IRQ, USART1_DRE_IRQ, USART1_TXC_IRQ,
+    USART2_RXC_IRQ, USART2_DRE_IRQ, USART2_TXC_IRQ,
+    USART3_RXC_IRQ, USART3_DRE_IRQ, USART3_TXC_IRQ,
+    TIMER0_CAPT_IRQ, TIMER0_COMPA_IRQ, TIMER0_COMPB_IRQ,
+        TIMER0_COMPC_IRQ, TIMER0_OVF_IRQ,
+    TIMER1_CAPT_IRQ, TIMER1_COMPA_IRQ, TIMER1_COMPB_IRQ,
+        TIMER1_COMPC_IRQ, TIMER1_OVF_IRQ,
+    TIMER2_CAPT_IRQ, TIMER2_COMPA_IRQ, TIMER2_COMPB_IRQ,
+        TIMER2_COMPC_IRQ, TIMER2_OVF_IRQ,
+    TIMER3_CAPT_IRQ, TIMER3_COMPA_IRQ, TIMER3_COMPB_IRQ,
+        TIMER3_COMPC_IRQ, TIMER3_OVF_IRQ,
+    TIMER4_CAPT_IRQ, TIMER4_COMPA_IRQ, TIMER4_COMPB_IRQ,
+        TIMER4_COMPC_IRQ, TIMER4_OVF_IRQ,
+    TIMER5_CAPT_IRQ, TIMER5_COMPA_IRQ, TIMER5_COMPB_IRQ,
+        TIMER5_COMPC_IRQ, TIMER5_OVF_IRQ,
+    IRQ_COUNT
+};
+
+#define USART_IRQ_COUNT     3
+#define USART_RXC_IRQ(n)    (n * USART_IRQ_COUNT + USART0_RXC_IRQ)
+#define USART_DRE_IRQ(n)    (n * USART_IRQ_COUNT + USART0_DRE_IRQ)
+#define USART_TXC_IRQ(n)    (n * USART_IRQ_COUNT + USART0_TXC_IRQ)
+#define TIMER_IRQ_COUNT     5
+#define TIMER_CAPT_IRQ(n)   (n * TIMER_IRQ_COUNT + TIMER0_CAPT_IRQ)
+#define TIMER_COMPA_IRQ(n)  (n * TIMER_IRQ_COUNT + TIMER0_COMPA_IRQ)
+#define TIMER_COMPB_IRQ(n)  (n * TIMER_IRQ_COUNT + TIMER0_COMPB_IRQ)
+#define TIMER_COMPC_IRQ(n)  (n * TIMER_IRQ_COUNT + TIMER0_COMPC_IRQ)
+#define TIMER_OVF_IRQ(n)    (n * TIMER_IRQ_COUNT + TIMER0_OVF_IRQ)
+
+static const uint8_t irq168_328[IRQ_COUNT] =3D {
+    [TIMER2_COMPA_IRQ]      =3D 8,
+    [TIMER2_COMPB_IRQ]      =3D 9,
+    [TIMER2_OVF_IRQ]        =3D 10,
+    [TIMER1_CAPT_IRQ]       =3D 11,
+    [TIMER1_COMPA_IRQ]      =3D 12,
+    [TIMER1_COMPB_IRQ]      =3D 13,
+    [TIMER1_OVF_IRQ]        =3D 14,
+    [TIMER0_COMPA_IRQ]      =3D 15,
+    [TIMER0_COMPB_IRQ]      =3D 16,
+    [TIMER0_OVF_IRQ]        =3D 17,
+    [USART0_RXC_IRQ]        =3D 19,
+    [USART0_DRE_IRQ]        =3D 20,
+    [USART0_TXC_IRQ]        =3D 21,
+}, irq1280_2560[IRQ_COUNT] =3D {
+    [TIMER2_COMPA_IRQ]      =3D 14,
+    [TIMER2_COMPB_IRQ]      =3D 15,
+    [TIMER2_OVF_IRQ]        =3D 16,
+    [TIMER1_CAPT_IRQ]       =3D 17,
+    [TIMER1_COMPA_IRQ]      =3D 18,
+    [TIMER1_COMPB_IRQ]      =3D 19,
+    [TIMER1_COMPC_IRQ]      =3D 20,
+    [TIMER1_OVF_IRQ]        =3D 21,
+    [TIMER0_COMPA_IRQ]      =3D 22,
+    [TIMER0_COMPB_IRQ]      =3D 23,
+    [TIMER0_OVF_IRQ]        =3D 24,
+    [USART0_RXC_IRQ]        =3D 26,
+    [USART0_DRE_IRQ]        =3D 27,
+    [USART0_TXC_IRQ]        =3D 28,
+    [TIMER3_CAPT_IRQ]       =3D 32,
+    [TIMER3_COMPA_IRQ]      =3D 33,
+    [TIMER3_COMPB_IRQ]      =3D 34,
+    [TIMER3_COMPC_IRQ]      =3D 35,
+    [TIMER3_OVF_IRQ]        =3D 36,
+    [USART1_RXC_IRQ]        =3D 37,
+    [USART1_DRE_IRQ]        =3D 38,
+    [USART1_TXC_IRQ]        =3D 39,
+    [TIMER4_CAPT_IRQ]       =3D 42,
+    [TIMER4_COMPA_IRQ]      =3D 43,
+    [TIMER4_COMPB_IRQ]      =3D 44,
+    [TIMER4_COMPC_IRQ]      =3D 45,
+    [TIMER4_OVF_IRQ]        =3D 46,
+    [TIMER5_CAPT_IRQ]       =3D 47,
+    [TIMER5_COMPA_IRQ]      =3D 48,
+    [TIMER5_COMPB_IRQ]      =3D 49,
+    [TIMER5_COMPC_IRQ]      =3D 50,
+    [TIMER5_OVF_IRQ]        =3D 51,
+    [USART2_RXC_IRQ]        =3D 52,
+    [USART2_DRE_IRQ]        =3D 53,
+    [USART2_TXC_IRQ]        =3D 54,
+    [USART3_RXC_IRQ]        =3D 55,
+    [USART3_DRE_IRQ]        =3D 56,
+    [USART3_TXC_IRQ]        =3D 57,
+};
+
+static void connect_peripheral_irq(const AtmegaMcuClass *mc,
+                                   SysBusDevice *sbd,
+                                   DeviceState *dev, int n,
+                                   unsigned peripheral_irq)
+{
+    int irq =3D mc->irq[peripheral_irq];
+
+    if (!irq) {
+        return;
+    }
+    /* FIXME move that to avr_cpu_set_int() once 'sample' board is remov=
ed */
+    assert(irq >=3D 2);
+    irq -=3D 2;
+
+    sysbus_connect_irq(sbd, n, qdev_get_gpio_in(dev, irq));
+}
+
+static void connect_power_reduction_gpio(AtmegaMcuState *s,
+                                         const AtmegaMcuClass *mc,
+                                         DeviceState *dev,
+                                         int peripheral_index)
+{
+    unsigned power_index =3D mc->dev[peripheral_index].power_index;
+    assert(mc->dev[power_index].addr);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pwr[power_index - POWER0]),
+                       mc->dev[peripheral_index].power_bit,
+                       qdev_get_gpio_in(dev, 0));
+}
+
+static void atmega_realize(DeviceState *dev, Error **errp)
+{
+    AtmegaMcuState *s =3D ATMEGA_MCU(dev);
+    const AtmegaMcuClass *mc =3D ATMEGA_MCU_GET_CLASS(dev);
+    DeviceState *cpudev;
+    SysBusDevice *sbd;
+    Error *err =3D NULL;
+    char *devname;
+    size_t i;
+
+    assert(mc->io_size <=3D 0x200);
+
+    if (!s->xtal_freq_hz) {
+        error_setg(errp, "\"xtal-frequency-hz\" property must be provide=
d.");
+        return;
+    }
+
+    /* CPU */
+    object_initialize_child(OBJECT(dev), "cpu", &s->cpu, sizeof(s->cpu),
+                            mc->cpu_type, &err, NULL);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &error_a=
bort);
+    cpudev =3D DEVICE(&s->cpu);
+
+    /* SRAM */
+    memory_region_init_ram(&s->sram, OBJECT(dev), "sram", mc->sram_size,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(),
+                                OFFSET_DATA + mc->io_size, &s->sram);
+
+    /* Flash */
+    memory_region_init_rom(&s->flash, OBJECT(dev),
+                           "flash", mc->flash_size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), OFFSET_CODE, &s->fl=
ash);
+
+    /*
+     * I/O
+     *
+     * 0x00 - 0x1f: Registers
+     * 0x20 - 0x5f: I/O memory
+     * 0x60 - 0xff: Extended I/O
+     */
+    s->io =3D qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(s->io, "name", "I/O");
+    qdev_prop_set_uint64(s->io, "size", mc->io_size);
+    qdev_init_nofail(s->io);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, OFFSET_DATA, -1234=
);
+
+    /* Power Reduction */
+    for (i =3D 0; i < POWER_MAX; i++) {
+        int idx =3D POWER(i);
+        if (!mc->dev[idx].addr) {
+            continue;
+        }
+        devname =3D g_strdup_printf("power%zu", i);
+        object_initialize_child(OBJECT(dev), devname,
+                                &s->pwr[i], sizeof(s->pwr[i]),
+                                TYPE_AVR_MASK, &error_abort, NULL);
+        object_property_set_bool(OBJECT(&s->pwr[i]), true, "realized",
+                                 &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->pwr[i]), 0,
+                        OFFSET_DATA + mc->dev[idx].addr);
+        g_free(devname);
+    }
+
+    /* GPIO */
+    for (i =3D 0; i < GPIO_MAX; i++) {
+        int idx =3D GPIO(i);
+        if (!mc->dev[idx].addr) {
+            continue;
+        }
+        devname =3D g_strdup_printf("avr-gpio-%c", 'a' + (char)i);
+        create_unimplemented_device(devname,
+                                    OFFSET_DATA + mc->dev[idx].addr, 3);
+        g_free(devname);
+    }
+
+    /* USART */
+    for (i =3D 0; i < USART_MAX; i++) {
+        int idx =3D USART(i);
+        if (!mc->dev[idx].addr) {
+            continue;
+        }
+        devname =3D g_strdup_printf("usart%zu", i);
+        object_initialize_child(OBJECT(dev), devname,
+                                &s->usart[i], sizeof(s->usart[i]),
+                                TYPE_AVR_USART, &error_abort, NULL);
+        qdev_prop_set_chr(DEVICE(&s->usart[i]), "chardev", serial_hd(i))=
;
+        object_property_set_bool(OBJECT(&s->usart[i]), true, "realized",
+                                 &error_abort);
+        sbd =3D SYS_BUS_DEVICE(&s->usart[i]);
+        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[USART(i)].addr);
+        connect_peripheral_irq(mc, sbd, cpudev, 0, USART_RXC_IRQ(i));
+        connect_peripheral_irq(mc, sbd, cpudev, 1, USART_DRE_IRQ(i));
+        connect_peripheral_irq(mc, sbd, cpudev, 2, USART_TXC_IRQ(i));
+        connect_power_reduction_gpio(s, mc, DEVICE(&s->usart[i]), idx);
+        g_free(devname);
+    }
+
+    /* Timer */
+    for (i =3D 0; i < TIMER_MAX; i++) {
+        int idx =3D TIMER(i);
+        if (!mc->dev[idx].addr) {
+            continue;
+        }
+        if (!mc->dev[idx].is_timer16) {
+            create_unimplemented_device("avr-timer8",
+                                        OFFSET_DATA + mc->dev[idx].addr,=
 5);
+            create_unimplemented_device("avr-timer8-intmask",
+                                        OFFSET_DATA
+                                        + mc->dev[idx].intmask_addr, 1);
+            create_unimplemented_device("avr-timer8-intflag",
+                                        OFFSET_DATA
+                                        + mc->dev[idx].intflag_addr, 1);
+            continue;
+        }
+        devname =3D g_strdup_printf("timer%zu", i);
+        object_initialize_child(OBJECT(dev), devname,
+                                &s->timer[i], sizeof(s->timer[i]),
+                                TYPE_AVR_TIMER16, &error_abort, NULL);
+        object_property_set_uint(OBJECT(&s->timer[i]), s->xtal_freq_hz,
+                                 "cpu-frequency-hz", &error_abort);
+        object_property_set_bool(OBJECT(&s->timer[i]), true, "realized",
+                                 &error_abort);
+        sbd =3D SYS_BUS_DEVICE(&s->timer[i]);
+        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[idx].addr);
+        sysbus_mmio_map(sbd, 1, OFFSET_DATA + mc->dev[idx].intmask_addr)=
;
+        sysbus_mmio_map(sbd, 2, OFFSET_DATA + mc->dev[idx].intflag_addr)=
;
+        connect_peripheral_irq(mc, sbd, cpudev, 0, TIMER_CAPT_IRQ(i));
+        connect_peripheral_irq(mc, sbd, cpudev, 1, TIMER_COMPA_IRQ(i));
+        connect_peripheral_irq(mc, sbd, cpudev, 2, TIMER_COMPB_IRQ(i));
+        connect_peripheral_irq(mc, sbd, cpudev, 3, TIMER_COMPC_IRQ(i));
+        connect_peripheral_irq(mc, sbd, cpudev, 4, TIMER_OVF_IRQ(i));
+        connect_power_reduction_gpio(s, mc, DEVICE(&s->timer[i]), idx);
+        g_free(devname);
+    }
+
+    create_unimplemented_device("avr-twi",          OFFSET_DATA + 0x0b8,=
 6);
+    create_unimplemented_device("avr-adc",          OFFSET_DATA + 0x078,=
 8);
+    create_unimplemented_device("avr-ext-mem-ctrl", OFFSET_DATA + 0x074,=
 2);
+    create_unimplemented_device("avr-watchdog",     OFFSET_DATA + 0x060,=
 1);
+    create_unimplemented_device("avr-spi",          OFFSET_DATA + 0x04c,=
 3);
+    create_unimplemented_device("avr-eeprom",       OFFSET_DATA + 0x03f,=
 3);
+}
+
+static Property atmega_props[] =3D {
+    DEFINE_PROP_UINT64("xtal-frequency-hz", AtmegaMcuState,
+                       xtal_freq_hz, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void atmega_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+
+    dc->realize =3D atmega_realize;
+    device_class_set_props(dc, atmega_props);
+    /* Reason: Mapped at fixed location on the system bus */
+    dc->user_creatable =3D false;
+}
+
+static void atmega168_class_init(ObjectClass *oc, void *data)
+{
+    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
+
+    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr5");
+    amc->flash_size =3D 16 * KiB;
+    amc->eeprom_size =3D 512;
+    amc->sram_size =3D 1 * KiB;
+    amc->io_size =3D 256;
+    amc->gpio_count =3D 23;
+    amc->adc_count =3D 6;
+    amc->irq =3D irq168_328;
+    amc->dev =3D dev168_328;
+};
+
+static void atmega328_class_init(ObjectClass *oc, void *data)
+{
+    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
+
+    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr5");
+    amc->flash_size =3D 32 * KiB;
+    amc->eeprom_size =3D 1 * KiB;
+    amc->sram_size =3D 2 * KiB;
+    amc->io_size =3D 256;
+    amc->gpio_count =3D 23;
+    amc->adc_count =3D 6;
+    amc->irq =3D irq168_328;
+    amc->dev =3D dev168_328;
+};
+
+static void atmega1280_class_init(ObjectClass *oc, void *data)
+{
+    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
+
+    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr6");
+    amc->flash_size =3D 128 * KiB;
+    amc->eeprom_size =3D 4 * KiB;
+    amc->sram_size =3D 8 * KiB;
+    amc->io_size =3D 512;
+    amc->gpio_count =3D 86;
+    amc->adc_count =3D 16;
+    amc->irq =3D irq1280_2560;
+    amc->dev =3D dev1280_2560;
+};
+
+static void atmega2560_class_init(ObjectClass *oc, void *data)
+{
+    AtmegaMcuClass *amc =3D ATMEGA_MCU_CLASS(oc);
+
+    amc->cpu_type =3D AVR_CPU_TYPE_NAME("avr6");
+    amc->flash_size =3D 256 * KiB;
+    amc->eeprom_size =3D 4 * KiB;
+    amc->sram_size =3D 8 * KiB;
+    amc->io_size =3D 512;
+    amc->gpio_count =3D 54;
+    amc->adc_count =3D 16;
+    amc->irq =3D irq1280_2560;
+    amc->dev =3D dev1280_2560;
+};
+
+static const TypeInfo atmega_mcu_types[] =3D {
+    {
+        .name           =3D TYPE_ATMEGA168_MCU,
+        .parent         =3D TYPE_ATMEGA_MCU,
+        .class_init     =3D atmega168_class_init,
+    }, {
+        .name           =3D TYPE_ATMEGA328_MCU,
+        .parent         =3D TYPE_ATMEGA_MCU,
+        .class_init     =3D atmega328_class_init,
+    }, {
+        .name           =3D TYPE_ATMEGA1280_MCU,
+        .parent         =3D TYPE_ATMEGA_MCU,
+        .class_init     =3D atmega1280_class_init,
+    }, {
+        .name           =3D TYPE_ATMEGA2560_MCU,
+        .parent         =3D TYPE_ATMEGA_MCU,
+        .class_init     =3D atmega2560_class_init,
+    }, {
+        .name           =3D TYPE_ATMEGA_MCU,
+        .parent         =3D TYPE_SYS_BUS_DEVICE,
+        .instance_size  =3D sizeof(AtmegaMcuState),
+        .class_size     =3D sizeof(AtmegaMcuClass),
+        .class_init     =3D atmega_class_init,
+        .abstract       =3D true,
+    }
+};
+
+DEFINE_TYPES(atmega_mcu_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 336c968..5eedee9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -912,9 +912,12 @@ AVR MCUs
 M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
+F: hw/avr/Kconfig
 F: hw/avr/Makefile.objs
 F: hw/avr/boot.h
 F: hw/avr/boot.c
+F: hw/avr/atmega.h
+F: hw/avr/atmega.c
 F: include/hw/char/avr_usart.h
 F: hw/char/avr_usart.c
 F: include/hw/timer/avr_timer16.h
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
new file mode 100644
index 0000000..9e6527e
--- /dev/null
+++ b/hw/avr/Kconfig
@@ -0,0 +1,5 @@
+config AVR_ATMEGA_MCU
+    bool
+    select AVR_TIMER16
+    select AVR_USART
+    select AVR_POWER
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
index 123f174..af0fdde 100644
--- a/hw/avr/Makefile.objs
+++ b/hw/avr/Makefile.objs
@@ -1 +1,2 @@
 obj-y +=3D boot.o
+obj-$(CONFIG_AVR_ATMEGA_MCU) +=3D atmega.o
--=20
2.7.4


