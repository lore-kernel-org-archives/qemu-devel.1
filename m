Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D686AC55ABD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2236020936
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVaIcjvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2236020936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6Ce-0000AW-0D
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 00:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66e-0000rD-VI
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:12 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66c-0005lx-1l
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:12 -0400
Received: by mail-pj1-x1042.google.com with SMTP id az3so512430pjb.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2g5WBXsxhjyjGqBkwMhniB3E7ybpgM7YqJQ7Mqdt4sE=;
 b=ZVaIcjvf6QMFwdKYwVCUnIkSJgbD2alkXZZf3jyexRcol0WIjdu61C6e0IwDtZ4OHb
 dxm88Si26z70p5wIuV9jRny/pVs+9l5wPY44IPK57iYaat2ir2jdpRgnZYsNeci7NW/q
 zr1LPngenZwAu3KIrIeW2AOpadZh9TiYalBTYolxX49XtmNIGnn/Jgy2jY0LVzeq5a9/
 TIOrKOTdwTm+GintOozVd/5B2WQ1N0KYsvnPuoDq2vk+QE72DxgYnx7ejulI4SeoA+Nn
 GR2hoxpqFsH6tQKgHFSvgwfvP5P/tSmkY1U7Ykxc961rWC9FuzznamkHvO6RrRhCEg/P
 R6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2g5WBXsxhjyjGqBkwMhniB3E7ybpgM7YqJQ7Mqdt4sE=;
 b=MBOB0qEfBZtHJ9cGsb/m9e7qdL1GBUKMAa7fB2Y8zwgynpa+HHV1avjx+ppQQ8JsWU
 44xVgrfaRNnEKAreVEsCd0RcajtV87RY3ORjx//cMCyB0Nrd+TzF4HalUIQQzZ1IYago
 GYSS4gGvasPl72C6E+RJoI8mrXr//znHNA2JBr1RD1EhVnNX2cAV94czD4JhL0WmreiF
 mk2hXk15XHnD08VebMJguWqBa+xQHEADudt9Jvg/HDeym8jgzzpTtH/rXh0l/UT31kE7
 4GXJrz5ZTJNYpbniH5XdpPu0el8G8mfXDn9gdM8BeD9T6cTBWCSsvHF9NrZK0ZgnOZX1
 uryg==
X-Gm-Message-State: AOAM531d9Wnahy+bx5r1TpvsafIbneHi1OrX2pmviYk+o00+1LmwEthw
 ehz9irSht/YoAUc+L3ToYSgWs5YiK0NZBQ==
X-Google-Smtp-Source: ABdhPJxt/HX1Y6x+eDnSr7N7uGk4Z4CQ/xP7ns8tX08QeR0yWO75dohv0SOryPjCTbmLxdbbfPwS3w==
X-Received: by 2002:a17:902:aa8a:b029:d3:c9dd:77d1 with SMTP id
 d10-20020a170902aa8ab02900d3c9dd77d1mr1395677plr.0.1603255927997; 
 Tue, 20 Oct 2020 21:52:07 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:52:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 13/15] Test float128_addsub
Date: Tue, 20 Oct 2020 21:51:47 -0700
Message-Id: <20201021045149.1582203-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
 fpu/softfloat.c                | 310 +++++++++++----------------------
 fpu/softfloat-specialize.c.inc |  33 ++++
 2 files changed, 137 insertions(+), 206 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 1bd21435e7..294c573fb9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -517,6 +517,14 @@ typedef struct {
     bool sign;
 } FloatParts;
 
+/* Similar for float128.  */
+typedef struct {
+    Int128 frac;
+    int32_t exp;
+    FloatClass cls;
+    bool sign;
+} FloatParts128;
+
 #define DECOMPOSED_BINARY_POINT    (64 - 2)
 #define DECOMPOSED_IMPLICIT_BIT    (1ull << DECOMPOSED_BINARY_POINT)
 #define DECOMPOSED_OVERFLOW_BIT    (DECOMPOSED_IMPLICIT_BIT << 1)
@@ -540,13 +548,20 @@ typedef struct {
 } FloatFmt;
 
 /* Expand fields based on the size of exponent and fraction */
-#define FLOAT_PARAMS(E, F)                                           \
+#define FLOAT_PARAMS1(E, F)                                          \
     .exp_size       = E,                                             \
     .exp_bias       = ((1 << E) - 1) >> 1,                           \
     .exp_max        = (1 << E) - 1,                                  \
-    .frac_size      = F,                                             \
+    .frac_size      = F
+
+#define FLOAT_PARAMS(E, F)                                           \
+    FLOAT_PARAMS1(E, F),                                             \
     .frac_shift     = DECOMPOSED_BINARY_POINT - F
 
+#define FLOAT128_PARAMS(E, F)                                        \
+    FLOAT_PARAMS1(E, F),                                             \
+    .frac_shift     = DECOMPOSED_BINARY_POINT + 64 - F
+
 static const FloatFmt float16_params = {
     FLOAT_PARAMS(5, 10)
 };
@@ -568,6 +583,10 @@ static const FloatFmt float64_params = {
     FLOAT_PARAMS(11, 52)
 };
 
