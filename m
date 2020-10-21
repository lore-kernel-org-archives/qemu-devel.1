Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2A8C561F8
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8419922200
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p06kQwLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8419922200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6Cc-00005Y-Ao
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 00:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66e-0000qJ-Jc
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:37701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66a-0005ks-9Z
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:12 -0400
Received: by mail-pf1-x42f.google.com with SMTP id 144so751937pfb.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lMJF5WFnPn+3ql6O6oXn1myeHt1X9LIPANXZ/hV9clY=;
 b=p06kQwLO2eznOwkOCu1LzJQadgEu4FH84B+snpg+BKGGqlRK3c6AP9Hd1xwyi1nQZ1
 t1+xUxRnXaE5j9G5VXMWbkhTDe0ynyeJRduIWBtmvjRnDnXu0O/Rf/GREtjhgP99Loio
 4j9U+t4/5cSseYrzwkKl4eFP6F1NFnMUfpW615s/Z6viF0A3s6y1PlNdJfsGAp8cnROQ
 gv85B0Ngk9R/grDuslPgETNU0v5cA1aWCFfeDSkP1KyWrE2QwPvS+zbqprWMQQuXv9GO
 gTmAU8sbLpU78ObdjiMgVvxgwUpeKxiDFLUOK4W12+anwL88lC8yzp7HjAlCjR/YDjYv
 ii2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lMJF5WFnPn+3ql6O6oXn1myeHt1X9LIPANXZ/hV9clY=;
 b=B+bmwpq/z++Xt2N3c2isMQOfvE/SDe9Bm0RNTIs0CUJk4X6udjsDqMIEl/1kDoxNFs
 zo+jCkMkvzI0oTAdu0ab5JeVQMqizqCAGGmZ3vV+NOsUn0L3gsIaegCBpPrBRijau6by
 YxLtC/cafHdK8DDZoOWPvvAYkKTEt2QW/sp5w/20YpPgUchYUBXGwNN5t3sFDqa2PIv2
 0ogY06NX5O5kz5e1GtVGxA8pYTe9ZEabdIl2inSS1UQ7wKpRh3hsPzmi5w4+RvOmZFnx
 Ys4S0KGIwq2hG/b+DE99/AB1U+Mc20xQiEBm31se9vA/ctxqiiz+rTxIGEcE+3vMr3Ce
 D0tA==
X-Gm-Message-State: AOAM532965ZZ09ksJTy34cf1DgzbxM8xBjvf7e3m7JBxDWNx4OGfRDgY
 4ga4xwrUy0qakqc7sz18Af7yOAghsLYQxA==
X-Google-Smtp-Source: ABdhPJyHanNuVEwI4OrWqKGFy5V9+BFifUbHKpirZzQOEpP9bgeE8ss4QtCj7PjYPS0RjQQ/CrU17A==
X-Received: by 2002:a65:50c5:: with SMTP id s5mr1549186pgp.399.1603255926048; 
 Tue, 20 Oct 2020 21:52:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:52:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 11/15] Test split to softfloat-parts.c.inc
Date: Tue, 20 Oct 2020 21:51:45 -0700
Message-Id: <20201021045149.1582203-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

---
 fpu/softfloat.c           | 438 ++++++++------------------------------
 fpu/softfloat-parts.c.inc | 327 ++++++++++++++++++++++++++++
 2 files changed, 421 insertions(+), 344 deletions(-)
 create mode 100644 fpu/softfloat-parts.c.inc

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3e625c47cd..3651f4525d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -651,191 +651,109 @@ static inline float64 float64_pack_raw(FloatParts p)
 *----------------------------------------------------------------------------*/
 #include "softfloat-specialize.c.inc"
 
