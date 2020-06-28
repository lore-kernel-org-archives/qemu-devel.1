Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D89C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 20:40:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E2D9206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 20:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BiKGJoy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2D9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpe6K-0007bo-RV
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 16:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpe3p-0004VP-FD
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 16:37:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpe3n-0006TP-GH
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 16:37:57 -0400
Received: by mail-wr1-x443.google.com with SMTP id o11so14572255wrv.9
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 13:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9WB0821wCgZMHTZ36aCK0ZT0ZEbBpWrgPt5kmPCgRK8=;
 b=BiKGJoy2Btx7daLQq43OO/Xp0Br5US3M879E+npz2Lln/IWJGuvXBm3BG0+kvjz08K
 aZNBZM4h/fLTpfs++xyJESVG8tC81pvCoF2Vm5d1IOw8b8hq8upLCJ7LisJMaxwWGcpu
 yV2Ft0Y7h/0naprjsiS9whwpU0gs6VGcqLpTxaa+3UkRsA2R76y4D5Xl5GKJDVPsoMFA
 oN1Zjb21f1ZeqJDEqRB490Dh/KJf5UVy1Gaqjq1z30sK9kRgipxUsYf0cMuNP56FrNOi
 Lh0n1irMzj6UdypXGu05oGY5PkbL7hdYmEr8EW4eWuxJKdcnBcxeH7IDJnT0BQHvDFGe
 /p2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9WB0821wCgZMHTZ36aCK0ZT0ZEbBpWrgPt5kmPCgRK8=;
 b=A7eAiDSxCTM2Cvdta8fVOHIcmb2KeCWMZORBQx0B2qn4F8R4YR8Lf6AAPvgoTbzI1K
 ZVDPQCPpObABBUZ4klXmCNh205bo3c9crubxrSvUx80nkbcce7kz2qxG4b+pbDbDJsO5
 oSKYAr4eGcYiF5J1wfNvYYZQFLp/kUnclO209JANVGocpz0CZZfI+aXQJM9jsfkD+KXd
 F3nhQG091bWVc95vyBT7/56HIAiUZxeK9407LCjELn2Abbjj0qLDTLKcoEfDh2lg2pfN
 uxj2jRMJNoDq2djfi3r7rd6OHH31rjgpwjVxvboTq0h0VAarxEPK+Lqc6D+xhfThHBGb
 96ow==
X-Gm-Message-State: AOAM5327cp6LKRCngTcOl+ezo5Neu23LCv7FLOz+ryw8twG2uAGHNP6K
 yGvoACfVr23RleHt6Yt+DkCwCg==
X-Google-Smtp-Source: ABdhPJz6EqAKsZBr9CHgACRTV898XOZMWyz8XWuy3xqE4nDwFl7Cm9G4Rszk87Zgs+wwI3jDQWAweA==
X-Received: by 2002:a05:6000:1c8:: with SMTP id
 t8mr15010678wrx.73.1593376673749; 
 Sun, 28 Jun 2020 13:37:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r11sm8402884wmh.1.2020.06.28.13.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 13:37:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/arm/tosa: Encapsulate misc GPIO handling in a device
Date: Sun, 28 Jun 2020 21:37:48 +0100
Message-Id: <20200628203748.14250-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628203748.14250-1-peter.maydell@linaro.org>
References: <20200628203748.14250-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
---
This is simpler than the spitz changes because the new device
doesn't need to refer to any of the other devices on the board.
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


