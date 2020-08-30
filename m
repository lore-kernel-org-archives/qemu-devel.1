Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F385C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0D52075B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlWwBr0U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0D52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCDAr-0007Fo-Al
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 22:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8h-0002iF-P6
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:15 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:43772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8f-0002Yd-7W
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:15 -0400
Received: by mail-pg1-x532.google.com with SMTP id d19so2372609pgl.10
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 19:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T763ehMytNeYEURPWFkoitjSdOEWxwTlP1JI5ym7p9A=;
 b=RlWwBr0UVZj90+6z2T51/mvbz8IwNXNTwzINcmKSq/wrGnf/vWLM/ZmOJ67+fmjOmP
 m2AW0l34aEbb8T/fTMl/x+2IJlff/26bXcBoP8CxMTiIziNKkavdfeiZSJlEU9XyrpQK
 +VjEKSWwcHAIg2AtO6IUmi9TtU/x3EjnsQZv5NRhByQgQdXvc1+c6LJXe4q6RP7vdPbc
 uDfarAlcUl68+OyRxfnwhCyRhpwImYtKx+qwQWNYbCnWmNE1bI2hdW6OQ4CuzbOFFKUp
 YcdHs1S1+lJefBgpY4MPt9kGYzeduAqYapdZJARRzkcZAo2pG+WaRbEg9K1Mf02Rx1F2
 T8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T763ehMytNeYEURPWFkoitjSdOEWxwTlP1JI5ym7p9A=;
 b=DdhKQ47TyYGz7wmZGAJfO2LoeJOI+Q/WKf1ThisU45MKczNjsCZW0TReditcCmL0Hw
 HhoiU+BCjv4IQvVuvxnd8MPmYZweSppEJ+7Qn/DJinX1ozkNeKYFUJyzXg/ypCPYey0K
 s/VyJTD3OkVSqHUTrm9Ap4ougsWrk2kBLOsWb63iyo9aFoQfgjODXQKcWf59EmlD9jR6
 8dQzGBb8Sfgh1PnbwPG+o7V1q8npmLfruzCtITuP9n/O6pxfh1CJ7PYGAqgV/qVpyDe5
 3qMxZT0fkrWv9GWEugNyVCAZmhd876KWuSiV6oL+RcG9LQWClsEafTD8wKnG6Eo5OqZa
 t9YQ==
X-Gm-Message-State: AOAM533Lk1a9ToWVELNKdsCicbqMaNhaXkicL0/Eh1qwMbSAIbRVm95E
 PTeAZ0pjs91MBMNeTKxhj5KvPCRnH2apDw==
X-Google-Smtp-Source: ABdhPJxyW6Myx8dCGWCrhIVuTmQTvDuQSTd0V+sYt1Mh/NuS2Ug7LtZnLb+VJr7EsqZ9aGE3jfYhQw==
X-Received: by 2002:a63:e00a:: with SMTP id e10mr4107166pgh.423.1598754731343; 
 Sat, 29 Aug 2020 19:32:11 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm3546269pgt.16.2020.08.29.19.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 19:32:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] softfloat: Define operations for bfloat16
Date: Sat, 29 Aug 2020 19:32:00 -0700
Message-Id: <20200830023203.612312-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200830023203.612312-1-richard.henderson@linaro.org>
References: <20200830023203.612312-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
Cc: peter.maydell@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

