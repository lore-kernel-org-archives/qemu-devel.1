Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABA1C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA1F2083E
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 13:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJJ6UM1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA1F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH5oE-0005mo-Ap
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 09:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5ls-0001dG-27; Sat, 12 Sep 2020 09:40:52 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:34856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH5lq-0007pr-F0; Sat, 12 Sep 2020 09:40:51 -0400
Received: by mail-wr1-x42d.google.com with SMTP id e16so14120002wrm.2;
 Sat, 12 Sep 2020 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dSaiRltAOJ/zxeobJcA1LXrUSnmjbfrE49BlQ0jwkLs=;
 b=KJJ6UM1aUNnpaFueQ/03AK5N4pwtNsVK6FSFmmFvug0PXtNpZLPPw5SGbQAy61UsD5
 +o+WmmKZFKGUsr3B37WtCDMdmqwnUYxb5psWrEDgICUO4sZOF6p01QngSCKfT4nP2+72
 TwZbDsXQ7zfYq8/PqfGktzqgrjTa6DubNdACc6A++eDTTwe5kNhwQrb3mQox/03pptIP
 VDXVV4Jwc5RUrVK+evTAjFLL70CiRuDfwuXYYhE636jBDRpvMxLVZ6baY/PSS0R0cx85
 nGkW6xKE6/ba1GcXAWIU8yw+5X21fNUI0ux+fol+g8L6Jm9d+pPUTgOyeiLhxh+0fs2T
 4m7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=dSaiRltAOJ/zxeobJcA1LXrUSnmjbfrE49BlQ0jwkLs=;
 b=YnhUaKuJ4GKRRoKj1iZ/+T2zoRa0Z/XbxP35i0nU96BmEzIb9G8SC7+sVVCpIHBU4/
 fq0tAeQeHzYZFicAvMdlTXnqkr1q/aCxPnMRzC6JUSwo74bxvfty5KeXft/pft0SyP7s
 0dBmciYqeZXwOSzdsk4QZ0T2Wy7hvjvcOzEmeAeyaihuNMYbwwu9HnZKQFtFFuiyAPTC
 NS/K5nBSczNuRVIGDKRPgxWKHb4gRZ43tWH8y49xpM6FARXZqXPJPZ6DgXeK/N42oHkt
 U+3cRh2z4/A/64hmgfiPnLEQlozJqcbko5cmHrqlWmNEsZS59oqaqP8FmCTECvVlMrjp
 f97A==
X-Gm-Message-State: AOAM530bCaw1KCZxaz7Pfxk7knGrPRX/90Sx0bhp74a0u6JRPFWjjzQF
 rdQ2sdLlFfcc+VuFLbCNRL0ARAQtt3U=
X-Google-Smtp-Source: ABdhPJyiwfHXP/Q206pIqJyyK9XNiRNJMQj30DnA8BxznmLeYZn2vVQEaloGAerdnh00AjBQYkj7ng==
X-Received: by 2002:adf:e289:: with SMTP id v9mr6932636wri.14.1599918048595;
 Sat, 12 Sep 2020 06:40:48 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm10309144wmg.44.2020.09.12.06.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 06:40:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/7] hw/misc/led: Emit a trace event when LED intensity has
 changed
Date: Sat, 12 Sep 2020 15:40:37 +0200
Message-Id: <20200912134041.946260-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912134041.946260-1-f4bug@amsat.org>
References: <20200912134041.946260-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Track the LED intensity, and emit a trace event when it changes.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/led.c        | 4 ++++
 hw/misc/trace-events | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/misc/led.c b/hw/misc/led.c
index c5fa09a613a..5266d026d0b 100644
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
index 211ff114694..5f3f6121bc9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -217,6 +217,7 @@ grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx6
 
 # led.c
 led_set_intensity(const char *color, const char *desc, uint8_t intensity_percent) "LED desc:'%s' color:%s intensity: %u%%"
+led_change_intensity(const char *color, const char *desc, uint8_t old_intensity_percent, uint8_t new_intensity_percent) "LED desc:'%s' color:%s intensity %u%% -> %u%%"
 
 # pca9552.c
 pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
-- 
2.26.2


