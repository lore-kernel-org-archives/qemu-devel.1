Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53979C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF98B20727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEahNZA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF98B20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZffE-0008My-3s
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfav-0001eo-6x
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:05 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:35493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfar-0001p9-M1
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:04 -0400
Received: by mail-pl1-x635.google.com with SMTP id q16so1277544plr.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 12:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YHyPL++O+/9UgujXQhMp7lR3lO3UfELutowK/5MU6JE=;
 b=gEahNZA+BvLFVDLzKZkFTXDC4VB8IFAxp45q6wj/yWg4T0S+Pu5u9511uQ08Ka7vAK
 umKYqyogVQVwVNTLJYEdETyOkDEVp7hCy4IvG5/LSgVY3JtI463IgU9/VSmsaxIV+e9/
 c/kXrQAEN1RXyTaV6swpWCvMXiQv/Qtdre/H5QYj2uL+TFVeK950CVbwuJoOtDEvQBoM
 BmFL7ubydq+WXakm0cnw3RmABbkneqPxo1MuYe3eHyCmIU3uloAg3jXxH3GcnHAPdz47
 1vHpGCfTdzpNwcWsaAQKIdUEIYkzsS2Ii211NK8lK+NxHWtBvnpiQHaaN1/GulKiawh2
 XiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YHyPL++O+/9UgujXQhMp7lR3lO3UfELutowK/5MU6JE=;
 b=HZLuPdp63D18iGXzlhV8nTY7CyjQ/5IqbbhyIqhKTTgt/Ttog+fjeZ6adPNBa9xPiI
 6N9mz9uNl4Uv/n/F/mgKYLclXlsqbHkGjHbKYUOM6tuUp/0ktK2xrJB5wg1rIOcZ+Kv4
 kRlXf3UHsGqV0aPqvlwaVJ0QRQ0+UjFHRhdsB+IngcVrdJAtlxBYCPQL49bUwf2mx5YN
 4W02sBGnLnGANAj71uPcNzYAhf3t5UyxfJStD50xjLE325vuO50ze85dpiJHoRI8PDt8
 Ui3EIzsgK3aNBAfUPJ45ojY2yDdepATQLyoU6MswR17LkamXYujclcy6NhAyZZZpbamH
 77+A==
X-Gm-Message-State: AOAM530yTzKK5UlpcaV7c3Dusg6B2+7c4pMm5vd8593G1aLOKH7q5mI6
 tqvT7KMcXnxF1bQPYEWmT2iy+gcIplQ=
X-Google-Smtp-Source: ABdhPJwIyHNbITV94XFY7eaY9tUOp1t0Mat2fEbdhwxxnK1BatvqzbhyiVp/SAsStfQ6fI4hrNYioQ==
X-Received: by 2002:a17:90a:7e4:: with SMTP id
 m91mr4962546pjm.155.1589569318407; 
 Fri, 15 May 2020 12:01:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q21sm2485719pfg.131.2020.05.15.12.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 12:01:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] softfloat: Replace flag with bool
Date: Fri, 15 May 2020 12:01:45 -0700
Message-Id: <20200515190153.6017-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515190153.6017-1-richard.henderson@linaro.org>
References: <20200515190153.6017-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

We have had this on the to-do list for quite some time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h |  14 +--
 include/fpu/softfloat-macros.h  |  24 ++--
 include/fpu/softfloat-types.h   |  14 +--
 include/fpu/softfloat.h         |  10 +-
 fpu/softfloat-specialize.inc.c  |  16 +--
 fpu/softfloat.c                 | 190 ++++++++++++++++----------------
 target/arm/sve_helper.c         |   8 +-
 target/arm/vfp_helper.c         |   8 +-
 target/m68k/softfloat.c         |  70 ++++++------
 target/mips/msa_helper.c        |  10 +-
 10 files changed, 174 insertions(+), 190 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index e0baf24c8f..528d7ebd9f 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -74,22 +74,22 @@ static inline void set_floatx80_rounding_precision(int val,
     status->floatx80_rounding_precision = val;
 }
 
-static inline void set_flush_to_zero(flag val, float_status *status)
+static inline void set_flush_to_zero(bool val, float_status *status)
 {
     status->flush_to_zero = val;
 }
 
-static inline void set_flush_inputs_to_zero(flag val, float_status *status)
+static inline void set_flush_inputs_to_zero(bool val, float_status *status)
 {
     status->flush_inputs_to_zero = val;
 }
 
-static inline void set_default_nan_mode(flag val, float_status *status)
+static inline void set_default_nan_mode(bool val, float_status *status)
 {
     status->default_nan_mode = val;
 }
 
-static inline void set_snan_bit_is_one(flag val, float_status *status)
+static inline void set_snan_bit_is_one(bool val, float_status *status)
 {
     status->snan_bit_is_one = val;
 }
@@ -114,17 +114,17 @@ static inline int get_floatx80_rounding_precision(float_status *status)
     return status->floatx80_rounding_precision;
 }
 
-static inline flag get_flush_to_zero(float_status *status)
+static inline bool get_flush_to_zero(float_status *status)
 {
     return status->flush_to_zero;
 }
 
-static inline flag get_flush_inputs_to_zero(float_status *status)
+static inline bool get_flush_inputs_to_zero(float_status *status)
 {
     return status->flush_inputs_to_zero;
 }
 
-static inline flag get_default_nan_mode(float_status *status)
+static inline bool get_default_nan_mode(float_status *status)
 {
     return status->default_nan_mode;
 }
diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 605c4f4bc6..a35ec2893a 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -756,11 +756,9 @@ static inline uint32_t estimateSqrt32(int aExp, uint32_t a)
 | Otherwise, returns 0.
 *----------------------------------------------------------------------------*/
 
-static inline flag eq128( uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1 )
+static inline bool eq128(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1)
 {
-
-    return ( a0 == b0 ) && ( a1 == b1 );
-
+    return a0 == b0 && a1 == b1;
 }
 
 /*----------------------------------------------------------------------------
@@ -769,11 +767,9 @@ static inline flag eq128( uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1 )
 | Otherwise, returns 0.
 *----------------------------------------------------------------------------*/
 
-static inline flag le128( uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1 )
+static inline bool le128(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1)
 {
-
-    return ( a0 < b0 ) || ( ( a0 == b0 ) && ( a1 <= b1 ) );
-
+    return a0 < b0 || (a0 == b0 && a1 <= b1);
 }
 
 /*----------------------------------------------------------------------------
@@ -782,11 +778,9 @@ static inline flag le128( uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1 )
 | returns 0.
 *----------------------------------------------------------------------------*/
 
