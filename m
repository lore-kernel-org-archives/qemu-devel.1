Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554FBC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F4121D56
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSkeWhZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F4121D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXzq-0005sV-7d
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgM-0004a8-Iq
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgJ-0002xP-TN
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgJ-0002wp-MV; Thu, 26 Sep 2019 13:35:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so3726067wme.1;
 Thu, 26 Sep 2019 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3CkZIT9Y9Ae7LSSsN/oOgCMbPqmMCdmGsnbLDg7Flfg=;
 b=iSkeWhZljJ/p+KpbCPQ2NakCDSFvW1N+zD6z1JHe8QrX2XngZM8IGKTkLuXWKvSaz7
 QxkE8wrPnmVIdmW5lPXUP+/8bYLlZtPvmOhu/H4rVHqIvKxmGGleMnpe7GXmbL7jaOtH
 BwsPYvm0fCVliroaIROZHi1BT0ldjFJ+5bdHozVwnOOqD6mA5TeK7wsjtoi68wx2HNS9
 y0/Hj2VsVh9+qARYgBTEDLYPDwgp1Sm/gQ6gW5BzaDCIhfjAU2A9RlbjVKuKaOKcSzgL
 a6EMzMRoRufVodCseDb6shK5ANPbyv2gZLFLH58cvX6XS5sDweHkAfUybkuIvIfe+rSX
 mViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3CkZIT9Y9Ae7LSSsN/oOgCMbPqmMCdmGsnbLDg7Flfg=;
 b=JdOOUuGOfSbLko0G1da9cLSstQecDi0DzYjuhbbE4RnSEYeyB16FGm+wEPqDUNEgGY
 bfTexpXCiljspV+DxMi/vdaBUCCyisGgU55kF2smQgJA2E6aKPErI5IDijyHd/rO/0P9
 wfWzskEGR0MOcLmDBDjUFZlZYWqC9fMek8qGs2CjnXwGC7SI3Uh8E1q6SEOupC17Ds5J
 HwrDwMCUkBVoafQILQtpzIcfZE4/CTl5Kd4SMGduvNlIGsoQ+Gn4lEkP6SvbMYLVnWhW
 uVweGTP+OEfXKYt6B91pXosp4D4BrTSU+9IqURiIecu3F32eWM6Kj3WydwvnZm1wv9Pz
 3mQg==
X-Gm-Message-State: APjAAAXXNNb+5L0quslL966CgkptImSxHCkHmA3yTsALHr6U7eaKYwk2
 y6M5jUma+ZtDWrvmTwKTbUHA1jsd1r4=
X-Google-Smtp-Source: APXvYqxILBVBF6fdsrjwl50FlQC2HCqP0mspsD5pVAi1Q871Xrg0z40epfYZBM9Cd36IWeeQI8E8sQ==
X-Received: by 2002:a7b:c0d4:: with SMTP id s20mr4122872wmh.101.1569519294390; 
 Thu, 26 Sep 2019 10:34:54 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/19] hw/timer/bcm2835: Add the BCM2835 SYS_timer
Date: Thu, 26 Sep 2019 19:34:18 +0200
Message-Id: <20190926173428.10713-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
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
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the 64-bit free running timer. Do not model the COMPARE register
(no IRQ generated).
This timer is used by U-Boot and recent Linux kernels:
https://github.com/u-boot/u-boot/blob/v2019.07/include/configs/rpi.h#L19

Datasheet used:
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since which kernels? 4.19 seems to use it.

checkpatch warning:
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
This is OK because the regex are:

  F: hw/*/bcm283*
  F: include/hw/*/bcm283*
---
 hw/timer/Makefile.objs            |   1 +
 hw/timer/bcm2835_systmr.c         | 100 ++++++++++++++++++++++++++++++
 hw/timer/trace-events             |   4 ++
 include/hw/timer/bcm2835_systmr.h |  30 +++++++++
 4 files changed, 135 insertions(+)
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
index 0000000000..c4d2b488bd
--- /dev/null
+++ b/hw/timer/bcm2835_systmr.c
@@ -0,0 +1,100 @@
+/*
+ * BCM2835 SYS timer emulation
+ *
+ * Copyright (C) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or
+ * (at your option) any later version.
+ *
+ * Datasheet: BCM2835 ARM Peripherals (C6357-M-1398)
+ * https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
+ *
+ * Only the free running 64-bit counter is implemented.
+ * The 4 COMPARE registers and the interruption are not implemented.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "qemu/log.h"
+#include "hw/registerfields.h"
+#include "hw/timer/bcm2835_systmr.h"
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
+static uint64_t bcm2835_sys_timer_read(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    uint64_t r = 0;
+
+    switch (offset) {
+    case A_CTRL_STATUS:
+    case A_COMPARE0 ... A_COMPARE3:
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
+    trace_bcm2835_sys_timer_read(offset, r);
+
+    return r;
+}
+
+static void bcm2835_sys_timer_write(void *opaque, hwaddr offset,
+                                    uint64_t value, unsigned size)
+{
+    trace_bcm2835_sys_timer_write(offset, value);
+
+    qemu_log_mask(LOG_UNIMP, "%s: bad offset 0x%" HWADDR_PRIx "\n",
+                  __func__, offset);
+}
+
+static const MemoryRegionOps bcm2835_sys_timer_ops = {
+    .read = bcm2835_sys_timer_read,
+    .write = bcm2835_sys_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void bcm2835_sys_timer_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    BCM2835SysTimerState *s = BCM2835_SYSTIMER(obj);
+
+    memory_region_init_io(&s->iomem, obj, &bcm2835_sys_timer_ops,
+                          s, "bcm2835-sys-timer", 0x20);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static const TypeInfo bcm2835_sys_timer_info = {
+    .name = TYPE_BCM2835_SYSTIMER,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835SysTimerState),
+    .instance_init = bcm2835_sys_timer_init,
+};
+
+static void bcm2835_sys_timer_register_types(void)
+{
+    type_register_static(&bcm2835_sys_timer_info);
+}
+
+type_init(bcm2835_sys_timer_register_types);
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index db02a9142c..81967a1a19 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -87,3 +87,7 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_alarm_raised(void) "alarm raised"
 pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
+
+# bcm2835_systmr.c
+bcm2835_sys_timer_read(uint64_t offset, uint64_t data) "timer read: offset 0x%" PRIx64 " data 0x%" PRIx64
+bcm2835_sys_timer_write(uint64_t offset, uint64_t data) "timer write: offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/include/hw/timer/bcm2835_systmr.h b/include/hw/timer/bcm2835_systmr.h
new file mode 100644
index 0000000000..6ac7f8ec5a
--- /dev/null
+++ b/include/hw/timer/bcm2835_systmr.h
@@ -0,0 +1,30 @@
+/*
+ * BCM2835 SYS timer emulation
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daudé <f4bug@amsat.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
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
+    OBJECT_CHECK(BCM2835SysTimerState, (obj), TYPE_BCM2835_SYSTIMER)
+
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion iomem;
+    qemu_irq irq;
+} BCM2835SysTimerState;
+
+#endif
-- 
2.20.1


