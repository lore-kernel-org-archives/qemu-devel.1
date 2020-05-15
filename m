Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ACAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E65C206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yS+tR7sz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E65C206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfcY-0003Vb-Jz
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfar-0001ay-F9
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:01 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfap-0001op-1b
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:01 -0400
Received: by mail-pf1-x443.google.com with SMTP id x13so1390639pfn.11
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FdTEJwk8OCj2gJ6qdZ/T9ggcqt2MBWuYzVMhJvyQfZQ=;
 b=yS+tR7szv1YtRbv33TWYSDAG9Gj3FC/9Xd7OCxVB1WNu3YExPBy1bi1GGqo0SncHZw
 /MvQVwmTF0F9bbAKsIuN/VwaG91nmssbQkCAy+Hn2kb7CkmOUIF/3McyMIyto64PaHiL
 0cK+WjOfRjslXCx2rpR1pdoQ7pOKVmjt/qlY6DJW0FjACI+dMIp1oWrw99YlrnnU0vsx
 VCsiqoyd30xy750kgPuxBNI276zRmB0TgNklBnJb00Lg3BcaHvzhV4Gtj+IQ8Ghz2swr
 54SMIb7VzIOb0r21uma96Itw9p7/WVRHH/YIrDWSdPeAainjivHkN4YjZMome8ffhn5T
 DatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FdTEJwk8OCj2gJ6qdZ/T9ggcqt2MBWuYzVMhJvyQfZQ=;
 b=lLabvCmUHxx0N5RobIfUx5jfQHUwBobVSc5WBXlKcn0Fgt+oHa5btvvUzI2HrsBNWq
 hiXUuwUSe5GyaxbaVsM8ZbgFm1CT/hBAtCqd3udM1xbdhp3uc1trKyCPB/2og20OninL
 D1Puht0pXUDpTK6m/gSOPwnf2h1gB7n2b19HuSarNKjZzDuwTI4dwaRpqVGIc3qqLCAL
 LLwTIgVEuSnuU0P/NDlmzNAZo9SkEA5V+CmmNd+I9tLKaDl6oMYFGUM4G175D3ESK1Oq
 X+Rrw+yEPiSF0aWoCUDapKLk2N73z2Vo6kU2SCuzq2nnkCh3y9xKdZASPCSQgKlHaqGN
 6Mng==
X-Gm-Message-State: AOAM531YKtG/fwV3DlheqKxEMBSdE2WaaB5X7iQs05kfmcl1FImN+18w
 IwkD05dEg07fealUu1quQyZ7OpN2qUY=
X-Google-Smtp-Source: ABdhPJxKCq+j3LEbs47QzAdQBQsRfnxa5RI8Z52n3e6qcsbhcH9nE2WN60+UHkhVWtzVIgeDCfvQ6A==
X-Received: by 2002:a63:d556:: with SMTP id v22mr4604310pgi.263.1589569316901; 
 Fri, 15 May 2020 12:01:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q21sm2485719pfg.131.2020.05.15.12.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 12:01:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/10] softfloat: Use post test for floatN_mul
Date: Fri, 15 May 2020 12:01:44 -0700
Message-Id: <20200515190153.6017-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515190153.6017-1-richard.henderson@linaro.org>
References: <20200515190153.6017-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The existing f{32,64}_addsub_post test, which checks for zero
inputs, is identical to f{32,64}_mul_fast_test.  Which means
we can eliminate the fast_test/fast_op hooks in favor of
reusing the same post hook.

This means we have one fewer test along the fast path for multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 65 +++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 51 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index a362bf89ca..5fb4ef75bb 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -339,12 +339,10 @@ static inline bool f64_is_inf(union_float64 a)
     return float64_is_infinity(a.s);
 }
 