-static inline flag lt128( uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1 )
+static inline bool lt128(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1)
 {
-
-    return ( a0 < b0 ) || ( ( a0 == b0 ) && ( a1 < b1 ) );
-
+    return a0 < b0 || (a0 == b0 && a1 < b1);
 }
 
 /*----------------------------------------------------------------------------
@@ -795,11 +789,9 @@ static inline flag lt128( uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1 )
 | Otherwise, returns 0.
 *----------------------------------------------------------------------------*/
 
-static inline flag ne128( uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1 )
+static inline bool ne128(uint64_t a0, uint64_t a1, uint64_t b0, uint64_t b1)
 {
-
-    return ( a0 != b0 ) || ( a1 != b1 );
-
+    return a0 != b0 || a1 != b1;
 }
 
 #endif
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 2aae6a89b1..619b875df6 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -80,12 +80,6 @@ this code that are retained.
 #ifndef SOFTFLOAT_TYPES_H
 #define SOFTFLOAT_TYPES_H
 
-/* This 'flag' type must be able to hold at least 0 and 1. It should
- * probably be replaced with 'bool' but the uses would need to be audited
- * to check that they weren't accidentally relying on it being a larger type.
- */
-typedef uint8_t flag;
-
 /*
  * Software IEC/IEEE floating-point types.
  */
@@ -169,12 +163,12 @@ typedef struct float_status {
     uint8_t     float_exception_flags;
     signed char floatx80_rounding_precision;
     /* should denormalised results go to zero and set the inexact flag? */
-    flag flush_to_zero;
+    bool flush_to_zero;
     /* should denormalised inputs go to zero and set the input_denormal flag? */
-    flag flush_inputs_to_zero;
-    flag default_nan_mode;
+    bool flush_inputs_to_zero;
+    bool default_nan_mode;
     /* not always used -- see snan_bit_is_one() in softfloat-specialize.h */
-    flag snan_bit_is_one;
+    bool snan_bit_is_one;
 } float_status;
 
 #endif /* SOFTFLOAT_TYPES_H */
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index ecb8ba0114..3f588da7c7 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -440,7 +440,7 @@ static inline float32 float32_set_sign(float32 a, int sign)
 | significand.
 *----------------------------------------------------------------------------*/
 
