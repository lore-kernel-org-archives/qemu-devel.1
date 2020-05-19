Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C32C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6640C204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K9XThOdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6640C204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5Xq-00082m-IJ
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RZ-0004u4-A0
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:17 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:44701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RX-0006Gr-NY
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:16 -0400
Received: by mail-pf1-x42a.google.com with SMTP id x13so165388pfn.11
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kNlqzG9j9TNbuizhAMOReFcBx2wA4AcU7iptAzdhd4c=;
 b=K9XThOdM2qki0p4eSKo/TjWK5i8llR2a9Ik4dUYJwsWw+AIgLok7BweL6v8VPq47Oz
 7y11dF9bMu3b/N1lgbJ7mSFdiIMjNJye6i8dDgtaV4ikhyxoz0xowMPj8wSOKK9MexA4
 7F3o559dNvzDXcniJQPq3zeceCi8yAqf5ml1fxXqOudp0uYoRxf6resV6PcldM+nco/r
 Hox9KrMmOG6OCEu8YK+cmlviPvZQsSErWCjHZ7Sl3ecrKv136dipmR/HYp47T8MUkLb9
 AYpxnHU+f1BSpsRBRojwKYNm8endMDspXCJdrTE7aEbA5KF/4K2o7u4bS25v2n0y23Fr
 LAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kNlqzG9j9TNbuizhAMOReFcBx2wA4AcU7iptAzdhd4c=;
 b=frpWmT5Hwshx80NId2mcR/R+SCMZJKmDKmAdUhiJbB/1pUNtIoinaDx/WUL8KlSleH
 //OEoQMX2qUcqfeVoeXG+Q1fL5cznB99AHRfvsP+zp2lsUgXJSI7DAhYfI2H+QxdXDSy
 48C0RcVygux6Anr0xyDW/Ug+pd+Iq3lFMoyD5zM6z//C5UGLFmE9zCKHHpppNxMaUnew
 k9JkFc6FTNLTSuJJDFbO/SJhMo3YcZKv140d5+2QVBT2SNUeSUHE1nSJpgF44LJjENsX
 WavUHC+h8cL9EzOZBLXuMzhpOhCevdIVb1LmjYisHQUnmPmyeHddktJCdeA0fE+/ZOE+
 m42g==
X-Gm-Message-State: AOAM530UmfQA7v8fqhpwp2ADdcicxSVsYL/k09/4V6rcd2RxQKb1GjRM
 ucXZC44AAkTY3IvY56Nr7hHVkmLqYZs=
X-Google-Smtp-Source: ABdhPJzUWQYIYbUz1o9avLHgbIWcVPUTkSg9kHlL4lgXGmhAO3ZWcY/ODQBJ+hH2WJ3i9yzqqbwLwA==
X-Received: by 2002:a63:da50:: with SMTP id l16mr127810pgj.198.1589907013552; 
 Tue, 19 May 2020 09:50:13 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gx21sm96685pjb.47.2020.05.19.09.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:50:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] softfloat: Inline floatx80 compare specializations
Date: Tue, 19 May 2020 09:49:56 -0700
Message-Id: <20200519164957.26920-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519164957.26920-1-richard.henderson@linaro.org>
References: <20200519164957.26920-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Replace the floatx80 compare specializations with inline functions
that call the standard floatx80_compare{,_quiet} functions.
Use bool as the return type.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |  49 ++++++--
 fpu/softfloat.c         | 257 ----------------------------------------
 2 files changed, 41 insertions(+), 265 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index cfb3cda46b..37217d9b9b 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -689,14 +689,6 @@ floatx80 floatx80_mul(floatx80, floatx80, float_status *status);
 floatx80 floatx80_div(floatx80, floatx80, float_status *status);
 floatx80 floatx80_rem(floatx80, floatx80, float_status *status);
 floatx80 floatx80_sqrt(floatx80, float_status *status);
