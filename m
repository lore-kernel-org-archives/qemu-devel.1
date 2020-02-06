Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA6C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E7220661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDmugTXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E7220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izW25-0002Lw-K3
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoZ-000137-Kk
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoX-0003kx-AW
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:37017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoX-0003fV-1h; Wed, 05 Feb 2020 20:18:41 -0500
Received: by mail-wm1-x336.google.com with SMTP id f129so5041118wmf.2;
 Wed, 05 Feb 2020 17:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/UJgNTzw4Gx4xqlDoFjvxGAMlpuH/2K8HEVCtznof0k=;
 b=lDmugTXxXUkIAWebkrZ2Oph5cBmnJi3cHYIotx7pAUf34EisrFfay9K7P5gsU9zU30
 HSjZM+0ZCNEMX8FrOa4s5EkqxXGXBS23Ap8Cf44Aj9CZXYYObpZUMSBm6RLp1vxsSOqF
 6SvJ9zvQAIKQ1EHHBwClPElY8CdV4H53VIQdDDKd9+BDS0JBynJ5Jeb3uxPLW+LRBjEG
 rkaw9EvpSXmH3KGMYQsTfvYovPyi+oI6zyuyh6QBQ1uwBIcq41e6LjGvU5/RhcAW2J5A
 qdnrIrRVsxgq2LwJpOF+X7l16VFwjMUQfUmGHCua3/K25RRL9p8TkZNxQkZ+wiQCDyI2
 +Kow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=/UJgNTzw4Gx4xqlDoFjvxGAMlpuH/2K8HEVCtznof0k=;
 b=ABZamC3+xbaOQFn7+8WeryvruJ6PMdvTesMVt852Baf07WKMVeF+dD2SpymMx7QPES
 4+lknMfjq0bqu1J2os56oHWvR20SLH5qxi6qxBhjYlnrJB7kESkmAc8NQcMhQGz/OQgb
 ws5RBsbX0VeRcyNfW1Lp1fvmZDokL/RPj9jMI7ur4nH8bdGwvJ0Ug7swATXOAA2M9qne
 p/7EmCJDvSGW029DbcjE1b3DKEvyjXuO3wmT3J0o5qNws0mlNqpiudySBfDaaeiHJVhi
 BuIxCeh0oTObrsbZQtSOM8+dbMa+LgYJgVhqwr9Wzwg60awehGLo60DNvZlSUPCs0WaC
 dJZA==
X-Gm-Message-State: APjAAAWhU7HqChvXz76onR6siYo06Axipu/+xvd8vE92N9/cgn81Grqb
 c6DaXJJ5v3aUvAboOpI9kiQYX4EG
X-Google-Smtp-Source: APXvYqyGm+iF5p8CMSsSSsM3yUk6NSZx9k1rp/RFyM4LcMOtJ3LWnXht5fMOPt+r3khBQVjfexWcfQ==
X-Received: by 2002:a05:600c:21ce:: with SMTP id
 x14mr619657wmj.120.1580951919723; 
 Wed, 05 Feb 2020 17:18:39 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/30] hw/arm/bcm2836: Introduce the BCM2835 SoC
Date: Thu,  6 Feb 2020 02:17:45 +0100
Message-Id: <20200206011756.2413-20-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h |  1 +
 hw/arm/bcm2836.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

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
-- 
2.21.1


