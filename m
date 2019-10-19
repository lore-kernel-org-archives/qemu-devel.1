Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2F1CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954AF20820
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Und+4WiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954AF20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyTP-00028x-Ra
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRT-000058-Dn
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRR-0005W4-NY
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRR-0005Vc-H8; Sat, 19 Oct 2019 19:47:25 -0400
Received: by mail-wm1-x341.google.com with SMTP id q70so2381037wme.1;
 Sat, 19 Oct 2019 16:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iEJkJA7iDsU1hNDUpdiwUKdaD5rbV1BDDy6YF2uxyVE=;
 b=Und+4WiDj0qzAL0YXYLPOkTDGyS1MAiN0OUfOTzZ6YDghmwckk4bI7niqSLQJYSD/J
 pNwDy1mYqVlktUeg/LmYO426+mvUHe155YRFf25FzSgRXaxs76qQQj1gnH04mdlfGQgI
 Q3INgdZEmcW0k41IzJGp1+HJ8ZqyMGI5Xi0ZGtrJviSslIqYgZ8rdVRxizDX/8EuXGBZ
 ddMC+MJyKIvqrGKV/DFsEFagRQ5NKfDUdPTdynvHs8n/5HWSSQEiKVNd1Km4VyehxSCh
 98F73l+xnDQHYoGMWn7Z0518c9tkIVw9elPIRnDcEx8wmgIVkj1H3ebYHe6TiHhcq6+2
 z4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=iEJkJA7iDsU1hNDUpdiwUKdaD5rbV1BDDy6YF2uxyVE=;
 b=rPUb1M5oQePI0AuDJxu46bSa+faBTanmNI0vcXqvrMwaMz/xSpFOTOdnGtEU3qrU41
 +D5ESsRm4937ftUR3h+Ddi/h50GIBmUGnk/+8asW2Zas7Irwq17M7x5uY+Egf++Fxozf
 WsslKY86qr0NUDD48PKuNji9ui4MH7pWCMqRX4GjmnbQV99SaGX7e70EyzTt7L4EdZ5J
 gQYQ5qEdcUVOIfPALLN9F97qPh89ADfDjRI833GYNmiEU3zwDkdcNj26MeCN4v3BBSXP
 wm4rPQ6iAqpW6VHf1OK4Kcb2VeHPtRCqP8XSvNnt/4rNDnvqsilshCK9tq0wI0L8hzb3
 ycyw==
X-Gm-Message-State: APjAAAWWwMKz/D8YRGi//awQScalmFprhYS2T2Fv6UsGP00EmR+zdAwQ
 qAlGEDIIaSo4TqCHD8JjIxLwlboi
X-Google-Smtp-Source: APXvYqwMj40BAckqzFwlZD1XjN0jHdON51J/vctj+Co/C/x8knbRbT24xzvJGWPHX1rxgLmnaFkSpA==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr187167wmc.124.1571528844070;
 Sat, 19 Oct 2019 16:47:24 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 03/16] hw/timer/bcm2835: Add the BCM2835 SYS_timer
Date: Sun, 20 Oct 2019 01:47:02 +0200
Message-Id: <20191019234715.25750-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the 64-bit free running timer. Do not model the COMPARE register
(no IRQ generated).
This timer is used by Linux kernel and recently U-Boot:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/bcm2835_timer.c?h=v3.7
https://github.com/u-boot/u-boot/blob/v2019.07/include/configs/rpi.h#L19

Datasheet used:
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2:
- Add status/compare* registers
- Add vmstate and reset handler

checkpatch warning:
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
This is OK because the regex are:

  F: hw/*/bcm283*
  F: include/hw/*/bcm283*
---
 hw/timer/Makefile.objs            |   1 +
 hw/timer/bcm2835_systmr.c         | 166 ++++++++++++++++++++++++++++++
 hw/timer/trace-events             |   5 +
 include/hw/timer/bcm2835_systmr.h |  33 ++++++
 4 files changed, 205 insertions(+)
 create mode 100644 hw/timer/bcm2835_systmr.c
 create mode 100644 include/hw/timer/bcm2835_systmr.h

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 123d92c969..696cda5905 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -47,3 +47,4 @@ common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
 common-obj-$(CONFIG_CMSDK_APB_TIMER) += cmsdk-apb-timer.o
 common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
 common-obj-$(CONFIG_MSF2) += mss-timer.o
