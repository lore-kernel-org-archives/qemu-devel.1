Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40374C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CC020833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CC020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZUE-0002Wq-Dh
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:49:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZM1-0004Ic-Q0
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZLz-00022q-NA
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:41 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:55354
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLz-0001yD-GE
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:39 -0400
Received: from host109-146-247-8.range109-146.btcentralplus.com
	([109.146.247.8] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLF-00018L-3Z; Fri, 17 May 2019 10:39:53 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Fri, 17 May 2019 10:40:26 +0100
Message-Id: <20190517094029.7667-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
References: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 109.146.247.8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PULL 5/8] grlib,
 apbuart: get rid of the old-style create function
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
 hw/char/grlib_apbuart.c  |  4 ++--
 hw/sparc/leon3.c         |  9 ++++++++-
 include/hw/sparc/grlib.h | 20 +-------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index e1d258b611..9623016d56 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -1,7 +1,7 @@
 /*
  * QEMU GRLIB APB UART Emulator
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
 #include "chardev/char-fe.h"
 
@@ -68,7 +69,6 @@
 
 #define FIFO_LENGTH 1024
 
-#define TYPE_GRLIB_APB_UART "grlib,apbuart"
 #define GRLIB_APB_UART(obj) \
     OBJECT_CHECK(UART, (obj), TYPE_GRLIB_APB_UART)
 
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index fb52527add..4f586910f2 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -47,6 +47,9 @@
 
 #define MAX_PILS 16
 
+#define LEON3_UART_OFFSET  (0x80000100)
+#define LEON3_UART_IRQ     (3)
+
 #define LEON3_IRQMP_OFFSET (0x80000200)
 
 #define LEON3_TIMER_OFFSET (0x80000300)
@@ -239,7 +242,11 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     /* Allocate uart */
     if (serial_hd(0)) {
-        grlib_apbuart_create(0x80000100, serial_hd(0), cpu_irqs[3]);
+        dev = qdev_create(NULL, TYPE_GRLIB_APB_UART);
+        qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
+        qdev_init_nofail(dev);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irqs[LEON3_UART_IRQ]);
     }
 }
 
diff --git a/include/hw/sparc/grlib.h b/include/hw/sparc/grlib.h
index fe553e93b8..5606ff0a97 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/sparc/grlib.h
@@ -45,24 +45,6 @@ void grlib_irqmp_ack(DeviceState *dev, int intno);
 #define TYPE_GRLIB_GPTIMER "grlib,gptimer"
 
 /* APB UART */
-
-static inline
-DeviceState *grlib_apbuart_create(hwaddr  base,
-                                  Chardev    *serial,
-                                  qemu_irq            irq)
-{
-    DeviceState *dev;
-
-    dev = qdev_create(NULL, "grlib,apbuart");
-    qdev_prop_set_chr(dev, "chrdev", serial);
-
-    qdev_init_nofail(dev);
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
-
-    return dev;
-}
+#define TYPE_GRLIB_APB_UART "grlib,apbuart"
 
 #endif /* GRLIB_H */
-- 
2.11.0


