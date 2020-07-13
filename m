Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E66C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BFF205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1ySdcjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BFF205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzPw-0007u0-44
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB9-0005he-R0
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:35 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:37898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB6-0006gL-O9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id z13so16733163wrw.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WnultCUDMK+c95bXDFQdZPFIzDBVtTwAZ+LdBT4HiI0=;
 b=Y1ySdcjcIHRNFPny8ZqDZ3VWjwBe8huiOcdMLi0cyYNJvJr1LwCa4dAKIXENPcGt+X
 Y9ovry5nw4epD1dDsjv+7HLvBKSkcx5KFlr5sXanx9uBNRF9SczfRPsL6dtuvYjX5/Kg
 +jow2elasu5InD8eJKsgJl5xiAzlTMHVlv//vEMObzIOV1mL5DgPMiGpqp8I/hj/MJ0P
 EAdMlioF+Xtihd8ZhofFxz+aISmY52QeafuO5vyFjUBju3amuTe5sHhkX1X2AKvFT1eM
 GKZQ7sGm+oXvFD6SzmcLu4C+W9pC1mPCFV57GxDTzuVPovlxpgiWJIIGNGCR1uctqwVW
 YtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WnultCUDMK+c95bXDFQdZPFIzDBVtTwAZ+LdBT4HiI0=;
 b=BrWk5uL1kIuObfnVEP42HhxJlXvy1cBpcogyBg4W3Y4PaAt3KUCy262+T0F1wr7I5m
 CHqZC3O/qC2MbSTLywSUHh0SNxnIg/XqxUumd3ywPaDaTaWQxgFUnTaR5+s8zu+A+vZu
 dy5KJ0AnGGYS/SBh5/u9MhZRqYUXxya6U6sg7Lj2ZfC3WPkdAVyxVzhsK7+dmM0tm6xN
 FBXpWJWibt1qhxSqfZt1fslj3TiizF9aeSUIfxrQEH/VLlQFeflntmqOwpaDcauZbm8w
 qi4Zf79AL7XacRLYxfQK6bo63LkPezRDk3zsQv2NwLQyjuDR7D3N672/7miOiBbQnsWf
 CqSg==
X-Gm-Message-State: AOAM532CNJE2ZHzxVJk+GdJ09fotHZeGSSYxR8PgdHjl5+kOncAR0vBA
 +zT28hqY/F9bDdLy7MWSa1OtV77RVKkJsQ==
X-Google-Smtp-Source: ABdhPJzudGXLork20hTyvNHweIF1BOAkbUW7LqmXlpsGibu1AFrL2iZ/sVxBvBip0EihybOVHFxTyA==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr78696204wru.411.1594649490833; 
 Mon, 13 Jul 2020 07:11:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/25] hw/arm/tosa: Encapsulate misc GPIO handling in a device
Date: Mon, 13 Jul 2020 15:11:01 +0100
Message-Id: <20200713141104.5139-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Currently we have a free-floating set of IRQs and a function
tosa_out_switch() which handle the GPIO lines on the tosa board which
connect to LEDs, and another free-floating IRQ and tosa_reset()
function to handle the GPIO line that resets the system.  Encapsulate
this behaviour in a simple QOM device.

This commit fixes Coverity issue CID 1421929 (which pointed out that
the 'outsignals' in tosa_gpio_setup() were leaked), because it
removes the use of the qemu_allocate_irqs() API from this code
entirely.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200628203748.14250-3-peter.maydell@linaro.org
---
 hw/arm/tosa.c | 88 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 24 deletions(-)

diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 06ecf1e7824..383b3b22e24 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -65,24 +65,39 @@ static void tosa_microdrive_attach(PXA2xxState *cpu)
     pxa2xx_pcmcia_attach(cpu->pcmcia[0], md);
 }
 
