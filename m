Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599ABC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09AFD204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itfyHYab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AFD204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5YK-0000LA-6f
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5Rj-0005CC-Gy
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:28 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:37968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RT-0006Fi-E4
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:27 -0400
Received: by mail-pl1-x629.google.com with SMTP id m7so132977plt.5
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cC6AWG5XyAggAOPFHLJeHkmubl9dOS4YtOi8r0R/48A=;
 b=itfyHYab9iQHkBBPQnJcpg8yYY/2xhzgwFDPtoC6H8Pt4wnw9QA9IyPJadWQDf7PPZ
 PJ5LKEv7FF6zBNRf9kCMKiGsgo9RT2BXzUoX73gAAfj3OH1Lf1eN9Ugd/LBdrEvIRkf9
 mK3DsAS7AN9fgN4sj+yzCKG3Iv4GXavgN9ygUEauXTQMSO7azg4ynaTvosWEZnsn1Srb
 IgW4XzQjWptl3mcTxidDyItowI3gkwJ3bJ1wbUzI3a1Bo1G+sEC11jkwzoHi4IiLn5SS
 9niI9HlXmz1dZGT7n+6GO9NMdRXZ/0LgliKb3WdICJnycvsBi+6TVcX/TFJLEjkFY2FE
 znbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cC6AWG5XyAggAOPFHLJeHkmubl9dOS4YtOi8r0R/48A=;
 b=cbJ9MLfJFVeudSHwZggQoaw1N0pcFKfystOR+7GgmqDQXHIutr48FixTV/7sZSUSbY
 6Amx3K4b1UvMGhaLAfytIJ7tNkWFtxxCRPD7dBm8nFXwSUBi+wASJtVYt+XrIKprYHe3
 SkdD3muoH66IUYIRRpM3nGuPFUKrjTX1haU3xfWDZoy1bZwMmYEOhkF600ZLbYW8znlx
 5Hjyn5lPlOa3qo3hCFVSh5myK7XaQ13vK8miGXz08RBXxHXKvWxbLoicRD727eYNTH6c
 VqaOl1wxKbkQHiv/Gr/CY7OmC4xfb/VFygrz6c9Z2dXx6hG54jwzQt5yjSRxiECmd0uV
 CmSQ==
X-Gm-Message-State: AOAM533xBTn8mxxFvUTJsfFIvFHXyY6BzzSrx9yajR8rm2kCFhLWVYHe
 7DuBLTwmBiJibqswvHIdTTd3B45Ybc0=
X-Google-Smtp-Source: ABdhPJxi3PfIDnhlby7tk7GsTKpqBpB2QNnPgRnewWnHxqk1uAYnlhKr9Z0C8/xgupylHhsGqYlfOw==
X-Received: by 2002:a17:90a:881:: with SMTP id v1mr435732pjc.227.1589907009332; 
 Tue, 19 May 2020 09:50:09 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gx21sm96685pjb.47.2020.05.19.09.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:50:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/10] softfloat: Inline float64 compare specializations
Date: Tue, 19 May 2020 09:49:54 -0700
Message-Id: <20200519164957.26920-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519164957.26920-1-richard.henderson@linaro.org>
References: <20200519164957.26920-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the float64 compare specializations with inline functions
that call the standard float64_compare{,_quiet} functions.
Use bool as the return type.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h       |  49 ++++++--
 fpu/softfloat.c               | 220 ----------------------------------
 target/s390x/vec_fpu_helper.c |   2 +-
 3 files changed, 42 insertions(+), 229 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 4d1af6ab45..281f0fd971 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -532,14 +532,6 @@ float64 float64_rem(float64, float64, float_status *status);
 float64 float64_muladd(float64, float64, float64, int, float_status *status);
 float64 float64_sqrt(float64, float_status *status);
 float64 float64_log2(float64, float_status *status);
-int float64_eq(float64, float64, float_status *status);
-int float64_le(float64, float64, float_status *status);
-int float64_lt(float64, float64, float_status *status);
-int float64_unordered(float64, float64, float_status *status);
-int float64_eq_quiet(float64, float64, float_status *status);
-int float64_le_quiet(float64, float64, float_status *status);
-int float64_lt_quiet(float64, float64, float_status *status);
-int float64_unordered_quiet(float64, float64, float_status *status);
 FloatRelation float64_compare(float64, float64, float_status *status);
 FloatRelation float64_compare_quiet(float64, float64, float_status *status);
 float64 float64_min(float64, float64, float_status *status);
@@ -615,6 +607,47 @@ static inline float64 float64_set_sign(float64 a, int sign)
                         | ((int64_t)sign << 63));
 }
 
