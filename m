Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00EAC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8882217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 02:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3X6V2wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8882217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu5uJ-0007C7-Co
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 21:38:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pg-000159-Ci
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu5pe-0001vy-Q8
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:28 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:35529)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu5pe-0001vY-KU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 21:33:26 -0500
Received: by mail-pl1-x632.google.com with SMTP id g6so2250743plt.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 18:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8oXffAFFos84hGLyMp+4FwyG83aEe0q98CSCZqlUHVE=;
 b=t3X6V2wckyvBumDIYVvT4erqIwy4Car3NYAr4cZqgTn/qbF4nUfOtFcc4ZFI5uxe3x
 4NmNis6kZnLdhUuRHMoak5vI9k9vc2w1TsJLXdZrl5HWcc4mn3Q7PIgvIHwqoxkgOQfe
 b5wbgPiX+GtE2M+/JLYDcRJoGLMYcWI2YNX1eDLuPeEsMOGKW3WgX53eJcNmi2oJtuG7
 2QX3FbHKzqRIzbUf2sDgxlGmhNseE9GG3OV2I1RohhJ9UxJpIN3A+LBzc4Q3jpjeMFqB
 c2Qa0wWgVKCxNglV5rPEnh/9sCqN9zkStKyDO6GPnnkO7vfL3Duc9v0RTJmTGvysNWqg
 4pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8oXffAFFos84hGLyMp+4FwyG83aEe0q98CSCZqlUHVE=;
 b=W8WsOQvKgM8k34aXideMzJ1ZEZKSuRvzbpd/Vy0Oi3J9vnmzKcqOhLVwUSOE1TiLf1
 GJmVc4jl/oEF7wfqRr6LxN7f7m2PXiCmFVFOeFEdiOg1zhNd4ByvxF2H+yN1zIwIMamt
 EIY3327qAgdYhWIjv7CUPtoRD8fpW4jsMZHW5tWBBEYctIT8ZxSNm/jKyZSdy4s9UwjJ
 vIgB4yG7YfhyFkb5lgtPOGE1gpIFs1LkSVsEYq8gG8VWheWiWizUV2eHIilWiK4CZbsA
 HeFm9io0YWmaOqus1VZFYzGdBWSAgxqsoBuFIr5MbnhukJRGIvVC8NAvCcazq0O0uRii
 RjLQ==
X-Gm-Message-State: APjAAAXfneKzzPew3Hxhgh6vinG7uS5/qb52ZHhSW830EVK1d3T71lQK
 YX1cZtQOTKw3vtoVXG7k0y7QDLinFxQ=
X-Google-Smtp-Source: APXvYqxSAbx45rmkv7h1p5PJ2Zr5RoorrzrN2u9O5kQ2xUnvuLif7Xra/yd37JelTfOHf68OwGgBHw==
X-Received: by 2002:a17:902:a40c:: with SMTP id
 p12mr8514814plq.292.1579660405277; 
 Tue, 21 Jan 2020 18:33:25 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id t1sm42935209pgq.23.2020.01.21.18.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 18:33:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/11] hw/hppa/machine: Correctly check the firmware is in PDC
 range
Date: Tue, 21 Jan 2020 16:32:53 -1000
Message-Id: <20200122023256.27556-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200122023256.27556-1-richard.henderson@linaro.org>
References: <20200122023256.27556-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::632
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
Cc: peter.maydell@linaro.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The firmware has to reside in the PDC range. If the Elf file
expects to load it below FIRMWARE_START, it is incorrect,
regardless the RAM size.

Acked-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200109000525.24744-2-f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a35527cfc7..e57530950a 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -171,7 +171,7 @@ static void machine_hppa_init(MachineState *machine)
     qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
                   "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
                   firmware_low, firmware_high, firmware_entry);
-    if (firmware_low < ram_size || firmware_high >= FIRMWARE_END) {
+    if (firmware_low < FIRMWARE_START || firmware_high >= FIRMWARE_END) {
         error_report("Firmware overlaps with memory or IO space");
         exit(1);
     }
-- 
2.20.1


