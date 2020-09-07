Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52833C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DEC21927
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSXeiDOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DEC21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFK8R-0005IF-RG
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFK4s-0008FM-Np; Mon, 07 Sep 2020 12:33:10 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:41686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFK4q-0007cV-Eo; Mon, 07 Sep 2020 12:33:10 -0400
Received: by mail-ed1-x542.google.com with SMTP id ay8so13308902edb.8;
 Mon, 07 Sep 2020 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pr3IdxupnoTag8g+l9d/z4aY7eG0d/P7ZaZKT2cQb14=;
 b=tSXeiDOvHKsgXQGnF2c5ZkjZL1FPCrWs6AKIXfNbiIW8OFg3ChzJYIwf3fDZyNURNX
 1ERSEPxjHXTjWF05PJFRz64nI8EEHVV0C8LM+c1a8zSOcyYnC+K3z9HraFl7+L0L3Jz9
 9ce+JbTBrusEN1Lle+Toqx/kucDmc8l24NP+6REZQ+y9PyZfsPPnKXJWuefw1K22CkTF
 cNQ/dlOxfgq/PLNzsVfBn1DEjESy2wDGeMR9GlwZLYw9Go2RGimnOUG49pEaPn8D6geW
 YQv3UWG+CQJClLwSbZdwLpO9JyTlt0HH3p0fOYBm4vCMhsynYxUrTWbveA6cvtI6gpmZ
 qBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pr3IdxupnoTag8g+l9d/z4aY7eG0d/P7ZaZKT2cQb14=;
 b=KMGuehbnnxHpaXR04Q1MetsO3VcwiFhssyKrgyWoYcT1bHz84RHHqAcLWKYAryS/Pr
 6VxpDfWuJcsoQEtalUuFH05bBrOFTSvYPG5oPwR6tt8jCbzXWHC9xHa/4fY4XFx5OrT9
 d8XPDq9qIAOBw3M8JkYNC9rwlUJIKgDOkqYPpi21qKA/8Gnu4vFgvb3kL544Rh2Rr2ag
 9svW9NauFI+hOW+7YNPJWLnlRIMCHdg8vXE2gGstG3cvGhIrhzbdtcNm74OAwduzsZno
 kwviWajhCwDjseSAOh8O/z0d07kMizk+zVR4xuoJh6Yi4Idmq87AZaCvG0DMBFmRoBl0
 CLfw==
X-Gm-Message-State: AOAM533EVkghht/4d+MvXU8aE3CDkai7LI4A+aqbuMHzOqyEHPZe+w4W
 QRzZZijfRm790MHPxQuoG0g5zv3IIFI=
X-Google-Smtp-Source: ABdhPJzgF4A2LH6+tLU2pOKb6e91t41o8McNQebV7qFRxUtojodsrIC6NKYX3l7tPv118u7F6ylIuw==
X-Received: by 2002:a50:be82:: with SMTP id b2mr23115522edk.303.1599496386488; 
 Mon, 07 Sep 2020 09:33:06 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u13sm15700199ejn.82.2020.09.07.09.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:33:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/8] hw/arm/aspeed: Add the 3 front LEDs drived by the
 PCA9552 #1
Date: Mon,  7 Sep 2020 18:32:53 +0200
Message-Id: <20200907163257.46527-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907163257.46527-1-f4bug@amsat.org>
References: <20200907163257.46527-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
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
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Luc Michel <luc.michel@greensocs.com>, Joel Stanley <joel@jms.id.au>
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


