Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2228DC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F8E22202
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6VxCSMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F8E22202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmdL-0004Uz-4H
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmaB-00076s-88; Sat, 20 Jun 2020 19:07:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmma9-0002Md-HF; Sat, 20 Jun 2020 19:07:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id q2so10719772wrv.8;
 Sat, 20 Jun 2020 16:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L7Y35LMk2Ma+Lon7EzcxgbVJFXZUaFqzrr3RXETrmOQ=;
 b=k6VxCSMDgEdEDsiaM6vtAhIPZymGdRmGefv4UZVGsNQ70nKYIRkUj7i1ujUNc3qc3U
 lS4qrSjXSz1pCIQDQNf7BEDU6sy6ebiVAF9dL9le+LyPMUwcvTzQUf8gXFRokFnbzkcY
 biV6ZIhConz/vN9Sa00siyogwyjSieiNLbow85GAWPswqUgaHMlyfOLj+5VhIhXnJQ+Z
 rv38WmeGXkQqlMgDigry+ZLwYgRSLMmNelq7BXMRHb3jsPLzi3Wc687OKRCIfqw4/h3J
 awmirJWZ8Q7d7B2RTuX8YOLFkA3T+yY2HYS2d5OVZR2gTCW3kyuySTTpxLErWC/kL2oD
 VuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=L7Y35LMk2Ma+Lon7EzcxgbVJFXZUaFqzrr3RXETrmOQ=;
 b=qYpmd9jCIBWu1s1BzAwBbApHPA/B427sBYP+fid7RABpn4bJa4sxUa1kSniAQSikZX
 e1jH+s5ee8BpuWUsGTOoAsWNLUWV4ttxOvS3i7OuoVsfL7PSVKWPMM0kqRjsQN4LOpPb
 KuDQeCjKbNxE8mFGnT5aVZ45KgKENpaJIAH+L2JO0txWwBRkquMH5v+RVLYkASCg5lNU
 DQzO34wxXdJ9+EppseElbb0XY7Dju0mHSlPoHNOOl/IS3m059wUw1GDjiIr52rTgYbtJ
 7lf7EEf2yGUIZSrJgndRu8YphG4Gjljcg7wul5kkGdLRtuycwyVaduRdu6N0lucZLsN/
 xwrw==
X-Gm-Message-State: AOAM533p1XZFtD/W4HAFmVdjehtGyXDpkVtAZ+VYMaPCITgpo15sO2iy
 nnMWiD6a9WZc9oKik4+Ynu8P/bDb
X-Google-Smtp-Source: ABdhPJwi2ycvqI0fhGiGhapj06F7HM5xGwQwG2GGJrOOwU6awWZypl9oBtK07LQeu6Si4vVEBa2GNg==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr12209614wro.60.1592694447696; 
 Sat, 20 Jun 2020 16:07:27 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o82sm11455037wmo.40.2020.06.20.16.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 16:07:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/7] hw/arm/aspeed: Add the 3 front LEDs drived by the
 PCA9552 #1
Date: Sun, 21 Jun 2020 01:07:16 +0200
Message-Id: <20200620230719.32139-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620230719.32139-1-f4bug@amsat.org>
References: <20200620230719.32139-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Witherspoon has 3 LEDs connected to a PCA9552. Add them.
The names and reset values are taken from:
https://github.com/open-power/witherspoon-xml/blob/master/witherspoon.xml

Example booting obmc-phosphor-image:

  $ qemu-system-arm -M witherspoon-bmc -trace led_change_intensity
  1592693373.997015:led_change_intensity LED desc:'front-fault-4' color:green intensity 0x0000 -> 0xffff
  1592693373.997632:led_change_intensity LED desc:'front-power-3' color:green intensity 0x0000 -> 0xffff
  1592693373.998239:led_change_intensity LED desc:'front-id-5' color:green intensity 0x0000 -> 0xffff
  1592693500.291805:led_change_intensity LED desc:'front-power-3' color:green intensity 0xffff -> 0x0000
  1592693500.312041:led_change_intensity LED desc:'front-power-3' color:green intensity 0x0000 -> 0xffff
  1592693500.821254:led_change_intensity LED desc:'front-power-3' color:green intensity 0xffff -> 0x0000
  1592693501.331517:led_change_intensity LED desc:'front-power-3' color:green intensity 0x0000 -> 0xffff
  1592693501.841367:led_change_intensity LED desc:'front-power-3' color:green intensity 0xffff -> 0x0000
  1592693502.350839:led_change_intensity LED desc:'front-power-3' color:green intensity 0x0000 -> 0xffff
  1592693502.861134:led_change_intensity LED desc:'front-power-3' color:green intensity 0xffff -> 0x0000
  1592693503.371090:led_change_intensity LED desc:'front-power-3' color:green intensity 0x0000 -> 0xffff

We notice the front-power LED starts to blink.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed.c | 17 +++++++++++++++++
 hw/arm/Kconfig  |  1 +
 2 files changed, 18 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 3d5dec4692..217f8ad7d5 100644
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
@@ -506,6 +507,16 @@ static void sonorapass_bmc_i2c_init(AspeedBoardState *bmc)
 
 static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 {
+    static const struct {
+        unsigned gpio_id;
+        LEDColor color;
+        const char *description;
+        uint16_t reset_intensity;
+    } pca1_leds[] = {
+        {13, LED_COLOR_GREEN, "front-fault-4",  LED_RESET_INTENSITY_ACTIVE_LOW},
+        {14, LED_COLOR_GREEN, "front-power-3",  LED_RESET_INTENSITY_ACTIVE_LOW},
+        {15, LED_COLOR_GREEN, "front-id-5",     LED_RESET_INTENSITY_ACTIVE_LOW},
+    };
     AspeedSoCState *soc = &bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
     DeviceState *dev;
@@ -518,6 +529,12 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
     i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3),
                           &error_fatal);
 
+    for (size_t i = 0; i < ARRAY_SIZE(pca1_leds); i++) {
+        create_led_by_gpio_id(OBJECT(bmc), dev,
+                              pca1_leds[i].gpio_id, pca1_leds[i].color,
+                              pca1_leds[i].description,
+                              pca1_leds[i].reset_intensity);
+    }
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9afa6eee79..1a57a861ac 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -393,6 +393,7 @@ config ASPEED_SOC
     select TMP105
     select TMP421
     select UNIMP
+    select LED
 
 config MPS2
     bool
-- 
2.21.3


