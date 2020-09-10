Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1D7C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A03F2080A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwT0F4Zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A03F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGTdW-0001rR-Cc
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 16:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGTae-0004Mv-4N; Thu, 10 Sep 2020 16:54:44 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kGTac-0000I4-ER; Thu, 10 Sep 2020 16:54:43 -0400
Received: by mail-wr1-x444.google.com with SMTP id a17so8650496wrn.6;
 Thu, 10 Sep 2020 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jeiRRdPErRrtK9Gj9+R/jotAsL7dELgR1Q5VvxS+mnE=;
 b=MwT0F4ZkItt59sl5P0p/1brApND5TzyvcuJOxWoG1vHwonqaKFLSRKqs6voVhxcasF
 6mIWcvE8h8AIy2oPhmXI6JIkFeuC1ws0l38c05VmustMPfA282GXWDXPD2nOO1HMAidd
 UASReW9SSRUMGP0J/PbRcElHSi8pQ9vEKgt50rN/qTepWT8NAxIwLHHMFNnaglrl+E/g
 YLC9gFZea+zzrOd8qvr5EBN/QPS97wq9oMKqX3gufJOEwZcsP4n5rhmRacmz04dcMXbz
 z80xviK3eGRe2J93G9HQmbudw+S3R+eau7gmxiwGZY8f3NQ26CqEdohj8Ri1gNC9xUxh
 imdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jeiRRdPErRrtK9Gj9+R/jotAsL7dELgR1Q5VvxS+mnE=;
 b=YKcILOMPoftgfFYVuSvyPTS/d3EICEGtL4wJZ9Dm277UEFeA0L3xJs2mbkh1Sp///O
 57dZbvGNIvO0CF0DGgUNk6yeVRStJuYO7RKEOPI0ooGDSNZ32IBAXFmjpNdSHbrAKEad
 ce3qyeREnZRRAYvcJrKi4LYzI0juHCG0Fc87WkR8Qo7b4i06Oy27Vg5rBED4NYrIO+dl
 AZeQYOixtdocZsT8TkIE16aWU9WxEVfqnv2H5H60vFIWU4xqfIJTxFrufV3ZPoy0AC7s
 7iqnnef82zYqzXEHWH7KJ1ldSJEx6pyf9g/VOc1Dt3m0VN9apyv9K9A9JhjcBmfA2Wne
 F8gg==
X-Gm-Message-State: AOAM532j9GyWdYKfz/zt4n34cv2kI0gUnvOEzyTfxU368rHn01n6nxAv
 eTbLQYl+6fwf+mJ190yFKqkBFb3lMWg=
X-Google-Smtp-Source: ABdhPJz43sqO8iE6A8rNnWADbMBL/Ns5liM0btki4oJoBmddWIVTjYjFWVrjrMcAnTkBp7mqadFOEA==
X-Received: by 2002:adf:bb44:: with SMTP id x4mr10814862wrg.76.1599771280425; 
 Thu, 10 Sep 2020 13:54:40 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t1sm5089317wmi.16.2020.09.10.13.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 13:54:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 7/7] hw/arm/tosa: Replace fprintf() calls by LED devices
Date: Thu, 10 Sep 2020 22:54:29 +0200
Message-Id: <20200910205429.727766-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910205429.727766-1-f4bug@amsat.org>
References: <20200910205429.727766-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The recently added LED device reports LED status changes with
the 'led_set_intensity' trace event. It is less invasive than
the fprintf() calls. We need however to have a binary built
with tracing support.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/tosa.c  | 40 +++++++++++++++-------------------------
 hw/arm/Kconfig |  1 +
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 90eef1f14dd..f23651fd775 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -24,6 +24,7 @@
 #include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
+#include "hw/misc/led.h"
 #include "exec/address-spaces.h"
 
 #define TOSA_RAM 0x04000000
@@ -81,26 +82,6 @@ typedef struct TosaMiscGPIOState {
     SysBusDevice parent_obj;
 } TosaMiscGPIOState;
 
-static void tosa_gpio_leds(void *opaque, int line, int level)
-{
-    switch (line) {
-    case 0:
-        fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
-        break;
-    case 1:
-        fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
-        break;
-    case 2:
-        fprintf(stderr, "amber LED %s.\n", level ? "on" : "off");
-        break;
-    case 3:
-        fprintf(stderr, "wlan LED %s.\n", level ? "on" : "off");
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static void tosa_reset(void *opaque, int line, int level)
 {
     if (level) {
@@ -112,7 +93,6 @@ static void tosa_misc_gpio_init(Object *obj)
 {
     DeviceState *dev = DEVICE(obj);
 
-    qdev_init_gpio_in_named(dev, tosa_gpio_leds, "leds", 4);
     qdev_init_gpio_in_named(dev, tosa_reset, "reset", 1);
 }
 
@@ -122,6 +102,7 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
                 TC6393xbState *tmio)
 {
     DeviceState *misc_gpio;
+    LEDState *led[4];
 
     misc_gpio = sysbus_create_simple(TYPE_TOSA_MISC_GPIO, -1, NULL);
 
@@ -143,14 +124,23 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
                         qdev_get_gpio_in(cpu->gpio, TOSA_GPIO_JC_CF_IRQ),
                         NULL);
 
+    led[0] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
+                               LED_COLOR_BLUE, "bluetooth");
+    led[1] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
+                               LED_COLOR_GREEN, "note");
+    led[2] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
+                               LED_COLOR_AMBER, "charger-error");
+    led[3] = led_create_simple(OBJECT(misc_gpio), GPIO_POLARITY_ACTIVE_HIGH,
+                               LED_COLOR_GREEN, "wlan");
+
     qdev_connect_gpio_out(scp1, TOSA_GPIO_BT_LED,
-                          qdev_get_gpio_in_named(misc_gpio, "leds", 0));
+                          qdev_get_gpio_in(DEVICE(led[0]), 0));
     qdev_connect_gpio_out(scp1, TOSA_GPIO_NOTE_LED,
-                          qdev_get_gpio_in_named(misc_gpio, "leds", 1));
+                          qdev_get_gpio_in(DEVICE(led[1]), 0));
     qdev_connect_gpio_out(scp1, TOSA_GPIO_CHRG_ERR_LED,
-                          qdev_get_gpio_in_named(misc_gpio, "leds", 2));
+                          qdev_get_gpio_in(DEVICE(led[2]), 0));
     qdev_connect_gpio_out(scp1, TOSA_GPIO_WLAN_LED,
-                          qdev_get_gpio_in_named(misc_gpio, "leds", 3));
+                          qdev_get_gpio_in(DEVICE(led[3]), 0));
 
     qdev_connect_gpio_out(scp1, TOSA_GPIO_TC6393XB_L3V_ON, tc6393xb_l3v_get(tmio));
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 06ba1c355b1..bbcfa098ae2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -150,6 +150,7 @@ config TOSA
     select ZAURUS  # scoop
     select MICRODRIVE
     select PXA2XX
+    select LED
 
 config SPITZ
     bool
-- 
2.26.2


