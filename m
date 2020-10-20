Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9F7C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CEE20704
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liD8uhbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CEE20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUutT-0001bd-CQ
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUue9-0007wf-6l
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:38:02 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:33797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUue2-000104-Na
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:38:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id i1so2978681wro.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eYa6Q4RE3MycBw08Hofq/5V0wFL9wifbiVGcaMm5vtU=;
 b=liD8uhbwwVGL07PJL2ZBbsD0vJq0ODIn1Ez7pzEKVlDJ2B1tiGejZ3pKO3MUexwMiq
 XhET1RrUjQHWSvS5Hh+Gvu9ebdc1aN1Lx7qOqPSeN2mAgG3JOeOBG8tibps9mQciLME3
 bq81NkovadjHnSh2k+9OLSqcC81Uevlf46zdQFLrUwmgohSWpzJwT72mCT1RFvaKkPbm
 9ijMVjX5eant/h+vbNxPtGzdmYMHOqWD8zbgE6YsljFwEu6/zHE5HkoI8y4ndTHjOIyS
 IX/0zHRRvZmMs/wYVcypBdcLCaCheid26qlnx6449rDsV08rUq/reZNu2fihz9hRqNEq
 XDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eYa6Q4RE3MycBw08Hofq/5V0wFL9wifbiVGcaMm5vtU=;
 b=m1lXENPTSppItoPxQ4D5G/SboHPZAGIjHQPxx104xJ5R7rPg84OxHETjOFMrYtVTv8
 +c4+jMBvUyk4qHYdqMyAPtXveYQwjAxt9adkErVC9A0IuFaFPsMeXzjieIJ5uL5WwcQA
 5alETkm+WWFt348NaSSkJUvR814htKhk5gATKAvbSEqzeUYHDe89e8gQiynHDKJEzTVs
 t/CU/G+4QCnlV/C4Lq9aAZSRz4Wz0Qgk7W6HGa0/Zomf/zhjBvhbK3v+bIMFau/sFvtx
 BOU3KxjDMdJ8Pym8dmvC6ajlWcq/Csz4oQX0CB2DPEXkWJlF9+3C/psRkteDCXMRoz0s
 qlyw==
X-Gm-Message-State: AOAM530sx+zf/Ba/B1O0iWvrQVeZHWIjZW3XQmgUIZ1BWuSQyitVEqTo
 akQY5Fb1wtoD4zbAVbI4acE6qg==
X-Google-Smtp-Source: ABdhPJwX7rqVP5zKEwc2NEVTIug9bbAUz+BzG8lIVzqn0sr89NPcy8EiwL5QO8nPegC/5igpCzEm8w==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr4319211wro.22.1603211873167; 
 Tue, 20 Oct 2020 09:37:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d30sm3988261wrc.19.2020.10.20.09.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 09:37:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 62AE11FF96;
 Tue, 20 Oct 2020 17:37:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 8/8] softfloat: implement addsub_floats128 using Uint128
 and new style code
Date: Tue, 20 Oct 2020 17:37:38 +0100
Message-Id: <20201020163738.27700-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020163738.27700-1-alex.bennee@linaro.org>
References: <20201020163738.27700-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This inevitably leads to duplication of almost identical functions for
the 128 bit and the 64/32/16 bit code. We will try and address that
later.

The expanded code is longer than the previous softfloat code and we
see a drop in performance from ~85 MFlops to ~72 MFlops.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/fpu/softfloat-macros.h |  17 +
 fpu/softfloat.c                | 586 ++++++++++++++++++++-------------
 fpu/softfloat-specialize.c.inc |  39 +++
 3 files changed, 421 insertions(+), 221 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 95d88d05b8..8e6158886d 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -259,6 +259,23 @@ static inline void
 
 }
 
