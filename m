Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFBBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A874920727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVUvL03J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A874920727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfh3-0002bA-Gv
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfax-0001ip-OT
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:07 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33851)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfav-0001pe-VV
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:07 -0400
Received: by mail-pg1-x544.google.com with SMTP id f6so1423424pgm.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xwz/crxYugQcXT51GmixlbDw5UMQQM60RRtK6DQvNo4=;
 b=XVUvL03JUcHum8mka0olkzlVykqEGJMR1/dlr+MEUjzETfAQNLZjiCk0+2Kgaa8/od
 ZghpJBQ1qcMMUDiVIXEH/OYC+LPXVqF4DIgAxPEcUdYGQri5lWTiARkNmLkTWQoTfA+W
 iUfuS9/piOMMl6iRiMwPe4wwau7xDirENi92RJTbIG9mv3aaJl17sNdN0yW+J0bqZnTl
 APLV6zuevN6+Hjt6C1UL1+1I4PoGgQXSbewyUA3kVPvY55Kdg9x6aRO0xJCjqGYOtFXs
 w/TW8Z41Owm5ZnyEkOAxC4OiZJyKQl3cLCmZA3+HViW3mjrADgF+PsY0VtjeostppE9K
 jwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xwz/crxYugQcXT51GmixlbDw5UMQQM60RRtK6DQvNo4=;
 b=KCSKK96ryY2syaTngPz5B7db033VS/sk2/hYH2W1Qv7Fxe9H/3Q7I8t73/msWpvUBE
 8LsU/wLwEHinpV+NiZ60L9iC77w2JysRD4NdPPEd0al8ZMADEnXunhw3haWYqyVH8UfO
 hSrVwLvCUgT3KnBnUerZWo2YMlMsvdoRgun4P6XxXGCjj7YNlcyBBHwsa8u9gu+epBQ6
 Hz7cVVuwaZm+lAslZEfi/T08o/GD9arPtbMULhw5PG1RK2vDPswzwq60GzAXP8Wz1L/O
 745/p/JrFCj/5Tecy9N0TUTkj6bvC+P1vxMYdpHZ8CoFdXJPcolqGLAQaZ3NQVGTjnJX
 Pu6g==
X-Gm-Message-State: AOAM530cUaahWzt0SpXKUgAgRmQs87z7BoCxe1JToU05EzdzfwrCvN/M
 VDMNPyq0qoZxoSGB/p83fZRJcNOEeu8=
X-Google-Smtp-Source: ABdhPJx7SD5InZjkX0rVlYYF30Mh4/lV7S/B7uAZl5QCmV36o9Q3IKqglZKinEgl0Bj6+YlT2m0mSA==
X-Received: by 2002:a65:6094:: with SMTP id t20mr4636711pgu.220.1589569323935; 
 Fri, 15 May 2020 12:02:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q21sm2485719pfg.131.2020.05.15.12.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 12:02:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/10] softfloat: Inline float32 compare specializations
Date: Fri, 15 May 2020 12:01:49 -0700
Message-Id: <20200515190153.6017-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515190153.6017-1-richard.henderson@linaro.org>
References: <20200515190153.6017-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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

Replace the float32 compare specializations with inline functions
that call the standard float32_compare{,_quiet} functions.
Use bool as the return type.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |  49 +++++++--
 fpu/softfloat.c         | 216 ----------------------------------------
 2 files changed, 41 insertions(+), 224 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 7f84235122..4d1af6ab45 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -343,14 +343,6 @@ float32 float32_muladd(float32, float32, float32, int, float_status *status);
 float32 float32_sqrt(float32, float_status *status);
 float32 float32_exp2(float32, float_status *status);
 float32 float32_log2(float32, float_status *status);
-int float32_eq(float32, float32, float_status *status);
-int float32_le(float32, float32, float_status *status);
-int float32_lt(float32, float32, float_status *status);
-int float32_unordered(float32, float32, float_status *status);
-int float32_eq_quiet(float32, float32, float_status *status);
-int float32_le_quiet(float32, float32, float_status *status);
-int float32_lt_quiet(float32, float32, float_status *status);
-int float32_unordered_quiet(float32, float32, float_status *status);
 FloatRelation float32_compare(float32, float32, float_status *status);
 FloatRelation float32_compare_quiet(float32, float32, float_status *status);
 float32 float32_min(float32, float32, float_status *status);
@@ -425,6 +417,47 @@ static inline float32 float32_set_sign(float32 a, int sign)
     return make_float32((float32_val(a) & 0x7fffffff) | (sign << 31));
 }
 