-/* Canonicalize EXP and FRAC, setting CLS.  */
-static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
-                                  float_status *status)
+static FloatParts return_nan(FloatParts a, float_status *s)
 {
-    if (part.exp == parm->exp_max && !parm->arm_althp) {
-        if (part.frac == 0) {
-            part.cls = float_class_inf;
-        } else {
-            part.frac <<= parm->frac_shift;
-            part.cls = (parts_is_snan_frac(part.frac, status)
-                        ? float_class_snan : float_class_qnan);
-        }
-    } else if (part.exp == 0) {
-        if (likely(part.frac == 0)) {
-            part.cls = float_class_zero;
-        } else if (status->flush_inputs_to_zero) {
-            float_raise(float_flag_input_denormal, status);
-            part.cls = float_class_zero;
-            part.frac = 0;
-        } else {
-            int shift = clz64(part.frac) - 1;
-            part.cls = float_class_normal;
-            part.exp = parm->frac_shift - parm->exp_bias - shift + 1;
-            part.frac <<= shift;
-        }
-    } else {
-        part.cls = float_class_normal;
-        part.exp -= parm->exp_bias;
-        part.frac = DECOMPOSED_IMPLICIT_BIT + (part.frac << parm->frac_shift);
-    }
-    return part;
-}
-
-/* Round and uncanonicalize a floating-point number by parts. There
- * are FRAC_SHIFT bits that may require rounding at the bottom of the
- * fraction; these bits will be removed. The exponent will be biased
- * by EXP_BIAS and must be bounded by [EXP_MAX-1, 0].
- */
-
-static FloatParts round_canonical(FloatParts p, float_status *s,
-                                  const FloatFmt *parm)
-{
-    const uint64_t frac_lsb = parm->frac_lsb;
-    const uint64_t frac_lsbm1 = parm->frac_lsbm1;
-    const uint64_t round_mask = parm->round_mask;
-    const uint64_t roundeven_mask = parm->roundeven_mask;
-    const int exp_max = parm->exp_max;
-    const int frac_shift = parm->frac_shift;
-    uint64_t frac, inc;
-    int exp, flags = 0;
-    bool overflow_norm;
-
-    frac = p.frac;
-    exp = p.exp;
-
-    switch (p.cls) {
-    case float_class_normal:
-        switch (s->float_rounding_mode) {
-        case float_round_nearest_even:
-            overflow_norm = false;
-            inc = ((frac & roundeven_mask) != frac_lsbm1 ? frac_lsbm1 : 0);
-            break;
-        case float_round_ties_away:
-            overflow_norm = false;
-            inc = frac_lsbm1;
-            break;
-        case float_round_to_zero:
-            overflow_norm = true;
-            inc = 0;
-            break;
-        case float_round_up:
-            inc = p.sign ? 0 : round_mask;
-            overflow_norm = p.sign;
-            break;
-        case float_round_down:
-            inc = p.sign ? round_mask : 0;
-            overflow_norm = !p.sign;
-            break;
-        case float_round_to_odd:
-            overflow_norm = true;
-            inc = frac & frac_lsb ? 0 : round_mask;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-
-        exp += parm->exp_bias;
-        if (likely(exp > 0)) {
-            if (frac & round_mask) {
-                flags |= float_flag_inexact;
-                frac += inc;
-                if (frac & DECOMPOSED_OVERFLOW_BIT) {
-                    frac >>= 1;
-                    exp++;
-                }
-            }
-            frac >>= frac_shift;
-
-            if (parm->arm_althp) {
-                /* ARM Alt HP eschews Inf and NaN for a wider exponent.  */
-                if (unlikely(exp > exp_max)) {
-                    /* Overflow.  Return the maximum normal.  */
-                    flags = float_flag_invalid;
-                    exp = exp_max;
-                    frac = -1;
-                }
-            } else if (unlikely(exp >= exp_max)) {
-                flags |= float_flag_overflow | float_flag_inexact;
-                if (overflow_norm) {
-                    exp = exp_max - 1;
-                    frac = -1;
-                } else {
-                    p.cls = float_class_inf;
-                    goto do_inf;
-                }
-            }
-        } else if (s->flush_to_zero) {
-            flags |= float_flag_output_denormal;
-            p.cls = float_class_zero;
-            goto do_zero;
-        } else {
-            bool is_tiny = s->tininess_before_rounding
-                        || (exp < 0)
-                        || !((frac + inc) & DECOMPOSED_OVERFLOW_BIT);
-
-            shift64RightJamming(frac, 1 - exp, &frac);
-            if (frac & round_mask) {
-                /* Need to recompute round-to-even.  */
-                switch (s->float_rounding_mode) {
-                case float_round_nearest_even:
-                    inc = ((frac & roundeven_mask) != frac_lsbm1
-                           ? frac_lsbm1 : 0);
-                    break;
-                case float_round_to_odd:
-                    inc = frac & frac_lsb ? 0 : round_mask;
-                    break;
-                default:
-                    break;
-                }
-                flags |= float_flag_inexact;
-                frac += inc;
-            }
-
-            exp = (frac & DECOMPOSED_IMPLICIT_BIT ? 1 : 0);
-            frac >>= frac_shift;
-
-            if (is_tiny && (flags & float_flag_inexact)) {
-                flags |= float_flag_underflow;
-            }
-            if (exp == 0 && frac == 0) {
-                p.cls = float_class_zero;
-            }
-        }
-        break;
-
-    case float_class_zero:
-    do_zero:
-        exp = 0;
-        frac = 0;
-        break;
-
-    case float_class_inf:
-    do_inf:
-        assert(!parm->arm_althp);
-        exp = exp_max;
-        frac = 0;
-        break;
-
-    case float_class_qnan:
+    switch (a.cls) {
     case float_class_snan:
-        assert(!parm->arm_althp);
-        exp = exp_max;
-        frac >>= parm->frac_shift;
+        s->float_exception_flags |= float_flag_invalid;
+        a = parts_silence_nan(a, s);
+        /* fall through */
+    case float_class_qnan:
+        if (s->default_nan_mode) {
+            return parts_default_nan(s);
+        }
         break;
 
     default:
         g_assert_not_reached();
     }
-
-    float_raise(flags, s);
-    p.exp = exp;
-    p.frac = frac;
-    return p;
+    return a;
 }
 
+static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
+                                  bool inf_zero, float_status *s)
+{
+    int which;
+
+    if (is_snan(a.cls) || is_snan(b.cls) || is_snan(c.cls)) {
+        s->float_exception_flags |= float_flag_invalid;
+    }
+
+    which = pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, s);
+
+    if (s->default_nan_mode) {
+        /* Note that this check is after pickNaNMulAdd so that function
+         * has an opportunity to set the Invalid flag.
+         */
+        which = 3;
+    }
+
+    switch (which) {
+    case 0:
+        break;
+    case 1:
+        a = b;
+        break;
+    case 2:
+        a = c;
+        break;
+    case 3:
+        return parts_default_nan(s);
+    default:
+        g_assert_not_reached();
+    }
+
+    if (is_snan(a.cls)) {
+        return parts_silence_nan(a, s);
+    }
+    return a;
+}
+
+#define FUNC(X)           X
+#define FRAC_TYPE         uint64_t
+#define PARTS_TYPE        FloatParts
+
+#define HI(P)             (P)
+#define LO(P)             (P)
+#define ZERO              0
+#define ONE               1
+#define MONE              -1
+
+#define ADD(P1, P2)       ((P1) + (P2))
+#define ADDI(P, I)        ((P) + (I))
+#define CLZ(P)            clz64(P)
+#define EQ0(P)            ((P) == 0)
+#define EQ(P1, P2)        ((P1) == (P2))
+#define GEU(P1, P2)       ((P1) >= (P2))
+#define OR(P1, P2)        ((P1) | (P2))
+#define SHL(P, C)         ((P) << (C))
+#define SHR(P, C)         ((P) >> (C))
+#define SHR_JAM(P, C) \
+    ({ uint64_t _r; shift64RightJamming((P), (C), &_r); _r; })
+#define SUB(P1, P2)       ((P1) - (P2))
+
+#include "softfloat-parts.c.inc"
+
+#undef FUNC
+#undef FRAC_TYPE
+#undef PARTS_TYPE
+#undef HI
+#undef LO
+#undef ZERO
+#undef MONE
+#undef ONE
+#undef ADD
+#undef ADDI
+#undef CLZ
+#undef EQ0
+#undef EQ
+#undef GEU
+#undef OR
+#undef SHL
+#undef SHR
+#undef SHR_JAM
+#undef SUB
+
 /* Explicit FloatFmt version */
 static FloatParts float16a_unpack_canonical(float16 f, float_status *s,
                                             const FloatFmt *params)
