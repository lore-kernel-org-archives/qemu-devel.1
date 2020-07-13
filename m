Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A583C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A43205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IE5PYKuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A43205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzOI-0005Ez-Qo
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB8-0005go-B7
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:35 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:45350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzB6-0006fz-0A
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id s10so16679988wrw.12
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3Fd2xhMAOfXLvcg5k7HCDapd9E8X8sbTyGKS6vLv9Bw=;
 b=IE5PYKuXZOr1R7s+7rSyLBd2P3VAMa9o5baN+6im0XleVU7i3ubuXi5hg6qEbeWPdq
 i7sLv4G6A+0n6jbLclS5/CmqQKoPmk+S83qgpEptxPyDzhsbNS7/klg2qA6WPQn445EV
 cwyyj0tZDpj/QgMbcJByvlng4yhKxCIeG44v/Z/OMTKru2mXHrJrpeq8eQnY5dh4w1qH
 LdWWx2SW9z6bLbYz3BNXhpwV2itOX/YNZ6zJTrOwW4T0NpeS1w3LGbtCWTjVdFXfWmXx
 PCb27GGLbQLYSPabfdjSk3YLCB+JSkdxURo8BrVQXqaNIbGfJlwquGIMqZeBfLlcN87F
 Tpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3Fd2xhMAOfXLvcg5k7HCDapd9E8X8sbTyGKS6vLv9Bw=;
 b=HKXzmrbpkdSPlNNLJbcBlDJzllGq4E3spG9sKphFq78RMakWL32c3Ts6cWWhWdxRkR
 qgiVZxzTit4Ga2m8gYUpgmf8tIOXP/TrE+hTEN522ohi/hwupgMRAIijwPNGfNG4vBE8
 lMRj15UZf7/NGI2TX7P/GdzYsRm3lV34Xz6Vdl/Rh3peIthYn6PSQD3KwYo9lwXvtP8p
 iGqDhvaHxjTvroQH05JJJNotfzi1lJQB+bQ5HOEEUtt5LGM3T34eZgkBz9o3E/bmwPce
 vJdfhvcHmqCVVzW50AyKoP2JQVCJgGAs1ZQN1ERzB/L2HGL4t3dmJpBEGqQb/QfkAH//
 NPQQ==
X-Gm-Message-State: AOAM530iO07RJM2XnZog6SSut60PvTTYSX0a4mck9g1wi46PABrduTPg
 4R+pgR/RgOocZo9nFd1W7TU+NaM/JN6ggw==
X-Google-Smtp-Source: ABdhPJylRo4GebJvIMwg3sffElYd7kgYtO41dHF2aZsknSHT/5VAGbAXQ2s/66gCitFoCXCIlXfBuA==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr78059848wrw.123.1594649489801; 
 Mon, 13 Jul 2020 07:11:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/25] hw/arm/tosa.c: Detabify
Date: Mon, 13 Jul 2020 15:11:00 +0100
Message-Id: <20200713141104.5139-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Remove the hardcoded tabs from hw/arm/tosa.c. There aren't
many, but since they're all in constant #defines they're not
going to go away with our usual "only when we touch a function"
policy on reformatting.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200628203748.14250-2-peter.maydell@linaro.org
---
 hw/arm/tosa.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index 5dee2d76c61..06ecf1e7824 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -26,32 +26,32 @@
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
 
-#define TOSA_RAM    0x04000000
-#define TOSA_ROM	0x00800000
+#define TOSA_RAM 0x04000000
+#define TOSA_ROM 0x00800000
 
-#define TOSA_GPIO_USB_IN		(5)
-#define TOSA_GPIO_nSD_DETECT	(9)
-#define TOSA_GPIO_ON_RESET		(19)
-#define TOSA_GPIO_CF_IRQ		(21)	/* CF slot0 Ready */
-#define TOSA_GPIO_CF_CD			(13)
-#define TOSA_GPIO_TC6393XB_INT  (15)
-#define TOSA_GPIO_JC_CF_IRQ		(36)	/* CF slot1 Ready */
+#define TOSA_GPIO_USB_IN                (5)
+#define TOSA_GPIO_nSD_DETECT            (9)
+#define TOSA_GPIO_ON_RESET              (19)
+#define TOSA_GPIO_CF_IRQ                (21)    /* CF slot0 Ready */
+#define TOSA_GPIO_CF_CD                 (13)
+#define TOSA_GPIO_TC6393XB_INT          (15)
+#define TOSA_GPIO_JC_CF_IRQ             (36)    /* CF slot1 Ready */
 
-#define TOSA_SCOOP_GPIO_BASE	1
-#define TOSA_GPIO_IR_POWERDWN	(TOSA_SCOOP_GPIO_BASE + 2)
-#define TOSA_GPIO_SD_WP			(TOSA_SCOOP_GPIO_BASE + 3)
-#define TOSA_GPIO_PWR_ON		(TOSA_SCOOP_GPIO_BASE + 4)
+#define TOSA_SCOOP_GPIO_BASE            1
+#define TOSA_GPIO_IR_POWERDWN           (TOSA_SCOOP_GPIO_BASE + 2)
+#define TOSA_GPIO_SD_WP                 (TOSA_SCOOP_GPIO_BASE + 3)
+#define TOSA_GPIO_PWR_ON                (TOSA_SCOOP_GPIO_BASE + 4)
 
-#define TOSA_SCOOP_JC_GPIO_BASE		1
-#define TOSA_GPIO_BT_LED		(TOSA_SCOOP_JC_GPIO_BASE + 0)
-#define TOSA_GPIO_NOTE_LED		(TOSA_SCOOP_JC_GPIO_BASE + 1)
-#define TOSA_GPIO_CHRG_ERR_LED		(TOSA_SCOOP_JC_GPIO_BASE + 2)
-#define TOSA_GPIO_TC6393XB_L3V_ON	(TOSA_SCOOP_JC_GPIO_BASE + 5)
-#define TOSA_GPIO_WLAN_LED		(TOSA_SCOOP_JC_GPIO_BASE + 7)
+#define TOSA_SCOOP_JC_GPIO_BASE         1
+#define TOSA_GPIO_BT_LED                (TOSA_SCOOP_JC_GPIO_BASE + 0)
+#define TOSA_GPIO_NOTE_LED              (TOSA_SCOOP_JC_GPIO_BASE + 1)
+#define TOSA_GPIO_CHRG_ERR_LED          (TOSA_SCOOP_JC_GPIO_BASE + 2)
+#define TOSA_GPIO_TC6393XB_L3V_ON       (TOSA_SCOOP_JC_GPIO_BASE + 5)
+#define TOSA_GPIO_WLAN_LED              (TOSA_SCOOP_JC_GPIO_BASE + 7)
 
-#define	DAC_BASE	0x4e
-#define DAC_CH1		0
-#define DAC_CH2		1
+#define DAC_BASE 0x4e
+#define DAC_CH1 0
+#define DAC_CH2 1
 
 static void tosa_microdrive_attach(PXA2xxState *cpu)
 {
-- 
2.20.1


