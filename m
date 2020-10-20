Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684CBC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:59:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF7B2177B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrxECvIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF7B2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuzB-0006ge-Hf
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUue7-0007vW-Ag
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:38:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUue2-0000zG-MT
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id c77so2490827wmd.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XpldNLE39oyJx0Efh9oGONaLZZynshqlNmAlRNDfdFs=;
 b=OrxECvIvdhHFefWeSlFdCh51gIHGKv7HEwcvBFShp1oYIV2eZaiydW/IGw2ZYP4c5b
 dtlCGinly6JbMAwPv6VvBciS3veZdD6M8Xs51P3w5Bc256t9geddCL8jtUtI+XYkQ23q
 NTDVjtY/OD8nOSL9pntl1GV2TGbK5a78Yxb32puoinzlA/FGLaVJvtpvOo78N8o4RqBt
 BPGMIunodfVFqHokepznc8o7EW//Oeny8HWDwpkzWlhiiuu4W5AVAe5Rqs6gkg9xJ2nf
 6ynLJKB4MXi32DG6gxvKBoX6hkLzhLVxMYOvdlELNwYzRL5xTJHRRZN8buq5lQfT1lvV
 VFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XpldNLE39oyJx0Efh9oGONaLZZynshqlNmAlRNDfdFs=;
 b=jTxJwgcc+NP5jo6LWvDZj13DaLMIXWMKU5xcQsA97rk2cIsb2xzlDOkhD3g+yReSKN
 JcItjYNQfjhMFE5Rlnluh7IAiGEekZlfhYCHE4+KwU7yyr5nAr/dbmYE6tZaCIcz1WZm
 E9vdik2eU24M0r7FELnuP9YlthUJSn3SeBWSHRRATufmlMvclt6Rz/o47kTakzZclrTE
 Q9K8BkRVbmIY/8Wo/4dD9kqnxsCwG4bayDIYee9QveP4Oydi7VLUwElACcP0/lBZR2Gb
 pBepjoTwYeOiJjsC27GLaHqWLQhijyyO1FxXmKqv2kNiZLxhQ85PPylvNItz5nyhMzRR
 H6Vw==
X-Gm-Message-State: AOAM533FQznBDtUUK4KH9ADxI8Ncl/KQ8A2GHyRE3P1EwFajGHFFoggK
 ctMi+GjxjEmAyU6lRL0R9QTT6A==
X-Google-Smtp-Source: ABdhPJyxEysbvP02GHnr8YrQi3skcoQqF+26oMsRuBQwJWZovjdmUE2NEUAgCpV8d0KHtGth4Vx2Lw==
X-Received: by 2002:a05:600c:2115:: with SMTP id
 u21mr3714911wml.2.1603211868544; 
 Tue, 20 Oct 2020 09:37:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h3sm3832576wrw.78.2020.10.20.09.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 09:37:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BF8C91FF91;
 Tue, 20 Oct 2020 17:37:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  5/8] softfloat: Inline pick_nan_muladd into its caller
Date: Tue, 20 Oct 2020 17:37:35 +0100
Message-Id: <20201020163738.27700-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020163738.27700-1-alex.bennee@linaro.org>
References: <20201020163738.27700-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Because of FloatParts, there will only ever be one caller.
Inlining allows us to re-use abc_mask for the snan test.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200925152047.709901-6-richard.henderson@linaro.org>
---
 fpu/softfloat.c | 75 +++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3e625c47cd..e038434a07 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -929,45 +929,6 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
     return a;
 }
 
-static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
-                                  bool inf_zero, float_status *s)
-{
-    int which;
-
-    if (is_snan(a.cls) || is_snan(b.cls) || is_snan(c.cls)) {
-        s->float_exception_flags |= float_flag_invalid;
-    }
-
-    which = pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, s);
-
-    if (s->default_nan_mode) {
-        /* Note that this check is after pickNaNMulAdd so that function
-         * has an opportunity to set the Invalid flag.
-         */
-        which = 3;
-    }
-
-    switch (which) {
-    case 0:
-        break;
-    case 1:
-        a = b;
-        break;
-    case 2:
-        a = c;
-        break;
-    case 3:
-        return parts_default_nan(s);
-    default:
-        g_assert_not_reached();
-    }
-
-    if (is_snan(a.cls)) {
-        return parts_silence_nan(a, s);
-    }
-    return a;
-}
-
 /*
  * Returns the result of adding or subtracting the values of the
  * floating-point values `a' and `b'. The operation is performed
@@ -1366,7 +1327,41 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
      * off to the target-specific pick-a-NaN routine.
      */
     if (unlikely(abc_mask & float_cmask_anynan)) {
-        return pick_nan_muladd(a, b, c, inf_zero, s);
+        int which;
+
+        if (unlikely(abc_mask & float_cmask_snan)) {
+            float_raise(float_flag_invalid, s);
+        }
+
+        which = pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, s);
+
+        if (s->default_nan_mode) {
+            /*
+             * Note that this check is after pickNaNMulAdd so that function
+             * has an opportunity to set the Invalid flag for inf_zero.
+             */
+            which = 3;
+        }
+
+        switch (which) {
+        case 0:
+            break;
+        case 1:
+            a = b;
+            break;
+        case 2:
+            a = c;
+            break;
+        case 3:
+            return parts_default_nan(s);
+        default:
+            g_assert_not_reached();
+        }
+
+        if (is_snan(a.cls)) {
+            return parts_silence_nan(a, s);
+        }
+        return a;
     }
 
     if (unlikely(inf_zero)) {
-- 
2.20.1


