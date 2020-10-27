Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F71C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927C321655
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZT+Sm0iR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927C321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOFU-0002SF-Iu
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPk-0001g5-Pl
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:20 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:34320)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPf-0004cw-Ab
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:20 -0400
Received: by mail-wr1-x42b.google.com with SMTP id i1so1562913wro.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sdjGX6xv31J1AJEP1OECkZCBJRmfrzAZBgvXrQVL0GE=;
 b=ZT+Sm0iRGCfLCoWeo2WYsgZQAzuNS1LuU674qRjrBNFdwVSgD9lPsfhuH8V+eurqcB
 guLL/hgX5MJDo2RiPswkGZOJP0a0UlpW8BjOeV4FXuk3j0VXRbUexSGt8MNHxEdyb3uq
 dsGzHeKqPcbKV9YdmJX2//TAQl3mQMEtLTnD7WxtsqLwS1yp+HpsfWNRGprpDUpgwJy+
 lYa/Cj520CEXtVVzsYdDo2zeGlVfTRSuywjOExFV+N527h208oK2mxAtbDxV1/kg+Ub9
 59ONS1VkjXTrIxwLocx1TfJuOKJFDGJL8hJvuvcK1EkJHV7+rIssX4M4it3YYDVKi7h5
 B/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sdjGX6xv31J1AJEP1OECkZCBJRmfrzAZBgvXrQVL0GE=;
 b=by+/nrZ61AXd7z6eyrbZdo7AlJS/zHGx+Eyjsdy/1W1OxmrrKY5jAYp2iqSaHtb6BR
 qDogiTNLStDfQqWp784WnUEy5WyBqP2ouLjXzqKhkwLak/uL7Gl8HbVZREp4puasJ2pl
 QtWANj5nYL1pUjA2Aa32PRoIt6THPDwhnIfnSW21pFVhUrX3PimyCJ60SyI9qn2pvXFC
 tXcUlBcfNMAH5UeiN/hveuvJoSsG92eGlnhIkFacyGxqpQmCPBsa3kgj+kDjqMqV1vJg
 r8OmGG+Spvxz03zDJRmF2/iBcLaL6WFlCjBuhs5ogqqkkE0a/7DAziuviLU5s+w1XJNH
 o2Fw==
X-Gm-Message-State: AOAM5302vdA0ssVbxajziBGiGI7MBD3DWNzr82ZjPnt4PivMlqcyYqxj
 Nf1jErHtDX1aSQUEHzr78zEOJOTLIAe14w==
X-Google-Smtp-Source: ABdhPJxayeZs0KYCeYba6RD4Ku2EvVTf4E3v1rdTXc66pIdWH5cSqktYI7Q2W2K9nMATm6pWEHcPNA==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr2512844wrn.188.1603799113692; 
 Tue, 27 Oct 2020 04:45:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/48] hw/arm/bcm2836: Introduce the BCM2835 SoC
Date: Tue, 27 Oct 2020 11:44:16 +0000
Message-Id: <20201027114438.17662-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201024170127.3592182-7-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.20.1


