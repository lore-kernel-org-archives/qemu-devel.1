Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0774C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B20920829
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2Vdrx6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B20920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH5rM-0001pO-9a
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 09:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5ly-0001wB-RT; Sat, 12 Sep 2020 09:40:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5lx-0007rt-1J; Sat, 12 Sep 2020 09:40:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id s13so6774074wmh.4;
 Sat, 12 Sep 2020 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LRr5PGbbM0M9HoMOdGuvjP4Xsc2e6vYqTLWnU5FdlUg=;
 b=e2Vdrx6UVgfC+p7pfZ0wt5P3A1TjXmivQVWEjaHqZ55hDhWbDuBLzuH5TKVeSr6vDV
 eI9WYCFupAV3YqHTCjGvdJUhK7fp6BNJ9SZt4DnuGmoIUnJL4WL4Hcl1Xr1bXg9hIRUv
 E3V2Mq3XKj5DgWaqwVE494lrajBq2d7vk+CWxvnSYICyVOVb+iewiX7CLGBm/CgC/+37
 l5ej2aGLv9uBhsjThoBp3HXK/6pkaJgPp1SdH94fwvtBBFIgxTsvK9EDLkFbcZFbNIbx
 SVkvXWaGMa0J5ZnjDu+SVrsIUG6yxd6gzAtE9qBMmh2aqVTzKZUNsDC1QjDYps6d9JWs
 TrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=LRr5PGbbM0M9HoMOdGuvjP4Xsc2e6vYqTLWnU5FdlUg=;
 b=WsK/OsZi1HpKp+bTrz1uwVl6aNHgpTV6sTXHHXiYszT4AkUrKJqIZeQQxmEo6vb1yf
 +34xLKr2zSeECgLkru1miHZPiyMzLAj4ATxGXdFMRhEgWvDYQZuyaR4cdqA69NdBT4O+
 3Sk98QdspBosWRFeAKAVePvxxwn4LsT3DmS5ScHrHqjppMcVeTXc27NEJ++SQEI/ryhh
 QgJqfV9V9t6OuMNCiSoRmvsv2cz5vGzigWQXNcR6wCnQgylxx2fUguViHFY3knqcnE2h
 7ENqS09XTVAMvzwvRuGrja/wYve/U/fR2ajy0cFk9I3WRU+OtoqgFbQtmjkaw46XbmWN
 h1dQ==
X-Gm-Message-State: AOAM5322jER8Zb6hFf0YIlAungRIvz8r4aSHzXg24NCbHgjFJyCkNNag
 gM0Q8Vwkif6ixGVCXVLQu7m2JTV2B+M=
X-Google-Smtp-Source: ABdhPJyG/yallnTCrunYD9mK592qQ9lp+5wRTy5EolEiYZSpKrlwVDDu/moUN9O/1I/YY/G5CFHfFw==
X-Received: by 2002:a1c:a911:: with SMTP id s17mr7010141wme.77.1599918054610; 
 Sat, 12 Sep 2020 06:40:54 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm10309144wmg.44.2020.09.12.06.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 06:40:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 7/7] hw/arm/tosa: Replace fprintf() calls by LED devices
Date: Sat, 12 Sep 2020 15:40:41 +0200
Message-Id: <20200912134041.946260-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912134041.946260-1-f4bug@amsat.org>
References: <20200912134041.946260-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
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

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/tosa.c  | 40 +++++++++++++++-------------------------
 hw/arm/Kconfig |  1 +
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 2ef6c7b2883..ca998f05232 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -24,6 +24,7 @@
 #include "hw/irq.h"
 #include "hw/ssi/ssi.h"
 #include "hw/sysbus.h"
+#include "hw/misc/led.h"
 #include "exec/address-spaces.h"
 #include "qom/object.h"
 
@@ -83,26 +84,6 @@ struct TosaMiscGPIOState {
     SysBusDevice parent_obj;
 };
 
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
@@ -114,7 +95,6 @@ static void tosa_misc_gpio_init(Object *obj)
 {
     DeviceState *dev = DEVICE(obj);
 
-    qdev_init_gpio_in_named(dev, tosa_gpio_leds, "leds", 4);
     qdev_init_gpio_in_named(dev, tosa_reset, "reset", 1);
 }
 
@@ -124,6 +104,7 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
                 TC6393xbState *tmio)
 {
     DeviceState *misc_gpio;
+    LEDState *led[4];
 
     misc_gpio = sysbus_create_simple(TYPE_TOSA_MISC_GPIO, -1, NULL);
 
@@ -145,14 +126,23 @@ static void tosa_gpio_setup(PXA2xxState *cpu,
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


