Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99984C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64392204EC
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w9idSx+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64392204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYJq-00071P-L1
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEe-0006As-Mf
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:44 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEZ-0004gr-El
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:44 -0400
Received: by mail-wm1-x342.google.com with SMTP id o8so13000314wmh.4
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uwJ6AMnZ4BeCXoBcjEvXgzYDqM09D0Grg4qI2GYORlA=;
 b=w9idSx+0gR7I3+whwLAtTQ7A4m1JDKYQnxwFpVGWoy1zyPJoHtWn7jrBfB64yYDhJb
 zRX3DoCDbWX/lt3udEUqF/quULhT1YkeaRLgjM+re95BUz4X0n7bBmmscdehIdfz6EfS
 ZENQM4oFGmfjl562zDe214qYQExwzKV3gUG/M6Ru+EDf5hMMzembzNkRl7vz83SEW/Af
 iosd6MKXYzjZ/P/W9/Zabs4dZ9DFC7XGhtl7QVWW11N7jyAMQ6htRfvzY49/Wdh7rTpL
 sUrg2OS2etoBz/9Om/tvB8TgUj6UehkxeKe2gWQmls6zORlGtCbARZgunh23/GcEiiDe
 exbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uwJ6AMnZ4BeCXoBcjEvXgzYDqM09D0Grg4qI2GYORlA=;
 b=DN2DZwAFSp8e81lLRq9WfGBJx+DX9TT9rAVJiHUirg6uZW3hAopO8JqZUI8idRmVIP
 k9JxF96RCXPxObIt+2ZFTbK9j8Imv8KehPf2ripme6ayr8kMZzHdO9JVcQw7JmoXZspL
 w4iKoSWnhxGLBb4Qh9corUeRyjda78AmFA99O6ROluAAXLJG+WQbvKAPPQ0s8Gv9ivLu
 A8Weeex/voMkf9nQUuvBZSLjGg1GA9AodYxWlxOMIla4bl19lV8P669ZAbPWZ5clLXWt
 9Vi+kIUroKIFZiv2hblPZwWp1wFtwUOODW4ElA7MzlfDah9VtdpTdaL0GCRaLiPONLpj
 KXZg==
X-Gm-Message-State: AOAM530M2xwtoPB/iSp3xHz9aV+t4HnRNp09XzmNKzs4TpH7ZI2IzBQo
 P/A+656vmAkRkmxo5NYVAtGMUA==
X-Google-Smtp-Source: ABdhPJzNybbq/Q5THx6AN2Pq4mbtM4WBGacxWUfLq08e7SVuU3AzC9cJUE3PCLIswe1KLCqccZ3VwQ==
X-Received: by 2002:a1c:9650:: with SMTP id y77mr8861480wmd.101.1593354278097; 
 Sun, 28 Jun 2020 07:24:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/17] hw/arm/spitz: Implement inbound GPIO lines for bit5 and
 power signals
Date: Sun, 28 Jun 2020 15:24:17 +0100
Message-Id: <20200628142429.17111-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628142429.17111-1-peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the Spitz board uses a nasty hack for the GPIO lines
that pass "bit5" and "power" information to the LCD controller:
the lcdtg realize function sets a global variable to point to
the instance it just realized, and then the functions spitz_bl_power()
and spitz_bl_bit5() use that to find the device they are changing
the internal state of. There is a comment reading:
 FIXME: Implement GPIO properly and remove this hack.
which was added in 2009.

Implement GPIO properly and remove this hack.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/spitz.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 69bc2b3fa10..11e413723f4 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -586,12 +586,9 @@ static void spitz_bl_update(SpitzLCDTG *s)
         zaurus_printf("LCD Backlight now off\n");
 }
 
-/* FIXME: Implement GPIO properly and remove this hack.  */
-static SpitzLCDTG *spitz_lcdtg;
-
 static inline void spitz_bl_bit5(void *opaque, int line, int level)
 {
-    SpitzLCDTG *s = spitz_lcdtg;
+    SpitzLCDTG *s = opaque;
     int prev = s->bl_intensity;
 
     if (level)
@@ -605,7 +602,7 @@ static inline void spitz_bl_bit5(void *opaque, int line, int level)
 
 static inline void spitz_bl_power(void *opaque, int line, int level)
 {
-    SpitzLCDTG *s = spitz_lcdtg;
+    SpitzLCDTG *s = opaque;
     s->bl_power = !!level;
     spitz_bl_update(s);
 }
@@ -639,13 +636,16 @@ static uint32_t spitz_lcdtg_transfer(SSISlave *dev, uint32_t value)
     return 0;
 }
 
-static void spitz_lcdtg_realize(SSISlave *dev, Error **errp)
+static void spitz_lcdtg_realize(SSISlave *ssi, Error **errp)
 {
-    SpitzLCDTG *s = FROM_SSI_SLAVE(SpitzLCDTG, dev);
+    SpitzLCDTG *s = FROM_SSI_SLAVE(SpitzLCDTG, ssi);
+    DeviceState *dev = DEVICE(s);
 
-    spitz_lcdtg = s;
     s->bl_power = 0;
     s->bl_intensity = 0x20;
+
+    qdev_init_gpio_in_named(dev, spitz_bl_bit5, "bl_bit5", 1);
+    qdev_init_gpio_in_named(dev, spitz_bl_power, "bl_power", 1);
 }
 
 /* SSP devices */
@@ -820,15 +820,11 @@ static void spitz_out_switch(void *opaque, int line, int level)
     case 3:
         zaurus_printf("Orange LED %s.\n", level ? "on" : "off");
         break;
-    case 4:
-        spitz_bl_bit5(opaque, line, level);
-        break;
-    case 5:
-        spitz_bl_power(opaque, line, level);
-        break;
     case 6:
         spitz_adc_temp_on(opaque, line, level);
         break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -858,9 +854,9 @@ static void spitz_scoop_gpio_setup(SpitzMachineState *sms)
 
     if (sms->scp1) {
         qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_CONT,
-                              outsignals[4]);
+                              qdev_get_gpio_in_named(sms->lcdtg, "bl_bit5", 0));
         qdev_connect_gpio_out(sms->scp1, SPITZ_SCP2_BACKLIGHT_ON,
-                              outsignals[5]);
+                              qdev_get_gpio_in_named(sms->lcdtg, "bl_power", 0));
     }
 
     qdev_connect_gpio_out(sms->scp0, SPITZ_SCP_ADC_TEMP_ON, outsignals[6]);
-- 
2.20.1


