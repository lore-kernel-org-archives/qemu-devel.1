Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6D5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D004020760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 17:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpS9NNSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D004020760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrPBl-0003tU-2C
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 13:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxU-0005Tj-Am
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:40 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOxS-0005l1-Cn
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id z2so11163730wrp.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=oD1qiWavKhquHomKBKPR8Lyah9vGykUE9wA4yaevKfY=;
 b=XpS9NNSOvH2yaLLeLVVJvNBc49U8pNbeQRKHCDj3hogS9UzJgvxnW5VjalzmRFAphD
 jRQdW1jz5oHV5xvqqnMl24qox9YSSWlRXeD5N+xpMgdQUr6jxsN/b4YpCEI3g0fCcPX0
 i7T70zAHn4Bl0MUT2B/1zWyLp5/3tKR5tI4KZA8AVYv4GQ8CSn1pLwnr2lYaRwgmrscn
 +LDwFLuNOQgLZ7FbR4ss0tzlyqJeyVT1gPHFKWZsD8lHmGBt7Shu9fYtyBvht3y+VENb
 rSCpW9RoJ6+HVV94NOYshY9B5dWxkxCyAhdHfbvUTg4mMWJRARDOD0tt4kSl2RnHSh2y
 85PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oD1qiWavKhquHomKBKPR8Lyah9vGykUE9wA4yaevKfY=;
 b=rRsBph/ljjI98F5eTAFdNB5NL9jFaD149B/34TMm4lvYpmlWt7805vZTW56yDPysL5
 +teC/Xv2TXfbi7qTQjCbxc2wK+f9jokj9GP7MnUUMfkvkuu+nO+Xv8ddiS6Ush5Z6cL6
 lCOhnFqU8k/GsTEJc4fCBYENCQpeQ4x3m8Mr/+NHg9gD0wCAQTLjLiYqE+woM6xBl9ZL
 h6fnDqIY6maT/fr4qijFZb9km1n4wlFPfZBa8IliWmkICOAiSEs671/URBWBrmiejXOW
 AVAbPwIMYUNu/K2KQjQO7SlqUBpIJL4KoBQbZocyB2NQaKco5VUYq3BgVaoAoVBUoqnw
 TBAg==
X-Gm-Message-State: AOAM533DaJslpPZB3TemFDw7OnpLB+jng7D9w9E7g70pdiGS3SmpLqcL
 MXhPM0uvYkqYMJ10aBn0JNNbkSRWesYxbg==
X-Google-Smtp-Source: ABdhPJwdoAHD8s+va/3gCHeIBkpVrsAn41Tr6Lm2MM6CxCluOAOvdTmAyNlLGLpSBJ6fJ7446vWvzA==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr26617729wrw.10.1593795276757; 
 Fri, 03 Jul 2020 09:54:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/34] hw/misc/max111x: Use GPIO lines rather than
 max111x_set_input()
Date: Fri,  3 Jul 2020 17:53:57 +0100
Message-Id: <20200703165405.17672-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200628142429.17111-11-peter.maydell@linaro.org
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


