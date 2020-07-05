Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A4BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F17206CD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOQKjcS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F17206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsDOq-0002d2-Op
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 18:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsDKr-0004X4-QJ; Sun, 05 Jul 2020 18:42:09 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46990)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsDKo-0002iR-Eb; Sun, 05 Jul 2020 18:42:09 -0400
Received: by mail-wr1-x443.google.com with SMTP id r12so38875196wrj.13;
 Sun, 05 Jul 2020 15:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zNOqrjVEJtR9iKe18RTGbM86vwArMWFzrQdWrPE495s=;
 b=JOQKjcS8HAMBrNOJWXeoioTRTvhIn1GFtcyXnOgRsV/gYNvTjgfU6oEexVudzIf3XD
 4jEplpGSLTRCNr0+6ZWdEWXn701iw2Rh34u9SUhXR7W4djft85ZP0IacBfUVXhzEIa42
 Qpt0at8bxWUmQZh5kzoTnM+aNh8RKvVQcq89+VROY7IBK2Qz5fuxFuM1LiomdzHfgcyj
 toB9mDLM0lQ7F/KrivBGit3bcwm/rwZx8WHs1PRvOmg0aCuVvzMxOxI9Y/UEDV6L6tG0
 yZZHEcMuQ2FP9yH4vx4boOSUFa7+12Rwe/wWfcwdLl/3ZIftj1mGCEz7piNkkjwjYr9q
 eoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=zNOqrjVEJtR9iKe18RTGbM86vwArMWFzrQdWrPE495s=;
 b=VrphJBZ4CFAVgKEp6Uhi9NhOnuMy34vJNpKkurCyaJyt9VUCsKPqrwYrotPQv+6RKi
 5R//1wusxfbNAE42Ul5x5ev8AMRDvBKUcz6KONRIQujYEmk9/QMDqrbj5bix3m5cMaZ0
 +dodXB0W2Mv8NwxLKcQqx9XDpiZGc7jJ3qwhPK3fH9klM1xggHx6lQrtqI8KV/hfGwz8
 JvcDaJR/Qjd/xtXLDVNqeOfE8TaEe2P9FI19vi13CoqdW1e2wDwQiuJ9EdlTKF1EcmoR
 DoOTRYEG2gt4AH4bYCFs/NJJQR4CkWnnWNxkhEUdYQx5M/MopKLvbXDf1N6/bzwAMCcg
 jDMg==
X-Gm-Message-State: AOAM533xFwUv0q6tqw6UmPfVDWrqRysiUScRCE8kyX4HwX+ZF6KQpOJL
 Zdm+mmIkQGccRkC1bEYPuiQfBhQVQJM=
X-Google-Smtp-Source: ABdhPJyyA6tL/OwCWkVgvUaEt6czdRyrxN/vERxdefcy9MkmMmVFKN/mqhjrUWUsVqn69wRo/Za3aw==
X-Received: by 2002:adf:f9c8:: with SMTP id w8mr45077608wrr.354.1593988923818; 
 Sun, 05 Jul 2020 15:42:03 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v6sm9151467wrr.85.2020.07.05.15.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 15:42:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] hw/i2c: Rename i2c_create_slave() as
 i2c_slave_create_simple()
Date: Mon,  6 Jul 2020 00:41:53 +0200
Message-Id: <20200705224154.16917-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705224154.16917-1-f4bug@amsat.org>
References: <20200705224154.16917-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use "create_simple" names for functions that allocate, initialize,
configure and realize device objects: pci_create_simple(),
isa_create_simple(), usb_create_simple(). For consistency, rename
i2c_create_slave() as i2c_slave_create_simple(). Since we have
to update all the callers, also let it return a I2CSlave object.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/i2c.h |  2 +-
 hw/arm/aspeed.c      | 58 ++++++++++++++++++++++----------------------
 hw/arm/musicpal.c    |  4 +--
 hw/arm/nseries.c     |  8 +++---
 hw/arm/pxa2xx.c      |  5 ++--
 hw/arm/realview.c    |  2 +-
 hw/arm/spitz.c       |  4 +--
 hw/arm/stellaris.c   |  2 +-
 hw/arm/tosa.c        |  2 +-
 hw/arm/versatilepb.c |  2 +-
 hw/arm/vexpress.c    |  2 +-
 hw/arm/z2.c          |  4 +--
 hw/display/sii9022.c |  2 +-
 hw/i2c/core.c        |  6 ++---
 hw/ppc/e500.c        |  2 +-
 hw/ppc/sam460ex.c    |  2 +-
 16 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index cb7211f027..c533058998 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -80,7 +80,7 @@ int i2c_send(I2CBus *bus, uint8_t data);
 uint8_t i2c_recv(I2CBus *bus);
 
 I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
-DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
+I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
 bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **errp);
 
 /* lm832x.c */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ed14e79f57..5fa95f0f02 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -385,14 +385,14 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* The palmetto platform expects a ds3231 RTC but a ds1338 is
      * enough to provide basic RTC features. Alarms will be missing */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
                           eeprom_buf);
 
     /* add a TMP423 temperature sensor */
-    dev = i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 2),
-                           "tmp423", 0x4c);
+    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
+                                         "tmp423", 0x4c));
     object_property_set_int(OBJECT(dev), 31000, "temperature0", &error_abort);
     object_property_set_int(OBJECT(dev), 28000, "temperature1", &error_abort);
     object_property_set_int(OBJECT(dev), 20000, "temperature2", &error_abort);
@@ -408,12 +408,12 @@ static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
                           eeprom_buf);
 
     /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 7),
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
                      TYPE_TMP105, 0x4d);
 
     /* The AST2500 EVB does not have an RTC. Let's pretend that one is
      * plugged on the I2C bus header */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 }
 
 static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
@@ -428,36 +428,36 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 }
 
 static void swift_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
 
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 3), "pca9552", 0x60);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "pca9552", 0x60);
 
     /* The swift board expects a TMP275 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 7), "tmp105", 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "tmp105", 0x48);
     /* The swift board expects a pca9551 but a pca9552 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9552", 0x60);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7), "pca9552", 0x60);
 
     /* The swift board expects an Epson RX8900 RTC but a ds1338 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "ds1338", 0x32);
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x60);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), "ds1338", 0x32);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x60);
 
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "tmp423", 0x4c);
     /* The swift board expects a pca9539 but a pca9552 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 9), "pca9552", 0x74);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), "pca9552", 0x74);
 
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "tmp423", 0x4c);
     /* The swift board expects a pca9539 but a pca9552 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 10), "pca9552",
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 10), "pca9552",
                      0x74);
 
     /* The swift board expects a TMP275 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 12), "tmp105", 0x48);
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 12), "tmp105", 0x4a);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 12), "tmp105", 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 12), "tmp105", 0x4a);
 }
 
 static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
@@ -465,8 +465,8 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
     AspeedSoCState *soc = &bmc->soc;
 
     /* bus 2 : */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x48);
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x49);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x49);
     /* bus 2 : pca9546 @ 0x73 */
 
     /* bus 3 : pca9548 @ 0x70 */
@@ -476,21 +476,21 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x54,
                           eeprom4_54);
     /* PCA9539 @ 0x76, but PCA9552 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 4), "pca9552", 0x76);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "pca9552", 0x76);
     /* PCA9539 @ 0x77, but PCA9552 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 4), "pca9552", 0x77);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "pca9552", 0x77);
 
     /* bus 6 : */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x48);
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x49);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x48);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 6), "tmp105", 0x49);
     /* bus 6 : pca9546 @ 0x73 */
 
     /* bus 8 : */
     uint8_t *eeprom8_56 = g_malloc0(8 * 1024);
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 8), 0x56,
                           eeprom8_56);
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x60);
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x61);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x60);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 8), "pca9552", 0x61);
     /* bus 8 : adc128d818 @ 0x1d */
     /* bus 8 : adc128d818 @ 0x1f */
 
@@ -519,16 +519,16 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
                                 aspeed_i2c_get_bus(&soc->i2c, 3),
                                 &error_fatal);
 
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
 
     /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
                      0x4a);
 
     /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough */
-    i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
                           eeprom_buf);
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 394a3345bd..bf7bd28b94 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1584,7 +1584,7 @@ static void musicpal_init(MachineState *machine)
     DeviceState *i2c_dev;
     DeviceState *lcd_dev;
     DeviceState *key_dev;
-    DeviceState *wm8750_dev;
+    I2CSlave *wm8750_dev;
     SysBusDevice *s;
     I2CBus *i2c;
     int i;
@@ -1687,7 +1687,7 @@ static void musicpal_init(MachineState *machine)
         qdev_connect_gpio_out(key_dev, i, qdev_get_gpio_in(dev, i + 15));
     }
 
