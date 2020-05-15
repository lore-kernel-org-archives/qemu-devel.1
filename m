Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E979EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9963220727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pxt8KPt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9963220727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfiE-0004VQ-MP
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfb2-0001sO-7f
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:12 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfb0-0001qI-5w
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:11 -0400
Received: by mail-pj1-x1042.google.com with SMTP id q9so1380576pjm.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cKi86OQSep6LgVzqwL+7q/01IrrZQWVDQUnTLFq+Ia0=;
 b=Pxt8KPt4l9Ajs8Pr8jUgrdmlT9cuJgfzYAMRv659lNpndFuX9IHjFrSBsYtanWb+4v
 Oz93/d92ijkX6NeJZmRckNBP44AM5wRpNFJj2xe/FoI2zfPHyfGwW+RtBajbLTVsFtBo
 tHCeq6sqfeJifeyHFRQI2Q5Ncwi6XHdqBRghaSsczWY/T7ltR9/Kgzx8u1qV5dp9A8/c
 NmXpZA5CtJppz20qLDBmgPIY8O/B9UO5XkuuecKHV7EBjBBBDuhIhLED9vHjD6amslf6
 tfS3KJmd4HIRB/bvI6inCVKpQBAd2c2zeTQ3HdSUzydu3Crb/9dCcVlpPe8i7YBsf0Am
 jYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cKi86OQSep6LgVzqwL+7q/01IrrZQWVDQUnTLFq+Ia0=;
 b=Sge6YDK2+4c92Mmd5Z62WrfKupMUoA59rf82EV66RljS+uW7DrY0Vssp52x84u3VPD
 Uxr+ZzgClr2MMyRErILnVZaLGKlzkXvIlwp3hG5N1cnOMzr0BFOu7daNam2mCjN9USkc
 y5X7dAXlE3/mcWtSEEKHsY1sx8FBXGPARR61FLcoW7gN8hI+0GFBXbfQnC22qjUt8PRP
 mNXtWk5ZZiTimP659A+/cv/1BRaR2D2hQmE7gUKrXE1xP4EMQP229IQluc02z1s/YtmV
 D3IDDQzcHEq/eqN69Vw52+Y3z0UwfgikhpFJ5AnheFcj5SrpA5IzjL/CDgpC24ctEgiX
 wVeg==
X-Gm-Message-State: AOAM533Wnw1NrRKvf4W/zMnKberDcUJj56EliHqwyYzVvzDtePVcZJr8
 P4HVejAbJtKStl4p5GsLAFGUqDQhoVk=
X-Google-Smtp-Source: ABdhPJyMHEkNj6SeptzYmJkPe3jDDTC+UilF+vfRee3Eqjmcs4bb0xcvoL4FZqPr7jPjKRdCc03cJg==
X-Received: by 2002:a17:902:d915:: with SMTP id
 c21mr4907770plz.49.1589569327167; 
 Fri, 15 May 2020 12:02:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q21sm2485719pfg.131.2020.05.15.12.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 12:02:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] softfloat: Inline floatx80 compare specializations
Date: Fri, 15 May 2020 12:01:52 -0700
Message-Id: <20200515190153.6017-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515190153.6017-1-richard.henderson@linaro.org>
References: <20200515190153.6017-1-richard.henderson@linaro.org>
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

Replace the floatx80 compare specializations with inline functions
that call the standard floatx80_compare{,_quiet} functions.
Use bool as the return type.

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


