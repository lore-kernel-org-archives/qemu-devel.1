Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C81AC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4702082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3wkgZ93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4702082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j331T-000485-EM
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32v7-0000E5-G9
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32v6-0004MY-09
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:16:05 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j32v4-0004Kq-36; Sat, 15 Feb 2020 14:16:02 -0500
Received: by mail-wm1-x342.google.com with SMTP id a6so14372256wme.2;
 Sat, 15 Feb 2020 11:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n/gOm3ZXg/TwLxJpokjY3cZbchzlNr35zqh4aJfwE0I=;
 b=E3wkgZ93HkfEh/vy24ARsp0MQkSmvghpSkRDCgjBZko7bjTn0uUpl4oSJYEmOzAdIR
 0Q1iI9vWkEp+mpjgbD2YzQ3STbzIBa8FGYGDMEDNQdhKdf7GEGL3O1Wp16Un37Kf3qya
 6/ZDFoes/E+MyEWxfIYvUor/Lo1EET4QlOADn4GV9xSfxTF9OebouGiuWZIioAeKMQe8
 lM93A9A1xYVWplKzbV3iIQ8qZnjFup0ym6GKdqsTpb8pB7nvT00erd8Ioo7k36Th5dz1
 f01AqjBV/xgDnqe9RZVAdvBFoSCjYP/ma/w07kZgfvBXzZD/B16cVzWrne4IwPlPkbcg
 7oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=n/gOm3ZXg/TwLxJpokjY3cZbchzlNr35zqh4aJfwE0I=;
 b=GSvcwAEsQF4bczctECi4KEs8xL/dH6H/QUMsUmIRPL05J1lqvWm59rrsnQK/ThXH3u
 XinofsVXNfGUsk8OibgTMz629hDkh1iUu/Xym5sYfK8D0XK+PLHF58PHE9NFUlV+Nvro
 8FkmwZowS+8DbYK+7SYvlmkznN72Tnj6tCSwHXTe4uZwWyw8aAMqobHH+ELwPu+1SOc2
 qOvMvxZgr9VnG3c24Y6X/F1JAIf7I9fcuRNMtvoauL/1ZNF60vKX+Re9/gNSKeyd9hvY
 UY21gFOUvVoS4hYSaupkAYBcSoOYWi2pfBsuPk7rGLeJuhPTBY0KZOn/4U5rK0K7z2/9
 S1CA==
X-Gm-Message-State: APjAAAVPEqW6wPSSMf3E13OY4Y7hiW1tfLdiYwpBLBgXwHhuLkZNRODJ
 cYDAS9Dr6yTzs7QDd/4rllUXaPywrmM=
X-Google-Smtp-Source: APXvYqz3FZ5TktiXi1wfXe+ZQibqsJbo+zG77MucmdtvdLSG9xPAIvK1zAktqxEE2P5R/y44Hb0rLw==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr11352903wml.47.1581794159923; 
 Sat, 15 Feb 2020 11:15:59 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o9sm9678605wrw.20.2020.02.15.11.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:15:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/12] hw/arm/bcm2836: Introduce the BCM2835 SoC
Date: Sat, 15 Feb 2020 20:15:41 +0100
Message-Id: <20200215191543.3235-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215191543.3235-1-f4bug@amsat.org>
References: <20200215191543.3235-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h |  1 +
 hw/arm/bcm2836.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/raspi.c           |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index acc75bf553..3d46469a73 100644
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
index 2b6fe31139..bce5f8a866 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -103,6 +103,31 @@ static void bcm283x_common_realize(DeviceState *dev, Error **errp)
                             bc->peri_base, 1);
 }
 
+static void bcm2835_realize(DeviceState *dev, Error **errp)
+{
+    BCM283XState *s = BCM283X(dev);
+    Error *err = NULL;
+
+    bcm283x_common_realize(dev, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_bool(OBJECT(&s->cpu[0].core), true,
+                             "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* Connect irq/fiq outputs from the interrupt controller. */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
+            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
+            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_FIQ));
+}
+
 static void bcm2836_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
@@ -184,6 +209,17 @@ static void bcm283x_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 }
 
+static void bcm2835_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    BCM283XClass *bc = BCM283X_CLASS(oc);
+
+    bc->cpu_type = ARM_CPU_TYPE_NAME("arm1176");
+    bc->core_count = 1;
+    bc->peri_base = 0x20000000;
+    dc->realize = bcm2835_realize;
+};
+
 static void bcm2836_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -214,6 +250,10 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo bcm283x_types[] = {
     {
+        .name           = TYPE_BCM2835,
+        .parent         = TYPE_BCM283X,
+        .class_init     = bcm2835_class_init,
+    }, {
         .name           = TYPE_BCM2836,
         .parent         = TYPE_BCM283X,
         .class_init     = bcm2836_class_init,
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 38829195c5..6db2bf5bbe 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -70,6 +70,7 @@ FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
 FIELD(REV_CODE, STYLE,             23, 1);
 
 typedef enum RaspiProcessorId {
+    PROCESSOR_ID_BCM2835 = 0,
     PROCESSOR_ID_BCM2836 = 1,
     PROCESSOR_ID_BCM2837 = 2,
 } RaspiProcessorId;
@@ -78,6 +79,7 @@ static const struct {
     const char *type;
     int cores_count;
 } soc_property[] = {
+    [PROCESSOR_ID_BCM2835] = {TYPE_BCM2835, 1},
     [PROCESSOR_ID_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS},
     [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
 };
-- 
2.21.1