-    wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
+    wm8750_dev = i2c_slave_create_simple(i2c, TYPE_WM8750, MP_WM_ADDR);
     dev = qdev_new(TYPE_MV88W8618_AUDIO);
     s = SYS_BUS_DEVICE(dev);
     object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 428a2a2c5a..e48092ca04 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -215,7 +215,7 @@ static void n8x0_i2c_setup(struct n800_s *s)
     I2CBus *i2c = omap_i2c_bus(s->mpu->i2c[0]);
 
     /* Attach a menelaus PM chip */
-    dev = i2c_create_slave(i2c, "twl92230", N8X0_MENELAUS_ADDR);
+    dev = DEVICE(i2c_slave_create_simple(i2c, "twl92230", N8X0_MENELAUS_ADDR));
     qdev_connect_gpio_out(dev, 3,
                           qdev_get_gpio_in(s->mpu->ih[0],
                                            OMAP_INT_24XX_SYS_NIRQ));
@@ -224,7 +224,7 @@ static void n8x0_i2c_setup(struct n800_s *s)
     qemu_register_powerdown_notifier(&n8x0_system_powerdown_notifier);
 
     /* Attach a TMP105 PM chip (A0 wired to ground) */
-    dev = i2c_create_slave(i2c, TYPE_TMP105, N8X0_TMP105_ADDR);
+    dev = DEVICE(i2c_slave_create_simple(i2c, TYPE_TMP105, N8X0_TMP105_ADDR));
     qdev_connect_gpio_out(dev, 0, tmp_irq);
 }
 
@@ -416,8 +416,8 @@ static void n810_kbd_setup(struct n800_s *s)
 
     /* Attach the LM8322 keyboard to the I2C bus,
      * should happen in n8x0_i2c_setup and s->kbd be initialised here.  */
