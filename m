Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D6BC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68B421927
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbNlWh0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68B421927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFK7X-0003vt-N7
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 12:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFK4q-00088C-4j; Mon, 07 Sep 2020 12:33:08 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:45189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kFK4o-0007c4-Gw; Mon, 07 Sep 2020 12:33:07 -0400
Received: by mail-ed1-x52d.google.com with SMTP id l17so13270655edq.12;
 Mon, 07 Sep 2020 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sOTWIKCT6VDFv2Z2z68Ud6vgTWqu6BKF5mHpas4qUIU=;
 b=CbNlWh0SZ+7iSW1+FYz4wkXR13QN3P64ZIb9mGTZ45QuJKP8BzwzHJWcUZ4opDAS+U
 NPwfnLRggsDeRGkYoETvHFcOISfCCoZEBl+m+F2F4mhClWL1W/PD5k5C1JukQNptuduA
 tQYQrZiO1+J2GdIJssDIepQ8IXYIGxQp/bQ/kOcAVQj7UzI7873cVIxKWzS6H6JJMr3A
 EIGAyzN7jkWU3F93RLTnvnKHR4JYudYeEVDsMDW+esIf/UaVOF8/qwDCf6g0x5jA086X
 KDLkQl6FTCHaGXnVaaqSBu6CGskE+VSvlpwu2B6tB0ppiVXB+JvGr12EHMXcectt4ETm
 SBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sOTWIKCT6VDFv2Z2z68Ud6vgTWqu6BKF5mHpas4qUIU=;
 b=rB7ahS0G9JlxY3QXewcESNSsRkeWoFlGKpNjHawHP/dEnFJb97X9FLcu837CbMkZIg
 JKN1ONuKycBOxRvUcEKLcQQoH/GdiJIoy5LJpGqk21IRhmKG9uibJd+M6yDQAmClcme4
 Di6Sz4ZE331MeZhJAkAt1LI6aaL1NQNgK/b7V1r4h+jr+B1mHKro1owfuCN2kyJGWnI7
 inHZPrrjtLM/XxL6d2cVMl6Xhu6pMuohm7La3aTutI2clsWLgEAY23THrH5kcxXv4XQR
 lnMnZ0SKLmve5sQ6RGY2XZHQh670pwkApPlwrykEdvGGY1n1hxnUZYpvqORk8QZXMdP2
 0Wzg==
X-Gm-Message-State: AOAM531FuvZIlbPA2cuIPqWLC5x39+HsMUpYsRwiQm/Imzg2Pi3D09HQ
 RKMTAuwV1omZIxtM+Eysg1K3lR1g9Ng=
X-Google-Smtp-Source: ABdhPJz4mZwYDnh5f9SkSMuj18wRVfof8pdYAQR5sxNMR440kQguG89aeMXab6/H9yyTddV3KMHFew==
X-Received: by 2002:aa7:dbd9:: with SMTP id v25mr23489525edt.78.1599496384529; 
 Mon, 07 Sep 2020 09:33:04 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u13sm15700199ejn.82.2020.09.07.09.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 09:33:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/8] hw/misc/led: Emit a trace event when LED intensity has
 changed
Date: Mon,  7 Sep 2020 18:32:52 +0200
Message-Id: <20200907163257.46527-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907163257.46527-1-f4bug@amsat.org>
References: <20200907163257.46527-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x52d.google.com
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

Track the LED intensity, and emit a trace event when it changes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/led.c        | 4 ++++
 hw/misc/trace-events | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/misc/led.c b/hw/misc/led.c
index 1acade1d592..b7e9b1465bb 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -41,6 +41,10 @@ void led_set_intensity(LEDState *s, unsigned intensity_percent)
         intensity_percent = LED_INTENSITY_PERCENT_MAX;
     }
     trace_led_set_intensity(s->description, s->color, intensity_percent);
+    if (intensity_percent != s->intensity_percent) {
+        trace_led_change_intensity(s->description, s->color,
+                                   s->intensity_percent, intensity_percent);
+    }
     s->intensity_percent = intensity_percent;
 }
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 76c9ddb54fe..89d15f05f9a 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -216,6 +216,7 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
 
 # led.c
 led_set_intensity(const char *color, const char *desc, uint8_t intensity_percent) "LED desc:'%s' color:%s intensity: %u%%"
+led_change_intensity(const char *color, const char *desc, uint8_t old_intensity_percent, uint8_t new_intensity_percent) "LED desc:'%s' color:%s intensity %u%% -> %u%%"
 
 # pca9552.c
 pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
-- 
2.26.2


