Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0786BC04E84
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0960206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0960206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQt9B-0004ij-Tu
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:36:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hQt4b-00018h-MX
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hQt4Z-0006Gl-TL
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:31:53 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:48086
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hQt4Z-0006C4-JC
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:31:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 6608681399;
	Wed, 15 May 2019 14:31:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sTTll03NCpE2; Wed, 15 May 2019 14:31:48 +0200 (CEST)
Received: from wifi-guest-96.act-europe.fr (wifi-guest-96.act-europe.fr
	[10.10.126.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id 4D8AF81392;
	Wed, 15 May 2019 14:31:48 +0200 (CEST)
From: KONRAD Frederic <frederic.konrad@adacore.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 14:31:28 +0200
Message-Id: <1557923493-4836-3-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557923493-4836-1-git-send-email-frederic.konrad@adacore.com>
References: <1557923493-4836-1-git-send-email-frederic.konrad@adacore.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
Subject: [Qemu-devel] [PATCH v3 2/7] grlib,
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
	chouteau@adacore.com, frederic.konrad@adacore.com,
	philmd@redhat.com, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/intc/grlib_irqmp.c    |  3 +--
 hw/sparc/leon3.c         | 12 ++++++++++--
 include/hw/sparc/grlib.h | 31 ++-----------------------------
 3 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/hw/intc/grlib_irqmp.c b/hw/intc/grlib_irqmp.c
index d6f9cb3..20accb6 100644
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
index f438718..3430693 100644
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
index 61a345c..bef371a 100644
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
1.8.3.1


