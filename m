Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851ACC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4681E207ED
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="viGyjhZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4681E207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfgdW-0000Dl-Iq
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 05:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfgcw-0008FX-Ft
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:21:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfgcv-0004ye-L4
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 05:21:02 -0400
Received: by mail-wm1-x341.google.com with SMTP id u26so11618546wmn.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cL+z9ENGszbmzKhGYjXFXL3yrpeAIly6RVP2vHyWxN8=;
 b=viGyjhZowV1NMeQn9LYe3deoTpqIo0cnGhhonSzF7hEMIHID/6kmHt+h+P5lIPI0k2
 Dcd0mxJXO554upWAdY3PVM22pUtdY2z15HvXsJaRWKcjRa+6HD3jCTfy2CZH/zKSc8Qo
 JcSyr1QE6ljq6MBIc/zRIR7ZTocoYE2EDywCUGsAxeCbO9kX5FA1LYEGxSnrZYfGNPso
 f2gWmX2WmJpnyVyMmjRVyFYirwhrs4kME5h042CT8XhO4kGJ9/SE2GvcKQ6QXxfczFWR
 ubQCArIzsO2xeu9XMNB+c3aAGqYZiX53Yixf3CDQLU/KgNbi5Wj4410Xb6o9NlCKJJhS
 l/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=cL+z9ENGszbmzKhGYjXFXL3yrpeAIly6RVP2vHyWxN8=;
 b=BUM/vSL5Vq7JyAYokBAbiuI0ELPpIC7M01NFvfrMdrhxZ10ynVt5xZN77QtBG8QQCf
 ur7+ZpJrPuq+cvshspz+NIsR3PrsyraVJ49ibvrck0UB9JTvZK29uSlTb6VDaJ0gLBHN
 sxAs/5axbMRdzqLX2G1Tr67fvQ7vhjQDivdMTc8LKDhd6A47uQOM4vueexvn5O/H+iBr
 nNWbgLjLMs7LFMjVx4R/xlKWHOH/TpAvBFTqfVbstkGTwDkuV/a1MZT3vPZAvfCP9Cuc
 KrLaqlddyhxDRs6Ec+TxRX0ZcTnbCMuyZYgKpxa81kEjv9eusbvLziGfLqIlfeWzI8/P
 ZGPg==
X-Gm-Message-State: AOAM5324zqjHSK16PzLMFSTagUj6Gj5kcq6C1SjNZB5onJ477OkwAyao
 J2pskLRZBPnrwcwUOhtYKstuX2Vk
X-Google-Smtp-Source: ABdhPJyEHFFrTE4zdB3f4Q1aUo1pZfehrJtxtOgggwy8UwXVu3L99QXAGYe7LFYKV3rix4IUMFXOtQ==
X-Received: by 2002:a1c:154:: with SMTP id 81mr13017516wmb.23.1591003259919;
 Mon, 01 Jun 2020 02:20:59 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id u13sm20129982wrp.53.2020.06.01.02.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 02:20:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas hardware
Date: Mon,  1 Jun 2020 11:20:57 +0200
Message-Id: <20200601092057.10555-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I don't have much clue about the Renesas hardware, but at least
I know now the source files a little bit, so I volunteer to pick
up patches and send pull-requests for them during my scarce
hobbyist time, until someone else with more knowledge steps up
to do this job instead.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0944d9c731..cbba3ac757 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -298,9 +298,7 @@ SH4 TCG CPUs
 M: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
 F: target/sh4/
-F: hw/sh4/
 F: disas/sh4.c
-F: include/hw/sh4/
 
 SPARC TCG CPUs
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
@@ -1238,6 +1236,18 @@ F: pc-bios/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 
+Renesas Hardware
+----------------
+SH4 Hardware
+M: Aurelien Jarno <aurelien@aurel32.net>
+M: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Odd Fixes
+F: hw/sh4/
+F: hw/char/sh_serial.c
+F: hw/intc/sh_intc.c
+F: hw/timer/sh_timer.c
+F: include/hw/sh4/
+
 SH4 Machines
 ------------
 R2D
@@ -1246,6 +1256,7 @@ S: Maintained
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
 F: hw/timer/sh_timer.c
+F: include/hw/sh4/sh_intc.h
 
 Shix
 M: Magnus Damm <magnus.damm@gmail.com>
-- 
2.21.3