-/* Note: @fast_test and @post can be NULL */
 static inline float32
 float32_gen2(float32 xa, float32 xb, float_status *s,
              hard_f32_op2_fn hard, soft_f32_op2_fn soft,
-             f32_check_fn pre, f32_check_fn post,
-             f32_check_fn fast_test, soft_f32_op2_fn fast_op)
+             f32_check_fn pre, f32_check_fn post)
 {
     union_float32 ua, ub, ur;
 
@@ -359,17 +357,12 @@ float32_gen2(float32 xa, float32 xb, float_status *s,
     if (unlikely(!pre(ua, ub))) {
         goto soft;
     }
-    if (fast_test && fast_test(ua, ub)) {
-        return fast_op(ua.s, ub.s, s);
-    }
 
     ur.h = hard(ua.h, ub.h);
     if (unlikely(f32_is_inf(ur))) {
         s->float_exception_flags |= float_flag_overflow;
-    } else if (unlikely(fabsf(ur.h) <= FLT_MIN)) {
-        if (post == NULL || post(ua, ub)) {
-            goto soft;
-        }
+    } else if (unlikely(fabsf(ur.h) <= FLT_MIN) && post(ua, ub)) {
+        goto soft;
     }
     return ur.s;
 
@@ -380,8 +373,7 @@ float32_gen2(float32 xa, float32 xb, float_status *s,
 static inline float64
 float64_gen2(float64 xa, float64 xb, float_status *s,
              hard_f64_op2_fn hard, soft_f64_op2_fn soft,
-             f64_check_fn pre, f64_check_fn post,
-             f64_check_fn fast_test, soft_f64_op2_fn fast_op)
+             f64_check_fn pre, f64_check_fn post)
 {
     union_float64 ua, ub, ur;
 
@@ -396,17 +388,12 @@ float64_gen2(float64 xa, float64 xb, float_status *s,
     if (unlikely(!pre(ua, ub))) {
         goto soft;
     }
-    if (fast_test && fast_test(ua, ub)) {
-        return fast_op(ua.s, ub.s, s);
-    }
 
     ur.h = hard(ua.h, ub.h);
     if (unlikely(f64_is_inf(ur))) {
         s->float_exception_flags |= float_flag_overflow;
-    } else if (unlikely(fabs(ur.h) <= DBL_MIN)) {
-        if (post == NULL || post(ua, ub)) {
-            goto soft;
-        }
+    } else if (unlikely(fabs(ur.h) <= DBL_MIN) && post(ua, ub)) {
+        goto soft;
     }
     return ur.s;
 
@@ -1115,7 +1102,7 @@ static double hard_f64_sub(double a, double b)
     return a - b;
 }
 
-static bool f32_addsub_post(union_float32 a, union_float32 b)
+static bool f32_addsubmul_post(union_float32 a, union_float32 b)
 {
     if (QEMU_HARDFLOAT_2F32_USE_FP) {
         return !(fpclassify(a.h) == FP_ZERO && fpclassify(b.h) == FP_ZERO);
@@ -1123,7 +1110,7 @@ static bool f32_addsub_post(union_float32 a, union_float32 b)
     return !(float32_is_zero(a.s) && float32_is_zero(b.s));
 }
 
-static bool f64_addsub_post(union_float64 a, union_float64 b)
+static bool f64_addsubmul_post(union_float64 a, union_float64 b)
 {
     if (QEMU_HARDFLOAT_2F64_USE_FP) {
         return !(fpclassify(a.h) == FP_ZERO && fpclassify(b.h) == FP_ZERO);
@@ -1136,14 +1123,14 @@ static float32 float32_addsub(float32 a, float32 b, float_status *s,
                               hard_f32_op2_fn hard, soft_f32_op2_fn soft)
 {
     return float32_gen2(a, b, s, hard, soft,
-                        f32_is_zon2, f32_addsub_post, NULL, NULL);
+                        f32_is_zon2, f32_addsubmul_post);
 }
 
 static float64 float64_addsub(float64 a, float64 b, float_status *s,
                               hard_f64_op2_fn hard, soft_f64_op2_fn soft)
 {
     return float64_gen2(a, b, s, hard, soft,
-                        f64_is_zon2, f64_addsub_post, NULL, NULL);
+                        f64_is_zon2, f64_addsubmul_post);
 }
 
 float32 QEMU_FLATTEN
@@ -1258,42 +1245,18 @@ static double hard_f64_mul(double a, double b)
     return a * b;
 }
 
-static bool f32_mul_fast_test(union_float32 a, union_float32 b)
-{
-    return float32_is_zero(a.s) || float32_is_zero(b.s);
-}
-
-static bool f64_mul_fast_test(union_float64 a, union_float64 b)
-{
-    return float64_is_zero(a.s) || float64_is_zero(b.s);
-}
-
-static float32 f32_mul_fast_op(float32 a, float32 b, float_status *s)
-{
-    bool signbit = float32_is_neg(a) ^ float32_is_neg(b);
-
-    return float32_set_sign(float32_zero, signbit);
-}
-
-static float64 f64_mul_fast_op(float64 a, float64 b, float_status *s)
-{
-    bool signbit = float64_is_neg(a) ^ float64_is_neg(b);
-
-    return float64_set_sign(float64_zero, signbit);
-}
-
 float32 QEMU_FLATTEN
 float32_mul(float32 a, float32 b, float_status *s)
 {
     return float32_gen2(a, b, s, hard_f32_mul, soft_f32_mul,
-                        f32_is_zon2, NULL, f32_mul_fast_test, f32_mul_fast_op);
+                        f32_is_zon2, f32_addsubmul_post);
 }
 
 float64 QEMU_FLATTEN
 float64_mul(float64 a, float64 b, float_status *s)
 {
     return float64_gen2(a, b, s, hard_f64_mul, soft_f64_mul,
-                        f64_is_zon2, NULL, f64_mul_fast_test, f64_mul_fast_op);
+                        f64_is_zon2, f64_addsubmul_post);
 }
 
 /*
@@ -1834,14 +1797,14 @@ float32 QEMU_FLATTEN
 float32_div(float32 a, float32 b, float_status *s)
 {
     return float32_gen2(a, b, s, hard_f32_div, soft_f32_div,
-                        f32_div_pre, f32_div_post, NULL, NULL);
+                        f32_div_pre, f32_div_post);
 }
 
 float64 QEMU_FLATTEN
 float64_div(float64 a, float64 b, float_status *s)
 {
     return float64_gen2(a, b, s, hard_f64_div, soft_f64_div,
-                        f64_div_pre, f64_div_post, NULL, NULL);
+                        f64_div_pre, f64_div_post);
 }
 
 /*
-- 
2.20.1


