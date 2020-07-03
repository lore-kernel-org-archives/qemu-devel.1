Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A008C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684822088E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oL99wT3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684822088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP5j-0002ga-IS
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxO-0005FD-SO
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxN-0005i6-0V
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id s10so33383728wrw.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Hph4sRVrrHIXw5YxnyUupaHI04MuhyQF4bKu2vDwcK0=;
 b=oL99wT3WaeQJXGPpANoeqAxdlnpLZCgpqgQll6LBDd+mBvqm15hVr+ulPsSd5Psy63
 U4JaazB/sN6S+Rrk72UWBiCz7iTJdrWGOuKPhK7Bv240y8+haQr1RE+DskApFsIOguVj
 YHMGDYqzXkOy+LnNFmIdwF4VRHgvKMO2a7OoVO8QJ2rDPACAitToqtmukuMSuuNgoiYR
 PMNtEal0cD3EyEzDg3DAHi57GPjXMHyGzli0Y+7ib56u53m4pgCYcbLKi2jl3OtQ7IrN
 6Feh5uARG1gh2q25rNLp1xZjgT9dIpWeNAuuVm8qjmJWh8KS+lSXlxpzzO1Y2WdEGxfm
 nfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hph4sRVrrHIXw5YxnyUupaHI04MuhyQF4bKu2vDwcK0=;
 b=OO7U4EKwsLlmOFu57rMxkMNaXpvT8pKFjBB9taYNqP0v1n9lA+Mz8rD0yb+Sslk+2U
 lzczPfFXBc8A+MFM8VPJKZ7TarZeUTMyA2KzMbUjL9DrJuHyfmS0/S1/VuWupd7iZOJI
 jzxrTTMbyjC9FxBRyW8yzEogrsED03VyF/O1hOvamKWjEtVC6blXgsT/7b+pPwcXMH9K
 DbMj5tSRsdJUO2iAjNyYpooKEBIhtc4QpDKw26b/UUscJNOZ8L+WhsUhIRxAqEnZAR4z
 dC6usn9hqIag/5jEK1HShfyFSsFvv1KfCRil4vsei6V3qkr741oIUlYwHY4XVG59Tlys
 4KNg==
X-Gm-Message-State: AOAM533Qse2fncZM9G+YuzsLuTQH2HiO9GV+myocT+XHhtBNrHdODAhb
 nEQct2yqDaoweHfKfx7oj62AEp3AdTg0ZA==
X-Google-Smtp-Source: ABdhPJzOz/5W+Gye5wC3mP84fuZFcshgP1W6MNv1yktopOsEAkMVdFSOYpGInNVZAwBDsPhiYlpHGg==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr37168766wru.200.1593795271227; 
 Fri, 03 Jul 2020 09:54:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/34] hw/arm/spitz: Implement inbound GPIO lines for bit5 and
 power signals
Date: Fri,  3 Jul 2020 17:53:52 +0100
Message-Id: <20200703165405.17672-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-6-peter.maydell@linaro.org
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


