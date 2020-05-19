Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFFDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0432075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zoj/wLe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0432075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5Sw-0006hB-WD
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RX-0004qT-Gu
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:15 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631]:45460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RV-0006GI-QP
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id u22so119220plq.12
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8NcAfmRPZydZSST/I9cj9RqhKrvGwCnMOXFqGqF3Hy4=;
 b=Zoj/wLe/T+KCyM3HO+4nI0Wh4l4XIQfqGlHumU6Avmz40b1dTRRVIVK2GrhDZmUEw5
 RQrQaRPl4acyivzARkW+xQDMYoh2jrNH5dLhN2/MCg9F05gzabrN09EAI5OgvsjkbIv5
 fhIU49iB+/ymwzLfr7zV45DhUcAakqJ6IQicAi3/NRZ0ZshQ/YwO0LQabmTp0eZPtsij
 HyD7QEN/JGttiYap9LTc1vDn8xcnLeOuFMguR9sylRgLOS8N0HlIo71KTh4g2pCRp+Uc
 6v0Mc9Zg2ZX8A6VFXQiCMICUp2Y0GwblpiYXP/yt2MylK5lKyP5zzmsLy80MyP7Ekmky
 UNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8NcAfmRPZydZSST/I9cj9RqhKrvGwCnMOXFqGqF3Hy4=;
 b=uNYgUKqZLeVu5JeYoyMT5qOvqXlHsBjYRWYmMXb8RO+v4R/53gFwWkx4V9KAVyMvzG
 dfEOWJXH+AETqBY0LylbkCFZab4pH22lDSJidD3lz7WGcujw8pQPmhy1Xdk6cEjo3lLe
 74VB/tSbyVeDKUqYg6S2axFoIqRzHWdqqrTM9jeHB+Zur56y4zuCtsapt9+Wbezzo3iy
 GAEArC6SLFEUOU6hsHIPprAu3gLWM2yOJ+jSKeH5NP1hu2Tz/brHU05IhQ+9tNeUSiUj
 uLPjcUIqD880h7FM0DUQmy3/iPO0IV0yGXF0fI3lU/+PTAKnxAVlbufH0AtTxwXNz+V5
 i/6Q==
X-Gm-Message-State: AOAM53051/g3FSXzJlF7vlbFD6pGGiygucuPuIEEyKTtrAUkZNn0wI/K
 Bt8SJbMFS58d3X7F+wEY6jLmln9HByE=
X-Google-Smtp-Source: ABdhPJy+KUMEuJtsZThwIfjFieTYa0FMyHMuheMGamxW8BVV2FYHpc/p6uThjLdhVWQhv1Hik0KLEQ==
X-Received: by 2002:a17:90a:985:: with SMTP id 5mr447715pjo.23.1589907011440; 
 Tue, 19 May 2020 09:50:11 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gx21sm96685pjb.47.2020.05.19.09.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:50:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/10] softfloat: Inline float128 compare specializations
Date: Tue, 19 May 2020 09:49:55 -0700
Message-Id: <20200519164957.26920-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519164957.26920-1-richard.henderson@linaro.org>
References: <20200519164957.26920-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Replace the float128 compare specializations with inline functions
that call the standard float128_compare{,_quiet} functions.
Use bool as the return type.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |  49 +++++++--
 fpu/softfloat.c         | 238 ----------------------------------------
 2 files changed, 41 insertions(+), 246 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 281f0fd971..cfb3cda46b 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -901,14 +901,6 @@ float128 float128_mul(float128, float128, float_status *status);
 float128 float128_div(float128, float128, float_status *status);
 float128 float128_rem(float128, float128, float_status *status);
 float128 float128_sqrt(float128, float_status *status);
-int float128_eq(float128, float128, float_status *status);
-int float128_le(float128, float128, float_status *status);
-int float128_lt(float128, float128, float_status *status);
-int float128_unordered(float128, float128, float_status *status);
-int float128_eq_quiet(float128, float128, float_status *status);
-int float128_le_quiet(float128, float128, float_status *status);
-int float128_lt_quiet(float128, float128, float_status *status);
-int float128_unordered_quiet(float128, float128, float_status *status);
 FloatRelation float128_compare(float128, float128, float_status *status);
 FloatRelation float128_compare_quiet(float128, float128, float_status *status);
 int float128_is_quiet_nan(float128, float_status *status);
@@ -964,6 +956,47 @@ static inline int float128_is_any_nan(float128 a)
         ((a.low != 0) || ((a.high & 0xffffffffffffLL) != 0));
 }
 