+common-obj-$(CONFIG_RASPI) += bcm2835_systmr.o
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
new file mode 100644
index 0000000000..49b40b55f9
--- /dev/null
+++ b/hw/timer/bcm2835_systmr.c
@@ -0,0 +1,166 @@
+/*
+ * BCM2835 SYS timer emulation
+ *
+ * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Datasheet: BCM2835 ARM Peripherals (C6357-M-1398)
+ * https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
+ *
+ * Only the free running 64-bit counter is implemented.
+ * The 4 COMPARE registers and the interruption are not implemented.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/timer.h"
+#include "hw/timer/bcm2835_systmr.h"
+#include "hw/registerfields.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+REG32(CTRL_STATUS,  0x00)
+REG32(COUNTER_LOW,  0x04)
+REG32(COUNTER_HIGH, 0x08)
+REG32(COMPARE0,     0x0c)
+REG32(COMPARE1,     0x10)
+REG32(COMPARE2,     0x14)
+REG32(COMPARE3,     0x18)
+
+static void bcm2835_systmr_update_irq(BCM2835SystemTimerState *s)
+{
+    bool enable = !!s->reg.status;
+
+    trace_bcm2835_systmr_irq(enable);
+    qemu_set_irq(s->irq, enable);
+}
+
+static void bcm2835_systmr_update_compare(BCM2835SystemTimerState *s,
+                                          unsigned timer_index)
+{
+    /* TODO fow now, since neither Linux nor U-boot use these timers. */
+    qemu_log_mask(LOG_UNIMP, "COMPARE register %u not implemented\n",
+                  timer_index);
+}
+
+static uint64_t bcm2835_systmr_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
+    uint64_t r = 0;
+
+    switch (offset) {
+    case A_CTRL_STATUS:
+        r = s->reg.status;
+        break;
+    case A_COMPARE0 ... A_COMPARE3:
+        r = s->reg.compare[(offset - A_COMPARE0) >> 2];
+        break;
+    case A_COUNTER_LOW:
+    case A_COUNTER_HIGH:
+        /* Free running counter at 1MHz */
+        r = qemu_clock_get_us(QEMU_CLOCK_VIRTUAL);
+        r >>= 8 * (offset - A_COUNTER_LOW);
+        r &= UINT32_MAX;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    }
+    trace_bcm2835_systmr_read(offset, r);
+
+    return r;
+}
+
+static void bcm2835_systmr_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(opaque);
+
+    trace_bcm2835_systmr_write(offset, value);
+    switch (offset) {
+    case A_CTRL_STATUS:
+        s->reg.status &= ~value; /* Ack */
+        bcm2835_systmr_update_irq(s);
+        break;
+    case A_COMPARE0 ... A_COMPARE3:
+        s->reg.compare[(offset - A_COMPARE0) >> 2] = value;
+        bcm2835_systmr_update_compare(s, (offset - A_COMPARE0) >> 2);
+        break;
+    case A_COUNTER_LOW:
+    case A_COUNTER_HIGH:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read-only ofs 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps bcm2835_systmr_ops = {
+    .read = bcm2835_systmr_read,
+    .write = bcm2835_systmr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void bcm2835_systmr_reset(DeviceState *dev)
+{
+    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(dev);
+
+    s->reg.status = 0;
+    for (size_t i = 0; i < ARRAY_SIZE(s->reg.compare); i++) {
+        s->reg.compare[i] = 0;
+    }
+}
+
+static void bcm2835_systmr_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835SystemTimerState *s = BCM2835_SYSTIMER(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_systmr_ops,
+                          s, "bcm2835-sys-timer", 0x20);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+}
+
+static const VMStateDescription bcm2835_systmr_vmstate = {
+    .name = "bcm2835_sys_timer",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(reg.status, BCM2835SystemTimerState),
+        VMSTATE_UINT32_ARRAY(reg.compare, BCM2835SystemTimerState, 4),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2835_systmr_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2835_systmr_realize;
+    dc->reset = bcm2835_systmr_reset;
+    dc->vmsd = &bcm2835_systmr_vmstate;
+}
+
+static const TypeInfo bcm2835_systmr_info = {
+    .name = TYPE_BCM2835_SYSTIMER,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835SystemTimerState),
+    .class_init = bcm2835_systmr_class_init,
+};
+
+static void bcm2835_systmr_register_types(void)
+{
+    type_register_static(&bcm2835_systmr_info);
+}
+
+type_init(bcm2835_systmr_register_types);
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index db02a9142c..0aa399ac69 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -87,3 +87,8 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_alarm_raised(void) "alarm raised"
 pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
+
+# bcm2835_systmr.c
+bcm2835_systmr_irq(bool enable) "timer irq state %u"
+bcm2835_systmr_read(uint64_t offset, uint64_t data) "timer read: offset 0x%" PRIx64 " data 0x%" PRIx64
+bcm2835_systmr_write(uint64_t offset, uint64_t data) "timer write: offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
new file mode 100644
index 0000000000..c0bc5c8127
--- /dev/null
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -0,0 +1,33 @@
+/*
+ * BCM2835 SYS timer emulation
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2835_SYSTIMER_H
+#define BCM2835_SYSTIMER_H
+
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+
+#define TYPE_BCM2835_SYSTIMER "bcm2835-sys-timer"
+#define BCM2835_SYSTIMER(obj) \
+    OBJECT_CHECK(BCM2835SystemTimerState, (obj), TYPE_BCM2835_SYSTIMER)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    struct {
+        uint32_t status;
+        uint32_t compare[4];
+    } reg;
+} BCM2835SystemTimerState;
+
+#endif
-- 
2.21.0


