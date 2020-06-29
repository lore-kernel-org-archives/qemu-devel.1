Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D7DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32011255C9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeUno5TY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32011255C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpxlN-0007UM-BW
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 13:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpxjh-0005kH-Vz; Mon, 29 Jun 2020 13:38:30 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:45529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpxjg-0000IC-34; Mon, 29 Jun 2020 13:38:29 -0400
Received: by mail-ej1-x643.google.com with SMTP id a1so17435140ejg.12;
 Mon, 29 Jun 2020 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vln2Kfj4w7antPWhsHXpewUAGbLCzfNZUk7aB5CR750=;
 b=MeUno5TY/yJ25IOp9vIghwHAYXRdVC/L5TxvKUPRMfx8cIWW0+q5usP1K2cWXH/Vh1
 du/aNiNcRKw7UE71I7wpb7fZXarS5LXfEcTdsK8Gu7MvSRmUkU5bupvw8Y6vpsZ2RSWJ
 4JoUl0syGIspjvLxxoo8isPwuRB2kWRmXvE22AD8IiOREB0koGyMcadKgogM+4mKSeNj
 w5oquHzTZVokVsih5v9qhG98WYRLY5Zr3tSGhR0lxDNW/AsoVnemic7jCE1fUtHbq4CC
 KY9LbGW4Jr2VxGMZcgSaD1gsyBcJkGUI4v1DoP3NYPO1dBqUj7Zg0C71RLWRpTwz6br5
 csEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vln2Kfj4w7antPWhsHXpewUAGbLCzfNZUk7aB5CR750=;
 b=OTtKVL1NUzwyAi8HDoHmsjNjF2k8McceuuQQZ5rca3fEAzXXr6mxNmSuo5B2OKCHvx
 0qRchH+7yiWsPI5rXzMA3ep71c8c4jPr30vZrrHPnC39v96H0DPQbjLgezJR0QkTEB2X
 o98Yr3XRuVEhCCqOFnDKYmAa8X6pb7j+h6Lm6M6yRGvPCz8qkPwKn0hc4jy4eqLZzCM4
 2iankc2n2d0VvBKaK/khpUk3ZB2WmFrXpfm8PuZ6WJmgEQ8JLPpuTh9WVyYcTYbmdUc8
 Xospxev7MIYH9w23hsR7d6kpi4aRc37wReoKt52I6OLu44AN73kUcGlMNrzcZw/6C4E9
 5LnA==
X-Gm-Message-State: AOAM530GSu0M8DljfuhhbRVnyLAY/TXFgQ0iAjoKBkYW0eKJ94bmQtET
 BsqkDwIlAwxoGRSObuvviSQhKWZZrwQ=
X-Google-Smtp-Source: ABdhPJym/s7CRhux1OvEc9gyCu5YZM57EGqySePw2Qc8iTT1NJ0BscrxtEgj+NOtZbpGvTwkb9XRBA==
X-Received: by 2002:a17:906:6a4f:: with SMTP id
 n15mr14630874ejs.378.1593452305860; 
 Mon, 29 Jun 2020 10:38:25 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id ce19sm216029ejb.24.2020.06.29.10.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 10:38:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()
Date: Mon, 29 Jun 2020 19:38:17 +0200
Message-Id: <20200629173821.22037-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629173821.22037-1-f4bug@amsat.org>
References: <20200629173821.22037-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify aspeed_i2c_get_bus() by using a AspeedI2CState argument.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/aspeed_i2c.h |  2 +-
 hw/arm/aspeed.c             | 70 ++++++++++++++++++-------------------
 hw/i2c/aspeed_i2c.c         |  3 +-
 3 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index f1b9e5bf91..243789ae5d 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -93,6 +93,6 @@ typedef struct AspeedI2CClass {
 
 } AspeedI2CClass;
 
