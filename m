Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D4CC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4971120797
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTVDKShe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4971120797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0PN-00068u-81
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztp-0003m1-HQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55883)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztg-0007mx-R0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:08 -0400
Received: by mail-wm1-x344.google.com with SMTP id a72so6930180wme.5
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WZSOSfAAlnoDbupRBScNRlOixSkOtWYILH234kBr4wY=;
 b=LTVDKSheZqGSBnYO/3aVAQJtAjLvOvPwCjYLbRXpGUgdT2LDnKyFfwSnI1DQgVUiPA
 N5oih9/7ubWXYF+xMAdLdz2euJEvlcQQcUA8nWKVUwSV+siO7McijqUGe7sdMzEq0TMU
 kGnkPSKBUfpaOHApnk1e5qe8piWYHshpS7SqSShiXPp+pIXda7cJU84f1E9BCuY4ig/J
 Lu4YZ1Du1zU5B9YSsv9CuVcwyevw9QFRtTA4ZFjjzhrqvAgNeOG5CjPJRtVpA1RXNeFE
 J3BB7IXxFYOFfttA1pBTIJFPTd/zK/ZNjPqOPLsDAQJEwJwOG3FbIQjLtQhD7kLO9Ejo
 UUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WZSOSfAAlnoDbupRBScNRlOixSkOtWYILH234kBr4wY=;
 b=LqhRwwC/McW3Ew8L5Zma46mGnTLQpG07LhM9OT+qPht5mrIC4eeEZqYrB1Upq9Rme4
 aYP6pWexW3g6oYGkgOFHpOYLICSGHTd5hH75SSzvnZBUXQ99NqJCw2Ycdce7RnjsH9/4
 9OzEWO9njdmaDa0+0oP09CanBFNSPJ/9JRP33bCPfqeHjTLqvfb/tlCQFJMokSJ7JDAB
 P6L4Mi8meK363c4uxpgCuNg/QCoPoRhaPs1UZs2ZwbwyO0onwzFPh/fZxD7WVIceF0Hi
 vfLv16hoIo0VvuSxydOftxlBmQvQzvQuhXeluihOzoLDxHQlPaX2SXchAJic23x6X20X
 e6Mw==
X-Gm-Message-State: AOAM531KbWvVEujnmQBqRm+cIE5cNWTOYVFJK501YPWw8M5mgNW7CoU0
 jtwQkU/AuJkvwTsBNDrpZLMCsQ==
X-Google-Smtp-Source: ABdhPJwjmtvEj5tvqQrBSHf7395TBIyaY7nOgQ6R3AagEoNgZzIOgIwRs6jxlX5PS8FNW5UwoZJv6g==
X-Received: by 2002:a7b:cb44:: with SMTP id v4mr11253890wmj.101.1602517079205; 
 Mon, 12 Oct 2020 08:37:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/10] target/arm: Fix writing to FPSCR.FZ16 on M-profile
Date: Mon, 12 Oct 2020 16:37:46 +0100
Message-Id: <20201012153746.9996-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153746.9996-1-peter.maydell@linaro.org>
References: <20201012153746.9996-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The M-profile specific part of the sanitizing of the value to
be written to the FPSCR used a mask which always zeroed bit 19,
which is FZ16. This is incorrect when the CPU supports 16-bit
floating point arithmetic, because the bit should be writeable.

Code earlier in the function already handles making this bit be RES0
if the CPU doesn't implement the FP16 feature, so we can simply stop
masking it out for M-profile.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 350150adbf1..4b0bb2bacfb 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -198,13 +198,14 @@ void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         /*
-         * M profile FPSCR is RES0 for the QC, STRIDE, FZ16, LEN bits
+         * M profile FPSCR is RES0 for the QC, STRIDE, LEN bits
          * and also for the trapped-exception-handling bits IxE.
          * From v8.1M with the low-overhead-loop extension bits
          * [18:16] are used for LTPSIZE and (since we don't implement
          * MVE) always read as 4 and ignore writes.
+         * FZ16 has already been handled as RES0 above if needed.
          */
-        val &= 0xf7c0009f;
+        val &= 0xf7c8009f;
         if (cpu_isar_feature(aa32_lob, cpu)) {
             val |= 4 << 16;
         }
-- 
2.20.1


