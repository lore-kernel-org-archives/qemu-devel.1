Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF842C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:33:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9685420843
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9685420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36549 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQt6Y-0002ZZ-No
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:33:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hQt4b-00018g-MS
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hQt4Z-0006GH-Kj
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:31:53 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:39589
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hQt4Y-0006CB-MZ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:31:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 7BADB8139B;
	Wed, 15 May 2019 14:31:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6anFVa7eIDmL; Wed, 15 May 2019 14:31:48 +0200 (CEST)
Received: from wifi-guest-96.act-europe.fr (wifi-guest-96.act-europe.fr
	[10.10.126.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id 6439981391;
	Wed, 15 May 2019 14:31:48 +0200 (CEST)
From: KONRAD Frederic <frederic.konrad@adacore.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 14:31:30 +0200
Message-Id: <1557923493-4836-5-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557923493-4836-1-git-send-email-frederic.konrad@adacore.com>
References: <1557923493-4836-1-git-send-email-frederic.konrad@adacore.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 194.98.77.210
Subject: [Qemu-devel] [PATCH v3 4/7] grlib,
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
	chouteau@adacore.com, frederic.konrad@adacore.com,
	philmd@redhat.com, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/char/grlib_apbuart.c  |  4 ++--
 hw/sparc/leon3.c         |  9 ++++++++-
 include/hw/sparc/grlib.h | 20 +-------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index e1d258b..9623016 100644
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
index fb52527..4f58691 100644
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
index fe553e9..5606ff0 100644
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
1.8.3.1