-static void tosa_out_switch(void *opaque, int line, int level)
+/*
+ * Encapsulation of some GPIO line behaviour for the Tosa board
+ *
+ * QEMU interface:
+ *  + named GPIO inputs "leds[0..3]": assert to light LEDs
+ *  + named GPIO input "reset": when asserted, resets the system
+ */
+
+#define TYPE_TOSA_MISC_GPIO "tosa-misc-gpio"
+#define TOSA_MISC_GPIO(obj) \
+    OBJECT_CHECK(TosaMiscGPIOState, (obj), TYPE_TOSA_MISC_GPIO)
+
+typedef struct TosaMiscGPIOState {
+    SysBusDevice parent_obj;
+} TosaMiscGPIOState;
+
+static void tosa_gpio_leds(void *opaque, int line, int level)
 {
     switch (line) {
-        case 0:
-            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
-            break;
-        case 1:
-            fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
-            break;
-        case 2:
-            fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
-            break;
-        case 3:
-            fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
-            break;
-        default:
-            fprintf(stderr, "Uhandled out event: %d = %d\n", line, level);
-            break;
+    case 0:
+        fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
+        break;
+    case 1:
+        fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
+        break;
+    case 2:
+        fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
+        break;
+    case 3:
+        fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
+        break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -93,13 +108,22 @@ static void tosa_reset(void *opaque, int line, int level)
     }
 }
 
+static void tosa_misc_gpio_init(Object *obj)
+{
+    DeviceState *dev = DEVICE(obj);
+
+    qdev_init_gpio_in_named(dev, tosa_gpio_leds, "leds", 4);
+    qdev_init_gpio_in_named(dev, tosa_reset, "reset", 1);
+}
+
 static void tosa_gpio_setup(PXA2xxState *cpu,
                 DeviceState *scp0,
                 DeviceState *scp1,
                 TC6393xbState *tmio)
 {
-    qemu_irq *outsignals = qemu_allocate_irqs(tosa_out_switch, cpu, 4);
-    qemu_irq reset;
+    DeviceState *misc_gpio;
+
+    misc_gpio = sysbus_create_simple(TYPE_TOSA_MISC_GPIO, -1, NULL);
 
     /* MMC/SD host */
     pxa2xx_mmci_handlers(cpu->mmc,
@@ -107,8 +131,8 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
                     qemu_irq_invert(qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_nSD_DETECT)));
 
     /* Handle reset */
-    reset = qemu_allocate_irq(tosa_reset, cpu, 0);
-    qdev_connect_gpio_out(cpu->gpio, TOSA_GPIO_ON_RESET, reset);
+    qdev_connect_gpio_out(cpu->gpio, TOSA_GPIO_ON_RESET,
+                          qdev_get_gpio_in_named(misc_gpio, "reset", 0));
 
     /* PCMCIA signals: card's IRQ and Card-Detect */
     pxa2xx_pcmcia_set_irq_cb(cpu->pcmcia[0],
@@ -119,10 +143,14 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
                         qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_JC_CF_IRQ),
                         NULL);
 
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED, outsignals[0]);
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED, outsignals[1]);
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED, outsignals[2]);
-    qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED, outsignals[3]);
+    qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED,
+                          qdev_get_gpio_in_named(misc_gpio, "leds", 0));
+    qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED,
+                          qdev_get_gpio_in_named(misc_gpio, "leds", 1));
+    qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED,
+                          qdev_get_gpio_in_named(misc_gpio, "leds", 2));
+    qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED,
+                          qdev_get_gpio_in_named(misc_gpio, "leds", 3));
 
     qdev_connect_gpio_out(scp1, TOSA_GPIO_TC6393XB_L3V_ON, tc6393xb_l3v_get(tmio));
 
@@ -287,10 +315,22 @@ static const TypeInfo tosa_ssp_info = {
     .class_init    = tosa_ssp_class_init,
 };
 
+static const TypeInfo tosa_misc_gpio_info = {
+    .name          = "tosa-misc-gpio",
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TosaMiscGPIOState),
+    .instance_init = tosa_misc_gpio_init,
+    /*
+     * No class init required: device has no internal state so does not
+     * need to set up reset or vmstate, and has no realize method.
+     */
+};
+
 static void tosa_register_types(void)
 {
     type_register_static(&tosa_dac_info);
     type_register_static(&tosa_ssp_info);
+    type_register_static(&tosa_misc_gpio_info);
 }
 
 type_init(tosa_register_types)
-- 
2.20.1


