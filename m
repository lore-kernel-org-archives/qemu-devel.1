Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F8AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77946206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRZ/BTdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77946206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssOH-0005bT-PF
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAI-0000Eh-NC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:18:00 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAG-0002x3-DL
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:58 -0400
Received: by mail-wr1-x436.google.com with SMTP id z15so34959125wrl.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VMm53XjaB19n/NZsPZmrfhwD6Ddbf2X3cNEE6NOM/uM=;
 b=KRZ/BTdwQuT5Q3eh8Fr4BFgSQ4z8EReg1EYGoe6Jyu7t4oZJPKSJ0s4vVaSqCB23FF
 a5h08uOYTKcrY87JWPDmb/NHfMMU5MWgbemVCwF8IiAlDDR0h/F0hQL5Bs77Vsa1t+Yr
 FvDj2ijlBhXkthMeI9tQcnNnRDZCBXCVSRofv5TA1o1wYGsDPzgYSBgkl83/aU3h/fZj
 2KzD/r6uy7ZmeHLuBEGP+8N635zv5POCM/leRfUo8w9VBmRuQb/Z2mU/ddwDPeq2Np1c
 vTSusaNZHaFhM+x9Y46zeJVRnvpOx8PHzn/zNulPNf9i+jDCpoFKoxnhAZYldgTPtcSr
 +55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VMm53XjaB19n/NZsPZmrfhwD6Ddbf2X3cNEE6NOM/uM=;
 b=Ob8qnd6wJ+utBFyqWhxpbCP7Gcw3+596ngUCV4K9tZh+JzT24qzTMNna7dd5KogDO0
 B+/P5GvbJwmWx1z1i+zWICSLicPYxtAs5YBEsptgrBkLBscqVX445PN5fUzW68f/aO5l
 Cub07LvNkfFWoiwla1Oi/LyijyzPE8dzGSz9vRut/rfmd/aoJScB1T7fpY2tqElhvdb+
 JTtTQ+VIowWeLKFykH58GA2rWKM0eRiwgSmVj9tLtT4yur5I7GsZFs8OpmiXvc2QzfrN
 ZWNdvv7au1VoaMnOkb66iJP7wxKHLkWdAGDfWFKKypMXNLFGSftyKmBQbYNv+wQSkZLQ
 1oFA==
X-Gm-Message-State: AOAM531+WF5cv9fwh4GV+0kni4oVzBTYN4oZmy/d3cwdjoPuzinOZGyV
 H+ntvgrxbUXnidFNR3xxpruU8D2C
X-Google-Smtp-Source: ABdhPJyP69duXc0CfZor1QKDYWAXvFOZIWZ3FnmKMc0oBlGXq06Me2D2NahXtYh9yheiiAWWeooyDQ==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr54080286wrt.209.1594145872999; 
 Tue, 07 Jul 2020 11:17:52 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/32] hw/avr: Add some ATmega microcontrollers
Date: Tue,  7 Jul 2020 20:17:03 +0200
Message-Id: <20200707181710.30950-26-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add some AVR microcontrollers from the ATmega family:

  - middle range: ATmega168 and ATmega328
  - high range: ATmega1280 and ATmega2560

For product comparison:
  https://www.microchip.com/wwwproducts/ProductCompare/ATmega168P/ATmega328P
  https://www.microchip.com/wwwproducts/ProductCompare/ATmega1280/ATmega2560

Datasheets:
  http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-168A-PA-328-P-DS-DS40002061A.pdf
  http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-2549-8-bit-AVR-Microcontroller-ATmega640-1280-1281-2560-2561_datasheet.pdf

[AM: Remove word 'Atmel' from filenames and all elements of code]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
[thuth: Rebased to master, fixed object_initialize_child() calls etc.]
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-25-huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/avr/atmega.h      |  48 +++++
 hw/avr/atmega.c      | 458 +++++++++++++++++++++++++++++++++++++++++++
 hw/avr/Kconfig       |   5 +
 hw/avr/Makefile.objs |   1 +
 4 files changed, 512 insertions(+)
 create mode 100644 hw/avr/atmega.h
 create mode 100644 hw/avr/atmega.c
 create mode 100644 hw/avr/Kconfig

diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
new file mode 100644
index 0000000000..0928cb0ce6
--- /dev/null
+++ b/hw/avr/atmega.h
@@ -0,0 +1,48 @@
+/*
+ * QEMU ATmega MCU
+ *
+ * Copyright (c) 2019-2020 Philippe Mathieu-Daudé
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
+#define ATMEGA_MCU(obj) OBJECT_CHECK(AtmegaMcuState, (obj), TYPE_ATMEGA_MCU)
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
index 0000000000..49ec8047f9
--- /dev/null
+++ b/hw/avr/atmega.c
@@ -0,0 +1,458 @@
+/*
+ * QEMU ATmega MCU
+ *
+ * Copyright (c) 2019-2020 Philippe Mathieu-Daudé
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
+#include "hw/boards.h" /* FIXME memory_region_allocate_system_memory for sram */
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
+static const peripheral_cfg dev168_328[PERIFMAX] = {
+    [USART0]        = {  0xc0, POWER0, 1 },
+    [TIMER2]        = {  0xb0, POWER0, 6, 0x70, 0x37, false },
+    [TIMER1]        = {  0x80, POWER0, 3, 0x6f, 0x36, true },
+    [POWER0]        = {  0x64 },
+    [TIMER0]        = {  0x44, POWER0, 5, 0x6e, 0x35, false },
+    [GPIOD]         = {  0x29 },
+    [GPIOC]         = {  0x26 },
+    [GPIOB]         = {  0x23 },
+}, dev1280_2560[PERIFMAX] = {
+    [USART3]        = { 0x130, POWER1, 2 },
+    [TIMER5]        = { 0x120, POWER1, 5, 0x73, 0x3a, true },
+    [GPIOL]         = { 0x109 },
+    [GPIOK]         = { 0x106 },
+    [GPIOJ]         = { 0x103 },
+    [GPIOH]         = { 0x100 },
+    [USART2]        = {  0xd0, POWER1, 1 },
+    [USART1]        = {  0xc8, POWER1, 0 },
+    [USART0]        = {  0xc0, POWER0, 1 },
+    [TIMER2]        = {  0xb0, POWER0, 6, 0x70, 0x37, false }, /* TODO async */
+    [TIMER4]        = {  0xa0, POWER1, 4, 0x72, 0x39, true },
+    [TIMER3]        = {  0x90, POWER1, 3, 0x71, 0x38, true },
+    [TIMER1]        = {  0x80, POWER0, 3, 0x6f, 0x36, true },
+    [POWER1]        = {  0x65 },
+    [POWER0]        = {  0x64 },
+    [TIMER0]        = {  0x44, POWER0, 5, 0x6e, 0x35, false },
+    [GPIOG]         = {  0x32 },
+    [GPIOF]         = {  0x2f },
+    [GPIOE]         = {  0x2c },
+    [GPIOD]         = {  0x29 },
+    [GPIOC]         = {  0x26 },
+    [GPIOB]         = {  0x23 },
+    [GPIOA]         = {  0x20 },
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
+static const uint8_t irq168_328[IRQ_COUNT] = {
+    [TIMER2_COMPA_IRQ]      = 8,
+    [TIMER2_COMPB_IRQ]      = 9,
+    [TIMER2_OVF_IRQ]        = 10,
+    [TIMER1_CAPT_IRQ]       = 11,
+    [TIMER1_COMPA_IRQ]      = 12,
+    [TIMER1_COMPB_IRQ]      = 13,
+    [TIMER1_OVF_IRQ]        = 14,
+    [TIMER0_COMPA_IRQ]      = 15,
+    [TIMER0_COMPB_IRQ]      = 16,
+    [TIMER0_OVF_IRQ]        = 17,
+    [USART0_RXC_IRQ]        = 19,
+    [USART0_DRE_IRQ]        = 20,
+    [USART0_TXC_IRQ]        = 21,
+}, irq1280_2560[IRQ_COUNT] = {
+    [TIMER2_COMPA_IRQ]      = 14,
+    [TIMER2_COMPB_IRQ]      = 15,
+    [TIMER2_OVF_IRQ]        = 16,
+    [TIMER1_CAPT_IRQ]       = 17,
+    [TIMER1_COMPA_IRQ]      = 18,
+    [TIMER1_COMPB_IRQ]      = 19,
+    [TIMER1_COMPC_IRQ]      = 20,
+    [TIMER1_OVF_IRQ]        = 21,
+    [TIMER0_COMPA_IRQ]      = 22,
+    [TIMER0_COMPB_IRQ]      = 23,
+    [TIMER0_OVF_IRQ]        = 24,
+    [USART0_RXC_IRQ]        = 26,
+    [USART0_DRE_IRQ]        = 27,
+    [USART0_TXC_IRQ]        = 28,
+    [TIMER3_CAPT_IRQ]       = 32,
+    [TIMER3_COMPA_IRQ]      = 33,
+    [TIMER3_COMPB_IRQ]      = 34,
+    [TIMER3_COMPC_IRQ]      = 35,
+    [TIMER3_OVF_IRQ]        = 36,
+    [USART1_RXC_IRQ]        = 37,
+    [USART1_DRE_IRQ]        = 38,
+    [USART1_TXC_IRQ]        = 39,
+    [TIMER4_CAPT_IRQ]       = 42,
+    [TIMER4_COMPA_IRQ]      = 43,
+    [TIMER4_COMPB_IRQ]      = 44,
+    [TIMER4_COMPC_IRQ]      = 45,
+    [TIMER4_OVF_IRQ]        = 46,
+    [TIMER5_CAPT_IRQ]       = 47,
+    [TIMER5_COMPA_IRQ]      = 48,
+    [TIMER5_COMPB_IRQ]      = 49,
+    [TIMER5_COMPC_IRQ]      = 50,
+    [TIMER5_OVF_IRQ]        = 51,
+    [USART2_RXC_IRQ]        = 52,
+    [USART2_DRE_IRQ]        = 53,
+    [USART2_TXC_IRQ]        = 54,
+    [USART3_RXC_IRQ]        = 55,
+    [USART3_DRE_IRQ]        = 56,
+    [USART3_TXC_IRQ]        = 57,
+};
+
+static void connect_peripheral_irq(const AtmegaMcuClass *k,
+                                   SysBusDevice *dev, int dev_irqn,
+                                   DeviceState *cpu,
+                                   unsigned peripheral_index)
+{
+    int cpu_irq = k->irq[peripheral_index];
+
+    if (!cpu_irq) {
+        return;
+    }
+    /* FIXME move that to avr_cpu_set_int() once 'sample' board is removed */
+    assert(cpu_irq >= 2);
+    cpu_irq -= 2;
+
+    sysbus_connect_irq(dev, dev_irqn, qdev_get_gpio_in(cpu, cpu_irq));
+}
+
+static void connect_power_reduction_gpio(AtmegaMcuState *s,
+                                         const AtmegaMcuClass *k,
+                                         DeviceState *cpu,
+                                         unsigned peripheral_index)
+{
+    unsigned power_index = k->dev[peripheral_index].power_index;
+    assert(k->dev[power_index].addr);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pwr[power_index - POWER0]),
+                       k->dev[peripheral_index].power_bit,
+                       qdev_get_gpio_in(cpu, 0));
+}
+
+static void atmega_realize(DeviceState *dev, Error **errp)
+{
+    AtmegaMcuState *s = ATMEGA_MCU(dev);
+    const AtmegaMcuClass *mc = ATMEGA_MCU_GET_CLASS(dev);
+    DeviceState *cpudev;
+    SysBusDevice *sbd;
+    char *devname;
+    size_t i;
+
+    assert(mc->io_size <= 0x200);
+
+    if (!s->xtal_freq_hz) {
+        error_setg(errp, "\"xtal-frequency-hz\" property must be provided.");
+        return;
+    }
+
+    /* CPU */
+    object_initialize_child(OBJECT(dev), "cpu", &s->cpu, mc->cpu_type);
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &error_abort);
+    cpudev = DEVICE(&s->cpu);
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
+    memory_region_add_subregion(get_system_memory(), OFFSET_CODE, &s->flash);
+
+    /*
+     * I/O
+     *
+     * 0x00 - 0x1f: Registers
+     * 0x20 - 0x5f: I/O memory
+     * 0x60 - 0xff: Extended I/O
+     */
+    s->io = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(s->io, "name", "I/O");
+    qdev_prop_set_uint64(s->io, "size", mc->io_size);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s->io), &error_fatal);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->io), 0, OFFSET_DATA, -1234);
+
+    /* Power Reduction */
+    for (i = 0; i < POWER_MAX; i++) {
+        int idx = POWER(i);
+        if (!mc->dev[idx].addr) {
+            continue;
+        }
+        devname = g_strdup_printf("power%zu", i);
+        object_initialize_child(OBJECT(dev), devname, &s->pwr[i],
+                                TYPE_AVR_MASK);
+        sysbus_realize(SYS_BUS_DEVICE(&s->pwr[i]), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->pwr[i]), 0,
+                        OFFSET_DATA + mc->dev[idx].addr);
+        g_free(devname);
+    }
+
+    /* GPIO */
+    for (i = 0; i < GPIO_MAX; i++) {
+        int idx = GPIO(i);
+        if (!mc->dev[idx].addr) {
+            continue;
+        }
+        devname = g_strdup_printf("atmega-gpio-%c", 'a' + (char)i);
+        create_unimplemented_device(devname,
+                                    OFFSET_DATA + mc->dev[idx].addr, 3);
+        g_free(devname);
+    }
+
+    /* USART */
+    for (i = 0; i < USART_MAX; i++) {
+        int idx = USART(i);
+        if (!mc->dev[idx].addr) {
+            continue;
+        }
+        devname = g_strdup_printf("usart%zu", i);
+        object_initialize_child(OBJECT(dev), devname, &s->usart[i],
+                                TYPE_AVR_USART);
+        qdev_prop_set_chr(DEVICE(&s->usart[i]), "chardev", serial_hd(i));
+        sbd = SYS_BUS_DEVICE(&s->usart[i]);
+        sysbus_realize(sbd, &error_abort);
+        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[USART(i)].addr);
+        connect_peripheral_irq(mc, sbd, 0, cpudev, USART_RXC_IRQ(i));
+        connect_peripheral_irq(mc, sbd, 1, cpudev, USART_DRE_IRQ(i));
+        connect_peripheral_irq(mc, sbd, 2, cpudev, USART_TXC_IRQ(i));
+        connect_power_reduction_gpio(s, mc, DEVICE(&s->usart[i]), idx);
+        g_free(devname);
+    }
+
+    /* Timer */
+    for (i = 0; i < TIMER_MAX; i++) {
+        int idx = TIMER(i);
+        if (!mc->dev[idx].addr) {
+            continue;
+        }
+        if (!mc->dev[idx].is_timer16) {
+            create_unimplemented_device("avr-timer8",
+                                        OFFSET_DATA + mc->dev[idx].addr, 5);
+            create_unimplemented_device("avr-timer8-intmask",
+                                        OFFSET_DATA
+                                        + mc->dev[idx].intmask_addr, 1);
+            create_unimplemented_device("avr-timer8-intflag",
+                                        OFFSET_DATA
+                                        + mc->dev[idx].intflag_addr, 1);
+            continue;
+        }
+        devname = g_strdup_printf("timer%zu", i);
+        object_initialize_child(OBJECT(dev), devname, &s->timer[i],
+                                TYPE_AVR_TIMER16);
+        object_property_set_uint(OBJECT(&s->timer[i]), s->xtal_freq_hz,
+                                 "cpu-frequency-hz", &error_abort);
+        sbd = SYS_BUS_DEVICE(&s->timer[i]);
+        sysbus_realize(sbd, &error_abort);
+        sysbus_mmio_map(sbd, 0, OFFSET_DATA + mc->dev[idx].addr);
+        sysbus_mmio_map(sbd, 1, OFFSET_DATA + mc->dev[idx].intmask_addr);
+        sysbus_mmio_map(sbd, 2, OFFSET_DATA + mc->dev[idx].intflag_addr);
+        connect_peripheral_irq(mc, sbd, 0, cpudev, TIMER_CAPT_IRQ(i));
+        connect_peripheral_irq(mc, sbd, 1, cpudev, TIMER_COMPA_IRQ(i));
+        connect_peripheral_irq(mc, sbd, 2, cpudev, TIMER_COMPB_IRQ(i));
+        connect_peripheral_irq(mc, sbd, 3, cpudev, TIMER_COMPC_IRQ(i));
+        connect_peripheral_irq(mc, sbd, 4, cpudev, TIMER_OVF_IRQ(i));
+        connect_power_reduction_gpio(s, mc, DEVICE(&s->timer[i]), idx);
+        g_free(devname);
+    }
+
+    create_unimplemented_device("avr-twi",          OFFSET_DATA + 0x0b8, 6);
+    create_unimplemented_device("avr-adc",          OFFSET_DATA + 0x078, 8);
+    create_unimplemented_device("avr-ext-mem-ctrl", OFFSET_DATA + 0x074, 2);
+    create_unimplemented_device("avr-watchdog",     OFFSET_DATA + 0x060, 1);
+    create_unimplemented_device("avr-spi",          OFFSET_DATA + 0x04c, 3);
+    create_unimplemented_device("avr-eeprom",       OFFSET_DATA + 0x03f, 3);
+}
+
+static Property atmega_props[] = {
+    DEFINE_PROP_UINT64("xtal-frequency-hz", AtmegaMcuState,
+                       xtal_freq_hz, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void atmega_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = atmega_realize;
+    device_class_set_props(dc, atmega_props);
+    /* Reason: Mapped at fixed location on the system bus */
+    dc->user_creatable = false;
+}
+
+static void atmega168_class_init(ObjectClass *oc, void *data)
+{
+    AtmegaMcuClass *amc = ATMEGA_MCU_CLASS(oc);
+
+    amc->cpu_type = AVR_CPU_TYPE_NAME("avr5");
+    amc->flash_size = 16 * KiB;
+    amc->eeprom_size = 512;
+    amc->sram_size = 1 * KiB;
+    amc->io_size = 256;
+    amc->gpio_count = 23;
+    amc->adc_count = 6;
+    amc->irq = irq168_328;
+    amc->dev = dev168_328;
+};
+
+static void atmega328_class_init(ObjectClass *oc, void *data)
+{
+    AtmegaMcuClass *amc = ATMEGA_MCU_CLASS(oc);
+
+    amc->cpu_type = AVR_CPU_TYPE_NAME("avr5");
+    amc->flash_size = 32 * KiB;
+    amc->eeprom_size = 1 * KiB;
+    amc->sram_size = 2 * KiB;
+    amc->io_size = 256;
+    amc->gpio_count = 23;
+    amc->adc_count = 6;
+    amc->irq = irq168_328;
+    amc->dev = dev168_328;
+};
+
+static void atmega1280_class_init(ObjectClass *oc, void *data)
+{
+    AtmegaMcuClass *amc = ATMEGA_MCU_CLASS(oc);
+
+    amc->cpu_type = AVR_CPU_TYPE_NAME("avr6");
+    amc->flash_size = 128 * KiB;
+    amc->eeprom_size = 4 * KiB;
+    amc->sram_size = 8 * KiB;
+    amc->io_size = 512;
+    amc->gpio_count = 86;
+    amc->adc_count = 16;
+    amc->irq = irq1280_2560;
+    amc->dev = dev1280_2560;
+};
+
+static void atmega2560_class_init(ObjectClass *oc, void *data)
+{
+    AtmegaMcuClass *amc = ATMEGA_MCU_CLASS(oc);
+
+    amc->cpu_type = AVR_CPU_TYPE_NAME("avr6");
+    amc->flash_size = 256 * KiB;
+    amc->eeprom_size = 4 * KiB;
+    amc->sram_size = 8 * KiB;
+    amc->io_size = 512;
+    amc->gpio_count = 54;
+    amc->adc_count = 16;
+    amc->irq = irq1280_2560;
+    amc->dev = dev1280_2560;
+};
+
+static const TypeInfo atmega_mcu_types[] = {
+    {
+        .name           = TYPE_ATMEGA168_MCU,
+        .parent         = TYPE_ATMEGA_MCU,
+        .class_init     = atmega168_class_init,
+    }, {
+        .name           = TYPE_ATMEGA328_MCU,
+        .parent         = TYPE_ATMEGA_MCU,
+        .class_init     = atmega328_class_init,
+    }, {
+        .name           = TYPE_ATMEGA1280_MCU,
+        .parent         = TYPE_ATMEGA_MCU,
+        .class_init     = atmega1280_class_init,
+    }, {
+        .name           = TYPE_ATMEGA2560_MCU,
+        .parent         = TYPE_ATMEGA_MCU,
+        .class_init     = atmega2560_class_init,
+    }, {
+        .name           = TYPE_ATMEGA_MCU,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(AtmegaMcuState),
+        .class_size     = sizeof(AtmegaMcuClass),
+        .class_init     = atmega_class_init,
+        .abstract       = true,
+    }
+};
+
+DEFINE_TYPES(atmega_mcu_types)
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
new file mode 100644
index 0000000000..9e6527e1f3
--- /dev/null
+++ b/hw/avr/Kconfig
@@ -0,0 +1,5 @@
+config AVR_ATMEGA_MCU
+    bool
+    select AVR_TIMER16
+    select AVR_USART
+    select AVR_POWER
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
index 123f174f0e..af0fddeb13 100644
--- a/hw/avr/Makefile.objs
+++ b/hw/avr/Makefile.objs
@@ -1 +1,2 @@
 obj-y += boot.o
+obj-$(CONFIG_AVR_ATMEGA_MCU) += atmega.o
-- 
2.21.3