+static const FloatFmt float128_params = {
+    FLOAT128_PARAMS(15, 112)
+};
+
 /* Unpack a float to parts, but do not canonicalize.  */
 static inline FloatParts unpack_raw(FloatFmt fmt, uint64_t raw)
 {
@@ -742,6 +761,51 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
 #undef SHR_JAM
 #undef SUB
 
+#define FUNC(X)           X##128
+#define FRAC_TYPE         Int128
+#define PARTS_TYPE        FloatParts128
+
+#define HI(P)             int128_gethi(P)
+#define LO(P)             int128_getlo(P)
+#define ZERO              int128_zero()
+#define MONE              int128_make128(-1, -1)
+#define ONE               int128_one()
+
+#define ADD(P1, P2)       int128_add(P1, P2)
+#define ADDI(P, I)        int128_add(P, int128_make64(I))
+#define CLZ(P)            int128_clz(P)
+#define EQ0(P)            (!int128_nz(P))
+#define EQ(P1, P2)        int128_eq(P1, P2)
+#define GEU(P1, P2)       int128_geu(P1, P2)
+#define OR(P1, P2)        int128_or(P1, P2)
+#define SHL(P, C)         int128_shl(P, C)
+#define SHR(P, C)         int128_shr(P, C)
+#define SHR_JAM(P, C)     \
+    ({ uint64_t _h, _l; shift128RightJamming(HI(P), LO(P), C, &_h, &_l); \
+       int128_make128(_l, _h); })
+#define SUB(P1, P2)       int128_sub(P1, P2)
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
+#undef SHL
+#undef SHR
+#undef SHR_JAM
+#undef SUB
+
 /* Explicit FloatFmt version */
 static FloatParts float16a_unpack_canonical(float16 f, float_status *s,
                                             const FloatFmt *params)
@@ -6664,225 +6728,59 @@ float128 float128_round_to_int(float128 a, float_status *status)
 
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
+static FloatParts128 float128_unpack_raw(float128 f)
 {
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
+    const int f_size = float128_params.frac_size;
+    const int e_size = float128_params.exp_size;
 
+    return (FloatParts128) {
+        .cls = float_class_unclassified,
+        .sign = extract64(f.high, f_size + e_size - 64, 1),
+        .exp = extract64(f.high, f_size - 64, e_size),
+        .frac = int128_make128(f.low, extract64(f.high, 0, f_size - 64))
+    };
 }
 
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
+static float128 float128_pack_raw(FloatParts128 p)
 {
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
+    const int f_size = float128_params.frac_size;
+    const int e_size = float128_params.exp_size;
+    uint64_t h = int128_gethi(p.frac);
+    uint64_t l = int128_getlo(p.frac);
 
+    h = deposit64(h, f_size - 64, e_size, p.exp);
+    h = deposit64(h, f_size + e_size - 64, 1, p.sign);
+    return make_float128(h, l);
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of adding the quadruple-precision floating-point values
-| `a' and `b'.  The operation is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
+static FloatParts128 float128_unpack_canonical(float128 f, float_status *s)
+{
+    return sf_canonicalize128(float128_unpack_raw(f), &float128_params, s);
+}
+
+static float128 float128_round_pack_canonical(FloatParts128 p, float_status *s)
+{
+    return float128_pack_raw(round_canonical128(p, s, &float128_params));
+}
+
+static float128 QEMU_FLATTEN
+float128_addsub(float128 a, float128 b, float_status *status, bool subtract)
+{
+    FloatParts128 pa = float128_unpack_canonical(a, status);
+    FloatParts128 pb = float128_unpack_canonical(b, status);
+    FloatParts128 pr = addsub_floats128(pa, pb, subtract, status);
+
+    return float128_round_pack_canonical(pr, status);
+}
 
 float128 float128_add(float128 a, float128 b, float_status *status)
 {
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
+    return float128_addsub(a, b, status, false);
 }
 
-/*----------------------------------------------------------------------------
-| Returns the result of subtracting the quadruple-precision floating-point
-| values `a' and `b'.  The operation is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
 float128 float128_sub(float128 a, float128 b, float_status *status)
 {
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
+    return float128_addsub(a, b, status, true);
 }
 
 /*----------------------------------------------------------------------------
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 0fe8ce408d..404d38071a 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -169,6 +169,23 @@ static FloatParts parts_default_nan(float_status *status)
     };
 }
 
+static FloatParts128 parts_default_nan128(float_status *status)
+{
+    FloatParts p = parts_default_nan(status);
+
+    /*
+     * Extrapolate from the choices made by parts_default_nan to fill
+     * in the quad-floating format.  Copy the high bits across unchanged,
+     * and replicate the lsb to all lower bits.
+     */
+    return (FloatParts128) {
+        .cls = float_class_qnan,
+        .sign = p.sign,
+        .exp = INT_MAX,
+        .frac = int128_make128(-(p.frac & 1), p.frac)
+    };
+}
+
 /*----------------------------------------------------------------------------
 | Returns a quiet NaN from a signalling NaN for the deconstructed
 | floating-point parts.
@@ -191,6 +208,22 @@ static FloatParts parts_silence_nan(FloatParts a, float_status *status)
     return a;
 }
 
+static FloatParts128 parts_silence_nan128(FloatParts128 a, float_status *s)
+{
+    g_assert(!no_signaling_nans(s));
+#if defined(TARGET_HPPA)
+    g_assert_not_reached();
+#endif
+    if (snan_bit_is_one(s)) {
+        return parts_default_nan128(s);
+    } else {
+        Int128 t = int128_make128(0, 1ULL << (DECOMPOSED_BINARY_POINT - 1));
+        a.frac = int128_or(a.frac, t);
+    }
+    a.cls = float_class_qnan;
+    return a;
+}
+
 /*----------------------------------------------------------------------------
 | The pattern for a default generated extended double-precision NaN.
 *----------------------------------------------------------------------------*/
-- 
2.25.1