@@ -889,174 +807,6 @@ static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
     return float64_pack_raw(round_canonical(p, s, &float64_params));
 }
 
-static FloatParts return_nan(FloatParts a, float_status *s)
-{
-    switch (a.cls) {
-    case float_class_snan:
-        s->float_exception_flags |= float_flag_invalid;
-        a = parts_silence_nan(a, s);
-        /* fall through */
-    case float_class_qnan:
-        if (s->default_nan_mode) {
-            return parts_default_nan(s);
-        }
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
-    return a;
-}
-
-static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
-{
-    if (is_snan(a.cls) || is_snan(b.cls)) {
-        s->float_exception_flags |= float_flag_invalid;
-    }
-
-    if (s->default_nan_mode) {
-        return parts_default_nan(s);
-    } else {
-        if (pickNaN(a.cls, b.cls,
-                    a.frac > b.frac ||
-                    (a.frac == b.frac && a.sign < b.sign), s)) {
-            a = b;
-        }
-        if (is_snan(a.cls)) {
-            return parts_silence_nan(a, s);
-        }
-    }
-    return a;
-}
-
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
-/*
- * Returns the result of adding or subtracting the values of the
- * floating-point values `a' and `b'. The operation is performed
- * according to the IEC/IEEE Standard for Binary Floating-Point
- * Arithmetic.
- */
-
-static FloatParts addsub_floats(FloatParts a, FloatParts b, bool subtract,
-                                float_status *s)
-{
-    bool a_sign = a.sign;
-    bool b_sign = b.sign ^ subtract;
-
-    if (a_sign != b_sign) {
-        /* Subtraction */
-
-        if (a.cls == float_class_normal && b.cls == float_class_normal) {
-            if (a.exp > b.exp || (a.exp == b.exp && a.frac >= b.frac)) {
-                shift64RightJamming(b.frac, a.exp - b.exp, &b.frac);
-                a.frac = a.frac - b.frac;
-            } else {
-                shift64RightJamming(a.frac, b.exp - a.exp, &a.frac);
-                a.frac = b.frac - a.frac;
-                a.exp = b.exp;
-                a_sign ^= 1;
-            }
-
-            if (a.frac == 0) {
-                a.cls = float_class_zero;
-                a.sign = s->float_rounding_mode == float_round_down;
-            } else {
-                int shift = clz64(a.frac) - 1;
-                a.frac = a.frac << shift;
-                a.exp = a.exp - shift;
-                a.sign = a_sign;
-            }
-            return a;
-        }
-        if (is_nan(a.cls) || is_nan(b.cls)) {
-            return pick_nan(a, b, s);
-        }
-        if (a.cls == float_class_inf) {
-            if (b.cls == float_class_inf) {
-                float_raise(float_flag_invalid, s);
-                return parts_default_nan(s);
-            }
-            return a;
-        }
-        if (a.cls == float_class_zero && b.cls == float_class_zero) {
-            a.sign = s->float_rounding_mode == float_round_down;
-            return a;
-        }
-        if (a.cls == float_class_zero || b.cls == float_class_inf) {
-            b.sign = a_sign ^ 1;
-            return b;
-        }
-        if (b.cls == float_class_zero) {
-            return a;
-        }
-    } else {
-        /* Addition */
-        if (a.cls == float_class_normal && b.cls == float_class_normal) {
-            if (a.exp > b.exp) {
-                shift64RightJamming(b.frac, a.exp - b.exp, &b.frac);
-            } else if (a.exp < b.exp) {
-                shift64RightJamming(a.frac, b.exp - a.exp, &a.frac);
-                a.exp = b.exp;
-            }
-            a.frac += b.frac;
-            if (a.frac & DECOMPOSED_OVERFLOW_BIT) {
-                shift64RightJamming(a.frac, 1, &a.frac);
-                a.exp += 1;
-            }
-            return a;
-        }
-        if (is_nan(a.cls) || is_nan(b.cls)) {
-            return pick_nan(a, b, s);
-        }
-        if (a.cls == float_class_inf || b.cls == float_class_zero) {
-            return a;
-        }
-        if (b.cls == float_class_inf || a.cls == float_class_zero) {
-            b.sign = b_sign;
-            return b;
-        }
-    }
-    g_assert_not_reached();
-}
-
 /*
  * Returns the result of adding or subtracting the floating-point
  * values `a' and `b'. The operation is performed according to the
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
new file mode 100644
index 0000000000..49bde45521
--- /dev/null
+++ b/fpu/softfloat-parts.c.inc
@@ -0,0 +1,327 @@
+/*
+ * QEMU float support
+ *
+ * The code in this source file is derived from release 2a of the SoftFloat
+ * IEC/IEEE Floating-point Arithmetic Package. Those parts of the code (and
+ * some later contributions) are provided under that license, as detailed below.
+ * It has subsequently been modified by contributors to the QEMU Project,
+ * so some portions are provided under:
+ *  the SoftFloat-2a license
+ *  the BSD license
+ *  GPL-v2-or-later
+ *
+ * Any future contributions to this file after December 1st 2014 will be
+ * taken to be licensed under the Softfloat-2a license unless specifically
+ * indicated otherwise.
+ */
+
+static PARTS_TYPE
+FUNC(pick_nan)(PARTS_TYPE a, PARTS_TYPE b, float_status *status)
+{
+    bool a_larger_sig;
+
+    if (is_snan(a.cls) || is_snan(b.cls)) {
+        float_raise(float_flag_invalid, status);
+    }
+
+    if (status->default_nan_mode) {
+        return FUNC(parts_default_nan)(status);
+    }
+
+    if (EQ(a.frac, b.frac)) {
+        a_larger_sig = a.sign < b.sign;
+    } else {
+        a_larger_sig = GEU(a.frac, b.frac);
+    }
+
+    if (pickNaN(a.cls, b.cls, a_larger_sig, status)) {
+        a = b;
+    }
+    if (is_snan(a.cls)) {
+        return FUNC(parts_silence_nan)(a, status);
+    }
+    return a;
+}
+
+/* Canonicalize EXP and FRAC, setting CLS.  */
+static PARTS_TYPE
+FUNC(sf_canonicalize)(PARTS_TYPE p, const FloatFmt *parm, float_status *status)
+{
+    if (p.exp == 0) {
+        if (likely(EQ0(p.frac))) {
+            p.cls = float_class_zero;
+        } else if (status->flush_inputs_to_zero) {
+            float_raise(float_flag_input_denormal, status);
+            p.cls = float_class_zero;
+            p.frac = ZERO;
+        } else {
+            int shift = CLZ(p.frac) - 1;
+            p.cls = float_class_normal;
+            p.exp = parm->frac_shift - parm->exp_bias - shift + 1;
+            p.frac = SHL(p.frac, shift);
+        }
+    } else if (likely(p.exp < parm->exp_max) || parm->arm_althp) {
+        p.cls = float_class_normal;
+        p.exp -= parm->exp_bias;
+        /* Set implicit bit. */
+        p.frac = OR(p.frac, SHL(ONE, parm->frac_size));
+        p.frac = SHL(p.frac, parm->frac_shift);
+    } else if (likely(EQ0(p.frac))) {
+        p.cls = float_class_inf;
+    } else {
+        p.frac = SHL(p.frac, parm->frac_shift);
+        p.cls = (parts_is_snan_frac(HI(p.frac), status)
+                 ? float_class_snan : float_class_qnan);
+    }
+    return p;
+}
+
+/* Round and uncanonicalize a floating-point number by parts. There
+ * are FRAC_SHIFT bits that may require rounding at the bottom of the
+ * fraction; these bits will be removed. The exponent will be biased
+ * by EXP_BIAS and must be bounded by [EXP_MAX-1, 0].
+ */
+
+static PARTS_TYPE
+FUNC(round_canonical)(PARTS_TYPE p, float_status *s, const FloatFmt *parm)
+{
+    const int exp_max = parm->exp_max;
+    const int frac_shift = parm->frac_shift;
+    const uint64_t frac_lsb = 1ull << frac_shift;
+    const uint64_t frac_lsbm1 = 1ull << (frac_shift - 1);
+    const uint64_t round_mask = frac_lsb - 1;
+    const uint64_t roundeven_mask = round_mask | frac_lsb;
+    int flags = 0;
+
+    switch (p.cls) {
+    case float_class_normal:
+        {
+            bool overflow_norm;
+            uint64_t inc, frac_lo;
+            int exp;
+
+            frac_lo = LO(p.frac);
+            switch (s->float_rounding_mode) {
+            case float_round_nearest_even:
+                overflow_norm = false;
+                inc = ((frac_lo & roundeven_mask) != frac_lsbm1
+                       ? frac_lsbm1 : 0);
+                break;
+            case float_round_ties_away:
+                overflow_norm = false;
+                inc = frac_lsbm1;
+                break;
+            case float_round_to_zero:
+                overflow_norm = true;
+                inc = 0;
+                break;
+            case float_round_up:
+                inc = p.sign ? 0 : round_mask;
+                overflow_norm = p.sign;
+                break;
+            case float_round_down:
+                inc = p.sign ? round_mask : 0;
+                overflow_norm = !p.sign;
+                break;
+            case float_round_to_odd:
+                overflow_norm = true;
+                inc = frac_lo & frac_lsb ? 0 : round_mask;
+                break;
+            default:
+                g_assert_not_reached();
+            }
+
+            exp = p.exp + parm->exp_bias;
+            if (likely(exp > 0)) {
+                if (frac_lo & round_mask) {
+                    flags |= float_flag_inexact;
+                    p.frac = ADDI(p.frac, inc);
+                    if (HI(p.frac) & DECOMPOSED_OVERFLOW_BIT) {
+                        p.frac = SHR(p.frac, 1);
+                        exp++;
+                    }
+                }
+                p.frac = SHR(p.frac, frac_shift);
+
+                if (parm->arm_althp) {
+                    /* ARM Alt HP eschews Inf and NaN for a wider exponent.  */
+                    if (unlikely(exp > exp_max)) {
+                        /* Overflow.  Return the maximum normal.  */
+                        flags = float_flag_invalid;
+                        exp = exp_max;
+                        p.frac = MONE;
+                    }
+                } else if (unlikely(exp >= exp_max)) {
+                    flags |= float_flag_overflow | float_flag_inexact;
+                    if (overflow_norm) {
+                        exp = exp_max - 1;
+                        p.frac = MONE;
+                    } else {
+                        p.cls = float_class_inf;
+                        goto do_inf;
+                    }
+                }
+            } else if (s->flush_to_zero) {
+                flags |= float_flag_output_denormal;
+                p.cls = float_class_zero;
+                goto do_zero;
+            } else {
+                bool is_tiny = s->tininess_before_rounding || exp < 0;
+                if (!is_tiny) {
+                    FRAC_TYPE frac_inc = ADDI(p.frac, inc);
+                    if (HI(frac_inc) & DECOMPOSED_OVERFLOW_BIT) {
+                        is_tiny = true;
+                    }
+                }
+
+                p.frac = SHR_JAM(p.frac, 1 - exp);
+                frac_lo = LO(p.frac);
+
+                if (frac_lo & round_mask) {
+                    /* Need to recompute round-to-even / round-to-odd.  */
+                    switch (s->float_rounding_mode) {
+                    case float_round_nearest_even:
+                        inc = ((frac_lo & roundeven_mask) != frac_lsbm1
+                               ? frac_lsbm1 : 0);
+                        break;
+                    case float_round_to_odd:
+                        inc = frac_lo & frac_lsb ? 0 : round_mask;
+                        break;
+                    default:
+                        break;
+                    }
+                    flags |= float_flag_inexact;
+                    p.frac = ADDI(p.frac, inc);
+                }
+
+                exp = (HI(p.frac) & DECOMPOSED_IMPLICIT_BIT ? 1 : 0);
+                p.frac = SHR(p.frac, frac_shift);
+
+                if (is_tiny && (flags & float_flag_inexact)) {
+                    flags |= float_flag_underflow;
+                }
+                if (exp == 0 && EQ0(p.frac)) {
+                    p.cls = float_class_zero;
+                }
+            }
+            p.exp = exp;
+        }
+        break;
+
+    case float_class_zero:
+    do_zero:
+        p.exp = 0;
+        p.frac = ZERO;
+        break;
+
+    case float_class_inf:
+    do_inf:
+        g_assert(!parm->arm_althp);
+        p.exp = exp_max;
+        p.frac = ZERO;
+        break;
+
+    case float_class_qnan:
+    case float_class_snan:
+        g_assert(!parm->arm_althp);
+        p.exp = exp_max;
+        p.frac = SHR(p.frac, parm->frac_shift);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    float_raise(flags, s);
+    return p;
+}
+
+/*
+ * Returns the result of adding or subtracting the values of the
+ * floating-point values `a' and `b'. The operation is performed
+ * according to the IEC/IEEE Standard for Binary Floating-Point
+ * Arithmetic.
+ */
+
+static PARTS_TYPE
+FUNC(addsub_floats)(PARTS_TYPE a, PARTS_TYPE b,
+                    bool subtract, float_status *s)
+{
+    bool a_sign = a.sign;
+    bool b_sign = b.sign ^ subtract;
+
+    if (a_sign != b_sign) {
+        /* Subtraction */
+
+        if (a.cls == float_class_normal && b.cls == float_class_normal) {
+            if (a.exp > b.exp || (a.exp == b.exp && GEU(a.frac, b.frac))) {
+                b.frac = SHR_JAM(b.frac, a.exp - b.exp);
+                a.frac = SUB(a.frac, b.frac);
+            } else {
+                a.frac = SHR_JAM(a.frac, b.exp - a.exp);
+                a.frac = SUB(b.frac, a.frac);
+                a.exp = b.exp;
+                a_sign ^= 1;
+            }
+
+            if (EQ0(a.frac)) {
+                a.cls = float_class_zero;
+                a.sign = s->float_rounding_mode == float_round_down;
+            } else {
+                int shift = CLZ(a.frac) - 1;
+                a.frac = SHL(a.frac, shift);
+                a.exp = a.exp - shift;
+                a.sign = a_sign;
+            }
+            return a;
+        }
+        if (is_nan(a.cls) || is_nan(b.cls)) {
+            return FUNC(pick_nan)(a, b, s);
+        }
+        if (a.cls == float_class_inf) {
+            if (b.cls == float_class_inf) {
+                float_raise(float_flag_invalid, s);
+                return FUNC(parts_default_nan)(s);
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
+                b.frac = SHR_JAM(b.frac, a.exp - b.exp);
+            } else if (a.exp < b.exp) {
+                a.frac = SHR_JAM(a.frac, b.exp - a.exp);
+                a.exp = b.exp;
+            }
+            a.frac = ADD(a.frac, b.frac);
+            if (HI(a.frac) & DECOMPOSED_OVERFLOW_BIT) {
+                a.frac = SHR_JAM(a.frac, 1);
+                a.exp += 1;
+            }
+            return a;
+        }
+        if (is_nan(a.cls) || is_nan(b.cls)) {
+            return FUNC(pick_nan)(a, b, s);
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
-- 
2.25.1


