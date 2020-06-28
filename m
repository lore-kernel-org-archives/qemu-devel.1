Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7228C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 21:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A135620720
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 21:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="klJLyuiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A135620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpf5Y-0000z4-V4
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 17:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpf4Q-0008F0-NH
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 17:42:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43123)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpf4O-00073J-0N
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 17:42:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id j4so12196283wrp.10
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ueTMRGS8RlMtxcVmTh1y5s8U6X/zJuJaAqd5maYfOBU=;
 b=klJLyuiK2tqR7Fjyk0UQ8fm3uaf+tk0YWm8kOvRmZlFj7+UPvRceuPeaM1tbzGcTcA
 3cI+NseMKwUGCYInsLsIcyk9yMT/Klkc288MShVFw9xTHw+txKmoa57DmBxNHbxn0NmV
 JcgV1X/hrUDhNJXfsMbjeFZQBYfql3UiUGe2FNso2D/xN+RVC2O97sRSh0C+Sz5S8/hJ
 G78DR7Xr+r9ziN6zonuLYRLwyXnYj6CbWsvVFCHASJdo69caxrIx3O4J8lk3kqvmRscs
 gLUTbk+cNrxJp4gDg4HbVH7W5oR7n+DL70Ex4U3rrOd12alVQc2t0JXKkIaWWLmHzjE1
 2wZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ueTMRGS8RlMtxcVmTh1y5s8U6X/zJuJaAqd5maYfOBU=;
 b=pDUJ4GdTyEVaeM6tCtoEd6E5RDBZCGt9gDVYCiKj7BBsk9xEK3jsaZxHqzt8FkJQWT
 Jlbm6zGf7KxihmN82QN1p5G/5OGfUVmtu0BR3yDjm+lq0L9347cLRPPLX/W64B6oM7UR
 8Ej8FjGlIjiSXnMRY9SErtj+TIvIU5A8n88KdqxUiqDhuqrefiwcFxSMpL+nLr7J98SE
 OjR08Ubes/CImlPVm0DsCQD9VGtoIiJsaUeizjtFsJsjxosnMBHsB91RS8cpK3w7Pkl+
 HR48kieGAfFKvfAlByNB8cKc0lNL+GxNpx7qpq7lC1ATGdwRlKM0vEBemGTFSPnn986F
 xVDw==
X-Gm-Message-State: AOAM530HR61mR5uOVF2DJtxpUlDCcGwb05kQMP6YbMv+YJVX8gPRTC3Y
 cp6LwExi/Ge2Bkm8M3aLQFpRww==
X-Google-Smtp-Source: ABdhPJycH/yPFmJdCzHapmTMTGyn1tN0KUoTtNvljE7CqI1SeZpql+S46p6f044XNqgy1LO/yPD3ZA==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr14159235wrt.108.1593380554713; 
 Sun, 28 Jun 2020 14:42:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t16sm26300948wru.9.2020.06.28.14.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 14:42:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/arm/palm.c: Encapsulate misc GPIO handling in a device
Date: Sun, 28 Jun 2020 22:42:30 +0100
Message-Id: <20200628214230.2592-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628214230.2592-1-peter.maydell@linaro.org>
References: <20200628214230.2592-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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