+static inline bool float128_eq(float128 a, float128 b, float_status *s)
+{
+    return float128_compare(a, b, s) == float_relation_equal;
+}
+
+static inline bool float128_le(float128 a, float128 b, float_status *s)
+{
+    return float128_compare(a, b, s) <= float_relation_equal;
+}
+
+static inline bool float128_lt(float128 a, float128 b, float_status *s)
+{
+    return float128_compare(a, b, s) < float_relation_equal;
+}
+
+static inline bool float128_unordered(float128 a, float128 b, float_status *s)
+{
+    return float128_compare(a, b, s) == float_relation_unordered;
+}
+
+static inline bool float128_eq_quiet(float128 a, float128 b, float_status *s)
+{
+    return float128_compare_quiet(a, b, s) == float_relation_equal;
+}
+
+static inline bool float128_le_quiet(float128 a, float128 b, float_status *s)
+{
+    return float128_compare_quiet(a, b, s) <= float_relation_equal;
+}
+
+static inline bool float128_lt_quiet(float128 a, float128 b, float_status *s)
+{
+    return float128_compare_quiet(a, b, s) < float_relation_equal;
+}
+
+static inline bool float128_unordered_quiet(float128 a, float128 b,
+                                           float_status *s)
+{
+    return float128_compare_quiet(a, b, s) == float_relation_unordered;
+}
+
 #define float128_zero make_float128(0, 0)
 
 /*----------------------------------------------------------------------------
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5d7fc2c17a..4567dda112 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7218,244 +7218,6 @@ float128 float128_sqrt(float128 a, float_status *status)
 
 }
 
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is equal to
-| the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  Otherwise, the comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_eq(float128 a, float128 b, float_status *status)
-{
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    return
-           ( a.low == b.low )
-        && (    ( a.high == b.high )
-             || (    ( a.low == 0 )
-                  && ( (uint64_t) ( ( a.high | b.high )<<1 ) == 0 ) )
-           );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is less than
-| or equal to the corresponding value `b', and 0 otherwise.  The invalid
-| exception is raised if either operand is a NaN.  The comparison is performed
-| according to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_le(float128 a, float128 b, float_status *status)
-{
-    bool aSign, bSign;
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            || (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 == 0 );
-    }
-    return
-          aSign ? le128( b.high, b.low, a.high, a.low )
-        : le128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  The invalid exception is
-| raised if either operand is a NaN.  The comparison is performed according
-| to the IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_lt(float128 a, float128 b, float_status *status)
-{
-    bool aSign, bSign;
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 0;
-    }
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            && (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 != 0 );
-    }
-    return
-          aSign ? lt128( b.high, b.low, a.high, a.low )
-        : lt128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  The invalid exception is raised if either
-| operand is a NaN. The comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_unordered(float128 a, float128 b, float_status *status)
-{
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        float_raise(float_flag_invalid, status);
-        return 1;
-    }
-    return 0;
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is equal to
-| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.  The comparison is performed according to the IEC/IEEE Standard
-| for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_eq_quiet(float128 a, float128 b, float_status *status)
-{
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        if (float128_is_signaling_nan(a, status)
-         || float128_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    return
-           ( a.low == b.low )
-        && (    ( a.high == b.high )
-             || (    ( a.low == 0 )
-                  && ( (uint64_t) ( ( a.high | b.high )<<1 ) == 0 ) )
-           );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is less than
-| or equal to the corresponding value `b', and 0 otherwise.  Quiet NaNs do not
-| cause an exception.  Otherwise, the comparison is performed according to the
-| IEC/IEEE Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_le_quiet(float128 a, float128 b, float_status *status)
-{
-    bool aSign, bSign;
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        if (float128_is_signaling_nan(a, status)
-         || float128_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            || (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 == 0 );
-    }
-    return
-          aSign ? le128( b.high, b.low, a.high, a.low )
-        : le128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point value `a' is less than
-| the corresponding value `b', and 0 otherwise.  Quiet NaNs do not cause an
-| exception.  Otherwise, the comparison is performed according to the IEC/IEEE
-| Standard for Binary Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_lt_quiet(float128 a, float128 b, float_status *status)
-{
-    bool aSign, bSign;
-
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        if (float128_is_signaling_nan(a, status)
-         || float128_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 0;
-    }
-    aSign = extractFloat128Sign( a );
-    bSign = extractFloat128Sign( b );
-    if ( aSign != bSign ) {
-        return
-               aSign
-            && (    ( ( (uint64_t) ( ( a.high | b.high )<<1 ) ) | a.low | b.low )
-                 != 0 );
-    }
-    return
-          aSign ? lt128( b.high, b.low, a.high, a.low )
-        : lt128( a.high, a.low, b.high, b.low );
-
-}
-
-/*----------------------------------------------------------------------------
-| Returns 1 if the quadruple-precision floating-point values `a' and `b' cannot
-| be compared, and 0 otherwise.  Quiet NaNs do not cause an exception.  The
-| comparison is performed according to the IEC/IEEE Standard for Binary
-| Floating-Point Arithmetic.
-*----------------------------------------------------------------------------*/
-
-int float128_unordered_quiet(float128 a, float128 b, float_status *status)
-{
-    if (    (    ( extractFloat128Exp( a ) == 0x7FFF )
-              && ( extractFloat128Frac0( a ) | extractFloat128Frac1( a ) ) )
-         || (    ( extractFloat128Exp( b ) == 0x7FFF )
-              && ( extractFloat128Frac0( b ) | extractFloat128Frac1( b ) ) )
-       ) {
-        if (float128_is_signaling_nan(a, status)
-         || float128_is_signaling_nan(b, status)) {
-            float_raise(float_flag_invalid, status);
-        }
-        return 1;
-    }
-    return 0;
-}
-
 static inline FloatRelation
 floatx80_compare_internal(floatx80 a, floatx80 b, bool is_quiet,
                           float_status *status)
-- 
2.20.1


