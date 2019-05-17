Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F444C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FCFF20833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FCFF20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45380 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRZSX-00018p-Lr
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:47:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZM1-0004IX-Dr
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hRZM0-000261-6M
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:41 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:55358
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLz-00021A-VZ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:40:40 -0400
Received: from host109-146-247-8.range109-146.btcentralplus.com
	([109.146.247.8] helo=kentang.home)
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hRZLE-00018L-5p; Fri, 17 May 2019 10:39:52 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Fri, 17 May 2019 10:40:24 +0100
Message-Id: <20190517094029.7667-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
References: <20190517094029.7667-1-mark.cave-ayland@ilande.co.uk>
X-SA-Exim-Connect-IP: 109.146.247.8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: [Qemu-devel] [PULL 3/8] grlib,
 irqmp: get rid of the old-style create function
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
 hw/intc/grlib_irqmp.c    |  3 +--
 hw/sparc/leon3.c         | 12 ++++++++++--
 include/hw/sparc/grlib.h | 31 ++-----------------------------
 3 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index d6f9cb3692..20accb6c4d 100644
--- a/hw/intc/grlib_irqmp.c
+++ b/hw/intc/grlib_irqmp.c
@@ -3,7 +3,7 @@
  *
  * (Multiprocessor and extended interrupt not supported)
  *
- * Copyright (c) 2010-2011 AdaCore
+ * Copyright (c) 2010-2019 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -47,7 +47,6 @@
 #define FORCE_OFFSET     0x80
 #define EXTENDED_OFFSET  0xC0
 
-#define TYPE_GRLIB_IRQMP "grlib,irqmp"
 #define GRLIB_IRQMP(obj) OBJECT_CHECK(IRQMP, (obj), TYPE_GRLIB_IRQMP)
 
 typedef struct IRQMPState IRQMPState;
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index f438718794..34306937bc 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -47,6 +47,8 @@
 
 #define MAX_PILS 16
 
+#define LEON3_IRQMP_OFFSET (0x80000200)
+
 typedef struct ResetData {
     SPARCCPU *cpu;
     uint32_t  entry;            /* save kernel entry in case of reset */
@@ -121,6 +123,7 @@ static void leon3_generic_hw_init(MachineState *machine)
     int         bios_size;
     int         prom_size;
     ResetData  *reset_info;
+    DeviceState *dev;
 
     /* Init CPU */
     cpu = SPARC_CPU(cpu_create(machine->cpu_type));
@@ -135,9 +138,14 @@ static void leon3_generic_hw_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, reset_info);
 
     /* Allocate IRQ manager */
-    grlib_irqmp_create(0x80000200, env, &cpu_irqs, MAX_PILS, &leon3_set_pil_in);
-
+    dev = qdev_create(NULL, TYPE_GRLIB_IRQMP);
+    qdev_prop_set_ptr(dev, "set_pil_in", leon3_set_pil_in);
+    qdev_prop_set_ptr(dev, "set_pil_in_opaque", env);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_IRQMP_OFFSET);
+    env->irq_manager = dev;
     env->qemu_irq_ack = leon3_irq_manager;
+    cpu_irqs = qemu_allocate_irqs(grlib_irqmp_set_irq, dev, MAX_PILS);
 
     /* Allocate RAM */
     if (ram_size > 1 * GiB) {
diff --git a/include/hw/sparc/grlib.h b/include/hw/sparc/grlib.h
index 61a345c269..bef371a06f 100644
--- a/include/hw/sparc/grlib.h
+++ b/include/hw/sparc/grlib.h
@@ -1,7 +1,7 @@
 /*
  * QEMU GRLIB Components
  *
- * Copyright (c) 2010-2011 AdaCore
+ * Copyright (c) 2010-2019 AdaCore
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -33,6 +33,7 @@
  */
 
 /* IRQMP */
+#define TYPE_GRLIB_IRQMP "grlib,irqmp"
 
 typedef void (*set_pil_in_fn) (void *opaque, uint32_t pil_in);
 
@@ -40,34 +41,6 @@ void grlib_irqmp_set_irq(void *opaque, int irq, int level);
 
 void grlib_irqmp_ack(DeviceState *dev, int intno);
 
-static inline
-DeviceState *grlib_irqmp_create(hwaddr   base,
-                                CPUSPARCState            *env,
-                                qemu_irq           **cpu_irqs,
-                                uint32_t             nr_irqs,
-                                set_pil_in_fn        set_pil_in)
-{
-    DeviceState *dev;
-
-    assert(cpu_irqs != NULL);
-
-    dev = qdev_create(NULL, "grlib,irqmp");
-    qdev_prop_set_ptr(dev, "set_pil_in", set_pil_in);
-    qdev_prop_set_ptr(dev, "set_pil_in_opaque", env);
-
-    qdev_init_nofail(dev);
-
-    env->irq_manager = dev;
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-
-    *cpu_irqs = qemu_allocate_irqs(grlib_irqmp_set_irq,
-                                   dev,
-                                   nr_irqs);
-
-    return dev;
-}
-
 /* GPTimer */
 
 static inline
-- 
2.11.0


