Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B515C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5152075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXvqHys/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5152075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5Tl-0007zi-VY
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RT-0004kR-UN
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:11 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:52362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RR-0006El-IT
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:11 -0400
Received: by mail-pj1-x1031.google.com with SMTP id a5so1662134pjh.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o6Jxwvi61ACAZcFbrA6qJoWgcewD3we7Uj1iEIe0UB4=;
 b=bXvqHys/1G+kp8o/GNw+LmBhlDDI3N4i8BLzek7iQWV8lWlZbOz1byjI0knBiet0/3
 4xnKIOma40AI5tZqa9aPM292Gpi+oan8SS/nqUQ5Lacy6nvDVGTbJnnn9dW5Ff6ur2w+
 U2sPK/1IAfFCrVMoI2QUp/zW10taQpstzsnKX2vP2czVaEh8he3Y2Lv03QooEHZvLVEV
 NOGSZZYqgnt7AdAiMWoihxdMUMbGQDGhBqyIYTgilJ8ptMxAg8T7LpVMSLSEy97M08Gx
 +F4sZtOZksdjkGiL0TxCHe63PoAOHV8SSnlZjkvNKkwzhTbvon3SuKVfT/1A3uPTBJKF
 K+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o6Jxwvi61ACAZcFbrA6qJoWgcewD3we7Uj1iEIe0UB4=;
 b=EoecVgIAdpcvEktFOscC/c5vGgAOsV3PCOWVIFDPQv93hx9Ne1kM8jSkPKXKOMZ55n
 sR04FrnP0cAc/DyPiY8pyhcoYkqneJdusw2k0MDBv9RsR6vkdZRropg90pUtZ0CjoAz+
 MnmPA5j+dy9G7H762T0Y82gZdVAIeeET/8yZJPM8YidTe8OxxjVm7dRR6NVDnT9uJhIC
 RQaQ91pJNIoKFmfxRyytsXKsbHaJVENTavu4ByRHz2RuLoMo4R25QVqNu5z+NrPfnlH9
 7PT+e2CoVAXuVeHF/xzOrJF2ll0syIDdvPH8a8yk/HQSKo/ahDxD88AtCzyFs37e/5V8
 w2XQ==
X-Gm-Message-State: AOAM531UE1Vitv7Cjy1+s0TPlurZd1IKRQ5MVKl3UgwaRJVvhpyejZvE
 BzNTYJvXl0oPyoFTai0uAuUNF/g/Y2A=
X-Google-Smtp-Source: ABdhPJzMx2b0hfg8/4x+fxEuuWEE/tpzc6sGvCfwzsz4kbgoxCO++eWO3p2M1zgQ0kSz/z9pIDbFpQ==
X-Received: by 2002:a17:90a:264c:: with SMTP id
 l70mr530563pje.18.1589907007576; 
 Tue, 19 May 2020 09:50:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gx21sm96685pjb.47.2020.05.19.09.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:50:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] softfloat: Inline float32 compare specializations
Date: Tue, 19 May 2020 09:49:53 -0700
Message-Id: <20200519164957.26920-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519164957.26920-1-richard.henderson@linaro.org>
References: <20200519164957.26920-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the float32 compare specializations with inline functions
that call the standard float32_compare{,_quiet} functions.
Use bool as the return type.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