+static inline bool float32_eq(float32 a, float32 b, float_status *s)
+{
+    return float32_compare(a, b, s) == float_relation_equal;
+}
+
+static inline bool float32_le(float32 a, float32 b, float_status *s)
+{
+    return float32_compare(a, b, s) <= float_relation_equal;
+}
+
+static inline bool float32_lt(float32 a, float32 b, float_status *s)
+{
+    return float32_compare(a, b, s) < float_relation_equal;
+}
+
+static inline bool float32_unordered(float32 a, float32 b, float_status *s)
+{
+    return float32_compare(a, b, s) == float_relation_unordered;
+}
+
+static inline bool float32_eq_quiet(float32 a, float32 b, float_status *s)
+{
+    return float32_compare_quiet(a, b, s) == float_relation_equal;
+}
+
+static inline bool float32_le_quiet(float32 a, float32 b, float_status *s)
+{
+    return float32_compare_quiet(a, b, s) <= float_relation_equal;
+}
+
+static inline bool float32_lt_quiet(float32 a, float32 b, float_status *s)
+{
+    return float32_compare_quiet(a, b, s) < float_relation_equal;
+}
+
+static inline bool float32_unordered_quiet(float32 a, float32 b,
+                                           float_status *s)
+{
+    return float32_compare_quiet(a, b, s) == float_relation_unordered;
+}
+
 #define float32_zero make_float32(0)
 #define float32_half make_float32(0x3f000000)
 #define float32_one make_float32(0x3f800000)
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 60b9ae5f05..f6bfc40c97 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4733,222 +4733,6 @@ float32 float32_log2(float32 a, float_status *status)
     return normalizeRoundAndPackFloat32(zSign, 0x85, zSig, status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is equal to
-| the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  Otherwise, the comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_eq(float32 a, float32 b, float_status *status)
-{
-    uint32_t av, bv;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    av = float32_val(a);
-    bv = float32_val(b);
-    return ( av == bv ) || ( (uint32_t) ( ( av | bv )<<1 ) == 0 );
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is less than
-| or equal to the corresponding value `b', and 0 otherwise.  The invalid
-| exception is raised if either operand is a NaN.  The comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_le(float32 a, float32 b, float_status *status)
-{
-    bool aSign, bSign;
-    uint32_t av, bv;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat32Sign( a );
-    bSign = extractFloat32Sign( b );
-    av = float32_val(a);
-    bv = float32_val(b);
-    if ( aSign != bSign ) return aSign || ( (uint32_t) ( ( av | bv )<<1 ) == 0 );
-    return ( av == bv ) || ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  The comparison is performed according
-| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_lt(float32 a, float32 b, float_status *status)
-{
-    bool aSign, bSign;
-    uint32_t av, bv;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat32Sign( a );
-    bSign = extractFloat32Sign( b );
-    av = float32_val(a);
-    bv = float32_val(b);
-    if ( aSign != bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<1 ) != 0 );
-    return ( av != bv ) && ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  The invalid exception is raised if either
-| operand is a NaN.  The comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_unordered(float32 a, float32 b, float_status *status)
-{
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 1;
-    }
-    return 0;
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is equal to
-| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.  The comparison is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_eq_quiet(float32 a, float32 b, float_status *status)
-{
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        if (float32_is_signaling_nan(a, status)
-         || float32_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    return ( float32_val(a) == float32_val(b) ) ||
-            ( (uint32_t) ( ( float32_val(a) | float32_val(b) )<<1 ) == 0 );
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is less than or
-| equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
-| cause an exception.  Otherwise, the comparison is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_le_quiet(float32 a, float32 b, float_status *status)
-{
-    bool aSign, bSign;
-    uint32_t av, bv;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        if (float32_is_signaling_nan(a, status)
-         || float32_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat32Sign( a );
-    bSign = extractFloat32Sign( b );
-    av = float32_val(a);
-    bv = float32_val(b);
-    if ( aSign != bSign ) return aSign || ( (uint32_t) ( ( av | bv )<<1 ) == 0 );
-    return ( av == bv ) || ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.  Otherwise, the comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_lt_quiet(float32 a, float32 b, float_status *status)
-{
-    bool aSign, bSign;
-    uint32_t av, bv;
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        if (float32_is_signaling_nan(a, status)
-         || float32_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat32Sign( a );
-    bSign = extractFloat32Sign( b );
-    av = float32_val(a);
-    bv = float32_val(b);
-    if ( aSign != bSign ) return aSign && ( (uint32_t) ( ( av | bv )<<1 ) != 0 );
-    return ( av != bv ) && ( aSign ^ ( av < bv ) );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the single-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  The
-| comparison is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float32_unordered_quiet(float32 a, float32 b, float_status *status)
-{
-    a = float32_squash_input_denormal(a, status);
-    b = float32_squash_input_denormal(b, status);
-
-    if (    ( ( extractFloat32Exp( a ) == 0xFF ) && extractFloat32Frac( a ) )
-         || ( ( extractFloat32Exp( b ) == 0xFF ) && extractFloat32Frac( b ) )
-       ) {
-        if (float32_is_signaling_nan(a, status)
-         || float32_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 1;
-    }
-    return 0;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the double-precision floating-point value
 | `a' to the extended double-precision floating-point format.  The conversion
-- 
2.20.1