-int floatx80_eq(floatx80, floatx80, float_status *status);
-int floatx80_le(floatx80, floatx80, float_status *status);
-int floatx80_lt(floatx80, floatx80, float_status *status);
-int floatx80_unordered(floatx80, floatx80, float_status *status);
-int floatx80_eq_quiet(floatx80, floatx80, float_status *status);
-int floatx80_le_quiet(floatx80, floatx80, float_status *status);
-int floatx80_lt_quiet(floatx80, floatx80, float_status *status);
-int floatx80_unordered_quiet(floatx80, floatx80, float_status *status);
 FloatRelation floatx80_compare(floatx80, floatx80, float_status *status);
 FloatRelation floatx80_compare_quiet(floatx80, floatx80, float_status *status);
 int floatx80_is_quiet_nan(floatx80, float_status *status);
@@ -746,6 +738,47 @@ static inline int floatx80_is_any_nan(floatx80 a)
     return ((a.high & 0x7fff) == 0x7fff) && (a.low<<1);
 }
 
+static inline bool floatx80_eq(floatx80 a, floatx80 b, float_status *s)
+{
+    return floatx80_compare(a, b, s) == float_relation_equal;
+}
+
+static inline bool floatx80_le(floatx80 a, floatx80 b, float_status *s)
+{
+    return floatx80_compare(a, b, s) <= float_relation_equal;
+}
+
+static inline bool floatx80_lt(floatx80 a, floatx80 b, float_status *s)
+{
+    return floatx80_compare(a, b, s) < float_relation_equal;
+}
+
+static inline bool floatx80_unordered(floatx80 a, floatx80 b, float_status *s)
+{
+    return floatx80_compare(a, b, s) == float_relation_unordered;
+}
+
+static inline bool floatx80_eq_quiet(floatx80 a, floatx80 b, float_status *s)
+{
+    return floatx80_compare_quiet(a, b, s) == float_relation_equal;
+}
+
+static inline bool floatx80_le_quiet(floatx80 a, floatx80 b, float_status *s)
+{
+    return floatx80_compare_quiet(a, b, s) <= float_relation_equal;
+}
+
+static inline bool floatx80_lt_quiet(floatx80 a, floatx80 b, float_status *s)
+{
+    return floatx80_compare_quiet(a, b, s) < float_relation_equal;
+}
+
+static inline bool floatx80_unordered_quiet(floatx80 a, floatx80 b,
+                                           float_status *s)
+{
+    return floatx80_compare_quiet(a, b, s) == float_relation_unordered;
+}
+
 /*----------------------------------------------------------------------------
 | Return whether the given value is an invalid floatx80 encoding.
 | Invalid floatx80 encodings arise when the integer bit is not set, but
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 4567dda112..6c8f2d597a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5849,263 +5849,6 @@ floatx80 floatx80_sqrt(floatx80 a, float_status *status)
                                 0, zExp, zSig0, zSig1, status);
 }
 
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is equal
-| to the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  Otherwise, the comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_eq(floatx80 a, floatx80 b, float_status *status)
-{
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
-        || (extractFloatx80Exp(a) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(a) << 1))
-        || (extractFloatx80Exp(b) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(b) << 1))
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    return
-           ( a.low == b.low )
-        && (    ( a.high == b.high )
-             || (    ( a.low == 0 )
-                  && ( (uint16_t) ( ( a.high | b.high )<<1 ) == 0 ) )
-           );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is
-| less than or equal to the corresponding value `b', and 0 otherwise.  The
-| invalid exception is raised if either operand is a NaN.  The comparison is
-| performed according to the IEC/IEEE Standard for Binary Floating-Point
-| Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_le(floatx80 a, floatx80 b, float_status *status)
-{
-    bool aSign, bSign;
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
-        || (extractFloatx80Exp(a) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(a) << 1))
-        || (extractFloatx80Exp(b) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(b) << 1))
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloatx80Sign( a );
-    bSign = extractFloatx80Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            || (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 == 0 );
-    }
-    return
-          aSign ? le128( b.high, b.low, a.high, a.low )
-        : le128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is
-| less than the corresponding value `b', and 0 otherwise.  The invalid
-| exception is raised if either operand is a NaN.  The comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_lt(floatx80 a, floatx80 b, float_status *status)
-{
-    bool aSign, bSign;
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
-        || (extractFloatx80Exp(a) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(a) << 1))
-        || (extractFloatx80Exp(b) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(b) << 1))
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloatx80Sign( a );
-    bSign = extractFloatx80Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            && (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 != 0 );
-    }
-    return
-          aSign ? lt128( b.high, b.low, a.high, a.low )
-        : lt128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point values `a' and `b'
-| cannot be compared, and 0 otherwise.  The invalid exception is raised if
-| either operand is a NaN.   The comparison is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-int floatx80_unordered(floatx80 a, floatx80 b, float_status *status)
-{
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)
-        || (extractFloatx80Exp(a) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(a) << 1))
-        || (extractFloatx80Exp(b) == 0x7FFF
-            && (uint64_t) (extractFloatx80Frac(b) << 1))
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 1;
-    }
-    return 0;
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is
-| equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
-| cause an exception.  The comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_eq_quiet(floatx80 a, floatx80 b, float_status *status)
-{
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    if (    (    ( extractFloatx80Exp( a ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
-         || (    ( extractFloatx80Exp( b ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
-       ) {
-        if (floatx80_is_signaling_nan(a, status)
-         || floatx80_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    return
-           ( a.low == b.low )
-        && (    ( a.high == b.high )
-             || (    ( a.low == 0 )
-                  && ( (uint16_t) ( ( a.high | b.high )<<1 ) == 0 ) )
-           );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is less
-| than or equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs
-| do not cause an exception.  Otherwise, the comparison is performed according
-| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_le_quiet(floatx80 a, floatx80 b, float_status *status)
-{
-    bool aSign, bSign;
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    if (    (    ( extractFloatx80Exp( a ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
-         || (    ( extractFloatx80Exp( b ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
-       ) {
-        if (floatx80_is_signaling_nan(a, status)
-         || floatx80_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloatx80Sign( a );
-    bSign = extractFloatx80Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            || (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 == 0 );
-    }
-    return
-          aSign ? le128( b.high, b.low, a.high, a.low )
-        : le128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point value `a' is less
-| than the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause
-| an exception.  Otherwise, the comparison is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int floatx80_lt_quiet(floatx80 a, floatx80 b, float_status *status)
-{
-    bool aSign, bSign;
-
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    if (    (    ( extractFloatx80Exp( a ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
-         || (    ( extractFloatx80Exp( b ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
-       ) {
-        if (floatx80_is_signaling_nan(a, status)
-         || floatx80_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloatx80Sign( a );
-    bSign = extractFloatx80Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            && (    ( ( (uint16_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 != 0 );
-    }
-    return
-          aSign ? lt128( b.high, b.low, a.high, a.low )
-        : lt128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the extended double-precision floating-point values `a' and `b'
-| cannot be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.
-| The comparison is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-int floatx80_unordered_quiet(floatx80 a, floatx80 b, float_status *status)
-{
-    if (floatx80_invalid_encoding(a) || floatx80_invalid_encoding(b)) {
-        float_raise(float_flag_invalid, status);
-        return 1;
-    }
-    if (    (    ( extractFloatx80Exp( a ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( a )<<1 ) )
-         || (    ( extractFloatx80Exp( b ) == 0x7FFF )
-              && (uint64_t) ( extractFloatx80Frac( b )<<1 ) )
-       ) {
-        if (floatx80_is_signaling_nan(a, status)
-         || floatx80_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 1;
-    }
-    return 0;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the quadruple-precision floating-point
 | value `a' to the 32-bit two's complement integer format.  The conversion
-- 
2.20.1


