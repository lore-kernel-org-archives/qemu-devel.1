Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF6CC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09E54204EC
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbeQVPCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E54204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYI6-0003N3-8t
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEh-0006HX-42
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEf-0004kK-59
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id k6so14062495wrn.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2DdwiLV6b1TNMiDc5ffJEq+J0urqTVL76KQisyKN10I=;
 b=jbeQVPCj3yyTpIPlOVE15mKqcSeUnSlI+bkImW6wpTyIlIux/MKdYglzvcw5v1S+r6
 9Xh1CgP4sJ6QEst3XrWxF8kJq70J9/LZbNOgM7u+idRiJeBUom+aR0E3KEfJWdB5zuXq
 ARhhSZwMNW/XOEmSZUcyXB6nlmImhZkVGcTRo6XasE1mHgRBRDf7ORcdgspv4MxAFrIl
 Bhex0On03Kf3D0HBr9Wa6+Fk9tKQzHkCR7uiI22m0FeOP+uA6VbtvgDZ595TNmeLzLUr
 C+PUxs+paEoq6w8jlMRMEPhZuUS8yMB3dPGzx2LLGa1iYrptaPq56kluaBvnrSL9qa2O
 MCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2DdwiLV6b1TNMiDc5ffJEq+J0urqTVL76KQisyKN10I=;
 b=cy/BQH/IcXzXcmAv1WE/PSATwiRbiyc1b1tnGMti48pFUFYa6so7OCMcMhWIblXYzX
 RjaeLsm7FUpL4bttC0PnUOFKLF1pvixOhfqA6PnmY4uZoSmEc7m5KPoQIBr/g2phdtC6
 EoVbsEaf68v78KyxO9QI9W4K4XE6IcLvXMIo+9ulvZR4tN88epd0rGM+k9yIml2Kdnvn
 0TrzgJthJGGOnZTzTn1z4niyuQ2VoJqp4v61Ts5p5nNHH3a2mAllEfm9sRhRg6nuQKgg
 BjyY2sik15Qu7z8wbAZNuQcyVwg53fAQADGCv3da4GKWnRwyy1gLQ/Wajg40Do7P12qO
 zvpA==
X-Gm-Message-State: AOAM533KmW7DMe5az68kzYqJwumzmqqDEDOcPPyGmViR3N1NyXURYvQH
 qrByuiYixC7vljWfEbCzsFAo+Q==
X-Google-Smtp-Source: ABdhPJxh0gFeMOphyrkWiCk41Hd72Hp40mkv5DtuJoDmPoP+91rDihJITpEmxd14ahXq0UXMAO7jbw==
X-Received: by 2002:adf:9062:: with SMTP id h89mr12181629wrh.285.1593354283851; 
 Sun, 28 Jun 2020 07:24:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/17] hw/misc/max111x: Use GPIO lines rather than
 max111x_set_input()
Date: Sun, 28 Jun 2020 15:24:22 +0100
Message-Id: <20200628142429.17111-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628142429.17111-1-peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The max111x ADC device model allows other code to set the level on
the 8 ADC inputs using the max111x_set_input() function.  Replace
this with generic qdev GPIO inputs, which also allow inputs to be set
to arbitrary values.

Using GPIO lines will make it easier for board code to wire things
up, so that if device A wants to set the ADC input it doesn't need to
have a direct pointer to the max111x but can just set that value on
its output GPIO, which is then wired up by the board to the
appropriate max111x input.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/ssi.h |  3 ---
 hw/arm/spitz.c       |  9 +++++----
 hw/misc/max111x.c    | 16 +++++++++-------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index 4be5325e654..5fd411f2e4e 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -111,7 +111,4 @@ SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
 
 uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
 
-/* max111x.c */
-void max111x_set_input(DeviceState *dev, int line, uint8_t value);
-
 #endif
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 93a25edcb5b..fa592aad6d6 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -696,13 +696,14 @@ static void corgi_ssp_gpio_cs(void *opaque, int line, int level)
 
 static void spitz_adc_temp_on(void *opaque, int line, int level)
 {
+    int batt_temp;
+
     if (!max1111)
         return;
 
-    if (level)
-        max111x_set_input(max1111, MAX1111_BATT_TEMP, SPITZ_BATTERY_TEMP);
-    else
-        max111x_set_input(max1111, MAX1111_BATT_TEMP, 0);
+    batt_temp = level ? SPITZ_BATTERY_TEMP : 0;
+
+    qemu_set_irq(qdev_get_gpio_in(max1111, MAX1111_BATT_TEMP), batt_temp);
 }
 
 static void corgi_ssp_realize(SSISlave *d, Error **errp)
diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index abddfa3c660..3a5cb838445 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -131,12 +131,21 @@ static const VMStateDescription vmstate_max111x = {
     }
 };
 
+static void max111x_input_set(void *opaque, int line, int value)
+{
+    MAX111xState *s = MAX_111X(opaque);
+
+    assert(line >= 0 && line < s->inputs);
+    s->input[line] = value;
+}
+
 static int max111x_init(SSISlave *d, int inputs)
 {
     DeviceState *dev = DEVICE(d);
     MAX111xState *s = MAX_111X(dev);
 
     qdev_init_gpio_out(dev, &s->interrupt, 1);
+    qdev_init_gpio_in(dev, max111x_input_set, inputs);
 
     s->inputs = inputs;
 
@@ -153,13 +162,6 @@ static void max1111_realize(SSISlave *dev, Error **errp)
     max111x_init(dev, 4);
 }
 
-void max111x_set_input(DeviceState *dev, int line, uint8_t value)
-{
-    MAX111xState *s = MAX_111X(dev);
-    assert(line >= 0 && line < s->inputs);
-    s->input[line] = value;
-}
-
 static void max111x_reset(DeviceState *dev)
 {
     MAX111xState *s = MAX_111X(dev);
-- 
2.20.1


