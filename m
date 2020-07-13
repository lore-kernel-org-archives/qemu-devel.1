Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFA3C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56997205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4UHpJQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56997205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzRs-0002Dx-KJ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzBA-0005iI-7V
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:39747)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB7-0006gV-LF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id w3so13308857wmi.4
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZsABSf3zCCbs9HoGH03ylmhl0Zn1zbJ1jZgoRtVVq6c=;
 b=A4UHpJQWJpSb5nQvr/LHvEXmi4Zh161aeV+Q0xS4n+PEHCJIiJOZQRVTQEHRcM6ZoH
 PsdZG2TKZNEokz1+spTggjRRAbSx0RTqQfPFSpwvnEeRpSwHqWbTkhxwMQhKbX0LW2dl
 TkvQNxJEMTqEFIJc19HHRi8FCFayLEQIg/Fl9EfIMyvKJiIN4cMHdOXviv3mtiveuSwC
 4ODkm0LKtOBhqZS07hVqGRWUL+1yCn2FFfSbMpX1bjS+Nz70rbVzEDXpX5kDDDtd6t74
 WP1hh1/IaIuzaBLKleOKTt0/FAKLWcxTv1exXt+S4LIMs10ZZ3kK3syjsZJALwX+OkxN
 TI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZsABSf3zCCbs9HoGH03ylmhl0Zn1zbJ1jZgoRtVVq6c=;
 b=nURyN7zXd8yD0ZFy9KHQdbH8kwGq/tQrFZ6dMd4WzghpXHFC4pTNYCMWiDWsYJC71V
 geQgV3gtOLIGhM59RYCHkLWMQ7FKZLfc3in87+6Db6bMVgZo6LjnebdO8N1KMelgUuP7
 Iod8+hu2wMhb2hQBcKstj33LGrUC4ZbbeHdQvj435IcHsFLbw0R6770xD1rziKqWOmR8
 IShq/vJDHTvSWZV7Lvhbv1mZTf7VcS8Y7XbyuAk3qTQfF09i7JxTkcQ1KT5eoS209rVR
 GjPkhMzYID/j9yEJXplNfHm6m120TO15sCoFQIiHOjMtCFzmZvH44+jdtad9bhL+b3py
 +EwA==
X-Gm-Message-State: AOAM532MegM+AWquw5HujdhYGrJlln98R2M67qeoIpj0rSxCiq2x16jp
 jHg6+ZZyGQ6M0DltiUVFrvj2D6AnnKDcpg==
X-Google-Smtp-Source: ABdhPJzsWfvRqjbB8X1IAiDuY+ZrUy8qB8k4QQkA9nsnjweohlnzsBg0+NrUFf+s/bS2hKCp7MyZgg==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr155599wmh.176.1594649491952; 
 Mon, 13 Jul 2020 07:11:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/25] hw/arm/palm.c: Detabify
