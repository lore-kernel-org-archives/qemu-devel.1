Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102FDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:37:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B2D20738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQCXc2li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B2D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRKC-0001od-2I
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHB-0005Jz-3N; Mon, 22 Jun 2020 14:34:37 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRH9-00080v-Kt; Mon, 22 Jun 2020 14:34:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id a6so576225wmm.0;
 Mon, 22 Jun 2020 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZQhKNZfSYqShQVnzUnYQe3jjUWQ7noSiOCxZDTyth74=;
 b=dQCXc2liZ7oP7mnVWleNs7GYO2WLl8IEwhMUkKgppRtOoRJbqsIWRHDmDpmV7ifeq/
 9UKWIF/RlspqO8rc79gaC++y3MU6PHQ4Nj4wt4mOQ9iqT51ST/S7R2RhV8+Lh7o5geVP
 7Z75SxLGCYzy6XKsFoKyudpV7mA0Hf361PS6vVOcNNC3PXYKbDhiCMVNf949KsQMGzIw
 VgXXYPlB5apW7sTltUfUHyRGMXu5N77fENymce+5bLyZszJKOrP+bHCAPlF7hRaL1g5N
 bn7Oa3UvWJEqhvceFyvKS7eGIa/AdcCvumC/m5vbRjfH46rq72jE6K7y3WTwZHplevG2
 3lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZQhKNZfSYqShQVnzUnYQe3jjUWQ7noSiOCxZDTyth74=;
 b=grnhVnUF21tsB3lZF/1Q5fa7G5WKmxTtYrhBJNYdkcQiwA/HZ+BK0HTC0DEvoc6exf
 ZgQ26omrBYEqXIBO/zZ0HxS43TfxETGObMDxHy/+zbl8NHf8tpgOzHM0hHIxQfwf2N8l
 3Pam14WHepVJuvSnxTs0rP540LJgP1ZkCSvAQHyr4kYxIkB0xs9Z0wi2rogCrWp7lr+6
 6P4xxahYEMnko6A6PD6dZsY0pSDu4qbEamIUHqrmUbhhWiX6o6I2J5n5VXPW73tNmRXw
 nNDQcXdDmupILQm7Q0IMmg83F7xzy5GfSsb2RgAQW60o0tVG3T0bRVgqllxBRRfdZ9pG
 nr8g==
X-Gm-Message-State: AOAM531fYRcsmp2je/qoOafwwAgoHAXj/7j8gEaTlExOUX1Rho8Znq0m
 7NgzJzoES1kUQJcAf9OT+lv8GHaY
X-Google-Smtp-Source: ABdhPJxMgkmlZPO3km+si1eTO/WiqT08RqId8x7hr6KMNM2z5TAzEVa+C2Ua3I4kn7EEWAUxYcofMQ==
X-Received: by 2002:a1c:9c49:: with SMTP id f70mr19311888wme.74.1592850873473; 
 Mon, 22 Jun 2020 11:34:33 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h29sm20286161wrc.78.2020.06.22.11.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 11:34:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/9] hw/misc/pca9552: Rename 'nr_leds' as 'pin_count'
Date: Mon, 22 Jun 2020 20:34:21 +0200
Message-Id: <20200622183428.12255-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200622183428.12255-1-f4bug@amsat.org>
References: <20200622183428.12255-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PCA9552 device does not expose LEDs, but simple pins
to connnect LEDs to. To be clearer with the device model,
rename 'nr_leds' as 'pin_count'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h |  2 +-
 hw/misc/pca9552.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index ebb43c63fe..bc5ed31087 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -26,7 +26,7 @@ typedef struct PCA9552State {
 
     uint8_t regs[PCA9552_NR_REGS];
     uint8_t max_reg;
-    uint8_t nr_leds;
+    uint8_t pin_count;
 } PCA9552State;
 
 #endif
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index cac729e35a..81da757a7e 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -37,7 +37,7 @@ static void pca9552_update_pin_input(PCA9552State *s)
 {
     int i;
 
-    for (i = 0; i < s->nr_leds; i++) {
+    for (i = 0; i < s->pin_count; i++) {
         uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
         uint8_t input_shift = (i % 8);
         uint8_t config = pca9552_pin_get_config(s, i);
@@ -185,7 +185,7 @@ static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (led < 0 || led > s->nr_leds) {
+    if (led < 0 || led > s->pin_count) {
         error_setg(errp, "%s invalid led %s", __func__, name);
         return;
     }
@@ -228,7 +228,7 @@ static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (led < 0 || led > s->nr_leds) {
+    if (led < 0 || led > s->pin_count) {
         error_setg(errp, "%s invalid led %s", __func__, name);
         return;
     }
@@ -291,9 +291,9 @@ static void pca9552_initfn(Object *obj)
      * PCA955X device
      */
     s->max_reg = PCA9552_LS3;
-    s->nr_leds = 16;
+    s->pin_count = 16;
 
-    for (led = 0; led < s->nr_leds; led++) {
+    for (led = 0; led < s->pin_count; led++) {
         char *name;
 
         name = g_strdup_printf("led%d", led);
-- 
2.21.3


