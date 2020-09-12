Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B74EC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF28D20829
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITzPUloz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF28D20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH5ph-0008Qo-Ug
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 09:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5lt-0001iW-Tk; Sat, 12 Sep 2020 09:40:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5ls-0007qo-4F; Sat, 12 Sep 2020 09:40:53 -0400
Received: by mail-wm1-x341.google.com with SMTP id l9so7214335wme.3;
 Sat, 12 Sep 2020 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dcziNR/TheFFTidKb7aVU6cyT7NZK4LKYIpEP4izZZI=;
 b=ITzPUlozKTs3MLNo9Opv5bjPAQxb3mcoO4GerxhHIiMzKhsQdE3E5wLRG/GChF6TJC
 Qjs31f9R72QXtZ2UchHjauA5b1Ei9mgKoa/OpXL/FrtXvOD6Y1jsfiyJv/kG/HVvmspC
 wEg5l7n3veXQTEA9W7mQodPzXoxEi2xYJnCShmd35hiBa1Nn1sr4Okhs9xMSM+z4fZn7
 OffhTOM27zmcwTjcqZm20AqrEtum6bVwCi79z+IZx2YymszBNkXjCYMmZ6worsfFdOcT
 L+S1s645SjRjb53Dh0mapCanoO/30KD8SIysDuOdaByCKyqXu1m16gRH97TUXZvhjeYT
 NpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dcziNR/TheFFTidKb7aVU6cyT7NZK4LKYIpEP4izZZI=;
 b=WRgMNPmcllp9H0j8zsg8Mq4uuH/tq8mFJQuYYAMb/2Z9dgZ7pKKLPgz7XpZXDRwHfw
 0dMJKuSY9CSOmWGW/ZSEswSuOKyOnoSs9wLyC5EJHAN898jU/qLWP1SrUrTOUUKY86ei
 eSF9vjlvT5jDPsVP6vBdvUGuhi/DjTbdvfYBFnqStXZ5WPsXI82HPDKRia7my+TmNaCP
 XIUE4jQar5cAX731rHCzBo8WryNZD23ywKq+ZsbOZGO/vCOKutBYITsX1FnPtAt42be/
 l5YSfC30lPapCdiCGg1p9lI72z0GGDyP2RLWNJZdO7/6Kp0JWKz2CdI/OcCfczFh02r2
 7NlQ==
X-Gm-Message-State: AOAM5305HhgXwfoW4TjGfPBdCVWDKSTiyh6SD/38kIwRMRCtURMtcnG8
 ddymcKtDfakYEcHTJSAtJqg7RxJ/JKs=
X-Google-Smtp-Source: ABdhPJxmEsMVymaDBn9BmFo/e9xFEp5NC3Vfo78nH2l4yUJ/DHw1tXxDC6kx71GMKk3kLfhoE8HHzQ==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr7346133wmz.26.1599918050157;
 Sat, 12 Sep 2020 06:40:50 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm10309144wmg.44.2020.09.12.06.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 06:40:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/7] hw/arm/aspeed: Add the 3 front LEDs drived by the
 PCA9552 #1
Date: Sat, 12 Sep 2020 15:40:38 +0200
Message-Id: <20200912134041.946260-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912134041.946260-1-f4bug@amsat.org>
References: <20200912134041.946260-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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

The Witherspoon has 3 LEDs connected to a PCA9552. Add them.
The names and reset values are taken from:
https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml

Example booting obmc-phosphor-image:

  $ qemu-system-arm -M witherspoon-bmc -trace led_change_intensity
  1592693373.997015:led_change_intensity LED desc:'front-fault-4' color:green intensity 0% -> 100%
  1592693373.997632:led_change_intensity LED desc:'front-power-3' color:green intensity 0% -> 100%
  1592693373.998239:led_change_intensity LED desc:'front-id-5' color:green intensity 0% -> 100%
  1592693500.291805:led_change_intensity LED desc:'front-power-3' color:green intensity 100% -> 0%
  1592693500.312041:led_change_intensity LED desc:'front-power-3' color:green intensity 0% -> 100%
  1592693500.821254:led_change_intensity LED desc:'front-power-3' color:green intensity 100% -> 0%
  1592693501.331517:led_change_intensity LED desc:'front-power-3' color:green intensity 0% -> 100%
  1592693501.841367:led_change_intensity LED desc:'front-power-3' color:green intensity 100% -> 0%
  1592693502.350839:led_change_intensity LED desc:'front-power-3' color:green intensity 0% -> 100%
  1592693502.861134:led_change_intensity LED desc:'front-power-3' color:green intensity 100% -> 0%
  1592693503.371090:led_change_intensity LED desc:'front-power-3' color:green intensity 0% -> 100%

We notice the front-power LED starts to blink at a ~2Hz rate.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed.c | 20 ++++++++++++++++++++
 hw/arm/Kconfig  |  1 +
 2 files changed, 21 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 8bfb1c79ddc..83e322ea983 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -20,6 +20,7 @@
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/tmp105.h"
+#include "hw/misc/led.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
@@ -521,9 +522,20 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
 {
+    static const struct {
+        unsigned gpio_id;
+        LEDColor color;
+        const char *description;
+        bool gpio_polarity;
+    } pca1_leds[] = {
+        {13, LED_COLOR_GREEN, "front-fault-4",  GPIO_POLARITY_ACTIVE_LOW},
+        {14, LED_COLOR_GREEN, "front-power-3",  GPIO_POLARITY_ACTIVE_LOW},
+        {15, LED_COLOR_GREEN, "front-id-5",     GPIO_POLARITY_ACTIVE_LOW},
+    };
     AspeedSoCState *soc = &bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
     DeviceState *dev;
+    LEDState *led;
 
     /* Bus 3: TODO bmp280@77 */
     /* Bus 3: TODO max31785@52 */
@@ -534,6 +546,14 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
                                 aspeed_i2c_get_bus(&soc->i2c, 3),
                                 &error_fatal);
 
+    for (size_t i = 0; i < ARRAY_SIZE(pca1_leds); i++) {
+        led = led_create_simple(OBJECT(bmc),
+                                pca1_leds[i].gpio_polarity,
+                                pca1_leds[i].color,
+                                pca1_leds[i].description);
+        qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
+                              qdev_get_gpio_in(DEVICE(led), 0));
+    }
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index bc3a423940b..06ba1c355b1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -394,6 +394,7 @@ config ASPEED_SOC
     select TMP105
     select TMP421
     select UNIMP
+    select LED
 
 config MPS2
     bool
-- 
2.26.2


