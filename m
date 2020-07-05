Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0296C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88771206CD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 22:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDbwYSKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88771206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsDMC-0006ux-Pc
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 18:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsDKo-0004MU-6D; Sun, 05 Jul 2020 18:42:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsDKm-0002iA-I3; Sun, 05 Jul 2020 18:42:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id w3so27362395wmi.4;
 Sun, 05 Jul 2020 15:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jokNy7niATa/omdvHPNh1/95otnWd0IrupXVCsLQO64=;
 b=mDbwYSKBLDCXnp38XSaEUGGxDP01Y7AY7LfMGiVIhubB1aB2o21Jr6t096nys/BLJl
 gulZ0Tmk0uQtIrFVh4yTZMocWM34/8Wn8z1NSLYT9LAayxOPtKTaVjXXmMMbzpVgbA3n
 zcWJYeazRaXXEopLt+5WmBJhA7i9yerzHF3zLJPJw07lyEByBn+f51EQDpRwhQtEe07V
 xq7qGHEV6TMbDIx8ime4k3W4RtyynlTqCPMys7CJnPzmsKizHzwxjnkw6djQ4comqWj2
 qtsbojpx7PzaXwdgbOm8r5nPAGbK9ua9LI27B7BQtyiUkjd7hVPfTvNLufP9pIY18wTv
 pa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jokNy7niATa/omdvHPNh1/95otnWd0IrupXVCsLQO64=;
 b=dgYj5f0qYWFN2jvdi8ULBRwwzhh/odye4cJCQE+uWNn8QMO1VX/3zl5KFAlG5LPagG
 8AUoUb/XbLusB4QCLqVgmdT4gTImmCNAKWKCUuWTPHiMy+d9x6RYAIBHvDkI44ZuOStD
 hvrSDMr3ty+QnbHRgskYClRGIBEEME6ZEptqCIs8NCAYcCWHoSICMtVKY/W3kNV6Zz/C
 dp0P/N7wZh9FNbfgVtj//uXRifMrTmKSmtZx4yfRP9fRtjv8uB5wdPdaxLZQ8LHW/sSZ
 HdOmCQ8vYD3ahXIQ68OfvVG0uxQsr+oBlSimzYBVV6JlkUPW2PMhQOLFFhALGi4nSZ3s
 2tJA==
X-Gm-Message-State: AOAM533sA5Erx3RNFkNnZ3Lw7nlZv4QgwSBZglWcUpUMkjjzbVNwz9FQ
 J2z3gNF/dZmZDX8xrsbq3Y0n1JSrwi0=
X-Google-Smtp-Source: ABdhPJxj3Zgx6kBmcG46J/FBzB8K7gfM4rRlkvZCQPYM18vDZKqGIfGuAKmBH31JoGFcFH+XXNtH8w==
X-Received: by 2002:a1c:9d0c:: with SMTP id g12mr40679856wme.107.1593988922217; 
 Sun, 05 Jul 2020 15:42:02 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v6sm9151467wrr.85.2020.07.05.15.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 15:42:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] hw/i2c: Rename i2c_realize_and_unref() as
 i2c_slave_realize_and_unref()
Date: Mon,  6 Jul 2020 00:41:52 +0200
Message-Id: <20200705224154.16917-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705224154.16917-1-f4bug@amsat.org>
References: <20200705224154.16917-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

The other i2c functions are called i2c_slave_FOO(). Rename as
i2c_slave_realize_and_unref() to be consistent.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/i2c/i2c.h |  2 +-
 hw/arm/aspeed.c      | 10 ++++++----
 hw/i2c/core.c        |  6 +++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 18efc668f1..cb7211f027 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -81,7 +81,7 @@ uint8_t i2c_recv(I2CBus *bus);
 
 I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
-bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
+bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **errp);
 
 /* lm832x.c */
 void lm832x_key_event(DeviceState *dev, int key, int state);
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 54ca36e0b6..ed14e79f57 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -515,8 +515,9 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
     /* Bus 3: TODO dps310@76 */
     dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
     qdev_prop_set_string(dev, "description", "pca1");
-    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 3),
-                          &error_fatal);
+    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
+                                aspeed_i2c_get_bus(&soc->i2c, 3),
+                                &error_fatal);
 
     i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
     i2c_create_slave(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
@@ -533,8 +534,9 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
                           eeprom_buf);
     dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
     qdev_prop_set_string(dev, "description", "pca0");
-    i2c_realize_and_unref(dev, aspeed_i2c_get_bus(&soc->i2c, 11),
-                          &error_fatal);
+    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
+                                aspeed_i2c_get_bus(&soc->i2c, 11),
+                                &error_fatal);
     /* Bus 11: TODO ucd90160@64 */
 }
 
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 144786f17a..f81601a5b9 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -276,16 +276,16 @@ I2CSlave *i2c_slave_new(const char *name, uint8_t addr)
     return I2C_SLAVE(dev);
 }
 
-bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
+bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **errp)
 {
-    return qdev_realize_and_unref(dev, &bus->qbus, errp);
+    return qdev_realize_and_unref(&dev->qdev, &bus->qbus, errp);
 }
 
 DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
 {
     I2CSlave *dev = i2c_slave_new(name, addr);
 
-    i2c_realize_and_unref(DEVICE(dev), bus, &error_fatal);
+    i2c_slave_realize_and_unref(dev, bus, &error_fatal);
 
     return DEVICE(dev);
 }
-- 
2.21.3


