Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C487EC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:37:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CECB2087B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pX0mHP6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CECB2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32895 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLADG-0002J5-Mt
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:37:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fQ-0005WK-Ab
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9fO-00075R-78
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:55632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9fM-0006ao-5N
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:02:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id o25so150876wmf.5
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=lwRLvPOYXyQlnpWWoMVUzPzdVHw8aYM3HaWE/wvgSrI=;
	b=pX0mHP6ETodKIkkgksVjb5SEiHgIBuWUA8bKgd3cNb2xH4oi/0bN+DVm9XA0UN3pK3
	2MOmscfvEv7DIWsl4b4rFle3OZwrZ6WaYTbhKgQa9/SJMZIUipi1z26IK8IHorqYdiLj
	GHEABOe8g4TEPuEtvVWL7cmPF1sltZs9aUYqgP40hS6ho5uWshxnmiq+Qp3LAMefrB3F
	83r3EB1WehQHUFm4OkY9IjW3DeuBU9L6Nco2BAZEgTHoOQlYUg++Fo/B1edy1IvHPjX0
	FlbV0i8/Pm2kw4XcuPcBP8i7nBoRlFDiOSLNjRHGsC3mHcKWMiiDbNY7KJ7WFNWTg0rt
	GLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=lwRLvPOYXyQlnpWWoMVUzPzdVHw8aYM3HaWE/wvgSrI=;
	b=ou30xp7hlMeE3zIbVXhJkEjEw/xyJ/s4xad96YCD2Rsm/fcahrBehN2slcMR/LxzSt
	XJKX7/a52e+q95puAFxnF4hHE4oA7U3Ymm9p2O8LGkZ80tVWvRY53bemfDFZuOTFsY6K
	YT2hA1GbBafZ2ahrq/gWm6fRBs/N8hOedzaRxoAlkKUhVEYDNDDNOYNC86XFLkemXAoK
	32deLWFKbMjgb8SZw6Jw/dvd6NEWpuULjACxJSMcpyHpaTuhwbtzOeAp/FSz1PpvNm8z
	SxHe2KtGAT8BDMzP9DBb2wXTaD8utBreFofnf4pC4Tlc/ROpyoWW5c5aKOw/38tHQ09P
	f06A==
X-Gm-Message-State: APjAAAVzAqLxZ0t5bmBpJFtqV03EiJA+1SSHWjhHbruCGyjbQyATRPci
	QSKKtHhOGr6e3AvGHqA9PjHBgbUAd2g=
X-Google-Smtp-Source: APXvYqyAAMds9QL0dafQ7K4/pYGcoc4ySpVQL5fJO8aJeKYgZj9oJYGtEa7SwCJLAdAl/ZDvkC4mkQ==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr46263wmh.128.1556557272577;
	Mon, 29 Apr 2019 10:01:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.01.11
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:01:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 18:00:19 +0100
Message-Id: <20190429170030.11323-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 31/42] hw/arm/aspeed: Use
 TYPE_TMP105/TYPE_PCA9552 instead of hardcoded string
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429170019.uekX0n4-_XQrr5Mzq404YdbXfK977BGWLtC3YteTlIE@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190412165416.7977-2-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/aspeed.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 996812498dc..1c23ebd9925 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -19,6 +19,8 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/boards.h"
 #include "hw/i2c/smbus_eeprom.h"
+#include "hw/misc/pca9552.h"
+#include "hw/misc/tmp105.h"
 #include "qemu/log.h"
 #include "sysemu/block-backend.h"
 #include "hw/loader.h"
@@ -267,7 +269,8 @@ static void ast2500_evb_i2c_init(AspeedBoardState *bmc)
                           eeprom_buf);
 
     /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7), "tmp105", 0x4d);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 7),
+                     TYPE_TMP105, 0x4d);
 
     /* The AST2500 EVB does not have an RTC. Let's pretend that one is
      * plugged on the I2C bus header */
@@ -288,13 +291,15 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
     AspeedSoCState *soc = &bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
 
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), "pca9552", 0x60);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), TYPE_PCA9552,
+                     0x60);
 
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 4), "tmp423", 0x4c);
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 5), "tmp423", 0x4c);
 
     /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), "tmp105", 0x4a);
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 9), TYPE_TMP105,
+                     0x4a);
 
     /* The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough */
@@ -302,7 +307,7 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState *bmc)
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), 0x51,
                           eeprom_buf);
-    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), "pca9552",
+    i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), TYPE_PCA9552,
                      0x60);
 }
 
-- 
2.20.1


