Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B1FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DA820738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLUUjYtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DA820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzHD-0008Bn-Mn
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzBB-0005jF-MD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB8-0006gr-I9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:37 -0400
Received: by mail-wm1-x341.google.com with SMTP id a6so111533wmm.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MHD7c88AS73IuJuFfkFyKX8KupwIl5bGxCUU0rAKXto=;
 b=sLUUjYtIOlNpoLaIRb6P8zx9S5We4EbkWWunsl/AIIcroJxu86F8sp77NgNewtn8Ut
 DcfqX+/GuxmzJpQNzglh//w/AdtW9gXNDlkGu4pC9S1OHdSfRAbWv4krH0uSww4xE6NB
 JpbP8lzZmEb0UhWKy/1k8t4uFvFRZqGSso4U1Cw7quMe1a1OGVm7YME3nl3R/4ZAMJ/h
 wiZABDJcW5w+L9Wtyyf8Qrl2gyzGoaf2D6tpBwbcJ1/bhMjOVrPKfIaRWpJr5RFmOMf6
 n32OeF6CIvGhuWP7mykrK5CkPrMcVKCUluT/6oAqU5dwSOqzTREZJDgozYyX9OKHIfI1
 /Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MHD7c88AS73IuJuFfkFyKX8KupwIl5bGxCUU0rAKXto=;
 b=SZmmraBVGKqeVWMPYNqAkGoiA4vTjFLEA2/HqHbCQxwzhyxyuEJl/D0nlHGl36DeBi
 4pbXGHJiSOMQII0SKrNiW/CcKhYJxF+eYtn67bdAaxPGKIMCuslIqvzy2RWqoURaDxci
 UXBB4ZF2qLWnQya0RTwQnw9jKzPxQ54WueAtrIqloEUWoQhEoA6eYoezpCRD3FfISL6X
 5FdM+RJFeDs/cfxtduB8LqXjUaJlX7hoOe4vGJ/8JzePsEowZ6FjxhUKSCsb3+E7fOxY
 KHl9KflKFGJiXkQ4xk8UCSgHlao060A4DmFyVwNAHDIj3l867iCdnXmgKEZBPw5cFhby
 MT4w==
X-Gm-Message-State: AOAM533CvhmOEj4VEVRWtqtmjTed360nIpL/FtatfbIc4uvbc+RGhYGD
 nARc8VLZvSO836fE6Zrpn1AHBorfKdUg2g==
X-Google-Smtp-Source: ABdhPJz0ulzWaddPZjAzpsR5Fl+fTgFtErTrGFby9FpHRnXjoaXOEw6i/ZzWAU5UZ2eLE69eQiUTnA==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr174023wmc.72.1594649493014;
 Mon, 13 Jul 2020 07:11:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/25] hw/arm/palm.c: Encapsulate misc GPIO handling in a device
Date: Mon, 13 Jul 2020 15:11:03 +0100
Message-Id: <20200713141104.5139-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

Replace the free-floating set of IRQs and palmte_onoff_gpios()
function with a simple QOM device that encapsulates this
behaviour.

This fixes Coverity issue CID 1421944, which points out that
the memory returned by qemu_allocate_irqs() is leaked.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200628214230.2592-3-peter.maydell@linaro.org
---
 hw/arm/palm.c | 61 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 569836178f6..e7bc9ea4c6a 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -124,6 +124,21 @@ static void palmte_button_event(void *opaque, int keycode)
                         !(keycode & 0x80));
 }
 
+/*
+ * Encapsulation of some GPIO line behaviour for the Palm board
+ *
+ * QEMU interface:
+ *  + unnamed GPIO inputs 0..6: for the various miscellaneous input lines
+ */
+
+#define TYPE_PALM_MISC_GPIO "palm-misc-gpio"
+#define PALM_MISC_GPIO(obj) \
+    OBJECT_CHECK(PalmMiscGPIOState, (obj), TYPE_PALM_MISC_GPIO)
+
+typedef struct PalmMiscGPIOState {
+    SysBusDevice parent_obj;
+} PalmMiscGPIOState;
+
 static void palmte_onoff_gpios(void *opaque, int line, int level)
 {
     switch (line) {
@@ -151,23 +166,44 @@ static void palmte_onoff_gpios(void *opaque, int line, int level)
     }
 }
 
+static void palm_misc_gpio_init(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+
+    qdev_init_gpio_in(dev, palmte_onoff_gpios, 7);
+}
+
+static const TypeInfo palm_misc_gpio_info = {
+    .name = TYPE_PALM_MISC_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PalmMiscGPIOState),
+    .instance_init = palm_misc_gpio_init,
+    /*
+     * No class init required: device has no internal state so does not
+     * need to set up reset or vmstate, and has no realize method.
+     */
+};
+
 static void palmte_gpio_setup(struct omap_mpu_state_s *cpu)
 {
-    qemu_irq *misc_gpio;
+    DeviceState *misc_gpio;
+
+    misc_gpio = sysbus_create_simple(TYPE_PALM_MISC_GPIO, -1, NULL);
 
     omap_mmc_handlers(cpu->mmc,
                     qdev_get_gpio_in(cpu->gpio, PALMTE_MMC_WP_GPIO),
                     qemu_irq_invert(omap_mpuio_in_get(cpu->mpuio)
                             [PALMTE_MMC_SWITCH_GPIO]));
 
-    misc_gpio = qemu_allocate_irqs(palmte_onoff_gpios, cpu, 7);
-    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,     misc_gpio[0]);
-    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,       misc_gpio[1]);
-    qdev_connect_gpio_out(cpu->gpio, 11,                        misc_gpio[2]);
-    qdev_connect_gpio_out(cpu->gpio, 12,                        misc_gpio[3]);
-    qdev_connect_gpio_out(cpu->gpio, 13,                        misc_gpio[4]);
-    omap_mpuio_out_set(cpu->mpuio, 1,                           misc_gpio[5]);
-    omap_mpuio_out_set(cpu->mpuio, 3,                           misc_gpio[6]);
+    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,
+                          qdev_get_gpio_in(misc_gpio, 0));
+    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,
+                          qdev_get_gpio_in(misc_gpio, 1));
+    qdev_connect_gpio_out(cpu->gpio, 11, qdev_get_gpio_in(misc_gpio, 2));
+    qdev_connect_gpio_out(cpu->gpio, 12, qdev_get_gpio_in(misc_gpio, 3));
+    qdev_connect_gpio_out(cpu->gpio, 13, qdev_get_gpio_in(misc_gpio, 4));
+    omap_mpuio_out_set(cpu->mpuio, 1, qdev_get_gpio_in(misc_gpio, 5));
+    omap_mpuio_out_set(cpu->mpuio, 3, qdev_get_gpio_in(misc_gpio, 6));
 
     /* Reset some inputs to initial state.  */
     qemu_irq_lower(qdev_get_gpio_in(cpu->gpio, PALMTE_USBDETECT_GPIO));
@@ -276,3 +312,10 @@ static void palmte_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE("cheetah", palmte_machine_init)
+
+static void palm_register_types(void)
+{
+    type_register_static(&palm_misc_gpio_info);
+}
+
+type_init(palm_register_types)
-- 
2.20.1


