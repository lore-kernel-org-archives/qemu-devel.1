Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50CEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3E00255C6
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 17:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYoTbZy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E00255C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpxng-0002QJ-Vs
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 13:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpxjj-0005nQ-GI; Mon, 29 Jun 2020 13:38:31 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:39441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpxjh-0000IV-RR; Mon, 29 Jun 2020 13:38:31 -0400
Received: by mail-ej1-x641.google.com with SMTP id w6so17475668ejq.6;
 Mon, 29 Jun 2020 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6cSGomOE4QTMbqeX26Zlg/Tz0PsmS6jvlXcVlbBS5jk=;
 b=MYoTbZy3tSOJy+RBaNTr/s68o6unK5Jg9w+yfwdUdOHKYQ0A8JCTOr3aAbfNhviUhY
 qUH87BKYUFQrnPrML2GzdkE1jex0nRM63rZExKsDC0WxoO3QVk6ZZ8qB+CiRI39mRjlQ
 7bGUJJ+9ojSNmj1kF0FA4tbiQHiuoOq/jx1wZO92+JfHf5ZsRQ1nNIVVYbmObdN2E621
 qMhnXWoppLKGueLs9fndoU2EiA5rk0zj63zukK5fY5zULlk6PbrJy/A+Njf7S6duzxEI
 wSbqn8TX0tJTEvUKInvELvgZ40K4s9h8g1+7G7i2KL5C2PVISXI5wBkddv6A86CKUA+/
 BaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6cSGomOE4QTMbqeX26Zlg/Tz0PsmS6jvlXcVlbBS5jk=;
 b=dliRD9B2EIZfMdUEFWrXhA1aAeUvIvT/sFj2o+HHCULm7sbKowxpcWHTdjtR2To64v
 yP+od4daSkm/tnMlkZoXucyTgptO18lCjBJ/d46lVqoPyF/Rnp3tgwTgyQDtYaPqWhoF
 0LHp3mmMDTJp8pFG6J4QMaUJRWjvRmf0V4gwfJeNOQh1GHhmmsePM25A60AgCigTAbrY
 6YYNlCi+pX/AuYVqJOHkKn/BIA4xwSY+qi4v3RP5SKGyZroActvhbAij/wUHMv+YcjUk
 iILHec5X+hLsbistzUat0a4cuWBrOUSRwlIXqUUcIZuNmQNXlQ79fRoHMNuUqHkTwgcp
 QV2Q==
X-Gm-Message-State: AOAM532isotknkQkmrBvZwMjjtMd/MRsKAGgzdzxe/j60KGGqAFK+mF4
 vlDR+i8XkBx0eaGU+IzrdqMt5wAVxpo=
X-Google-Smtp-Source: ABdhPJxpCvKXibp1/JiVxLX2RNV5rM15dNzb1UWuuOCmsy+mejhyx7LPpj2NHtJHBCSO61EMgBskfA==
X-Received: by 2002:a17:906:17d5:: with SMTP id
 u21mr15597071eje.413.1593452307332; 
 Mon, 29 Jun 2020 10:38:27 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id ce19sm216029ejb.24.2020.06.29.10.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 10:38:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new()
Date: Mon, 29 Jun 2020 19:38:18 +0200
Message-Id: <20200629173821.22037-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629173821.22037-1-f4bug@amsat.org>
References: <20200629173821.22037-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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

We use "new" names for functions that allocate and initialize
device objects: pci_new(), isa_new(), usb_new().
Let's call this one i2c_slave_new(). Since we have to update
all the callers, also let it return a I2CSlave object.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/i2c.h | 2 +-
 hw/arm/aspeed.c      | 4 ++--
 hw/i2c/core.c        | 9 ++++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index d6e3d85faf..18efc668f1 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -79,8 +79,8 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
 int i2c_send(I2CBus *bus, uint8_t data);
 uint8_t i2c_recv(I2CBus *bus);
 
+I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
-DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
 bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
 
 /* lm832x.c */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 1285bf82c0..54ca36e0b6 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -513,7 +513,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
     /* Bus 3: TODO bmp280@77 */
     /* Bus 3: TODO max31785@52 */
     /* Bus 3: TODO dps310@76 */
-    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
+    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
     qdev_prop_set_string(dev, "description", "pca1");
     i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 3),
                           &error_fatal);
@@ -531,7 +531,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
                           eeprom_buf);
-    dev = i2c_try_create_slave(TYPE_PCA9552, 0x60);
+    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
     qdev_prop_set_string(dev, "description", "pca0");
     i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 11),
                           &error_fatal);
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index acf34a12d6..6eacb4a463 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -267,13 +267,13 @@ const VMStateDescription vmstate_i2c_slave = {
     }
 };
 
-DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
+I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
 {
     DeviceState *dev;
 
     dev = qdev_new(name);
     qdev_prop_set_uint8(dev, "address", addr);
-    return dev;
+    return I2C_SLAVE(dev);
 }
 
 bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
@@ -283,10 +283,9 @@ bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
 
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
 {
-    DeviceState *dev;
+    DeviceState *dev = DEVICE(i2c_slave_new(name, addr));
 
-    dev = i2c_try_create_slave(name, addr);
-    i2c_realize_and_unref(dev, bus, &error_fatal);
+    i2c_realize_and_unref(I2C_SLAVE(dev), bus, &error_fatal);
 
     return dev;
 }
-- 
2.21.3


