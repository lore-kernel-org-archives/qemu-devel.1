Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7407C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8DB206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxjWsug9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8DB206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfQG-0003fv-P4
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfMq-00083o-Hb
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:47:33 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:46821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfMp-0005zW-HB
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:47:32 -0400
Received: by mail-pg1-x52e.google.com with SMTP id p21so1386122pgm.13
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KgLFINBGEx2VLJ3Ma6VyMCd7VNjG3xrKYeKQiYwUVWY=;
 b=YxjWsug9donkIqf6gR6bbyFweBlsgZAoObZ/oxq2s9S4acMulNJ0R1VZyCpM84Y7Ak
 OQXMX/G/EbR1NHvreh8iH+7QmEfp/FSqC0+HDQuoyPypQmg4CeMPYQPEErY0PMvNHkXp
 zxP9/7eCg5wSIKHw1prHMnRQiQpODHzYd8mW7BIqUQ7l27vzSPUCTYOFOD6nTqF5TxL6
 iQ1LlGAb3wEhW6nqFToWESLsP3hjB0UwRWTjdF8TkpfESCPHX1lk+upsee84usJgeMRJ
 jR7YFcZrow8A8TiiEhncxjcww05DO2efYBb/2+2oAWBhSvMu77RlgofSiG7/cn533WGf
 N0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KgLFINBGEx2VLJ3Ma6VyMCd7VNjG3xrKYeKQiYwUVWY=;
 b=GQdu3VFLr92+ZNGNzAx52tqrrIEqellZIziBByZRiSgBu1tjVfgLpoVteeYm+XHCcf
 VLxJQo/ARVT5RNvEc0lTTibhJaFKUP1Sbeu4sYd6hy2+tTW8lYdSQyrLlRwG1OYLp6Ta
 7A257lX0DPD8HjanQSLkpcKBd9yd7LR493bBQRSdHePyBWWvGPDZjUWXtwcggz4JxhrQ
 QA4RSG6aEMVmR44Q12WdUsqc1sCRXXQO5TJUKHd7y/ARcP/WolzXsbOY9AAAWp2x+CKa
 DoVLb57gDznMqiLTOiXkJCafAqy6CIsdamE4EBOR57pp1MMkYwlg7iOK/CNY9AGLn8qQ
 6Sdw==
X-Gm-Message-State: AOAM531tV9FXajhbLEAV53Daf5rfKqcR6OUl6RR08wpna9P9Fzyfl5cw
 CH0IAGk6R9MjrNtU1t7wlABi+BsOrt8=
X-Google-Smtp-Source: ABdhPJxwXnJ3uE0iM0axvWXnDZVSrX/DbRErXkkU8G5FTkUWR1DlegWEIK571cUdwsE10a6uQH4eTw==
X-Received: by 2002:aa7:9f5a:: with SMTP id h26mr5236902pfr.281.1589568449160; 
 Fri, 15 May 2020 11:47:29 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u73sm2743630pfc.0.2020.05.15.11.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 11:47:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] softfloat: fix floatx80 pseudo-denormal round to integer
Date: Fri, 15 May 2020 11:47:22 -0700
Message-Id: <20200515184722.31182-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515184722.31182-1-richard.henderson@linaro.org>
References: <20200515184722.31182-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org, Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

The softfloat function floatx80_round_to_int incorrectly handles the
case of a pseudo-denormal where only the high bit of the significand
is set, ignoring that bit (treating the number as an exact zero)
rather than treating the number as an alternative representation of
+/- 2^-16382 (which may round to +/- 1 depending on the rounding mode)
as hardware does.  Fix this check (simplifying the code in the
process).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2005042339420.22972@digraph.polyomino.org.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c                            |  2 +-
 tests/tcg/i386/test-i386-pseudo-denormal.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index c57f72e3a6..a362bf89ca 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5741,7 +5741,7 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
     }
     if ( aExp < 0x3FFF ) {
         if (    ( aExp == 0 )
-             && ( (uint64_t) ( extractFloatx80Frac( a )<<1 ) == 0 ) ) {
+             && ( (uint64_t) ( extractFloatx80Frac( a ) ) == 0 ) ) {
             return a;
         }
         status->float_exception_flags |= float_flag_inexact;
diff --git a/tests/tcg/i386/test-i386-pseudo-denormal.c b/tests/tcg/i386/test-i386-pseudo-denormal.c
index acf2b9cf03..00d510cf4a 100644
--- a/tests/tcg/i386/test-i386-pseudo-denormal.c
+++ b/tests/tcg/i386/test-i386-pseudo-denormal.c
@@ -14,6 +14,7 @@ volatile long double ld_res;
 
 int main(void)
 {
+    short cw;
     int ret = 0;
     ld_res = ld_pseudo_m16382.ld + ld_pseudo_m16382.ld;
     if (ld_res != 0x1p-16381L) {
@@ -24,5 +25,14 @@ int main(void)
         printf("FAIL: pseudo-denormal compare\n");
         ret = 1;
     }
+    /* Set round-upward.  */
+    __asm__ volatile ("fnstcw %0" : "=m" (cw));
+    cw = (cw & ~0xc00) | 0x800;
+    __asm__ volatile ("fldcw %0" : : "m" (cw));
+    __asm__ ("frndint" : "=t" (ld_res) : "0" (ld_pseudo_m16382.ld));
+    if (ld_res != 1.0L) {
+        printf("FAIL: pseudo-denormal round-to-integer\n");
+        ret = 1;
+    }
     return ret;
 }
-- 
2.20.1