+static inline bool float64_eq(float64 a, float64 b, float_status *s)
+{
+    return float64_compare(a, b, s) == float_relation_equal;
+}
+
+static inline bool float64_le(float64 a, float64 b, float_status *s)
+{
+    return float64_compare(a, b, s) <= float_relation_equal;
+}
+
+static inline bool float64_lt(float64 a, float64 b, float_status *s)
+{
+    return float64_compare(a, b, s) < float_relation_equal;
+}
+
+static inline bool float64_unordered(float64 a, float64 b, float_status *s)
+{
+    return float64_compare(a, b, s) == float_relation_unordered;
+}
+
+static inline bool float64_eq_quiet(float64 a, float64 b, float_status *s)
+{
+    return float64_compare_quiet(a, b, s) == float_relation_equal;
+}
+
+static inline bool float64_le_quiet(float64 a, float64 b, float_status *s)
+{
+    return float64_compare_quiet(a, b, s) <= float_relation_equal;
+}
+
+static inline bool float64_lt_quiet(float64 a, float64 b, float_status *s)
+{
+    return float64_compare_quiet(a, b, s) < float_relation_equal;
+}
+
+static inline bool float64_unordered_quiet(float64 a, float64 b,
+                                           float_status *s)
+{
+    return float64_compare_quiet(a, b, s) == float_relation_unordered;
+}
+
 #define float64_zero make_float64(0)
 #define float64_half make_float64(0x3fe0000000000000LL)
 #define float64_one make_float64(0x3ff0000000000000LL)
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index f6bfc40c97..5d7fc2c17a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4941,226 +4941,6 @@ float64 float64_log2(float64 a, float_status *status)
     return normalizeRoundAndPackFloat64(zSign, 0x408, zSig, status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is equal to the
-| corresponding value `b', and 0 otherwise.  The invalid exception is raised
-| if either operand is a NaN.  Otherwise, the comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_eq(float64 a, float64 b, float_status *status)
-{
-    uint64_t av, bv;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    av = float64_val(a);
-    bv = float64_val(b);
-    return ( av == bv ) || ( (uint64_t) ( ( av | bv )<<1 ) == 0 );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is less than or
-| equal to the corresponding value `b', and 0 otherwise.  The invalid
-| exception is raised if either operand is a NaN.  The comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_le(float64 a, float64 b, float_status *status)
-{
-    bool aSign, bSign;
-    uint64_t av, bv;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    av = float64_val(a);
-    bv = float64_val(b);
-    if ( aSign != bSign ) return aSign || ( (uint64_t) ( ( av | bv )<<1 ) == 0 );
-    return ( av == bv ) || ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  The comparison is performed according
-| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_lt(float64 a, float64 b, float_status *status)
-{
-    bool aSign, bSign;
-    uint64_t av, bv;
-
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    av = float64_val(a);
-    bv = float64_val(b);
-    if ( aSign != bSign ) return aSign && ( (uint64_t) ( ( av | bv )<<1 ) != 0 );
-    return ( av != bv ) && ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  The invalid exception is raised if either
-| operand is a NaN.  The comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_unordered(float64 a, float64 b, float_status *status)
-{
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 1;
-    }
-    return 0;
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is equal to the
-| corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.The comparison is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_eq_quiet(float64 a, float64 b, float_status *status)
-{
-    uint64_t av, bv;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        if (float64_is_signaling_nan(a, status)
-         || float64_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    av = float64_val(a);
-    bv = float64_val(b);
-    return ( av == bv ) || ( (uint64_t) ( ( av | bv )<<1 ) == 0 );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is less than or
-| equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
-| cause an exception.  Otherwise, the comparison is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_le_quiet(float64 a, float64 b, float_status *status)
-{
-    bool aSign, bSign;
-    uint64_t av, bv;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        if (float64_is_signaling_nan(a, status)
-         || float64_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    av = float64_val(a);
-    bv = float64_val(b);
-    if ( aSign != bSign ) return aSign || ( (uint64_t) ( ( av | bv )<<1 ) == 0 );
-    return ( av == bv ) || ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.  Otherwise, the comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_lt_quiet(float64 a, float64 b, float_status *status)
-{
-    bool aSign, bSign;
-    uint64_t av, bv;
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        if (float64_is_signaling_nan(a, status)
-         || float64_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat64Sign( a );
-    bSign = extractFloat64Sign( b );
-    av = float64_val(a);
-    bv = float64_val(b);
-    if ( aSign != bSign ) return aSign && ( (uint64_t) ( ( av | bv )<<1 ) != 0 );
-    return ( av != bv ) && ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the double-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  The
-| comparison is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float64_unordered_quiet(float64 a, float64 b, float_status *status)
-{
-    a = float64_squash_input_denormal(a, status);
-    b = float64_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat64Exp( a ) == 0x7FF ) && extractFloat64Frac( a ) )
-         || ( ( extractFloat64Exp( b ) == 0x7FF ) && extractFloat64Frac( b ) )
-       ) {
-        if (float64_is_signaling_nan(a, status)
-         || float64_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 1;
-    }
-    return 0;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the extended double-precision floating-
 | point value `a' to the 32-bit two's complement integer format.  The
diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
index a48bd704bc..c1564e819b 100644
--- a/target/s390x/vec_fpu_helper.c
+++ b/target/s390x/vec_fpu_helper.c
@@ -174,7 +174,7 @@ void HELPER(gvec_wfk64)(const void *v1, const void *v2, CPUS390XState *env,
     env->cc_op = wfc64(v1, v2, env, true, GETPC());
 }
 
-typedef int (*vfc64_fn)(float64 a, float64 b, float_status *status);
+typedef bool (*vfc64_fn)(float64 a, float64 b, float_status *status);
 static int vfc64(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
                  CPUS390XState *env, bool s, vfc64_fn fn, uintptr_t retaddr)
 {
-- 
2.20.1


