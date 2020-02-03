Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11355C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D107320661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWoYjOGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D107320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXcB-00028O-09
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyXa9-0008AU-5v
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyXa8-0007b9-0M
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:59:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55366)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iyXa7-0007aj-PS; Mon, 03 Feb 2020 03:59:47 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so14827167wmj.5;
 Mon, 03 Feb 2020 00:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=skNJ/BGH0y+JxuI4sQ86g1cgznE5/NeuYWJkhvsn8Dw=;
 b=JWoYjOGx4J3bzpkjM9eH39hNTO5arMk/OVYxSDpCmrFdMB1YzuNMODQz3Yy43a8AvH
 z5/gjBkUbglSo49FzO7yh1E+3WMP7XWnhwZbbd96t6sC/QjKqyAzcXBDLlp9C8WC6Qlo
 qQjk+/YG2zx0nwZwTSCEalyYgpkVah0BD8hPhRRHUThByLxqW/qqkbTwKEse+7MqBuOQ
 Kz3Mtw7bkyDlHgEFOf70P2Ec9cyuiBmjrvzAkTiTckTk0kQ/Qq2Amfyfn7V895sDqpHp
 z7A3jsivK79J2WBMNe2l9AmnSPKSUEaiuyJPXR+cw/0mLehczrMaILw+/T7hPoN2hjDH
 T4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=skNJ/BGH0y+JxuI4sQ86g1cgznE5/NeuYWJkhvsn8Dw=;
 b=Nq4KobhTI2mjaKsnOIPyZXcYvY3Oz8AWI2YaxGsNgZVI/kIWY3rOY44seo1QRnLlE6
 7UGuz8NdqJUlEg0QSWema5QywOI4eyAdN6NeAm4TUpTEyI+BbSUJKhw1B9CqzOt7kOp/
 XnFhVfO6DoSw0ArWpbTcrHeF9uRzS35urjj19Zl/vTImLmFZ1TsPTW6DvoAUdS79GG1Y
 c5ebndJOwO2NcF5YwtkQ3GqIdg0ueXPyFb1GP9gh5wUZlVQ0No5MM4rqSu25gUniImWp
 RPqVHIPv2vL/aXtW5ix6OwtvvIcszcCmRp6RPofi72qnC+E54itiwbO+sPUx1WgCvqwQ
 f7IQ==
X-Gm-Message-State: APjAAAUtuGAAQhQy7HwGACdwcUi4SKQD6yOh3YVovQkPvd9jvdPTo2Iu
 rck4Ib6NtfMFKyoBJtjjwpDKjSfm
X-Google-Smtp-Source: APXvYqyWlb/bxOVcHbLLOxd+Dng7VS/XOQnXJkgNHCk8yBPNDSFu0gKJJeEv+CbG/yfQtCPiMIaV6g==
X-Received: by 2002:a1c:7dd4:: with SMTP id y203mr28278459wmc.67.1580720386519; 
 Mon, 03 Feb 2020 00:59:46 -0800 (PST)
Received: from localhost.localdomain (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id j5sm10029678wrw.24.2020.02.03.00.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 00:59:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [NOTFORMERGE PATCH 1/2] hw/arm: Add the BCM2835 SoC
Date: Mon,  3 Feb 2020 09:59:41 +0100
Message-Id: <20200203085942.19826-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200203085942.19826-1-f4bug@amsat.org>
References: <20200203085942.19826-1-f4bug@amsat.org>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the BCM2835 SoC, which uses a ARM1176JZF-S core.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
TODO: better QOM modelling of core_count and intc

 include/hw/arm/bcm2836.h |  1 +
 hw/arm/bcm2836.c         | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 92a6544816..5c3f8958ef 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -24,6 +24,7 @@
  * them, code using these devices should always handle them via the
  * BCM283x base class, so they have no BCM2836(obj) etc macros.
  */
+#define TYPE_BCM2835 "bcm2835"
 #define TYPE_BCM2836 "bcm2836"
 #define TYPE_BCM2837 "bcm2837"
 
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 38e2941bab..e4a89f0381 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -21,13 +21,21 @@ struct BCM283XInfo {
     const char *cpu_type;
     hwaddr peri_base; /* Peripheral base address seen by the CPU */
     hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
+    int core_count;
     int clusterid;
 };
 
 static const BCM283XInfo bcm283x_socs[] = {
+    {
+        .name = TYPE_BCM2835,
+        .cpu_type = ARM_CPU_TYPE_NAME("arm1176"),
+        .core_count = 1,
+        .peri_base = 0x20000000,
+    },
     {
         .name = TYPE_BCM2836,
         .cpu_type = ARM_CPU_TYPE_NAME("cortex-a7"),
+        .core_count = 4,
         .peri_base = 0x3f000000,
         .ctrl_base = 0x40000000,
         .clusterid = 0xf,
@@ -36,6 +44,7 @@ static const BCM283XInfo bcm283x_socs[] = {
     {
         .name = TYPE_BCM2837,
         .cpu_type = ARM_CPU_TYPE_NAME("cortex-a53"),
+        .core_count = 4,
         .peri_base = 0x3f000000,
         .ctrl_base = 0x40000000,
         .clusterid = 0x0,
@@ -50,14 +59,16 @@ static void bcm2836_init(Object *obj)
     const BCM283XInfo *info = bc->info;
     int n;
 
-    for (n = 0; n < BCM283X_NCPUS; n++) {
+    for (n = 0; n < info->core_count; n++) {
         object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
                                 sizeof(s->cpu[n].core), info->cpu_type,
                                 &error_abort, NULL);
     }
 
-    sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
-                          TYPE_BCM2836_CONTROL);
+    if (info->ctrl_base) {
+        sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->control),
+                              TYPE_BCM2836_CONTROL);
+    }
 
     sysbus_init_child_obj(obj, "peripherals", &s->peripherals,
                           sizeof(s->peripherals), TYPE_BCM2835_PERIPHERALS);
@@ -107,6 +118,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
                             info->peri_base, 1);
 
+    if (info->ctrl_base) {
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
     if (err) {
@@ -120,8 +132,22 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
         qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
+    }
 
-    for (n = 0; n < BCM283X_NCPUS; n++) {
+    if (!info->ctrl_base) {
+        object_property_set_bool(OBJECT(&s->cpu[0].core), true,
+                                 "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        /* Connect irq/fiq outputs from the interrupt controller. */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
+                qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_IRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
+                qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_FIQ));
+    } else {
+    for (n = 0; n < info->core_count; n++) {
         /* TODO: this should be converted to a property of ARM_CPU */
         s->cpu[n].core.mp_affinity = (info->clusterid << 8) | n;
 
@@ -165,6 +191,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_SEC,
                 qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", n));
     }
+    }
 }
 
 static Property bcm2836_props[] = {
-- 
2.21.1


