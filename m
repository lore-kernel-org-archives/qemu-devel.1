Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77B3C4742C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B2D2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="svWAz9bW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B2D2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdX5-0008QI-C2
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLv-00012q-Vh
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:44 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLt-0006c9-GK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:43 -0500
Received: by mail-wm1-x342.google.com with SMTP id c16so10222648wmd.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PHlIRH7863n7trY1b/lRLkeSRiEQjbh9eyt3Xp710GY=;
 b=svWAz9bWchfwgECY344PtiYeWsCE/Hm77JXZ1Rc3jOwwqcnLTVJ8WYU8Hn5PqDcZJN
 X3KGf+/U9dy1++42xBMZ+Sf7K4exyyBLgMA4XtHkncH+i8hkPWDclLOFT2ynv7sVc892
 Z27lpyQcenwAMkhpLIL51A3w4vUG5rlh/SjJkO6HgTZtha6TmLUyFZ8lJCJPxlgTZD4W
 gZm/msABK5JeHZhotAunFnHCCdDBHSGN9K7oGxkY8klBzaueGEI6oEUUjRouqx9HRfai
 JSih+eyBeEqe9KTOZ+jZQBIIotmvJU0IlhyjnpPezXOhmKclbYWIj9k8IBk2TgnRXIhL
 QRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PHlIRH7863n7trY1b/lRLkeSRiEQjbh9eyt3Xp710GY=;
 b=YYLNE3a2diEiAKU6+z+8EbOAQem5Sfjbe0wJG1CieCn96/LslESaMoxUrhSinFKdnQ
 gkuTnJyd4FGK9TRVgwJ4iUu0Kq2wzvYb0Y4ESNwvIJINzfB4Bu/nfdR+K9utgya7DKrF
 cj3exqPpmScNA3fv/KKjA/cNKetwy7AvHz+QTfWd2+ZyBsW7AUW4CphGXXg13iHvjjsB
 qSK1KLAoBxXFYeV8s/ab0mUf1gEUNWkv6S6js9IehdtuqkRHJIukzoXcbNpXoXAByBeN
 ZDKodFuWuHzsOsbLUeRmsfizMBHGDMKzyCaChtgqLVyH8hn0emskP0k6ECRIPVnEbenZ
 kwRA==
X-Gm-Message-State: AOAM530n+H9GFmgf03PgvlK4YghmLT8Lmx/7pmtCxtSwIcT280bVPz5j
 HR+nrHBUb6jzm+cjZ2HVH0UEBahrQH7aFQ==
X-Google-Smtp-Source: ABdhPJyfaNC8iq2bC+Fzv/VeJDQNtGjqsh6Gjps53kazktb8pMB0nyjUXaBx0E+0735k9qG+w5ymvw==
X-Received: by 2002:a1c:ac87:: with SMTP id
 v129mr18630069wme.119.1604337039975; 
 Mon, 02 Nov 2020 09:10:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:39 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/26] hw/display/omap_lcdc: Fix potential NULL pointer
 dereference
Date: Mon,  2 Nov 2020 17:09:58 +0000
Message-Id: <20201102171005.30690-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

From: AlexChen <alex.chen@huawei.com>

In omap_lcd_interrupts(), the pointer omap_lcd is dereferinced before
being check if it is valid, which may lead to NULL pointer dereference.
So move the assignment to surface after checking that the omap_lcd is valid
and move surface_bits_per_pixel(surface) to after the surface assignment.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: AlexChen <alex.chen@huawei.com>
Message-id: 5F9CDB8A.9000001@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/display/omap_lcdc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index fa4a381db64..58e659c94ff 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -78,14 +78,18 @@ static void omap_lcd_interrupts(struct omap_lcd_panel_s *s)
 static void omap_update_display(void *opaque)
 {
     struct omap_lcd_panel_s *omap_lcd = (struct omap_lcd_panel_s *) opaque;
-    DisplaySurface *surface = qemu_console_surface(omap_lcd->con);
+    DisplaySurface *surface;
     draw_line_func draw_line;
     int size, height, first, last;
     int width, linesize, step, bpp, frame_offset;
     hwaddr frame_base;
 
-    if (!omap_lcd || omap_lcd->plm == 1 || !omap_lcd->enable ||
-        !surface_bits_per_pixel(surface)) {
+    if (!omap_lcd || omap_lcd->plm == 1 || !omap_lcd->enable) {
+        return;
+    }
+
+    surface = qemu_console_surface(omap_lcd->con);
+    if (!surface_bits_per_pixel(surface)) {
         return;
     }
 
-- 
2.20.1