-I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr);
+I2CBus *aspeed_i2c_get_bus(AspeedI2CState *s, int busnr);
 
 #endif /* ASPEED_I2C_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 379f9672a5..1285bf82c0 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -385,13 +385,13 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), "ds1338", 0x68);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 0), 0x50,
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
-    dev = i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2),
+    dev = i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 2),
                            "tmp423", 0x4c);
     object_property_set_int(OBJECT(dev), 31000, "temperature0", &error_abort);
     object_property_set_int(OBJECT(dev), 28000, "temperature1", &error_abort);
@@ -404,16 +404,16 @@ static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = &bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
 
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), 0x50,
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 3), 0x50,
                           eeprom_buf);
 
     /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7),
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 7),
                      TYPE_TMP105, 0x4d);
 
     /* The AST2500 EVB does not have an RTC. Let's pretend that one is
      * plugged on the I2C bus header */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 }
 
 static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
@@ -428,36 +428,36 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 }
 
 static void swift_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
 
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca9552", 0x60);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 3), "pca9552", 0x60);
 
     /* The swift board expects a TMP275 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 7), "tmp105", 0x48);
     /* The swift board expects a pca9551 but a pca9552 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "pca9552", 0x60);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9552", 0x60);
 
     /* The swift board expects an Epson RX8900 RTC but a ds1338 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "ds1338", 0x32);
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x60);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "ds1338", 0x32);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x60);
 
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp423", 0x4c);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
     /* The swift board expects a pca9539 but a pca9552 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "pca9552", 0x74);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 9), "pca9552", 0x74);
 
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "tmp423", 0x4c);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
     /* The swift board expects a pca9539 but a pca9552 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 10), "pca9552",
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 10), "pca9552",
                      0x74);
 
     /* The swift board expects a TMP275 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x48);
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 12), "tmp105", 0x4a);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 12), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 12), "tmp105", 0x4a);
 }
 
 static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
@@ -465,32 +465,32 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = &bmc->soc;
 
     /* bus 2 : */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x48);
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2), "tmp105", 0x49);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x49);
     /* bus 2 : pca9546 @ 0x73 */
 
     /* bus 3 : pca9548 @ 0x70 */
 
     /* bus 4 : */
     uint8_t *eeprom4_54 = g_malloc0(8 * 1024);
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), 0x54,
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x54,
                           eeprom4_54);
     /* PCA9539 @ 0x76, but PCA9552 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x76);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 4), "pca9552", 0x76);
     /* PCA9539 @ 0x77, but PCA9552 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "pca9552", 0x77);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 4), "pca9552", 0x77);
 
     /* bus 6 : */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x48);
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 6), "tmp105", 0x49);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x48);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x49);
     /* bus 6 : pca9546 @ 0x73 */
 
     /* bus 8 : */
     uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), 0x56,
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 0x56,
                           eeprom8_56);
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x60);
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 8), "pca9552", 0x61);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x60);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x61);
     /* bus 8 : adc128d818 @ 0x1d */
     /* bus 8 : adc128d818 @ 0x1f */
 
@@ -515,25 +515,25 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
     /* Bus 3: TODO dps310@76 */
     dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
     qdev_prop_set_string(dev, "description", "pca1");
-    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3),
+    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 3),
                           &error_fatal);
 
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
 
     /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), TYPE_TMP105,
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
                      0x4a);
 
     /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "ds1338", 0x32);
+    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
                           eeprom_buf);
     dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
     qdev_prop_set_string(dev, "description", "pca0");
-    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11),
+    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 11),
                           &error_fatal);
     /* Bus 11: TODO ucd90160@64 */
 }
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index fb973a983d..518a3f5c6f 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -959,9 +959,8 @@ static void aspeed_i2c_register_types(void)
 type_init(aspeed_i2c_register_types)
 
 
-I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr)
+I2CBus *aspeed_i2c_get_bus(AspeedI2CState *s, int busnr)
 {
-    AspeedI2CState *s = ASPEED_I2C(dev);
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
     I2CBus *bus = NULL;
 
-- 
2.21.3


