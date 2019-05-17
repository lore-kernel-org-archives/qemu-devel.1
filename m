Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632CEC04E84
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3657A20879
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3657A20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZNt-0005S9-4B
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:42:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZM0-0004IN-DY
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZLz-00020Q-7W
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:40 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:55340
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLz-0001vP-0i
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:39 -0400
Received: from host109-146-247-8.range109-146.btcentralplus.com
	([109.146.247.8] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLE-00018L-LU; Fri, 17 May 2019 10:39:53 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Fri, 17 May 2019 10:40:25 +0100
Message-Id: <20190517094029.7667-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
References: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 109.146.247.8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PULL 4/8] grlib,
 gptimer: get rid of the old-style create function
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: KONRAD Frederic <frederic.konrad@adacore.com>

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc/leon3.c         | 17 ++++++++++++++++-
 hw/timer/grlib_gptimer.c |  4 ++--
 include/hw/sparc/grlib.h | 27 +--------------------------
 3 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 34306937bc..fb52527add 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -49,6 +49,10 @@
 
 #define LEON3_IRQMP_OFFSET (0x80000200)
 
+#define LEON3_TIMER_OFFSET (0x80000300)
+#define LEON3_TIMER_IRQ    (6)
+#define LEON3_TIMER_COUNT  (2)
+
 typedef struct ResetData {
     SPARCCPU *cpu;
     uint32_t  entry;            /* save kernel entry in case of reset */
@@ -124,6 +128,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     int         prom_size;
     ResetData  *reset_info;
     DeviceState *dev;
+    int i;
 
     /* Init CPU */
     cpu = SPARC_CPU(cpu_create(machine->cpu_type));
@@ -220,7 +225,17 @@ static void leon3_generic_hw_init(MachineState *machine)
     }
 
     /* Allocate timers */
-    grlib_gptimer_create(0x80000300, 2, CPU_CLK, cpu_irqs, 6);
+    dev = qdev_create(NULL, TYPE_GRLIB_GPTIMER);
+    qdev_prop_set_uint32(dev, "nr-timers", LEON3_TIMER_COUNT);
+    qdev_prop_set_uint32(dev, "frequency", CPU_CLK);
+    qdev_prop_set_uint32(dev, "irq-line", LEON3_TIMER_IRQ);
+    qdev_init_nofail(dev);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_TIMER_OFFSET);
+    for (i = 0; i < LEON3_TIMER_COUNT; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
+                           cpu_irqs[LEON3_TIMER_IRQ + i]);
+    }
 
     /* Allocate uart */
     if (serial_hd(0)) {
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 183eddc073..4b7088fc84 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -1,7 +1,7 @@
 /*
  * QEMU GRLIB GPTimer Emulator
  *
- * Copyright (c) 2010-2011 AdaCore
+ * Copyright (c) 2010-2019 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/sparc/grlib.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
@@ -52,7 +53,6 @@
 #define COUNTER_RELOAD_OFFSET 0x04
 #define TIMER_BASE            0x10
 
-#define TYPE_GRLIB_GPTIMER "grlib,gptimer"
 #define GRLIB_GPTIMER(obj) \
     OBJECT_CHECK(GPTimerUnit, (obj), TYPE_GRLIB_GPTIMER)
 
diff --git a/include/hw/sparc/grlib.h b/include/hw/sparc/grlib.h
index bef371a06f..fe553e93b8 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/sparc/grlib.h
@@ -42,32 +42,7 @@ void grlib_irqmp_set_irq(void *opaque, int irq, int level);
 void grlib_irqmp_ack(DeviceState *dev, int intno);
 
 /* GPTimer */
-
-static inline
-DeviceState *grlib_gptimer_create(hwaddr  base,
-                                  uint32_t            nr_timers,
-                                  uint32_t            freq,
-                                  qemu_irq           *cpu_irqs,
-                                  int                 base_irq)
-{
-    DeviceState *dev;
-    int i;
-
-    dev = qdev_create(NULL, "grlib,gptimer");
-    qdev_prop_set_uint32(dev, "nr-timers", nr_timers);
-    qdev_prop_set_uint32(dev, "frequency", freq);
-    qdev_prop_set_uint32(dev, "irq-line", base_irq);
-
-    qdev_init_nofail(dev);
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-
-    for (i = 0; i < nr_timers; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, cpu_irqs[base_irq + i]);
-    }
-
-    return dev;
-}
+#define TYPE_GRLIB_GPTIMER "grlib,gptimer"
 
 /* APB UART */
 
-- 
2.11.0