-    s->kbd = i2c_create_slave(omap_i2c_bus(s->mpu->i2c[0]),
-                           "lm8323", N810_LM8323_ADDR);
+    s->kbd = DEVICE(i2c_slave_create_simple(omap_i2c_bus(s->mpu->i2c[0]),
+                                            "lm8323", N810_LM8323_ADDR));
     qdev_connect_gpio_out(s->kbd, 0, kbd_irq);
 }
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index f104a33463..6203c4cfe0 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -1522,8 +1522,9 @@ PXA2xxI2CState *pxa2xx_i2c_init(hwaddr base,
     s = PXA2XX_I2C(i2c_dev);
     /* FIXME: Should the slave device really be on a separate bus?  */
     i2cbus = i2c_init_bus(dev, "dummy");
-    dev = i2c_create_slave(i2cbus, TYPE_PXA2XX_I2C_SLAVE, 0);
-    s->slave = PXA2XX_I2C_SLAVE(dev);
+    s->slave = PXA2XX_I2C_SLAVE(i2c_slave_create_simple(i2cbus,
+                                                        TYPE_PXA2XX_I2C_SLAVE,
+                                                        0));
     s->slave->host = s;
 
     return s;
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index b6c0a1adb9..e105b6509f 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -285,7 +285,7 @@ static void realview_init(MachineState *machine,
 
     dev = sysbus_create_simple(TYPE_VERSATILE_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_create_slave(i2c, "ds1338", 0x68);
+    i2c_slave_create_simple(i2c, "ds1338", 0x68);
 
     /* Memory map for RealView Emulation Baseboard:  */
     /* 0x10000000 System registers.  */
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index f020aff974..7ac8254aa6 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -787,7 +787,7 @@ static void spitz_i2c_setup(PXA2xxState *cpu)
     DeviceState *wm;
 
     /* Attach a WM8750 to the bus */
-    wm = i2c_create_slave(bus, TYPE_WM8750, 0);
+    wm = DEVICE(i2c_slave_create_simple(bus, TYPE_WM8750, 0));
 
     spitz_wm8750_addr(wm, 0, 0);
     qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_WM,
@@ -802,7 +802,7 @@ static void spitz_i2c_setup(PXA2xxState *cpu)
 static void spitz_akita_i2c_setup(PXA2xxState *cpu)
 {
     /* Attach a Max7310 to Akita I2C bus.  */
-    i2c_create_slave(pxa2xx_i2c_bus(cpu->i2c[0]), "max7310",
+    i2c_slave_create_simple(pxa2xx_i2c_bus(cpu->i2c[0]), "max7310",
                      AKITA_MAX_ADDR);
 }
 
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 97ef566c12..3f45550cf6 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1380,7 +1380,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
                                    qdev_get_gpio_in(nvic, 8));
         i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
         if (board->peripherals & BP_OLED_I2C) {
-            i2c_create_slave(i2c, "ssd0303", 0x3d);
+            i2c_slave_create_simple(i2c, "ssd0303", 0x3d);
         }
     }
 
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 5dee2d76c6..8c1ee0cdd1 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -206,7 +206,7 @@ static uint8_t tosa_dac_recv(I2CSlave *s)
 static void tosa_tg_init(PXA2xxState *cpu)
 {
     I2CBus *bus = pxa2xx_i2c_bus(cpu->i2c[0]);
-    i2c_create_slave(bus, TYPE_TOSA_DAC, DAC_BASE);
+    i2c_slave_create_simple(bus, TYPE_TOSA_DAC, DAC_BASE);
     ssi_create_slave(cpu->ssp[1], "tosa-ssp");
 }
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index e596b8170f..34709afb32 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -317,7 +317,7 @@ static void versatile_init(MachineState *machine, int board_id)
 
     dev = sysbus_create_simple(TYPE_VERSATILE_I2C, 0x10002000, NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_create_slave(i2c, "ds1338", 0x68);
+    i2c_slave_create_simple(i2c, "ds1338", 0x68);
 
     /* Add PL041 AACI Interface to the LM4549 codec */
     pl041 = qdev_new("pl041");
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 5bf9cff8a8..4f6a2b6ddd 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -642,7 +642,7 @@ static void vexpress_common_init(MachineState *machine)
 
     dev = sysbus_create_simple(TYPE_VERSATILE_I2C, map[VE_SERIALDVI], NULL);
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_create_slave(i2c, "sii9022", 0x39);
+    i2c_slave_create_simple(i2c, "sii9022", 0x39);
 
     sysbus_create_simple("pl031", map[VE_RTC], pic[4]); /* RTC */
 
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index e1f22f5868..9a9bbc653b 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -330,8 +330,8 @@ static void z2_init(MachineState *machine)
     type_register_static(&aer915_info);
     z2_lcd = ssi_create_slave(mpu->ssp[1], TYPE_ZIPIT_LCD);
     bus = pxa2xx_i2c_bus(mpu->i2c[0]);
-    i2c_create_slave(bus, TYPE_AER915, 0x55);
-    wm = i2c_create_slave(bus, TYPE_WM8750, 0x1b);
+    i2c_slave_create_simple(bus, TYPE_AER915, 0x55);
+    wm = DEVICE(i2c_slave_create_simple(bus, TYPE_WM8750, 0x1b));
     mpu->i2s->opaque = wm;
     mpu->i2s->codec_out = wm8750_dac_dat;
     mpu->i2s->codec_in = wm8750_adc_dat;
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index 0710ce9de5..3b82a8567f 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -161,7 +161,7 @@ static void sii9022_realize(DeviceState *dev, Error **errp)
     I2CBus *bus;
 
     bus = I2C_BUS(qdev_get_parent_bus(dev));
-    i2c_create_slave(bus, TYPE_I2CDDC, 0x50);
+    i2c_slave_create_simple(bus, TYPE_I2CDDC, 0x50);
 }
 
 static void sii9022_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index f81601a5b9..21ec52ac5a 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -281,13 +281,13 @@ bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **errp)
     return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
-DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
+I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr)
 {
     I2CSlave *dev = i2c_slave_new(name, addr);
 
-    i2c_slave_realize_and_unref(dev, bus, &error_fatal);
+    i2c_slave_realize_and_unref(dev, bus, &error_abort);
 
-    return DEVICE(dev);
+    return dev;
 }
 
 static void i2c_slave_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 51bf95b303..67924915ae 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -944,7 +944,7 @@ void ppce500_init(MachineState *machine)
     memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
     i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
-    i2c_create_slave(i2c, "ds1338", RTC_REGS_OFFSET);
+    i2c_slave_create_simple(i2c, "ds1338", RTC_REGS_OFFSET);
 
 
     /* General Utility device */
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1a106a68de..1702344c46 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -339,7 +339,7 @@ static void sam460ex_init(MachineState *machine)
     spd_data[20] = 4; /* SO-DIMM module */
     smbus_eeprom_init_one(i2c, 0x50, spd_data);
     /* RTC */
-    i2c_create_slave(i2c, "m41t80", 0x68);
+    i2c_slave_create_simple(i2c, "m41t80", 0x68);
 
     dev = sysbus_create_simple(TYPE_PPC4xx_I2C, 0x4ef600800, uic[0][3]);
 
-- 
2.21.3


