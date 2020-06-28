Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A53EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FD5204EC
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eaNfHj38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FD5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpYJr-00072d-4z
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 10:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEd-00067Q-G6
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpYEa-0004hI-Il
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 10:24:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id o2so13694698wmh.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ysv1uk4fUAcPUnh8atox5ci4JG0ni1jWyD3+T3R5UZg=;
 b=eaNfHj38r2xcCxDOtRyrTaKt/52EBaEzS96uXZeRgRUO/5aRnuigUT/Rzqj3omeRo/
 7+FGOdIcvt6w49hsY/4HT89KxNeHb0EUr8JcufxuLN9DiYnoSQGnal2k0tDI3g2bIu/0
 YoL1u5r1aCHtydxrmSvzXoOhxkV3XZ8a7zyPC4hSs93+swcy9mYXfC8N4wdTE5Unh1Qm
 WGQBllzlA59gxBJ2Dodys7J1YXCjpTrSda+IqW7mx5ly5OArfygbpnPm5fo8yjrQjt2V
 4FWWYlIQsh7i2b1b9Nm0lV5KJ3KfGRJgoK/LNkuqIMpxpQu2K/s14/q+EKcxH+lqZsuX
 cSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ysv1uk4fUAcPUnh8atox5ci4JG0ni1jWyD3+T3R5UZg=;
 b=M7FlVLAOpnXnmszXKXuhGalBYskzTpuixhTqz2sbjV/QuFrxYytKdrwyOa8M9xkLvW
 VCnpjo/W4or6r1z++oXrd2pMs0ov6G5A7KI6aSlH/Wt2WQqmZ/V8ndLsDnZq/1+W72xr
 sxopL88Pr+fXNSXppSEZg3WEAUKWiHNBi1A41c8ZwTNy3rNkJCFgJWOTP/Kbgg/1z1qK
 SIFuojsUFVRLv/fWVwM6bBkCdUbG3CsclYZOxxUOhjUkB2s+qAKqvd8jXHZbUDl7QVwU
 u9R6CMPOz7YyfD/4T62XkahUdkyX7elgnB7bmKtLPl4/Isu5m2f/bebJonldBdgodifN
 hOmw==
X-Gm-Message-State: AOAM532hfoaB5klVQzbQoQkC9NuhoRctSH9RapLh3DSoqMBuAX9y/Xqe
 JGiClYGyLeyAsRh6cZ5qaCYYbA==
X-Google-Smtp-Source: ABdhPJwHYlzv/I403bapWHIqi0YJuydD/qHlw1JACIfFNZsoGp+sWS95njksk8y7KSZW8Ewf550ZNw==
X-Received: by 2002:a1c:6788:: with SMTP id
 b130mr13030185wmc.100.1593354279271; 
 Sun, 28 Jun 2020 07:24:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h13sm5321555wml.42.2020.06.28.07.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 07:24:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/17] hw/misc/max111x: provide QOM properties for setting
 initial values
Date: Sun, 28 Jun 2020 15:24:18 +0100
Message-Id: <20200628142429.17111-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628142429.17111-1-peter.maydell@linaro.org>
References: <20200628142429.17111-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

Add some QOM properties to the max111x ADC device to allow the
initial values to be configured. Currently this is done by
board code calling max111x_set_input() after it creates the
device, which doesn't work on system reset.

This requires us to implement a reset method for this device,
so while we're doing that make sure we reset the other parts
of the device state.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/max111x.c | 57 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/hw/misc/max111x.c b/hw/misc/max111x.c
index 2b87bdee5b7..d0e5534e4f5 100644
--- a/hw/misc/max111x.c
+++ b/hw/misc/max111x.c
@@ -15,11 +15,15 @@
 #include "hw/ssi/ssi.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "hw/qdev-properties.h"
 
 typedef struct {
     SSISlave parent_obj;
 
     qemu_irq interrupt;
+    /* Values of inputs at system reset (settable by QOM property) */
+    uint8_t reset_input[8];
+
     uint8_t tb1, rb2, rb3;
     int cycle;
 
@@ -135,16 +139,6 @@ static int max111x_init(SSISlave *d, int inputs)
     qdev_init_gpio_out(dev, &s->interrupt, 1);
 
     s->inputs = inputs;
-    /* TODO: add a user interface for setting these */
-    s->input[0] = 0xf0;
-    s->input[1] = 0xe0;
-    s->input[2] = 0xd0;
-    s->input[3] = 0xc0;
-    s->input[4] = 0xb0;
-    s->input[5] = 0xa0;
-    s->input[6] = 0x90;
-    s->input[7] = 0x80;
-    s->com = 0;
 
     vmstate_register(VMSTATE_IF(dev), VMSTATE_INSTANCE_ID_ANY,
                      &vmstate_max111x, s);
@@ -168,11 +162,50 @@ void max111x_set_input(DeviceState *dev, int line, uint8_t value)
     s->input[line] = value;
 }
 
+static void max111x_reset(DeviceState *dev)
+{
+    MAX111xState *s = MAX_111X(dev);
+    int i;
+
+    for (i = 0; i < s->inputs; i++) {
+        s->input[i] = s->reset_input[i];
+    }
+    s->com = 0;
+    s->tb1 = 0;
+    s->rb2 = 0;
+    s->rb3 = 0;
+    s->cycle = 0;
+}
+
+static Property max1110_properties[] = {
+    /* Reset values for ADC inputs */
+    DEFINE_PROP_UINT8("input0", MAX111xState, reset_input[0], 0xf0),
+    DEFINE_PROP_UINT8("input1", MAX111xState, reset_input[1], 0xe0),
+    DEFINE_PROP_UINT8("input2", MAX111xState, reset_input[2], 0xd0),
+    DEFINE_PROP_UINT8("input3", MAX111xState, reset_input[3], 0xc0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static Property max1111_properties[] = {
+    /* Reset values for ADC inputs */
+    DEFINE_PROP_UINT8("input0", MAX111xState, reset_input[0], 0xf0),
+    DEFINE_PROP_UINT8("input1", MAX111xState, reset_input[1], 0xe0),
+    DEFINE_PROP_UINT8("input2", MAX111xState, reset_input[2], 0xd0),
+    DEFINE_PROP_UINT8("input3", MAX111xState, reset_input[3], 0xc0),
+    DEFINE_PROP_UINT8("input4", MAX111xState, reset_input[4], 0xb0),
+    DEFINE_PROP_UINT8("input5", MAX111xState, reset_input[5], 0xa0),
+    DEFINE_PROP_UINT8("input6", MAX111xState, reset_input[6], 0x90),
+    DEFINE_PROP_UINT8("input7", MAX111xState, reset_input[7], 0x80),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void max111x_class_init(ObjectClass *klass, void *data)
 {
     SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->transfer = max111x_transfer;
+    dc->reset = max111x_reset;
 }
 
 static const TypeInfo max111x_info = {
@@ -186,8 +219,10 @@ static const TypeInfo max111x_info = {
 static void max1110_class_init(ObjectClass *klass, void *data)
 {
     SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = max1110_realize;
+    device_class_set_props(dc, max1110_properties);
 }
 
 static const TypeInfo max1110_info = {
@@ -199,8 +234,10 @@ static const TypeInfo max1110_info = {
 static void max1111_class_init(ObjectClass *klass, void *data)
 {
     SSISlaveClass *k = SSI_SLAVE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
     k->realize = max1111_realize;
+    device_class_set_props(dc, max1111_properties);
 }
 
 static const TypeInfo max1111_info = {
-- 
2.20.1


