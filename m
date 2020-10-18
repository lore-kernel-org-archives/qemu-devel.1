Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC55C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43FE22277
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJX+QQLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43FE22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFTH-0000oU-1k
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFNx-0001ur-Il; Sun, 18 Oct 2020 16:34:33 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUFNv-0000zn-Sy; Sun, 18 Oct 2020 16:34:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id h5so9125883wrv.7;
 Sun, 18 Oct 2020 13:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jViLzsnHUVqtQxwtvYdFxDUn3i00wRweHY3mgJ2gUEU=;
 b=GJX+QQLtomsdm7cmL4jaXRaGnQLv2L5aOFrd20TR+jHML8J4tkjGUye5K2o7Fb+WLP
 kHrREpL1OQ4y5D/a9Ulr+j/k+7HgKIWLb3UXcmJP4MvLHH/4Bjn56xUGCYvHXT0A0/nM
 joSqGxFVs542g+fYb195ZO+PfrBaRXUMWLGBuL25wM1aitEmhLoz6NKR8YhzDrtc+X4e
 knZvjIZPEJ41SZWtAFNzwDtEMacXIwLAcb+kxEOYx7KkCT4ffZ1dNdXyLlM+W4H4m/rU
 zFKMVmryNmJM2BIotDvOrIhbXL7E2JiRoy5E3idGM/ISO1a3MTdVeF5+KTgVrKeBzM+p
 DTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jViLzsnHUVqtQxwtvYdFxDUn3i00wRweHY3mgJ2gUEU=;
 b=Npdh8mbHNZZHTUcqH8BvCHCHQgSHosYaMjLa5Uji4dYYamlaBHDR1zNTw27jQprxu+
 bh5nu2JJFZQTj53B1ombvAyEyxnLE5X0ON/0AadnV+sBMYWGzZVB0Dy6xmA2NaoEnyJA
 FuV+ZKv5Iqw1v2mS4rIjBYWm7o9EZaaIwbqZsrShQFhStJOnnypALNA+6T5ZoQzs3Pff
 8b58rLkpmbKvasiHv20pzLH4bTpmk8DOxzEzm2mHI8gTONGj2UsjAEuRJLDzfHCbKKxY
 8VZ7F6tUqRJDsaHXOUQKmZ2Zgz5a/zPz6iapY6KQvEfM7RisktWDfpqcSUjvyIdCAC12
 pV6A==
X-Gm-Message-State: AOAM530eQuSjjYjcWJDALD+mDXVk+bU+ODC/NyIVuoFI0HaXCeEvCL+D
 Ycr8+BdTb02QQjYVfTn3wkdPWeZback=
X-Google-Smtp-Source: ABdhPJz1YsVU2ZrYV7Qhiz2KxK32B+L/6zVQNSJyPunndu8CLQiAuO8FOKyF5bUBFK1q5xz/twAVZA==
X-Received: by 2002:adf:cc82:: with SMTP id p2mr16478026wrj.177.1603053269399; 
 Sun, 18 Oct 2020 13:34:29 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id p9sm13102665wmm.4.2020.10.18.13.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 13:34:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/9] hw/arm/bcm2836: Introduce the BCM2835 SoC
Date: Sun, 18 Oct 2020 22:33:55 +0200
Message-Id: <20201018203358.1530378-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201018203358.1530378-1-f4bug@amsat.org>
References: <20201018203358.1530378-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/bcm2836.h |  1 +
 hw/arm/bcm2836.c         | 34 ++++++++++++++++++++++++++++++++++
 hw/arm/raspi.c           |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 43e9f8cd0ef..6f90cabfa3a 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -26,6 +26,7 @@ OBJECT_DECLARE_TYPE(BCM283XState, BCM283XClass, BCM283X)
  * them, code using these devices should always handle them via the
  * BCM283x base class, so they have no BCM2836(obj) etc macros.
  */
+#define TYPE_BCM2835 "bcm2835"
 #define TYPE_BCM2836 "bcm2836"
 #define TYPE_BCM2837 "bcm2837"
 
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 7d975cf2f53..de7ade2878e 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -89,6 +89,25 @@ static bool bcm283x_common_realize(DeviceState *dev, Error **errp)
     return true;
 }
 
+static void bcm2835_realize(DeviceState *dev, Error **errp)
+{
+    BCM283XState *s = BCM283X(dev);
+
+    if (!bcm283x_common_realize(dev, errp)) {
+        return;
+    }
+
+    if (!qdev_realize(DEVICE(&s->cpu[0].core), NULL, errp)) {
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
@@ -159,6 +178,17 @@ static void bcm283x_class_init(ObjectClass *oc, void *data)
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
@@ -189,6 +219,10 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
 
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
index b5b30f0f38f..30fafa59ecb 100644
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
2.26.2