This patch implements operations for bfloat16 except conversion and some misc
operations. We also add FloatFmt and pack/unpack interfaces for bfloat16.
As they are both static fields, we can't make a sperate patch for them.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200813071421.2509-2-zhiwei_liu@c-sky.com>
[rth: Use FloatRelation for comparison operations.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-types.h |   5 +
 include/fpu/softfloat.h       |  38 ++++++++
 fpu/softfloat.c               | 168 ++++++++++++++++++++++++++++++++++
 3 files changed, 211 insertions(+)

diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index c7ddcab8ca..8a3f20fae9 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -112,6 +112,11 @@ typedef struct {
 #define make_float128(high_, low_) ((float128) { .high = high_, .low = low_ })
 #define make_float128_init(high_, low_) { .high = high_, .low = low_ }
 
+/*
+ * Software neural-network floating-point types.
+ */
+typedef uint16_t bfloat16;
+
 /*
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 863dfc6151..68b3cf488d 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -109,6 +109,7 @@ void float_raise(uint8_t flags, float_status *status);
 float16 float16_squash_input_denormal(float16 a, float_status *status);
 float32 float32_squash_input_denormal(float32 a, float_status *status);
 float64 float64_squash_input_denormal(float64 a, float_status *status);
+bfloat16 bfloat16_squash_input_denormal(bfloat16 a, float_status *status);
 
 /*----------------------------------------------------------------------------
 | Options to indicate which negations to perform in float*_muladd()
@@ -347,6 +348,43 @@ static inline bool float16_unordered_quiet(float16 a, float16 b,
 #define float16_three make_float16(0x4200)
 #define float16_infinity make_float16(0x7c00)
 
+/*----------------------------------------------------------------------------
+| Software bfloat16 operations.
+*----------------------------------------------------------------------------*/
+
+bfloat16 bfloat16_add(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_sub(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_mul(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_div(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_muladd(bfloat16, bfloat16, bfloat16, int,
+                         float_status *status);
+float16 bfloat16_scalbn(bfloat16, int, float_status *status);
+bfloat16 bfloat16_min(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_max(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_minnum(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_maxnum(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_minnummag(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_maxnummag(bfloat16, bfloat16, float_status *status);
+bfloat16 bfloat16_sqrt(bfloat16, float_status *status);
+FloatRelation bfloat16_compare(bfloat16, bfloat16, float_status *status);
+FloatRelation bfloat16_compare_quiet(bfloat16, bfloat16, float_status *status);
+
+bfloat16 bfloat16_silence_nan(bfloat16, float_status *status);
+bfloat16 bfloat16_default_nan(float_status *status);
+
+static inline bfloat16 bfloat16_set_sign(bfloat16 a, int sign)
+{
+    return (a & 0x7fff) | (sign << 15);
+}
+
+#define bfloat16_zero 0
+#define bfloat16_half 0x3f00
+#define bfloat16_one 0x3f80
+#define bfloat16_one_point_five 0x3fc0
+#define bfloat16_two 0x4000
+#define bfloat16_three 0x4040
+#define bfloat16_infinity 0x7f80
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated half-precision NaN.
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 64de0b40f7..77d81ab9b0 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -554,6 +554,10 @@ static const FloatFmt float16_params_ahp = {
     .arm_althp = true
 };
 
+static const FloatFmt bfloat16_params = {
+    FLOAT_PARAMS(8, 7)
+};
+
 static const FloatFmt float32_params = {
     FLOAT_PARAMS(8, 23)
 };
@@ -580,6 +584,11 @@ static inline FloatParts float16_unpack_raw(float16 f)
     return unpack_raw(float16_params, f);
 }
 
+static inline FloatParts bfloat16_unpack_raw(bfloat16 f)
+{
+    return unpack_raw(bfloat16_params, f);
+}
+
 static inline FloatParts float32_unpack_raw(float32 f)
 {
     return unpack_raw(float32_params, f);
@@ -603,6 +612,11 @@ static inline float16 float16_pack_raw(FloatParts p)
     return make_float16(pack_raw(float16_params, p));
 }
 
+static inline bfloat16 bfloat16_pack_raw(FloatParts p)
+{
+    return pack_raw(bfloat16_params, p);
+}
+
 static inline float32 float32_pack_raw(FloatParts p)
 {
     return make_float32(pack_raw(float32_params, p));
@@ -820,6 +834,11 @@ static FloatParts float16_unpack_canonical(float16 f, float_status *s)
     return float16a_unpack_canonical(f, s, &float16_params);
 }
 
+static FloatParts bfloat16_unpack_canonical(bfloat16 f, float_status *s)
+{
+    return sf_canonicalize(bfloat16_unpack_raw(f), &bfloat16_params, s);
+}
+
 static float16 float16a_round_pack_canonical(FloatParts p, float_status *s,
                                              const FloatFmt *params)
 {
@@ -831,6 +850,11 @@ static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
     return float16a_round_pack_canonical(p, s, &float16_params);
 }
 
+static bfloat16 bfloat16_round_pack_canonical(FloatParts p, float_status *s)
+{
+    return bfloat16_pack_raw(round_canonical(p, s, &bfloat16_params));
+}
+
 static FloatParts float32_unpack_canonical(float32 f, float_status *s)
 {
     return sf_canonicalize(float32_unpack_raw(f), &float32_params, s);
@@ -1158,6 +1182,28 @@ float64_sub(float64 a, float64 b, float_status *s)
     return float64_addsub(a, b, s, hard_f64_sub, soft_f64_sub);
 }
 
+/*
+ * Returns the result of adding or subtracting the bfloat16
+ * values `a' and `b'.
+ */
+bfloat16 QEMU_FLATTEN bfloat16_add(bfloat16 a, bfloat16 b, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pb = bfloat16_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, false, status);
+
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
+bfloat16 QEMU_FLATTEN bfloat16_sub(bfloat16 a, bfloat16 b, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pb = bfloat16_unpack_canonical(b, status);
+    FloatParts pr = addsub_floats(pa, pb, true, status);
+
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*
  * Returns the result of multiplying the floating-point values `a' and
  * `b'. The operation is performed according to the IEC/IEEE Standard
@@ -1260,6 +1306,20 @@ float64_mul(float64 a, float64 b, float_status *s)
                         f64_is_zon2, f64_addsubmul_post);
 }
 
+/*
+ * Returns the result of multiplying the bfloat16
+ * values `a' and `b'.
+ */
+
+bfloat16 QEMU_FLATTEN bfloat16_mul(bfloat16 a, bfloat16 b, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pb = bfloat16_unpack_canonical(b, status);
+    FloatParts pr = mul_floats(pa, pb, status);
+
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*
  * Returns the result of multiplying the floating-point values `a' and
  * `b' then adding 'c', with no intermediate rounding step after the
@@ -1642,6 +1702,23 @@ float64_muladd(float64 xa, float64 xb, float64 xc, int flags, float_status *s)
     return soft_f64_muladd(ua.s, ub.s, uc.s, flags, s);
 }
 
+/*
+ * Returns the result of multiplying the bfloat16 values `a'
+ * and `b' then adding 'c', with no intermediate rounding step after the
+ * multiplication.
+ */
+
+bfloat16 QEMU_FLATTEN bfloat16_muladd(bfloat16 a, bfloat16 b, bfloat16 c,
+                                      int flags, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pb = bfloat16_unpack_canonical(b, status);
+    FloatParts pc = bfloat16_unpack_canonical(c, status);
+    FloatParts pr = muladd_floats(pa, pb, pc, flags, status);
+
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*
  * Returns the result of dividing the floating-point value `a' by the
  * corresponding value `b'. The operation is performed according to
@@ -1808,6 +1885,20 @@ float64_div(float64 a, float64 b, float_status *s)
                         f64_div_pre, f64_div_post);
 }
 
+/*
+ * Returns the result of dividing the bfloat16
+ * value `a' by the corresponding value `b'.
+ */
+
+bfloat16 bfloat16_div(bfloat16 a, bfloat16 b, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pb = bfloat16_unpack_canonical(b, status);
+    FloatParts pr = div_floats(pa, pb, status);
+
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*
  * Float to Float conversions
  *
@@ -2881,6 +2972,25 @@ MINMAX(64, maxnummag, false, true, true)
 
 #undef MINMAX
 
+#define BF16_MINMAX(name, ismin, isiee, ismag)                          \
+bfloat16 bfloat16_ ## name(bfloat16 a, bfloat16 b, float_status *s)     \
+{                                                                       \
+    FloatParts pa = bfloat16_unpack_canonical(a, s);                    \
+    FloatParts pb = bfloat16_unpack_canonical(b, s);                    \
+    FloatParts pr = minmax_floats(pa, pb, ismin, isiee, ismag, s);      \
+                                                                        \
+    return bfloat16_round_pack_canonical(pr, s);                        \
+}
+
+BF16_MINMAX(min, true, false, false)
+BF16_MINMAX(minnum, true, true, false)
+BF16_MINMAX(minnummag, true, true, true)
+BF16_MINMAX(max, false, false, false)
+BF16_MINMAX(maxnum, false, true, false)
+BF16_MINMAX(maxnummag, false, true, true)
+
+#undef BF16_MINMAX
+
 /* Floating point compare */
 static FloatRelation compare_floats(FloatParts a, FloatParts b, bool is_quiet,
                                     float_status *s)
@@ -3042,6 +3152,24 @@ FloatRelation float64_compare_quiet(float64 a, float64 b, float_status *s)
     return f64_compare(a, b, true, s);
 }
 
+static FloatRelation QEMU_FLATTEN
+soft_bf16_compare(bfloat16 a, bfloat16 b, bool is_quiet, float_status *s)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, s);
+    FloatParts pb = bfloat16_unpack_canonical(b, s);
+    return compare_floats(pa, pb, is_quiet, s);
+}
+
+FloatRelation bfloat16_compare(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return soft_bf16_compare(a, b, false, s);
+}
+
+FloatRelation bfloat16_compare_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return soft_bf16_compare(a, b, true, s);
+}
+
 /* Multiply A by 2 raised to the power N.  */
 static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
 {
@@ -3081,6 +3209,13 @@ float64 float64_scalbn(float64 a, int n, float_status *status)
     return float64_round_pack_canonical(pr, status);
 }
 
+bfloat16 bfloat16_scalbn(bfloat16 a, int n, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pr = scalbn_decomposed(pa, n, status);
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*
  * Square Root
  *
@@ -3231,6 +3366,13 @@ float64 QEMU_FLATTEN float64_sqrt(float64 xa, float_status *s)
     return soft_f64_sqrt(ua.s, s);
 }
 
+bfloat16 QEMU_FLATTEN bfloat16_sqrt(bfloat16 a, float_status *status)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, status);
+    FloatParts pr = sqrt_float(pa, status, &bfloat16_params);
+    return bfloat16_round_pack_canonical(pr, status);
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated NaN.
 *----------------------------------------------------------------------------*/
@@ -3273,6 +3415,13 @@ float128 float128_default_nan(float_status *status)
     return r;
 }
 
+bfloat16 bfloat16_default_nan(float_status *status)
+{
+    FloatParts p = parts_default_nan(status);
+    p.frac >>= bfloat16_params.frac_shift;
+    return bfloat16_pack_raw(p);
+}
+
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN from a signalling NaN for the floating point value `a'.
 *----------------------------------------------------------------------------*/
@@ -3304,6 +3453,14 @@ float64 float64_silence_nan(float64 a, float_status *status)
     return float64_pack_raw(p);
 }
 
+bfloat16 bfloat16_silence_nan(bfloat16 a, float_status *status)
+{
+    FloatParts p = bfloat16_unpack_raw(a);
+    p.frac <<= bfloat16_params.frac_shift;
+    p = parts_silence_nan(p, status);
+    p.frac >>= bfloat16_params.frac_shift;
+    return bfloat16_pack_raw(p);
+}
 
 /*----------------------------------------------------------------------------
 | If `a' is denormal and we are in flush-to-zero mode then set the
@@ -3353,6 +3510,17 @@ float64 float64_squash_input_denormal(float64 a, float_status *status)
     return a;
 }
 
+bfloat16 bfloat16_squash_input_denormal(bfloat16 a, float_status *status)
+{
+    if (status->flush_inputs_to_zero) {
+        FloatParts p = bfloat16_unpack_raw(a);
+        if (parts_squash_denormal(p, status)) {
+            return bfloat16_set_sign(bfloat16_zero, p.sign);
+        }
+    }
+    return a;
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
-- 
2.25.1


