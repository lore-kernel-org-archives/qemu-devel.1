Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B4C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7F921D7D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qb6K7+ip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7F921D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFK8C-00053S-Vu
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFK4w-0008Pp-Rc; Mon, 07 Sep 2020 12:33:14 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:46341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFK4v-0007da-1m; Mon, 07 Sep 2020 12:33:14 -0400
Received: by mail-ej1-x642.google.com with SMTP id z23so18871649ejr.13;
 Mon, 07 Sep 2020 09:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jeiRRdPErRrtK9Gj9+R/jotAsL7dELgR1Q5VvxS+mnE=;
 b=qb6K7+ipyUmvsw9nZ2i/KdjQlDvSPjt8fLFlI/E5oQueKAPHguVSYrHQ2lWVhqoHbu
 TkSorb82zKPXbUUZK2aglcaDmoZjNDC1odPUktC5hkQellTK7KkiDu5N/xS4C3djRgRi
 GubSxwDFo9kq3xRxZSxFU4XbiDSJRlw+nhuO+f7RiwpQtv/W36s3TVsaV8L103yhUK4/
 8ycwcj5Qawe8EcjJMs1UTjqemfoEbBJBXoLapRcMiZxD74ENYOUpJlkXgn0QfeB+Ke9c
 Rw0P177KQfM1Q6JcsA/UkDyr9yTBLkyfAbx4gwJeMyGf5OPBiXb5w1Q8DNLYkub+3CbZ
 /cDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jeiRRdPErRrtK9Gj9+R/jotAsL7dELgR1Q5VvxS+mnE=;
 b=HbNsnV5qhhj/c6nN8d77IlgXJdE/Cg+DuMyfV2E0+2ZFyv8mhLVRoH9KNqtAUWp/Hn
 pFAxdS9JS0If7qX5XVZ4yIF4F/pWvuPj++mn4jXxJ6NG2ir+XwgcHs6PaMnErwBUOKAE
 upceO3Sda5bd5Ajv0c6tycLqO+SFGAU6buzlb1bRVHCAG83BlK816irTYcLIo/1BLQfI
 ShWyMACoqefgXmcQ0djnLhBvD4CNuA3EGDLsUSR/PV3kzKhaLPJ37WRCTiZPOgyLBPPe
 nlP77URCyy2R2cJt4TNj6yp9OP77/w7I8E2eYvvRZghzR74F0uf7og+/Atv6bKJKI3aA
 3StA==
X-Gm-Message-State: AOAM530QSJXUR3IKyXmap160zjZkIQcjYdmlLGKX08Acbp2ugKVzJF77
 +vYfbYKp2k7xeUp0Tcqko3B3o8NHsno=
X-Google-Smtp-Source: ABdhPJxif1S8WYd//dNJ5p0OU4D5QlgtDNoRmnZGFvKW7jsYMD3vA96jY2tc7MMFWZkQlwDI0h0L6Q==
X-Received: by 2002:a17:906:63c9:: with SMTP id
 u9mr18426715ejk.82.1599496391020; 
 Mon, 07 Sep 2020 09:33:11 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u13sm15700199ejn.82.2020.09.07.09.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:33:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 7/8] hw/arm/tosa: Replace fprintf() calls by LED devices
Date: Mon,  7 Sep 2020 18:32:56 +0200
Message-Id: <20200907163257.46527-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907163257.46527-1-f4bug@amsat.org>
References: <20200907163257.46527-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Luc Michel <luc.michel@greensocs.com>, Joel Stanley <joel@jms.id.au>
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


