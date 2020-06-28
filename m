Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59BFC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 21:45:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89E620720
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 21:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUbyaE+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89E620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpf7B-0002HJ-Vf
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 17:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpf4P-0008Dt-Vb
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 17:42:37 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpf4N-00072N-5S
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 17:42:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id q5so14645662wru.6
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZROhVR26UPnFTLpmqo4CvX6OnKKdzzJIIB4TAfobIgs=;
 b=OUbyaE+sOsJVjprwRa1S+qohK+L+6aFTScTiGv3MTn7vj2VJDgSuxCCk/8ExOhntxt
 N4ssIx7A3K43a9o8MR06M2E0086gYovNrFpjCayuug6U6B9Dsa21vqRfUCjRBtMEborz
 KU/JAsiriWz4y21r0MBRO7s6sKLCWurBRqCdgmJNgaHZl+ev/Mw5YBJb7KMPcIj2jFPU
 PUM0NzJ3MEKiNY0cB9y6+qzlzmox74uDu2x/vZPJhaIYm4oZ+axsAX1rhNxNku02dnVL
 uWAPIju+5NbbaElZl1UkxZw577pza1txEBZ10gn/8/2ts3+M1pzEtPn5nu25JOdLlRQw
 XKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZROhVR26UPnFTLpmqo4CvX6OnKKdzzJIIB4TAfobIgs=;
 b=DDM2U/iaKL/5umbbeL8IN58xADjQnIaR4utaNSX3/uJeQQhJibzUB3Z5+hVc4i1aMr
 VC6jL/vW5e4O9NKrFYs46nQ+Xz95JgtHubMItlCYGNFM59eGlivLT8uto07bGS3a795O
 ++eeVLtrpZNN75ckQ0E4wtN83KQQtfzhdibyQNtuHGjZU0hpVsCxo3Vrqw4p74simk+t
 ODCYh7emqEvLhaLqhIIlTamY/ug2/Oha+cnGRUuctTVGMFRNVnWvNIXkeZp+VoayII7f
 uY7ZSOvL9roCK2s5vWJZsbHDnRj0Khyp64fLLG9FiwK75qcr0Cur0yic15wx9+tOjNgv
 m4oA==
X-Gm-Message-State: AOAM530s4c44Ee1QBvA0rrdDAx6N8KlzYnQP0LrxCKu3dnVCbbwTmJyb
 JN7Zg80VYT/kBDsWX1feodAhUg==
X-Google-Smtp-Source: ABdhPJx1ffhRmNmjbffKiwfCJboqcB/NY3S2IjoarIZv0H8XLtLY6/cvArLCULNNnzk7E1kN5+ZGrg==
X-Received: by 2002:adf:f4c1:: with SMTP id h1mr13616969wrp.328.1593380553473; 
 Sun, 28 Jun 2020 14:42:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t16sm26300948wru.9.2020.06.28.14.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 14:42:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/arm/palm.c: Detabify
Date: Sun, 28 Jun 2020 22:42:29 +0100
Message-Id: <20200628214230.2592-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628214230.2592-1-peter.maydell@linaro.org>
References: <20200628214230.2592-1-peter.maydell@linaro.org>
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

Remove hard-tabs from palm.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