+/* as above with Uint128 */
+static inline Uint128 shift128RightJammingUint128(Int128 in, int count)
+{
+    Uint128 out;
+
+    if (count == 0) {
+        out = in;
+    } else if ( count < 128 ) {
+        Uint128 jam_mask = uint128_sub(uint128_lshift(1, count), 1);
+        int shifted_away = uint128_and(in, jam_mask) != 0;
+        out = uint128_or(uint128_rshift(in, count), shifted_away);
+    } else {
+        out = ( in != 0 );
+    }
+    return out;
+}
+
 /*----------------------------------------------------------------------------
 | Shifts the 192-bit value formed by concatenating `a0', `a1', and `a2' right
 | by 64 _plus_ the number of bits given in `count'.  The shifted result is
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e038434a07..694616bb3d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -517,9 +517,20 @@ typedef struct {
     bool sign;
 } FloatParts;
 
+/* Similar for float128.  */
+typedef struct {
+    Uint128 frac;
+    int32_t exp;
+    FloatClass cls;
+    bool sign;
+} FloatParts128;
+
 #define DECOMPOSED_BINARY_POINT    (64 - 2)
 #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
 #define DECOMPOSED_OVERFLOW_BIT    (DECOMPOSED_IMPLICIT_BIT << 1)
+#define DECOMPOSED128_BINARY_POINT (128 - 2)
+#define DECOMPOSED128_IMPLICIT_BIT (uint128_lshift(1, DECOMPOSED128_BINARY_POINT))
+#define DECOMPOSED128_OVERFLOW_BIT (uint128_lshift(DECOMPOSED128_IMPLICIT_BIT, 1))
 
 /* Structure holding all of the relevant parameters for a format.
  *   exp_size: the size of the exponent field
@@ -559,6 +570,13 @@ typedef struct {
     .round_mask     = (1ull << (DECOMPOSED_BINARY_POINT - F)) - 1,   \
     .roundeven_mask = (2ull << (DECOMPOSED_BINARY_POINT - F)) - 1
 
+#define FLOAT128_PARAMS(E, F)                                           \
+    .exp_size       = E,                                             \
+    .exp_bias       = ((1 << E) - 1) >> 1,                           \
+    .exp_max        = (1 << E) - 1,                                  \
+    .frac_size      = F,                                             \
+    .frac_shift     = DECOMPOSED128_BINARY_POINT - F,
+
 static const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
 };
@@ -580,6 +598,16 @@ static const FloatFmt float64_params = {
     FLOAT_PARAMS(11, 52)
 };
 
+static const FloatFmt float128_params = {
+    FLOAT128_PARAMS(15, 112)
+    /* the remaining fields are not used for 128 bit ops */
+    .frac_lsb = 0,
+    .frac_lsbm1 = 0,
+    .round_mask = 0,
+    .roundeven_mask = 0,
+    .arm_althp = false
+};
+
 /* Unpack a float to parts, but do not canonicalize.  */
 static inline FloatParts unpack_raw(FloatFmt fmt, uint64_t raw)
 {
@@ -593,6 +621,18 @@ static inline FloatParts unpack_raw(FloatFmt fmt, uint64_t raw)
     };
 }
 
+static inline FloatParts128 unpack128_raw(FloatFmt fmt, Uint128 raw)
+{
+    const int sign_pos = fmt.frac_size + fmt.exp_size;
+
+    return (FloatParts128) {
+        .cls = float_class_unclassified,
+        .sign = extract128(raw, sign_pos, 1),
+        .exp = extract128(raw, fmt.frac_size, fmt.exp_size),
+        .frac = extract128(raw, 0, fmt.frac_size),
+    };
+}
+
 static inline FloatParts float16_unpack_raw(float16 f)
 {
     return unpack_raw(float16_params, f);
@@ -613,6 +653,11 @@ static inline FloatParts float64_unpack_raw(float64 f)
     return unpack_raw(float64_params, f);
 }
 
+static inline FloatParts128 float128_unpack_raw(float128 f)
+{
+    return unpack128_raw(float128_params, uint128_make128(f.low, f.high));
+}
+
 /* Pack a float from parts, but do not canonicalize.  */
 static inline uint64_t pack_raw(FloatFmt fmt, FloatParts p)
 {
@@ -621,6 +666,13 @@ static inline uint64_t pack_raw(FloatFmt fmt, FloatParts p)
     return deposit64(ret, sign_pos, 1, p.sign);
 }
 
+static inline Uint128 pack128_raw(FloatFmt fmt, FloatParts128 p)
+{
+    const int sign_pos = fmt.frac_size + fmt.exp_size;
+    Uint128 ret = deposit128(p.frac, fmt.frac_size, fmt.exp_size, p.exp);
+    return deposit128(ret, sign_pos, 1, p.sign);
+}
+
 static inline float16 float16_pack_raw(FloatParts p)
 {
     return make_float16(pack_raw(float16_params, p));
@@ -641,6 +693,12 @@ static inline float64 float64_pack_raw(FloatParts p)
     return make_float64(pack_raw(float64_params, p));
 }
 