-static inline float32 packFloat32(flag zSign, int zExp, uint32_t zSig)
+static inline float32 packFloat32(bool zSign, int zExp, uint32_t zSig)
 {
     return make_float32(
           (((uint32_t)zSign) << 31) + (((uint32_t)zExp) << 23) + zSig);
@@ -722,7 +722,7 @@ static inline int32_t extractFloatx80Exp(floatx80 a)
 | `a'.
 *----------------------------------------------------------------------------*/
 
-static inline flag extractFloatx80Sign(floatx80 a)
+static inline bool extractFloatx80Sign(floatx80 a)
 {
     return a.high >> 15;
 }
@@ -732,7 +732,7 @@ static inline flag extractFloatx80Sign(floatx80 a)
 | extended double-precision floating-point value, returning the result.
 *----------------------------------------------------------------------------*/
 
-static inline floatx80 packFloatx80(flag zSign, int32_t zExp, uint64_t zSig)
+static inline floatx80 packFloatx80(bool zSign, int32_t zExp, uint64_t zSig)
 {
     floatx80 z;
 
@@ -783,7 +783,7 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status);
 | Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
+floatx80 roundAndPackFloatx80(int8_t roundingPrecision, bool zSign,
                               int32_t zExp, uint64_t zSig0, uint64_t zSig1,
                               float_status *status);
 
@@ -797,7 +797,7 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
 *----------------------------------------------------------------------------*/
 
 floatx80 normalizeRoundAndPackFloatx80(int8_t roundingPrecision,
-                                       flag zSign, int32_t zExp,
+                                       bool zSign, int32_t zExp,
                                        uint64_t zSig0, uint64_t zSig1,
                                        float_status *status);
 
diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
index 5ab2fa1941..025ee4f991 100644
--- a/fpu/softfloat-specialize.inc.c
+++ b/fpu/softfloat-specialize.inc.c
@@ -93,7 +93,7 @@ this code that are retained.
  * 2008 revision and backward compatibility with their original choice.
  * Thus for MIPS we must make the choice at runtime.
  */
-static inline flag snan_bit_is_one(float_status *status)
+static inline bool snan_bit_is_one(float_status *status)
 {
 #if defined(TARGET_MIPS)
     return status->snan_bit_is_one;
@@ -114,7 +114,7 @@ static bool parts_is_snan_frac(uint64_t frac, float_status *status)
 #ifdef NO_SIGNALING_NANS
     return false;
 #else
-    flag msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
+    bool msb = extract64(frac, DECOMPOSED_BINARY_POINT - 1, 1);
     return msb == snan_bit_is_one(status);
 #endif
 }
@@ -236,7 +236,7 @@ void float_raise(uint8_t flags, float_status *status)
 | Internal canonical NaN format.
 *----------------------------------------------------------------------------*/
 typedef struct {
-    flag sign;
+    bool sign;
     uint64_t high, low;
 } commonNaNT;
 
@@ -374,7 +374,7 @@ static float32 commonNaNToFloat32(commonNaNT a, float_status *status)
 *----------------------------------------------------------------------------*/
 
 static int pickNaN(FloatClass a_cls, FloatClass b_cls,
-                   flag aIsLargerSignificand)
+                   bool aIsLargerSignificand)
 {
 #if defined(TARGET_ARM) || defined(TARGET_MIPS) || defined(TARGET_HPPA)
     /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take
@@ -584,7 +584,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
 
 static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
 {
-    flag aIsLargerSignificand;
+    bool aIsLargerSignificand;
     uint32_t av, bv;
     FloatClass a_cls, b_cls;
 
@@ -722,7 +722,7 @@ static float64 commonNaNToFloat64(commonNaNT a, float_status *status)
 
 static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
 {
-    flag aIsLargerSignificand;
+    bool aIsLargerSignificand;
     uint64_t av, bv;
     FloatClass a_cls, b_cls;
 
@@ -890,7 +890,7 @@ static floatx80 commonNaNToFloatx80(commonNaNT a, float_status *status)
 
 floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aIsLargerSignificand;
+    bool aIsLargerSignificand;
     FloatClass a_cls, b_cls;
 
     /* This is not complete, but is good enough for pickNaN.  */
@@ -1038,7 +1038,7 @@ static float128 commonNaNToFloat128(commonNaNT a, float_status *status)
 static float128 propagateFloat128NaN(float128 a, float128 b,
                                      float_status *status)
 {
-    flag aIsLargerSignificand;
+    bool aIsLargerSignificand;
     FloatClass a_cls, b_cls;
 
     /* This is not complete, but is good enough for pickNaN.  */
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5fb4ef75bb..b741cf5bc3 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -423,7 +423,7 @@ static inline int extractFloat32Exp(float32 a)
 | Returns the sign bit of the single-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
 
-static inline flag extractFloat32Sign(float32 a)
+static inline bool extractFloat32Sign(float32 a)
 {
     return float32_val(a) >> 31;
 }
@@ -450,7 +450,7 @@ static inline int extractFloat64Exp(float64 a)
 | Returns the sign bit of the double-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
 
-static inline flag extractFloat64Sign(float64 a)
+static inline bool extractFloat64Sign(float64 a)
 {
     return float64_val(a) >> 63;
 }
@@ -3328,10 +3328,11 @@ float64 float64_squash_input_denormal(float64 a, float_status *status)
 | positive or negative integer is returned.
 *----------------------------------------------------------------------------*/
 
-static int32_t roundAndPackInt32(flag zSign, uint64_t absZ, float_status *status)
+static int32_t roundAndPackInt32(bool zSign, uint64_t absZ,
+                                 float_status *status)
 {
     int8_t roundingMode;
-    flag roundNearestEven;
+    bool roundNearestEven;
     int8_t roundIncrement, roundBits;
     int32_t z;
 
@@ -3385,11 +3386,11 @@ static int32_t roundAndPackInt32(flag zSign, uint64_t absZ, float_status *status
 | returned.
 *----------------------------------------------------------------------------*/
 
-static int64_t roundAndPackInt64(flag zSign, uint64_t absZ0, uint64_t absZ1,
+static int64_t roundAndPackInt64(bool zSign, uint64_t absZ0, uint64_t absZ1,
                                float_status *status)
 {
     int8_t roundingMode;
-    flag roundNearestEven, increment;
+    bool roundNearestEven, increment;
     int64_t z;
 
     roundingMode = status->float_rounding_mode;
@@ -3443,11 +3444,11 @@ static int64_t roundAndPackInt64(flag zSign, uint64_t absZ0, uint64_t absZ1,
 | exception is raised and the largest unsigned integer is returned.
 *----------------------------------------------------------------------------*/
 
-static int64_t roundAndPackUint64(flag zSign, uint64_t absZ0,
+static int64_t roundAndPackUint64(bool zSign, uint64_t absZ0,
                                 uint64_t absZ1, float_status *status)
 {
     int8_t roundingMode;
-    flag roundNearestEven, increment;
+    bool roundNearestEven, increment;
 
     roundingMode = status->float_rounding_mode;
     roundNearestEven = (roundingMode == float_round_nearest_even);
@@ -3531,13 +3532,13 @@ static void
 | Binary Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-static float32 roundAndPackFloat32(flag zSign, int zExp, uint32_t zSig,
+static float32 roundAndPackFloat32(bool zSign, int zExp, uint32_t zSig,
                                    float_status *status)
 {
     int8_t roundingMode;
-    flag roundNearestEven;
+    bool roundNearestEven;
     int8_t roundIncrement, roundBits;
-    flag isTiny;
+    bool isTiny;
 
     roundingMode = status->float_rounding_mode;
     roundNearestEven = ( roundingMode == float_round_nearest_even );
@@ -3618,7 +3619,7 @@ static float32 roundAndPackFloat32(flag zSign, int zExp, uint32_t zSig,
 *----------------------------------------------------------------------------*/
 
 static float32
- normalizeRoundAndPackFloat32(flag zSign, int zExp, uint32_t zSig,
+ normalizeRoundAndPackFloat32(bool zSign, int zExp, uint32_t zSig,
                               float_status *status)
 {
     int8_t shiftCount;
@@ -3658,7 +3659,7 @@ static void
 | significand.
 *----------------------------------------------------------------------------*/
 
-static inline float64 packFloat64(flag zSign, int zExp, uint64_t zSig)
+static inline float64 packFloat64(bool zSign, int zExp, uint64_t zSig)
 {
 
     return make_float64(
@@ -3688,13 +3689,13 @@ static inline float64 packFloat64(flag zSign, int zExp, uint64_t zSig)
 | Binary Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
+static float64 roundAndPackFloat64(bool zSign, int zExp, uint64_t zSig,
                                    float_status *status)
 {
     int8_t roundingMode;
-    flag roundNearestEven;
+    bool roundNearestEven;
     int roundIncrement, roundBits;
-    flag isTiny;
+    bool isTiny;
 
     roundingMode = status->float_rounding_mode;
     roundNearestEven = ( roundingMode == float_round_nearest_even );
@@ -3774,7 +3775,7 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
 *----------------------------------------------------------------------------*/
 
 static float64
- normalizeRoundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
+ normalizeRoundAndPackFloat64(bool zSign, int zExp, uint64_t zSig,
                               float_status *status)
 {
     int8_t shiftCount;
@@ -3826,12 +3827,12 @@ void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
 | Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
+floatx80 roundAndPackFloatx80(int8_t roundingPrecision, bool zSign,
                               int32_t zExp, uint64_t zSig0, uint64_t zSig1,
                               float_status *status)
 {
     int8_t roundingMode;
-    flag roundNearestEven, increment, isTiny;
+    bool roundNearestEven, increment, isTiny;
     int64_t roundIncrement, roundMask, roundBits;
 
     roundingMode = status->float_rounding_mode;
@@ -4025,7 +4026,7 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
 *----------------------------------------------------------------------------*/
 
 floatx80 normalizeRoundAndPackFloatx80(int8_t roundingPrecision,
-                                       flag zSign, int32_t zExp,
+                                       bool zSign, int32_t zExp,
                                        uint64_t zSig0, uint64_t zSig1,
                                        float_status *status)
 {
@@ -4084,11 +4085,9 @@ static inline int32_t extractFloat128Exp( float128 a )
 | Returns the sign bit of the quadruple-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
 
-static inline flag extractFloat128Sign( float128 a )
+static inline bool extractFloat128Sign(float128 a)
 {
-
-    return a.high>>63;
-
+    return a.high >> 63;
 }
 
 /*----------------------------------------------------------------------------
@@ -4146,14 +4145,13 @@ static void
 *----------------------------------------------------------------------------*/
 
 static inline float128
- packFloat128( flag zSign, int32_t zExp, uint64_t zSig0, uint64_t zSig1 )
+packFloat128(bool zSign, int32_t zExp, uint64_t zSig0, uint64_t zSig1)
 {
     float128 z;
 
     z.low = zSig1;
-    z.high = ( ( (uint64_t) zSign )<<63 ) + ( ( (uint64_t) zExp )<<48 ) + zSig0;
+    z.high = ((uint64_t)zSign << 63) + ((uint64_t)zExp << 48) + zSig0;
     return z;
-
 }
 
 /*----------------------------------------------------------------------------
@@ -4177,12 +4175,12 @@ static inline float128
 | overflow follows the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
+static float128 roundAndPackFloat128(bool zSign, int32_t zExp,
                                      uint64_t zSig0, uint64_t zSig1,
                                      uint64_t zSig2, float_status *status)
 {
     int8_t roundingMode;
-    flag roundNearestEven, increment, isTiny;
+    bool roundNearestEven, increment, isTiny;
 
     roundingMode = status->float_rounding_mode;
     roundNearestEven = ( roundingMode == float_round_nearest_even );
@@ -4302,7 +4300,7 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
 | point exponent.
 *----------------------------------------------------------------------------*/
 
-static float128 normalizeRoundAndPackFloat128(flag zSign, int32_t zExp,
+static float128 normalizeRoundAndPackFloat128(bool zSign, int32_t zExp,
                                               uint64_t zSig0, uint64_t zSig1,
                                               float_status *status)
 {
@@ -4338,7 +4336,7 @@ static float128 normalizeRoundAndPackFloat128(flag zSign, int32_t zExp,
 
 floatx80 int32_to_floatx80(int32_t a, float_status *status)
 {
-    flag zSign;
+    bool zSign;
     uint32_t absA;
     int8_t shiftCount;
     uint64_t zSig;
@@ -4360,7 +4358,7 @@ floatx80 int32_to_floatx80(int32_t a, float_status *status)
 
 float128 int32_to_float128(int32_t a, float_status *status)
 {
-    flag zSign;
+    bool zSign;
     uint32_t absA;
     int8_t shiftCount;
     uint64_t zSig0;
@@ -4383,7 +4381,7 @@ float128 int32_to_float128(int32_t a, float_status *status)
 
 floatx80 int64_to_floatx80(int64_t a, float_status *status)
 {
-    flag zSign;
+    bool zSign;
     uint64_t absA;
     int8_t shiftCount;
 
@@ -4403,7 +4401,7 @@ floatx80 int64_to_floatx80(int64_t a, float_status *status)
 
 float128 int64_to_float128(int64_t a, float_status *status)
 {
-    flag zSign;
+    bool zSign;
     uint64_t absA;
     int8_t shiftCount;
     int32_t zExp;
@@ -4451,7 +4449,7 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
 
 floatx80 float32_to_floatx80(float32 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int aExp;
     uint32_t aSig;
 
@@ -4487,7 +4485,7 @@ floatx80 float32_to_floatx80(float32 a, float_status *status)
 
 float128 float32_to_float128(float32 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int aExp;
     uint32_t aSig;
 
@@ -4518,7 +4516,7 @@ float128 float32_to_float128(float32 a, float_status *status)
 
 float32 float32_rem(float32 a, float32 b, float_status *status)
 {
-    flag aSign, zSign;
+    bool aSign, zSign;
     int aExp, bExp, expDiff;
     uint32_t aSig, bSig;
     uint32_t q;
@@ -4653,7 +4651,7 @@ static const float64 float32_exp2_coefficients[15] =
 
 float32 float32_exp2(float32 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int aExp;
     uint32_t aSig;
     float64 r, x, xn;
@@ -4703,7 +4701,7 @@ float32 float32_exp2(float32 a, float_status *status)
 *----------------------------------------------------------------------------*/
 float32 float32_log2(float32 a, float_status *status)
 {
-    flag aSign, zSign;
+    bool aSign, zSign;
     int aExp;
     uint32_t aSig, zSig, i;
 
@@ -4779,7 +4777,7 @@ int float32_eq(float32 a, float32 b, float_status *status)
 
 int float32_le(float32 a, float32 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
     uint32_t av, bv;
     a = float32_squash_input_denormal(a, status);
     b = float32_squash_input_denormal(b, status);
@@ -4808,7 +4806,7 @@ int float32_le(float32 a, float32 b, float_status *status)
 
 int float32_lt(float32 a, float32 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
     uint32_t av, bv;
     a = float32_squash_input_denormal(a, status);
     b = float32_squash_input_denormal(b, status);
@@ -4883,7 +4881,7 @@ int float32_eq_quiet(float32 a, float32 b, float_status *status)
 
 int float32_le_quiet(float32 a, float32 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
     uint32_t av, bv;
     a = float32_squash_input_denormal(a, status);
     b = float32_squash_input_denormal(b, status);
@@ -4915,7 +4913,7 @@ int float32_le_quiet(float32 a, float32 b, float_status *status)
 
 int float32_lt_quiet(float32 a, float32 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
     uint32_t av, bv;
     a = float32_squash_input_denormal(a, status);
     b = float32_squash_input_denormal(b, status);
@@ -4971,7 +4969,7 @@ int float32_unordered_quiet(float32 a, float32 b, float_status *status)
 
 floatx80 float64_to_floatx80(float64 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int aExp;
     uint64_t aSig;
 
@@ -5008,7 +5006,7 @@ floatx80 float64_to_floatx80(float64 a, float_status *status)
 
 float128 float64_to_float128(float64 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int aExp;
     uint64_t aSig, zSig0, zSig1;
 
@@ -5041,7 +5039,7 @@ float128 float64_to_float128(float64 a, float_status *status)
 
 float64 float64_rem(float64 a, float64 b, float_status *status)
 {
-    flag aSign, zSign;
+    bool aSign, zSign;
     int aExp, bExp, expDiff;
     uint64_t aSig, bSig;
     uint64_t q, alternateASig;
@@ -5128,7 +5126,7 @@ float64 float64_rem(float64 a, float64 b, float_status *status)
 *----------------------------------------------------------------------------*/
 float64 float64_log2(float64 a, float_status *status)
 {
-    flag aSign, zSign;
+    bool aSign, zSign;
     int aExp;
     uint64_t aSig, aSig0, aSig1, zSig, i;
     a = float64_squash_input_denormal(a, status);
@@ -5204,7 +5202,7 @@ int float64_eq(float64 a, float64 b, float_status *status)
 
 int float64_le(float64 a, float64 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
     uint64_t av, bv;
     a = float64_squash_input_denormal(a, status);
     b = float64_squash_input_denormal(b, status);
@@ -5233,7 +5231,7 @@ int float64_le(float64 a, float64 b, float_status *status)
 
 int float64_lt(float64 a, float64 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
     uint64_t av, bv;
 
     a = float64_squash_input_denormal(a, status);
@@ -5311,7 +5309,7 @@ int float64_eq_quiet(float64 a, float64 b, float_status *status)
 
 int float64_le_quiet(float64 a, float64 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
     uint64_t av, bv;
     a = float64_squash_input_denormal(a, status);
     b = float64_squash_input_denormal(b, status);
@@ -5343,7 +5341,7 @@ int float64_le_quiet(float64 a, float64 b, float_status *status)
 
 int float64_lt_quiet(float64 a, float64 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
     uint64_t av, bv;
     a = float64_squash_input_denormal(a, status);
     b = float64_squash_input_denormal(b, status);
@@ -5402,7 +5400,7 @@ int float64_unordered_quiet(float64 a, float64 b, float_status *status)
 
 int32_t floatx80_to_int32(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp, shiftCount;
     uint64_t aSig;
 
@@ -5433,7 +5431,7 @@ int32_t floatx80_to_int32(floatx80 a, float_status *status)
 
 int32_t floatx80_to_int32_round_to_zero(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp, shiftCount;
     uint64_t aSig, savedASig;
     int32_t z;
@@ -5484,7 +5482,7 @@ int32_t floatx80_to_int32_round_to_zero(floatx80 a, float_status *status)
 
 int64_t floatx80_to_int64(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp, shiftCount;
     uint64_t aSig, aSigExtra;
 
@@ -5525,7 +5523,7 @@ int64_t floatx80_to_int64(floatx80 a, float_status *status)
 
 int64_t floatx80_to_int64_round_to_zero(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp, shiftCount;
     uint64_t aSig;
     int64_t z;
@@ -5572,7 +5570,7 @@ int64_t floatx80_to_int64_round_to_zero(floatx80 a, float_status *status)
 
 float32 floatx80_to_float32(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -5606,7 +5604,7 @@ float32 floatx80_to_float32(floatx80 a, float_status *status)
 
 float64 floatx80_to_float64(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig, zSig;
 
@@ -5640,7 +5638,7 @@ float64 floatx80_to_float64(floatx80 a, float_status *status)
 
 float128 floatx80_to_float128(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int aExp;
     uint64_t aSig, zSig0, zSig1;
 
@@ -5686,7 +5684,7 @@ floatx80 floatx80_round(floatx80 a, float_status *status)
 
 floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t lastBitMask, roundBitsMask;
     floatx80 z;
@@ -5783,7 +5781,7 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
 | Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
+static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, bool zSign,
                                 float_status *status)
 {
     int32_t aExp, bExp, zExp;
@@ -5863,7 +5861,7 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
 | Standard for Binary Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-static floatx80 subFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
+static floatx80 subFloatx80Sigs(floatx80 a, floatx80 b, bool zSign,
                                 float_status *status)
 {
     int32_t aExp, bExp, zExp;
@@ -5932,7 +5930,7 @@ static floatx80 subFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
 
 floatx80 floatx80_add(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
         float_raise(float_flag_invalid, status);
@@ -5957,7 +5955,7 @@ floatx80 floatx80_add(floatx80 a, floatx80 b, float_status *status)
 
 floatx80 floatx80_sub(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
         float_raise(float_flag_invalid, status);
@@ -5982,7 +5980,7 @@ floatx80 floatx80_sub(floatx80 a, floatx80 b, float_status *status)
 
 floatx80 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, bSign, zSign;
+    bool aSign, bSign, zSign;
     int32_t aExp, bExp, zExp;
     uint64_t aSig, bSig, zSig0, zSig1;
 
@@ -6044,7 +6042,7 @@ floatx80 floatx80_mul(floatx80 a, floatx80 b, float_status *status)
 
 floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, bSign, zSign;
+    bool aSign, bSign, zSign;
     int32_t aExp, bExp, zExp;
     uint64_t aSig, bSig, zSig0, zSig1;
     uint64_t rem0, rem1, rem2, term0, term1, term2;
@@ -6131,7 +6129,7 @@ floatx80 floatx80_div(floatx80 a, floatx80 b, float_status *status)
 
 floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, zSign;
+    bool aSign, zSign;
     int32_t aExp, bExp, expDiff;
     uint64_t aSig0, aSig1, bSig;
     uint64_t q, term0, term1, alternateASig0, alternateASig1;
@@ -6230,7 +6228,7 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
 
 floatx80 floatx80_sqrt(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp, zExp;
     uint64_t aSig0, aSig1, zSig0, zSig1, doubleZSig0;
     uint64_t rem0, rem1, rem2, rem3, term0, term1, term2, term3;
@@ -6331,7 +6329,7 @@ int floatx80_eq(floatx80 a, floatx80 b, float_status *status)
 
 int floatx80_le(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
         || (extractFloatx80Exp(a) == 0x7FFF
@@ -6365,7 +6363,7 @@ int floatx80_le(floatx80 a, floatx80 b, float_status *status)
 
 int floatx80_lt(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
         || (extractFloatx80Exp(a) == 0x7FFF
@@ -6453,7 +6451,7 @@ int floatx80_eq_quiet(floatx80 a, floatx80 b, float_status *status)
 
 int floatx80_le_quiet(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
         float_raise(float_flag_invalid, status);
@@ -6493,7 +6491,7 @@ int floatx80_le_quiet(floatx80 a, floatx80 b, float_status *status)
 
 int floatx80_lt_quiet(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
         float_raise(float_flag_invalid, status);
@@ -6562,7 +6560,7 @@ int floatx80_unordered_quiet(floatx80 a, floatx80 b, float_status *status)
 
 int32_t float128_to_int32(float128 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp, shiftCount;
     uint64_t aSig0, aSig1;
 
@@ -6591,7 +6589,7 @@ int32_t float128_to_int32(float128 a, float_status *status)
 
 int32_t float128_to_int32_round_to_zero(float128 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp, shiftCount;
     uint64_t aSig0, aSig1, savedASig;
     int32_t z;
@@ -6641,7 +6639,7 @@ int32_t float128_to_int32_round_to_zero(float128 a, float_status *status)
 
 int64_t float128_to_int64(float128 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp, shiftCount;
     uint64_t aSig0, aSig1;
 
@@ -6684,7 +6682,7 @@ int64_t float128_to_int64(float128 a, float_status *status)
 
 int64_t float128_to_int64_round_to_zero(float128 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp, shiftCount;
     uint64_t aSig0, aSig1;
     int64_t z;
@@ -6749,7 +6747,7 @@ int64_t float128_to_int64_round_to_zero(float128 a, float_status *status)
 
 uint64_t float128_to_uint64(float128 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int aExp;
     int shiftCount;
     uint64_t aSig0, aSig1;
@@ -6860,7 +6858,7 @@ uint32_t float128_to_uint32(float128 a, float_status *status)
 
 float32 float128_to_float32(float128 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig0, aSig1;
     uint32_t zSig;
@@ -6895,7 +6893,7 @@ float32 float128_to_float32(float128 a, float_status *status)
 
 float64 float128_to_float64(float128 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig0, aSig1;
 
@@ -6928,7 +6926,7 @@ float64 float128_to_float64(float128 a, float_status *status)
 
 floatx80 float128_to_floatx80(float128 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig0, aSig1;
 
@@ -6966,7 +6964,7 @@ floatx80 float128_to_floatx80(float128 a, float_status *status)
 
 float128 float128_round_to_int(float128 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t lastBitMask, roundBitsMask;
     float128 z;
@@ -7121,7 +7119,7 @@ float128 float128_round_to_int(float128 a, float_status *status)
 | Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-static float128 addFloat128Sigs(float128 a, float128 b, flag zSign,
+static float128 addFloat128Sigs(float128 a, float128 b, bool zSign,
                                 float_status *status)
 {
     int32_t aExp, bExp, zExp;
@@ -7212,7 +7210,7 @@ static float128 addFloat128Sigs(float128 a, float128 b, flag zSign,
 | Standard for Binary Floating-Point Arithmetic.
 *----------------------------------------------------------------------------*/
 
-static float128 subFloat128Sigs(float128 a, float128 b, flag zSign,
+static float128 subFloat128Sigs(float128 a, float128 b, bool zSign,
                                 float_status *status)
 {
     int32_t aExp, bExp, zExp;
@@ -7300,7 +7298,7 @@ static float128 subFloat128Sigs(float128 a, float128 b, flag zSign,
 
 float128 float128_add(float128 a, float128 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     aSign = extractFloat128Sign( a );
     bSign = extractFloat128Sign( b );
@@ -7321,7 +7319,7 @@ float128 float128_add(float128 a, float128 b, float_status *status)
 
 float128 float128_sub(float128 a, float128 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     aSign = extractFloat128Sign( a );
     bSign = extractFloat128Sign( b );
@@ -7342,7 +7340,7 @@ float128 float128_sub(float128 a, float128 b, float_status *status)
 
 float128 float128_mul(float128 a, float128 b, float_status *status)
 {
-    flag aSign, bSign, zSign;
+    bool aSign, bSign, zSign;
     int32_t aExp, bExp, zExp;
     uint64_t aSig0, aSig1, bSig0, bSig1, zSig0, zSig1, zSig2, zSig3;
 
@@ -7405,7 +7403,7 @@ float128 float128_mul(float128 a, float128 b, float_status *status)
 
 float128 float128_div(float128 a, float128 b, float_status *status)
 {
-    flag aSign, bSign, zSign;
+    bool aSign, bSign, zSign;
     int32_t aExp, bExp, zExp;
     uint64_t aSig0, aSig1, bSig0, bSig1, zSig0, zSig1, zSig2;
     uint64_t rem0, rem1, rem2, rem3, term0, term1, term2, term3;
@@ -7492,7 +7490,7 @@ float128 float128_div(float128 a, float128 b, float_status *status)
 
 float128 float128_rem(float128 a, float128 b, float_status *status)
 {
-    flag aSign, zSign;
+    bool aSign, zSign;
     int32_t aExp, bExp, expDiff;
     uint64_t aSig0, aSig1, bSig0, bSig1, q, term0, term1, term2;
     uint64_t allZero, alternateASig0, alternateASig1, sigMean1;
@@ -7599,7 +7597,7 @@ float128 float128_rem(float128 a, float128 b, float_status *status)
 
 float128 float128_sqrt(float128 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp, zExp;
     uint64_t aSig0, aSig1, zSig0, zSig1, zSig2, doubleZSig0;
     uint64_t rem0, rem1, rem2, rem3, term0, term1, term2, term3;
@@ -7695,7 +7693,7 @@ int float128_eq(float128 a, float128 b, float_status *status)
 
 int float128_le(float128 a, float128 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
               && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
@@ -7728,7 +7726,7 @@ int float128_le(float128 a, float128 b, float_status *status)
 
 int float128_lt(float128 a, float128 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
               && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
@@ -7811,7 +7809,7 @@ int float128_eq_quiet(float128 a, float128 b, float_status *status)
 
 int float128_le_quiet(float128 a, float128 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
               && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
@@ -7847,7 +7845,7 @@ int float128_le_quiet(float128 a, float128 b, float_status *status)
 
 int float128_lt_quiet(float128 a, float128 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
               && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
@@ -7900,7 +7898,7 @@ int float128_unordered_quiet(float128 a, float128 b, float_status *status)
 static inline int floatx80_compare_internal(floatx80 a, floatx80 b,
                                             int is_quiet, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
         float_raise(float_flag_invalid, status);
@@ -7957,7 +7955,7 @@ int floatx80_compare_quiet(floatx80 a, floatx80 b, float_status *status)
 static inline int float128_compare_internal(float128 a, float128 b,
                                             int is_quiet, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
 
     if (( ( extractFloat128Exp( a ) == 0x7fff ) &&
           ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) ) ||
@@ -8000,7 +7998,7 @@ int float128_compare_quiet(float128 a, float128 b, float_status *status)
 
 floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -8039,7 +8037,7 @@ floatx80 floatx80_scalbn(floatx80 a, int n, float_status *status)
 
 float128 float128_scalbn(float128 a, int n, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig0, aSig1;
 
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 0da254d402..e590db6637 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3201,7 +3201,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vg, void *status, uint32_t desc) \
  */
 static inline float32 sve_f16_to_f32(float16 f, float_status *fpst)
 {
-    flag save = get_flush_inputs_to_zero(fpst);
+    bool save = get_flush_inputs_to_zero(fpst);
     float32 ret;
 
     set_flush_inputs_to_zero(false, fpst);
@@ -3212,7 +3212,7 @@ static inline float32 sve_f16_to_f32(float16 f, float_status *fpst)
 
 static inline float64 sve_f16_to_f64(float16 f, float_status *fpst)
 {
-    flag save = get_flush_inputs_to_zero(fpst);
+    bool save = get_flush_inputs_to_zero(fpst);
     float64 ret;
 
     set_flush_inputs_to_zero(false, fpst);
@@ -3223,7 +3223,7 @@ static inline float64 sve_f16_to_f64(float16 f, float_status *fpst)
 
 static inline float16 sve_f32_to_f16(float32 f, float_status *fpst)
 {
-    flag save = get_flush_to_zero(fpst);
+    bool save = get_flush_to_zero(fpst);
     float16 ret;
 
     set_flush_to_zero(false, fpst);
@@ -3234,7 +3234,7 @@ static inline float16 sve_f32_to_f16(float32 f, float_status *fpst)
 
 static inline float16 sve_f64_to_f16(float64 f, float_status *fpst)
 {
-    flag save = get_flush_to_zero(fpst);
+    bool save = get_flush_to_zero(fpst);
     float16 ret;
 
     set_flush_to_zero(false, fpst);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 88483d4066..42625747d1 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -531,7 +531,7 @@ float32 HELPER(vfp_fcvt_f16_to_f32)(uint32_t a, void *fpstp, uint32_t ahp_mode)
      * it would affect flushing input denormals.
      */
     float_status *fpst = fpstp;
-    flag save = get_flush_inputs_to_zero(fpst);
+    bool save = get_flush_inputs_to_zero(fpst);
     set_flush_inputs_to_zero(false, fpst);
     float32 r = float16_to_float32(a, !ahp_mode, fpst);
     set_flush_inputs_to_zero(save, fpst);
@@ -544,7 +544,7 @@ uint32_t HELPER(vfp_fcvt_f32_to_f16)(float32 a, void *fpstp, uint32_t ahp_mode)
      * it would affect flushing output denormals.
      */
     float_status *fpst = fpstp;
-    flag save = get_flush_to_zero(fpst);
+    bool save = get_flush_to_zero(fpst);
     set_flush_to_zero(false, fpst);
     float16 r = float32_to_float16(a, !ahp_mode, fpst);
     set_flush_to_zero(save, fpst);
@@ -557,7 +557,7 @@ float64 HELPER(vfp_fcvt_f16_to_f64)(uint32_t a, void *fpstp, uint32_t ahp_mode)
      * it would affect flushing input denormals.
      */
     float_status *fpst = fpstp;
-    flag save = get_flush_inputs_to_zero(fpst);
+    bool save = get_flush_inputs_to_zero(fpst);
     set_flush_inputs_to_zero(false, fpst);
     float64 r = float16_to_float64(a, !ahp_mode, fpst);
     set_flush_inputs_to_zero(save, fpst);
@@ -570,7 +570,7 @@ uint32_t HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
      * it would affect flushing output denormals.
      */
     float_status *fpst = fpstp;
-    flag save = get_flush_to_zero(fpst);
+    bool save = get_flush_to_zero(fpst);
     set_flush_to_zero(false, fpst);
     float16 r = float64_to_float16(a, !ahp_mode, fpst);
     set_flush_to_zero(save, fpst);
diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 24c313ed69..9f120cf15e 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -49,7 +49,7 @@ static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
 
 floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, zSign;
+    bool aSign, zSign;
     int32_t aExp, bExp, expDiff;
     uint64_t aSig0, aSig1, bSig;
     uint64_t qTemp, term0, term1;
@@ -132,7 +132,7 @@ floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
 
 floatx80 floatx80_getman(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -166,7 +166,7 @@ floatx80 floatx80_getman(floatx80 a, float_status *status)
 
 floatx80 floatx80_getexp(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -202,7 +202,7 @@ floatx80 floatx80_getexp(floatx80 a, float_status *status)
 
 floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
 {
-    flag aSign, bSign;
+    bool aSign, bSign;
     int32_t aExp, bExp, shiftCount;
     uint64_t aSig, bSig;
 
@@ -258,7 +258,7 @@ floatx80 floatx80_scale(floatx80 a, floatx80 b, float_status *status)
 
 floatx80 floatx80_move(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -306,7 +306,7 @@ static int32_t floatx80_make_compact(int32_t aExp, uint64_t aSig)
 
 floatx80 floatx80_lognp1(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig, fSig;
 
@@ -505,7 +505,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
 
 floatx80 floatx80_logn(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig, fSig;
 
@@ -673,7 +673,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
 
 floatx80 floatx80_log10(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -730,7 +730,7 @@ floatx80 floatx80_log10(floatx80 a, float_status *status)
 
 floatx80 floatx80_log2(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -797,7 +797,7 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
 
 floatx80 floatx80_etox(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -805,7 +805,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
 
     int32_t compact, n, j, k, m, m1;
     floatx80 fp0, fp1, fp2, fp3, l2, scale, adjscale;
-    flag adjflag;
+    bool adjflag;
 
     aSig = extractFloatx80Frac(a);
     aExp = extractFloatx80Exp(a);
@@ -981,7 +981,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
 
 floatx80 floatx80_twotox(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -1131,7 +1131,7 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
 
 floatx80 floatx80_tentox(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -1286,7 +1286,7 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
 
 floatx80 floatx80_tan(floatx80 a, float_status *status)
 {
-    flag aSign, xSign;
+    bool aSign, xSign;
     int32_t aExp, xExp;
     uint64_t aSig, xSig;
 
@@ -1295,7 +1295,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
     int32_t compact, l, n, j;
     floatx80 fp0, fp1, fp2, fp3, fp4, fp5, invtwopi, twopi1, twopi2;
     float32 twoto63;
-    flag endflag;
+    bool endflag;
 
     aSig = extractFloatx80Frac(a);
     aExp = extractFloatx80Exp(a);
@@ -1344,10 +1344,10 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             xExp -= 0x3FFF;
             if (xExp <= 28) {
                 l = 0;
-                endflag = 1;
+                endflag = true;
             } else {
                 l = xExp - 27;
-                endflag = 0;
+                endflag = false;
             }
             invtwopi = packFloatx80(0, 0x3FFE - l,
                                     UINT64_C(0xA2F9836E4E44152A)); /* INVTWOPI */
@@ -1372,7 +1372,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             fp1 = floatx80_sub(fp1, fp4, status); /* FP1 is a := r - p */
             fp0 = floatx80_add(fp0, fp1, status); /* FP0 is R := A+a */
 
-            if (endflag > 0) {
+            if (endflag) {
                 n = floatx80_to_int32(fp2, status);
                 goto tancont;
             }
@@ -1496,7 +1496,7 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
 
 floatx80 floatx80_sin(floatx80 a, float_status *status)
 {
-    flag aSign, xSign;
+    bool aSign, xSign;
     int32_t aExp, xExp;
     uint64_t aSig, xSig;
 
@@ -1505,7 +1505,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
     int32_t compact, l, n, j;
     floatx80 fp0, fp1, fp2, fp3, fp4, fp5, x, invtwopi, twopi1, twopi2;
     float32 posneg1, twoto63;
-    flag endflag;
+    bool endflag;
 
     aSig = extractFloatx80Frac(a);
     aExp = extractFloatx80Exp(a);
@@ -1554,10 +1554,10 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             xExp -= 0x3FFF;
             if (xExp <= 28) {
                 l = 0;
-                endflag = 1;
+                endflag = true;
             } else {
                 l = xExp - 27;
-                endflag = 0;
+                endflag = false;
             }
             invtwopi = packFloatx80(0, 0x3FFE - l,
                                     UINT64_C(0xA2F9836E4E44152A)); /* INVTWOPI */
@@ -1582,7 +1582,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             fp1 = floatx80_sub(fp1, fp4, status); /* FP1 is a := r - p */
             fp0 = floatx80_add(fp0, fp1, status); /* FP0 is R := A+a */
 
-            if (endflag > 0) {
+            if (endflag) {
                 n = floatx80_to_int32(fp2, status);
                 goto sincont;
             }
@@ -1735,7 +1735,7 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
 
 floatx80 floatx80_cos(floatx80 a, float_status *status)
 {
-    flag aSign, xSign;
+    bool aSign, xSign;
     int32_t aExp, xExp;
     uint64_t aSig, xSig;
 
@@ -1744,7 +1744,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
     int32_t compact, l, n, j;
     floatx80 fp0, fp1, fp2, fp3, fp4, fp5, x, invtwopi, twopi1, twopi2;
     float32 posneg1, twoto63;
-    flag endflag;
+    bool endflag;
 
     aSig = extractFloatx80Frac(a);
     aExp = extractFloatx80Exp(a);
@@ -1793,10 +1793,10 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             xExp -= 0x3FFF;
             if (xExp <= 28) {
                 l = 0;
-                endflag = 1;
+                endflag = true;
             } else {
                 l = xExp - 27;
-                endflag = 0;
+                endflag = false;
             }
             invtwopi = packFloatx80(0, 0x3FFE - l,
                                     UINT64_C(0xA2F9836E4E44152A)); /* INVTWOPI */
@@ -1821,7 +1821,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp1 = floatx80_sub(fp1, fp4, status); /* FP1 is a := r - p */
             fp0 = floatx80_add(fp0, fp1, status); /* FP0 is R := A+a */
 
-            if (endflag > 0) {
+            if (endflag) {
                 n = floatx80_to_int32(fp2, status);
                 goto sincont;
             }
@@ -1972,7 +1972,7 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
 
 floatx80 floatx80_atan(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -2169,7 +2169,7 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
 
 floatx80 floatx80_asin(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -2234,7 +2234,7 @@ floatx80 floatx80_asin(floatx80 a, float_status *status)
 
 floatx80 floatx80_acos(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -2303,7 +2303,7 @@ floatx80 floatx80_acos(floatx80 a, float_status *status)
 
 floatx80 floatx80_atanh(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -2368,7 +2368,7 @@ floatx80 floatx80_atanh(floatx80 a, float_status *status)
 
 floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
@@ -2620,7 +2620,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
 
 floatx80 floatx80_tanh(floatx80 a, float_status *status)
 {
-    flag aSign, vSign;
+    bool aSign, vSign;
     int32_t aExp, vExp;
     uint64_t aSig, vSig;
 
@@ -2735,7 +2735,7 @@ floatx80 floatx80_tanh(floatx80 a, float_status *status)
 
 floatx80 floatx80_sinh(floatx80 a, float_status *status)
 {
-    flag aSign;
+    bool aSign;
     int32_t aExp;
     uint64_t aSig;
 
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 4065cfe4f7..3c7012c0b8 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -5508,7 +5508,7 @@ static inline int get_enabled_exceptions(const CPUMIPSState *env, int c)
     return c & enable;
 }
 
-static inline float16 float16_from_float32(int32_t a, flag ieee,
+static inline float16 float16_from_float32(int32_t a, bool ieee,
                                            float_status *status)
 {
       float16 f_val;
@@ -5527,7 +5527,7 @@ static inline float32 float32_from_float64(int64_t a, float_status *status)
       return a < 0 ? (f_val | (1 << 31)) : f_val;
 }
 
-static inline float32 float32_from_float16(int16_t a, flag ieee,
+static inline float32 float32_from_float16(int16_t a, bool ieee,
                                            float_status *status)
 {
       float32 f_val;
@@ -6564,7 +6564,7 @@ void helper_msa_fexdo_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
              * IEEE and "ARM" format.  The latter gains extra exponent
              * range by omitting the NaN/Inf encodings.
              */
-            flag ieee = 1;
+            bool ieee = true;
 
             MSA_FLOAT_BINOP(Lh(pwx, i), from_float32, pws->w[i], ieee, 16);
             MSA_FLOAT_BINOP(Rh(pwx, i), from_float32, pwt->w[i], ieee, 16);
@@ -7178,7 +7178,7 @@ void helper_msa_fexupl_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
              * IEEE and "ARM" format.  The latter gains extra exponent
              * range by omitting the NaN/Inf encodings.
              */
-            flag ieee = 1;
+            bool ieee = true;
 
             MSA_FLOAT_BINOP(pwx->w[i], from_float16, Lh(pws, i), ieee, 32);
         }
@@ -7214,7 +7214,7 @@ void helper_msa_fexupr_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
              * IEEE and "ARM" format.  The latter gains extra exponent
              * range by omitting the NaN/Inf encodings.
              */
-            flag ieee = 1;
+            bool ieee = true;
 
             MSA_FLOAT_BINOP(pwx->w[i], from_float16, Rh(pws, i), ieee, 32);
         }
-- 
2.20.1