Date: Mon, 13 Jul 2020 15:11:02 +0100
Message-Id: <20200713141104.5139-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove hard-tabs from palm.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200628214230.2592-2-peter.maydell@linaro.org
---
 hw/arm/palm.c | 64 +++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 97ca105d297..569836178f6 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -61,21 +61,21 @@ static const MemoryRegionOps static_ops = {
 /* Palm Tunsgten|E support */
 
 /* Shared GPIOs */
-#define PALMTE_USBDETECT_GPIO	0
-#define PALMTE_USB_OR_DC_GPIO	1
-#define PALMTE_TSC_GPIO		4
-#define PALMTE_PINTDAV_GPIO	6
-#define PALMTE_MMC_WP_GPIO	8
-#define PALMTE_MMC_POWER_GPIO	9
-#define PALMTE_HDQ_GPIO		11
-#define PALMTE_HEADPHONES_GPIO	14
-#define PALMTE_SPEAKER_GPIO	15
+#define PALMTE_USBDETECT_GPIO   0
+#define PALMTE_USB_OR_DC_GPIO   1
+#define PALMTE_TSC_GPIO                 4
+#define PALMTE_PINTDAV_GPIO     6
+#define PALMTE_MMC_WP_GPIO      8
+#define PALMTE_MMC_POWER_GPIO   9
+#define PALMTE_HDQ_GPIO                 11
+#define PALMTE_HEADPHONES_GPIO  14
+#define PALMTE_SPEAKER_GPIO     15
 /* MPU private GPIOs */
-#define PALMTE_DC_GPIO		2
-#define PALMTE_MMC_SWITCH_GPIO	4
-#define PALMTE_MMC1_GPIO	6
-#define PALMTE_MMC2_GPIO	7
-#define PALMTE_MMC3_GPIO	11
+#define PALMTE_DC_GPIO          2
+#define PALMTE_MMC_SWITCH_GPIO  4
+#define PALMTE_MMC1_GPIO        6
+#define PALMTE_MMC2_GPIO        7
+#define PALMTE_MMC3_GPIO        11
 
 static MouseTransformInfo palmte_pointercal = {
     .x = 320,
@@ -100,17 +100,17 @@ static struct {
     int column;
 } palmte_keymap[0x80] = {
     [0 ... 0x7f] = { -1, -1 },
-    [0x3b] = { 0, 0 },	/* F1	-> Calendar */
-    [0x3c] = { 1, 0 },	/* F2	-> Contacts */
-    [0x3d] = { 2, 0 },	/* F3	-> Tasks List */
-    [0x3e] = { 3, 0 },	/* F4	-> Note Pad */
-    [0x01] = { 4, 0 },	/* Esc	-> Power */
-    [0x4b] = { 0, 1 },	/* 	   Left */
-    [0x50] = { 1, 1 },	/* 	   Down */
-    [0x48] = { 2, 1 },	/*	   Up */
-    [0x4d] = { 3, 1 },	/*	   Right */
-    [0x4c] = { 4, 1 },	/* 	   Centre */
-    [0x39] = { 4, 1 },	/* Spc	-> Centre */
+    [0x3b] = { 0, 0 },  /* F1   -> Calendar */
+    [0x3c] = { 1, 0 },  /* F2   -> Contacts */
+    [0x3d] = { 2, 0 },  /* F3   -> Tasks List */
+    [0x3e] = { 3, 0 },  /* F4   -> Note Pad */
+    [0x01] = { 4, 0 },  /* Esc  -> Power */
+    [0x4b] = { 0, 1 },  /*         Left */
+    [0x50] = { 1, 1 },  /*         Down */
+    [0x48] = { 2, 1 },  /*         Up */
+    [0x4d] = { 3, 1 },  /*         Right */
+    [0x4c] = { 4, 1 },  /*         Centre */
+    [0x39] = { 4, 1 },  /* Spc  -> Centre */
 };
 
 static void palmte_button_event(void *opaque, int keycode)
@@ -161,13 +161,13 @@ static void palmte_gpio_setup(struct omap_mpu_state_s *cpu)
                             [PALMTE_MMC_SWITCH_GPIO]));
 
     misc_gpio = qemu_allocate_irqs(palmte_onoff_gpios, cpu, 7);
-    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,	misc_gpio[0]);
-    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,	misc_gpio[1]);
-    qdev_connect_gpio_out(cpu->gpio, 11,			misc_gpio[2]);
-    qdev_connect_gpio_out(cpu->gpio, 12,			misc_gpio[3]);
-    qdev_connect_gpio_out(cpu->gpio, 13,			misc_gpio[4]);
-    omap_mpuio_out_set(cpu->mpuio, 1,				misc_gpio[5]);
-    omap_mpuio_out_set(cpu->mpuio, 3,				misc_gpio[6]);
+    qdev_connect_gpio_out(cpu->gpio, PALMTE_MMC_POWER_GPIO,     misc_gpio[0]);
+    qdev_connect_gpio_out(cpu->gpio, PALMTE_SPEAKER_GPIO,       misc_gpio[1]);
+    qdev_connect_gpio_out(cpu->gpio, 11,                        misc_gpio[2]);
+    qdev_connect_gpio_out(cpu->gpio, 12,                        misc_gpio[3]);
+    qdev_connect_gpio_out(cpu->gpio, 13,                        misc_gpio[4]);
+    omap_mpuio_out_set(cpu->mpuio, 1,                           misc_gpio[5]);
+    omap_mpuio_out_set(cpu->mpuio, 3,                           misc_gpio[6]);
 
     /* Reset some inputs to initial state.  */
     qemu_irq_lower(qdev_get_gpio_in(cpu->gpio, PALMTE_USBDETECT_GPIO));
-- 
2.20.1


