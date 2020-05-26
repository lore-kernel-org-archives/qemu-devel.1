Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AFBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE2D2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="viFYdDmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE2D2071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdTBp-00070Z-S3
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzc-0007DL-HW; Tue, 26 May 2020 02:23:16 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSzb-0002VR-Re; Tue, 26 May 2020 02:23:16 -0400
Received: by mail-wm1-x343.google.com with SMTP id l26so2014084wme.3;
 Mon, 25 May 2020 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xv8ZA3fcUN8kM/s02kASb+D+Ei0KDbMU50VMBXHzoSE=;
 b=viFYdDmZbCBLlLhjV4MJ2GuPWqOD6lmlmKFp6gfxbKIJIhnKjqy6XUmrCSig1iw2im
 ELFLij6uSv9htptmYvkp0f+GV3GVis+3DankPo/nnPnWG3A6+tGd1nNuvgZZduQ4rZcq
 FSkMPWZvqY1iyGueK1bWuVsrDffNKm3Y5B6kyUQ+IOoljEEgNZ/5yunOlFeHrR8AtOTg
 fSzVT7WydKNqTfoqtAJlGXSSKh2xAy8gc20HpWsvjUqEIVvlzMhvEC3+lqp82Jx1kfcu
 xo+i1AfSSnrb9HcDuuiNcjtSGlvPE2iadkdUEdo1YHBB2QoF0X0LyVJ3M/+N9YaOA1HW
 ugjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xv8ZA3fcUN8kM/s02kASb+D+Ei0KDbMU50VMBXHzoSE=;
 b=J41Dg+Q2yOki2aLVc2mBbl8t6P88SRDqVM6R8q9gB1yCVbtevn2KbWNe5h9ElJ8Ag2
 TXbPlGfgGdOk/bKqFlT9kjqB/iYRpAWeu5rUBjw0qH2YvkC+TVoqmCGdooGoHUAXOUxp
 EA88ENhKuNI/k22/tJlkECHiq+2y0mtoaVfujOlRMGik7+AOc+1uGSmu1prhgodDFsWq
 r6x7LplLUbD/svYrb4xzMCTVv5zN6EMiBN4hOk0l4iRNbchXHEbtoydpKftR7htcSZV5
 yZQsqE8RXV+wLCk1JZsVIQSwal9M8mrXkLpEoCBP+mXmovKwt3+ztwOgdAve8odk3c/e
 ItZw==
X-Gm-Message-State: AOAM530JAEPT3AOLyIwSeByBeX5yYUTi91qAIRL1D7LFIgVFiot6F07F
 6WU7XM3ybvDhqncidbasRp4=
X-Google-Smtp-Source: ABdhPJwbFmyPavCjCLdltZDvtds2og8+eMCyocTM472tAvKJRS3AS5iMOxFc09D6y7oOrluBMzIglg==
X-Received: by 2002:a1c:2644:: with SMTP id m65mr1832466wmm.178.1590474193955; 
 Mon, 25 May 2020 23:23:13 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a16sm5764745wrx.8.2020.05.25.23.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 23:23:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 13/14] hw/display/omap_dss: Replace fprintf() call by
 qemu_log_mask(LOG_UNIMP)
Date: Tue, 26 May 2020 08:22:51 +0200
Message-Id: <20200526062252.19852-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526062252.19852-1-f4bug@amsat.org>
References: <20200526062252.19852-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace fprintf() call by qemu_log_mask(LOG_UNIMP), which is
disabled by default. This avoid flooding the terminal when
fuzzing the device.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/display/omap_dss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/omap_dss.c b/hw/display/omap_dss.c
index 32dc0d6aa7..21fde58a26 100644
--- a/hw/display/omap_dss.c
+++ b/hw/display/omap_dss.c
@@ -619,7 +619,7 @@ static void omap_rfbi_transfer_start(struct omap_dss_s *s)
     if (s->rfbi.control & (1 << 1)) {				/* BYPASS */
         /* TODO: in non-Bypass mode we probably need to just assert the
          * DRQ and wait for DMA to write the pixels.  */
-        fprintf(stderr, "%s: Bypass mode unimplemented\n", __func__);
+        qemu_log_mask(LOG_UNIMP, "%s: Bypass mode unimplemented\n", __func__);
         return;
     }
 
-- 
2.21.3


