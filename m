Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143FDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D780A20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9qwFqvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D780A20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlF9g-0004CT-13
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF56-0001P3-Cc
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:04 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF54-0007UK-Dl
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id c71so3576678wmd.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h9ltt+F4LrKZIkRTSNT6mJTq1A3I28QBdjW3sTZLEvk=;
 b=p9qwFqvqdF4EuWaXu52rQ/2ZxpI6yMZX7WlO4H3HlSTKuoP5JzwS+VfEt2KC2AyLEy
 /6XLQwMly4t6JfyuN2v48ChaRzKSx4qy8HvhmEDl+PNxYy1HEZgIIuGcv+td5nMwPiwm
 Ni3bZQugLqQFYFqwb4BaxRgKCYW64So4ip6R/+xzcAFj92gFyDH50X9AvLhRnZtUD96b
 XH1o9jZZQPfzi/EKhEaIwbJXwy6N+gSnMRknlFfzQ0R5JUYWLVFhxOxA02v/XgfhRxc7
 wIMXj0x3DV7OFwEuOm2Z8tNkrpQlRFwntWy/UH5yEqO0U+pHEeN7EeoVq9nM73Q0BluL
 lyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h9ltt+F4LrKZIkRTSNT6mJTq1A3I28QBdjW3sTZLEvk=;
 b=Ddc+3NOWXeSI35W4xJ7Ee/oIcu1r4Hb49RYz+RGRSlrT9A5PFQFooBtsMkBAg/9diq
 qZc5ujx2VblmnP92M8xFbzlFHhtqPN1FrRAz0e3s4YjN/+c/i85lt/nHX9c5s/svjWnL
 aRzro3wQ7OoHJP8jNQvRFX2MTGHeoYA3TSI7jEam1UgPNsepjTsY+q0N4E2JAT3QQgRc
 47giur7t/kmxS30rXld8DwzTlAbq3Ndty/Qiiy+uYYiaLTMNxDXLuYt7OaL+HCFmlyf0
 VOruXIPSuGPGZ6S5MpI3HApU6+K11szuz6WfQBamG32sN9zgU7oq/FuG7qxDzf9I+RRb
 X3dQ==
X-Gm-Message-State: AOAM533cChhqH7dPVZbujiNGzf6oYj2ZXWaJ07d2RNucjcBmqFQfdl4h
 K1u6jkNXYLFroV7lb0e+yQX+mw==
X-Google-Smtp-Source: ABdhPJxQREB7/zxRhmsRFlaXtyN/5AYK1szEwzmhHOdBQYzcmc7eL3QLy3pLEhrrMWNjM7ZcwyTnmA==
X-Received: by 2002:a05:600c:4410:: with SMTP id
 u16mr4205349wmn.88.1592327340993; 
 Tue, 16 Jun 2020 10:09:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:09:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 10/21] target/arm: Fix capitalization in NeonGenTwo{Single,
 Double}OPFn typedefs
Date: Tue, 16 Jun 2020 18:08:33 +0100
Message-Id: <20200616170844.13318-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All the other typedefs like these spell "Op" with a lowercase 'p';
remane the NeonGenTwoSingleOPFn and NeonGenTwoDoubleOPFn typedefs to
match.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h          | 4 ++--
 target/arm/translate-a64.c      | 4 ++--
 target/arm/translate-neon.inc.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index 35218b3fdf1..467c5291101 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -372,8 +372,8 @@ typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
 typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
 typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
 typedef void NeonGenTwoOpWidenFn(TCGv_i64, TCGv_i32, TCGv_i32);
-typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
-typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
+typedef void NeonGenTwoSingleOpFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
+typedef void NeonGenTwoDoubleOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 typedef void NeonGenOne64OpFn(TCGv_i64, TCGv_i64);
 typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
 typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7cb5fbfba80..12040984981 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9534,7 +9534,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         TCGv_i64 tcg_op = tcg_temp_new_i64();
         TCGv_i64 tcg_zero = tcg_const_i64(0);
         TCGv_i64 tcg_res = tcg_temp_new_i64();
-        NeonGenTwoDoubleOPFn *genfn;
+        NeonGenTwoDoubleOpFn *genfn;
         bool swap = false;
         int pass;
 
@@ -9576,7 +9576,7 @@ static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
         TCGv_i32 tcg_op = tcg_temp_new_i32();
         TCGv_i32 tcg_zero = tcg_const_i32(0);
         TCGv_i32 tcg_res = tcg_temp_new_i32();
-        NeonGenTwoSingleOPFn *genfn;
+        NeonGenTwoSingleOpFn *genfn;
         bool swap = false;
         int pass, maxpasses;
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 5e2cd18bf71..c39443c8cae 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1664,7 +1664,7 @@ static bool trans_VSHLL_U_2sh(DisasContext *s, arg_2reg_shift *a)
 }
 
 static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
-                      NeonGenTwoSingleOPFn *fn)
+                      NeonGenTwoSingleOpFn *fn)
 {
     /* FP operations in 2-reg-and-shift group */
     TCGv_i32 tmp, shiftv;
-- 
2.20.1