+static inline float128 float128_pack_raw(FloatParts128 p)
+{
+    Uint128 out = pack128_raw(float128_params, p);
+    return make_float128(uint128_gethi(out), uint128_getlo(out));
+}
+
 /*----------------------------------------------------------------------------
 | Functions and definitions to determine:  (1) whether tininess for underflow
 | is detected before or after rounding by default, (2) what (if anything)
@@ -684,6 +742,41 @@ static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
     return part;
 }
 
+/* Almost exactly the same as sf_canonicalize except 128 bit */
+static FloatParts128 sf128_canonicalize(FloatParts128 part, const FloatFmt *parm,
+                                        float_status *status)
+{
+    bool frac_is_zero = uint128_eq(part.frac, uint128_zero());
+    if (part.exp == parm->exp_max) {
+        if (frac_is_zero) {
+            part.cls = float_class_inf;
+        } else {
+            part.frac = uint128_lshift(part.frac, parm->frac_shift);
+            part.cls = (parts128_is_snan_frac(part.frac, status)
+                        ? float_class_snan : float_class_qnan);
+        }
+    } else if (part.exp == 0) {
+        if (likely(frac_is_zero)) {
+            part.cls = float_class_zero;
+        } else if (status->flush_inputs_to_zero) {
+            float_raise(float_flag_input_denormal, status);
+            part.cls = float_class_zero;
+            part.frac = uint128_zero();
+        } else {
+            int shift = clz128(part.frac) - 1;
+            part.cls = float_class_normal;
+            part.exp = parm->frac_shift - parm->exp_bias - shift + 1;
+            part.frac = uint128_lshift(part.frac, shift);
+        }
+    } else {
+        Uint128 imp_bit = uint128_lshift(1, DECOMPOSED128_BINARY_POINT);
+        part.cls = float_class_normal;
+        part.exp -= parm->exp_bias;
+        part.frac = uint128_add(imp_bit, uint128_lshift(part.frac, parm->frac_shift));
+    }
+    return part;
+}
+
 /* Round and uncanonicalize a floating-point number by parts. There
  * are FRAC_SHIFT bits that may require rounding at the bottom of the
  * fraction; these bits will be removed. The exponent will be biased
@@ -836,6 +929,144 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
     return p;
 }
 
+/* As above but wider */
+static FloatParts128 round128_canonical(FloatParts128 p, float_status *s,
+                                        const FloatFmt *parm)
+{
+    /* Do these by hand rather than widening the FloatFmt structure */
+    const Uint128 frac_lsb = uint128_lshift(1, DECOMPOSED128_BINARY_POINT - parm->frac_size);
+    const Uint128 frac_lsbm1 = uint128_lshift(1, (DECOMPOSED128_BINARY_POINT - parm->frac_size) - 1);
+    const Uint128 round_mask = uint128_sub(frac_lsb, 1);
+    const Uint128 roundeven_mask = uint128_sub(uint128_lshift(2, DECOMPOSED128_BINARY_POINT - parm->frac_size), 1);
+    const int exp_max = parm->exp_max;
+    const int frac_shift = parm->frac_shift;
+    Uint128 frac, inc;
+    int exp, flags = 0;
+    bool overflow_norm;
+
+    frac = p.frac;
+    exp = p.exp;
+
+    switch (p.cls) {
+    case float_class_normal:
+        switch (s->float_rounding_mode) {
+        case float_round_nearest_even:
+            overflow_norm = false;
+            inc = ((frac & roundeven_mask) != frac_lsbm1 ? frac_lsbm1 : 0);
+            break;
+        case float_round_ties_away:
+            overflow_norm = false;
+            inc = frac_lsbm1;
+            break;
+        case float_round_to_zero:
+            overflow_norm = true;
+            inc = 0;
+            break;
+        case float_round_up:
+            inc = p.sign ? 0 : round_mask;
+            overflow_norm = p.sign;
+            break;
+        case float_round_down:
+            inc = p.sign ? round_mask : 0;
+            overflow_norm = !p.sign;
+            break;
+        case float_round_to_odd:
+            overflow_norm = true;
+            inc = frac & frac_lsb ? 0 : round_mask;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        exp += parm->exp_bias;
+        if (likely(exp > 0)) {
+            if (frac & round_mask) {
+                flags |= float_flag_inexact;
+                frac += inc;
+                if (frac & DECOMPOSED128_OVERFLOW_BIT) {
+                    frac >>= 1;
+                    exp++;
+                }
+            }
+            frac >>= frac_shift;
+
+            if (unlikely(exp >= exp_max)) {
+                flags |= float_flag_overflow | float_flag_inexact;
+                if (overflow_norm) {
+                    exp = exp_max - 1;
+                    frac = -1;
+                } else {
+                    p.cls = float_class_inf;
+                    goto do_inf;
+                }
+            }
+        } else if (s->flush_to_zero) {
+            flags |= float_flag_output_denormal;
+            p.cls = float_class_zero;
+            goto do_zero;
+        } else {
+            bool is_tiny = s->tininess_before_rounding
+                        || (exp < 0)
+                        || !(uint128_and(uint128_add(frac, inc), DECOMPOSED128_OVERFLOW_BIT));
+
+            frac = shift128RightJammingUint128(frac, 1 - exp);
+            if (frac & round_mask) {
+                /* Need to recompute round-to-even.  */
+                switch (s->float_rounding_mode) {
+                case float_round_nearest_even:
+                    inc = ((uint128_and(frac, roundeven_mask)) != frac_lsbm1
+                           ? frac_lsbm1 : 0);
+                    break;
+                case float_round_to_odd:
+                    inc = uint128_and(frac, frac_lsb ? 0 : round_mask);
+                    break;
+                default:
+                    break;
+                }
+                flags |= float_flag_inexact;
+                uint128_add(frac, inc);
+            }
+
+            exp = (uint128_and(frac, DECOMPOSED128_IMPLICIT_BIT) ? 1 : 0);
+            frac = uint128_rshift(frac, parm->frac_shift);
+
+            if (is_tiny && (flags & float_flag_inexact)) {
+                flags |= float_flag_underflow;
+            }
+            if (exp == 0 && frac == 0) {
+                p.cls = float_class_zero;
+            }
+        }
+        break;
+
+    case float_class_zero:
+    do_zero:
+        exp = 0;
+        frac = 0;
+        break;
+
+    case float_class_inf:
+    do_inf:
+        exp = exp_max;
+        frac = 0;
+        break;
+
+    case float_class_qnan:
+    case float_class_snan:
+        exp = exp_max;
+        frac = uint128_rshift(frac, parm->frac_shift);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    float_raise(flags, s);
+    p.exp = exp;
+    p.frac = frac;
+    return p;
+}
+
 /* Explicit FloatFmt version */
 static FloatParts float16a_unpack_canonical(float16 f, float_status *s,
                                             const FloatFmt *params)
@@ -889,6 +1120,16 @@ static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
     return float64_pack_raw(round_canonical(p, s, &float64_params));
 }
 
+static FloatParts128 float128_unpack_canonical(float128 f, float_status *s)
+{
+    return sf128_canonicalize(float128_unpack_raw(f), &float128_params, s);
+}
+
+static float128 float128_round_pack_canonical(FloatParts128 p, float_status *s)
+{
+    return float128_pack_raw(round128_canonical(p, s, &float128_params));
+}
+
 static FloatParts return_nan(FloatParts a, float_status *s)
 {
     switch (a.cls) {
@@ -1018,6 +1259,110 @@ static FloatParts addsub_floats(FloatParts a, FloatParts b, bool subtract,
     g_assert_not_reached();
 }
 
+/* As above but with Uint128 fractions */
+static FloatParts128 pick_nan128(FloatParts128 a, FloatParts128 b, float_status *s)
+{
+    if (is_snan(a.cls) || is_snan(b.cls)) {
+        s->float_exception_flags |= float_flag_invalid;
+    }
+
+    if (s->default_nan_mode) {
+        return parts128_default_nan(s);
+    } else {
+        if (pickNaN(a.cls, b.cls,
+                    a.frac > b.frac ||
+                    (a.frac == b.frac && a.sign < b.sign), s)) {
+            a = b;
+        }
+        if (is_snan(a.cls)) {
+            return parts128_silence_nan(a, s);
+        }
+    }
+    return a;
+}
+
+static FloatParts128 addsub_floats128(FloatParts128 a, FloatParts128 b, bool subtract,
+                                   float_status *s)
+{
+    bool a_sign = a.sign;
+    bool b_sign = b.sign ^ subtract;
+
+    if (a_sign != b_sign) {
+        /* Subtraction */
+
+        if (a.cls == float_class_normal && b.cls == float_class_normal) {
+            if (a.exp > b.exp || (a.exp == b.exp && a.frac >= b.frac)) {
+                b.frac = shift128RightJammingUint128(b.frac, a.exp - b.exp);
+                a.frac = uint128_sub(a.frac, b.frac);
+            } else {
+                a.frac = shift128RightJammingUint128(a.frac, b.exp - a.exp);
+                a.frac = uint128_sub(b.frac, a.frac);
+                a.exp = b.exp;
+                a_sign ^= 1;
+            }
+
+            if (a.frac == 0) {
+                a.cls = float_class_zero;
+                a.sign = s->float_rounding_mode == float_round_down;
+            } else {
+                int shift = clz128(a.frac) - 1;
+                a.frac = uint128_lshift(a.frac, shift);
+                a.exp = a.exp - shift;
+                a.sign = a_sign;
+            }
+            return a;
+        }
+        if (is_nan(a.cls) || is_nan(b.cls)) {
+            return pick_nan128(a, b, s);
+        }
+        if (a.cls == float_class_inf) {
+            if (b.cls == float_class_inf) {
+                float_raise(float_flag_invalid, s);
+                return parts128_default_nan(s);
+            }
+            return a;
+        }
+        if (a.cls == float_class_zero && b.cls == float_class_zero) {
+            a.sign = s->float_rounding_mode == float_round_down;
+            return a;
+        }
+        if (a.cls == float_class_zero || b.cls == float_class_inf) {
+            b.sign = a_sign ^ 1;
+            return b;
+        }
+        if (b.cls == float_class_zero) {
+            return a;
+        }
+    } else {
+        /* Addition */
+        if (a.cls == float_class_normal && b.cls == float_class_normal) {
+            if (a.exp > b.exp) {
+                b.frac = shift128RightJammingUint128(b.frac, a.exp - b.exp);
+            } else if (a.exp < b.exp) {
+                a.frac = shift128RightJammingUint128(a.frac, b.exp - a.exp);
+                a.exp = b.exp;
+            }
+            a.frac = uint128_add(a.frac, b.frac);
+            if (a.frac & DECOMPOSED128_OVERFLOW_BIT) {
+                a.frac = shift128RightJammingUint128(a.frac, 1);
+                a.exp += 1;
+            }
+            return a;
+        }
+        if (is_nan(a.cls) || is_nan(b.cls)) {
+            return pick_nan128(a, b, s);
+        }
+        if (a.cls == float_class_inf || b.cls == float_class_zero) {
+            return a;
+        }
+        if (b.cls == float_class_inf || a.cls == float_class_zero) {
+            b.sign = b_sign;
+            return b;
+        }
+    }
+    g_assert_not_reached();
+}
+
 /*
  * Returns the result of adding or subtracting the floating-point
  * values `a' and `b'. The operation is performed according to the
@@ -1157,6 +1502,26 @@ float64_sub(float64 a, float64 b, float_status *s)
     return float64_addsub(a, b, s, hard_f64_sub, soft_f64_sub);
 }
 
+float128 QEMU_FLATTEN
+float128_add(float128 a, float128 b, float_status *status)
+{
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 pr = addsub_floats128(pa, pb, false, status);
+
+    return float128_round_pack_canonical(pr, status);
+}
+
+float128 QEMU_FLATTEN
+float128_sub(float128 a, float128 b, float_status *status)
+{
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 pr = addsub_floats128(pa, pb, true, status);
+
+    return float128_round_pack_canonical(pr, status);
+}
+
 /*
  * Returns the result of adding or subtracting the bfloat16
  * values `a' and `b'.
@@ -6921,227 +7286,6 @@ float128 float128_round_to_int(float128 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of adding the absolute values of the quadruple-precision
-| floating-point values `a' and `b'.  If `zSign' is 1, the sum is negated
-| before being returned.  `zSign' is ignored if the result is a NaN.
-| The addition is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float128 addFloat128Sigs(float128 a, float128 b, bool zSign,
-                                float_status *status)
-{
-    int32_t aExp, bExp, zExp;
-    uint64_t aSig0, aSig1, bSig0, bSig1, zSig0, zSig1, zSig2;
-    int32_t expDiff;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    bSig1 = extractFloat128Frac1( b );
-    bSig0 = extractFloat128Frac0( b );
-    bExp = extractFloat128Exp( b );
-    expDiff = aExp - bExp;
-    if ( 0 < expDiff ) {
-        if ( aExp == 0x7FFF ) {
-            if (aSig0 | aSig1) {
-                return propagateFloat128NaN(a, b, status);
-            }
-            return a;
-        }
-        if ( bExp == 0 ) {
-            --expDiff;
-        }
-        else {
-            bSig0 |= UINT64_C(0x0001000000000000);
-        }
-        shift128ExtraRightJamming(
-            bSig0, bSig1, 0, expDiff, &bSig0, &bSig1, &zSig2 );
-        zExp = aExp;
-    }
-    else if ( expDiff < 0 ) {
-        if ( bExp == 0x7FFF ) {
-            if (bSig0 | bSig1) {
-                return propagateFloat128NaN(a, b, status);
-            }
-            return packFloat128( zSign, 0x7FFF, 0, 0 );
-        }
-        if ( aExp == 0 ) {
-            ++expDiff;
-        }
-        else {
-            aSig0 |= UINT64_C(0x0001000000000000);
-        }
-        shift128ExtraRightJamming(
-            aSig0, aSig1, 0, - expDiff, &aSig0, &aSig1, &zSig2 );
-        zExp = bExp;
-    }
-    else {
-        if ( aExp == 0x7FFF ) {
-            if ( aSig0 | aSig1 | bSig0 | bSig1 ) {
-                return propagateFloat128NaN(a, b, status);
-            }
-            return a;
-        }
-        add128( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
-        if ( aExp == 0 ) {
-            if (status->flush_to_zero) {
-                if (zSig0 | zSig1) {
-                    float_raise(float_flag_output_denormal, status);
-                }
-                return packFloat128(zSign, 0, 0, 0);
-            }
-            return packFloat128( zSign, 0, zSig0, zSig1 );
-        }
-        zSig2 = 0;
-        zSig0 |= UINT64_C(0x0002000000000000);
-        zExp = aExp;
-        goto shiftRight1;
-    }
-    aSig0 |= UINT64_C(0x0001000000000000);
-    add128( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
-    --zExp;
-    if ( zSig0 < UINT64_C(0x0002000000000000) ) goto roundAndPack;
-    ++zExp;
- shiftRight1:
-    shift128ExtraRightJamming(
-        zSig0, zSig1, zSig2, 1, &zSig0, &zSig1, &zSig2 );
- roundAndPack:
-    return roundAndPackFloat128(zSign, zExp, zSig0, zSig1, zSig2, status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the absolute values of the quadruple-
-| precision floating-point values `a' and `b'.  If `zSign' is 1, the
-| difference is negated before being returned.  `zSign' is ignored if the
-| result is a NaN.  The subtraction is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-static float128 subFloat128Sigs(float128 a, float128 b, bool zSign,
-                                float_status *status)
-{
-    int32_t aExp, bExp, zExp;
-    uint64_t aSig0, aSig1, bSig0, bSig1, zSig0, zSig1;
-    int32_t expDiff;
-
-    aSig1 = extractFloat128Frac1( a );
-    aSig0 = extractFloat128Frac0( a );
-    aExp = extractFloat128Exp( a );
-    bSig1 = extractFloat128Frac1( b );
-    bSig0 = extractFloat128Frac0( b );
-    bExp = extractFloat128Exp( b );
-    expDiff = aExp - bExp;
-    shortShift128Left( aSig0, aSig1, 14, &aSig0, &aSig1 );
-    shortShift128Left( bSig0, bSig1, 14, &bSig0, &bSig1 );
-    if ( 0 < expDiff ) goto aExpBigger;
-    if ( expDiff < 0 ) goto bExpBigger;
-    if ( aExp == 0x7FFF ) {
-        if ( aSig0 | aSig1 | bSig0 | bSig1 ) {
-            return propagateFloat128NaN(a, b, status);
-        }
-        float_raise(float_flag_invalid, status);
-        return float128_default_nan(status);
-    }
-    if ( aExp == 0 ) {
-        aExp = 1;
-        bExp = 1;
-    }
-    if ( bSig0 < aSig0 ) goto aBigger;
-    if ( aSig0 < bSig0 ) goto bBigger;
-    if ( bSig1 < aSig1 ) goto aBigger;
-    if ( aSig1 < bSig1 ) goto bBigger;
-    return packFloat128(status->float_rounding_mode == float_round_down,
-                        0, 0, 0);
- bExpBigger:
-    if ( bExp == 0x7FFF ) {
-        if (bSig0 | bSig1) {
-            return propagateFloat128NaN(a, b, status);
-        }
-        return packFloat128( zSign ^ 1, 0x7FFF, 0, 0 );
-    }
-    if ( aExp == 0 ) {
-        ++expDiff;
-    }
-    else {
-        aSig0 |= UINT64_C(0x4000000000000000);
-    }
-    shift128RightJamming( aSig0, aSig1, - expDiff, &aSig0, &aSig1 );
-    bSig0 |= UINT64_C(0x4000000000000000);
- bBigger:
-    sub128( bSig0, bSig1, aSig0, aSig1, &zSig0, &zSig1 );
-    zExp = bExp;
-    zSign ^= 1;
-    goto normalizeRoundAndPack;
- aExpBigger:
-    if ( aExp == 0x7FFF ) {
-        if (aSig0 | aSig1) {
-            return propagateFloat128NaN(a, b, status);
-        }
-        return a;
-    }
-    if ( bExp == 0 ) {
-        --expDiff;
-    }
-    else {
-        bSig0 |= UINT64_C(0x4000000000000000);
-    }
-    shift128RightJamming( bSig0, bSig1, expDiff, &bSig0, &bSig1 );
-    aSig0 |= UINT64_C(0x4000000000000000);
- aBigger:
-    sub128( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
-    zExp = aExp;
- normalizeRoundAndPack:
-    --zExp;
-    return normalizeRoundAndPackFloat128(zSign, zExp - 14, zSig0, zSig1,
-                                         status);
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of adding the quadruple-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 float128_add(float128 a, float128 b, float_status *status)
-{
-    bool aSign, bSign;
-
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign == bSign ) {
-        return addFloat128Sigs(a, b, aSign, status);
-    }
-    else {
-        return subFloat128Sigs(a, b, aSign, status);
-    }
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the quadruple-precision floating-point
-| values `a' and `b'.  The operation is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-float128 float128_sub(float128 a, float128 b, float_status *status)
-{
-    bool aSign, bSign;
-
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign == bSign ) {
-        return subFloat128Sigs(a, b, aSign, status);
-    }
-    else {
-        return addFloat128Sigs(a, b, aSign, status);
-    }
-
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of multiplying the quadruple-precision floating-point
 | values `a' and `b'.  The operation is performed according to the IEC/IEEE
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index c2f87addb2..347896bf57 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -125,6 +125,16 @@ static bool parts_is_snan_frac(uint64_t frac, float_status *status)
     }
 }
 
+static bool parts128_is_snan_frac(Uint128 frac, float_status *status)
+{
+    if (no_signaling_nans(status)) {
+        return false;
+    } else {
+        bool msb = extract128(frac, DECOMPOSED128_BINARY_POINT - 1, 1);
+        return msb == snan_bit_is_one(status);
+    }
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated deconstructed floating-point NaN.
 *----------------------------------------------------------------------------*/
@@ -169,6 +179,23 @@ static FloatParts parts_default_nan(float_status *status)
     };
 }
 
+static FloatParts128 parts128_default_nan(float_status *status)
+{
+    bool sign = 0;
+    Uint128 frac;
+
+    /* !snan_bit_is_one, set sign and msb */
+    frac = uint128_lshift(1, DECOMPOSED128_BINARY_POINT - 1);
+    sign = 1;
+
+    return (FloatParts128) {
+        .cls = float_class_qnan,
+        .sign = sign,
+        .exp = INT_MAX,
+        .frac = frac
+    };
+}
+
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN from a signalling NaN for the deconstructed
 | floating-point parts.
@@ -191,6 +218,18 @@ static FloatParts parts_silence_nan(FloatParts a, float_status *status)
     return a;
 }
 
+static FloatParts128 parts128_silence_nan(FloatParts128 a, float_status *status)
+{
+    g_assert(!no_signaling_nans(status));
+    if (snan_bit_is_one(status)) {
+        return parts128_default_nan(status);
+    } else {
+        a.frac = uint128_or(a.frac, int128_lshift(1, DECOMPOSED128_BINARY_POINT - 1));
+    }
+    a.cls = float_class_qnan;
+    return a;
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated extended double-precision NaN.
 *----------------------------------------------------------------------------*/
-- 
2.20.1


