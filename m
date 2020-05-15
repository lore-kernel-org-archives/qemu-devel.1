Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC994C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CE520727
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5lH1nBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CE520727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfjh-0006u4-BX
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfb2-0001t7-F3
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:12 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfb0-0001qb-EN
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:12 -0400
Received: by mail-pf1-x443.google.com with SMTP id z26so1278030pfk.12
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 12:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2mkOApOfyovlkCqZcQYL+u8RzltlLvSt3FtUuezPUhI=;
 b=O5lH1nBkVtOJYEIyNRjztqyF3fWvtE1dWrHocclWOAJgF12s5fQb3+33mhtX8lbMwY
 /WtEuj8TnQ5tT5oZ3dIb3bNL5pVWoSvavi80FwzfDNOm65Gf7hK/aaBJfVKdfGL1adFI
 DahGUQKRVO3hPhISUK0PlPjSxQ7iuJWuHCq6dA06tE3EN6q7Dq6elwYMOR5mGDr8xeMs
 YpouBLsmPrUuTf5CvA+N8B7JRj64C60GIIzjkRV1EisecMRUzINk2IqWpHvJ3pB0SO+V
 6KxUkkxMNrj2otVP7sMVqcNy2S2oNy4aj06ZmqLbE2Mnxl4fDgb+9dZSXPSPH4vEpI2b
 VoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2mkOApOfyovlkCqZcQYL+u8RzltlLvSt3FtUuezPUhI=;
 b=MCorgNRERtOewIGrc8/LvqYHZrizFLbe4pebMITK0i/6PpM4JpEW+GcSBoXb/xALap
 1SNp1TrEA2aNIkOGzrRZ8azFneiX4oMN9bUsUJ0FO8q/cdGYeIJOD6ZRUmuvTU2Ynrta
 9W/EHfpNk/cBECE/TIYiFuDz4SZGu8UH2gfJC04kmRFwvx3ExeCxXFo71WXAJHkS2Kff
 j0SZY4X9CKFGCydapkslIUx5Ii8DcLJKc2fSFeXdgQ+EM5WJvF5zEC2fo6kJ6US94QUj
 1o7iW+KNgUEG0f4RYBIali6gz5poeeO0vhf27Lp9B8xPiqTRj/roQoBTsJDODFFgP8ys
 zVxA==
X-Gm-Message-State: AOAM530r2kP0g8GpJhbMcPK1IGd+dhI+Yj4VbK24/tEg3/jzJQPe5jSy
 jbq4IRc5/5HbIhRIMlj3fyXoy7UO16s=
X-Google-Smtp-Source: ABdhPJyqvY8sLyijzRDQW2mVem7l5Z2U6wgE4BDMYl9ZTR+MhNGpteyn4Xpj5lFAyWfQzeDquwzMuw==
X-Received: by 2002:a62:68c1:: with SMTP id d184mr5307519pfc.138.1589569328261; 
 Fri, 15 May 2020 12:02:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q21sm2485719pfg.131.2020.05.15.12.02.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 12:02:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/10] softfloat: Return bool from all classification
 predicates
Date: Fri, 15 May 2020 12:01:53 -0700
Message-Id: <20200515190153.6017-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515190153.6017-1-richard.henderson@linaro.org>
References: <20200515190153.6017-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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

This includes *_is_any_nan, *_is_neg, *_is_inf, etc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h        | 66 +++++++++++++++++-----------------
 fpu/softfloat-specialize.inc.c | 16 ++++-----
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 37217d9b9b..16ca697a73 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -235,31 +235,31 @@ float16 float16_sqrt(float16, float_status *status);
 FloatRelation float16_compare(float16, float16, float_status *status);
 FloatRelation float16_compare_quiet(float16, float16, float_status *status);
 
-int float16_is_quiet_nan(float16, float_status *status);
-int float16_is_signaling_nan(float16, float_status *status);
+bool float16_is_quiet_nan(float16, float_status *status);
+bool float16_is_signaling_nan(float16, float_status *status);
 float16 float16_silence_nan(float16, float_status *status);
 
-static inline int float16_is_any_nan(float16 a)
+static inline bool float16_is_any_nan(float16 a)
 {
     return ((float16_val(a) & ~0x8000) > 0x7c00);
 }
 
-static inline int float16_is_neg(float16 a)
+static inline bool float16_is_neg(float16 a)
 {
     return float16_val(a) >> 15;
 }
 
-static inline int float16_is_infinity(float16 a)
+static inline bool float16_is_infinity(float16 a)
 {
     return (float16_val(a) & 0x7fff) == 0x7c00;
 }
 
-static inline int float16_is_zero(float16 a)
+static inline bool float16_is_zero(float16 a)
 {
     return (float16_val(a) & 0x7fff) == 0;
 }
 
-static inline int float16_is_zero_or_denormal(float16 a)
+static inline bool float16_is_zero_or_denormal(float16 a)
 {
     return (float16_val(a) & 0x7c00) == 0;
 }
@@ -351,8 +351,8 @@ float32 float32_minnum(float32, float32, float_status *status);
 float32 float32_maxnum(float32, float32, float_status *status);
 float32 float32_minnummag(float32, float32, float_status *status);
 float32 float32_maxnummag(float32, float32, float_status *status);
-int float32_is_quiet_nan(float32, float_status *status);
-int float32_is_signaling_nan(float32, float_status *status);
+bool float32_is_quiet_nan(float32, float_status *status);
+bool float32_is_signaling_nan(float32, float_status *status);
 float32 float32_silence_nan(float32, float_status *status);
 float32 float32_scalbn(float32, int, float_status *status);
 
@@ -372,27 +372,27 @@ static inline float32 float32_chs(float32 a)
     return make_float32(float32_val(a) ^ 0x80000000);
 }
 
-static inline int float32_is_infinity(float32 a)
+static inline bool float32_is_infinity(float32 a)
 {
     return (float32_val(a) & 0x7fffffff) == 0x7f800000;
 }
 
-static inline int float32_is_neg(float32 a)
+static inline bool float32_is_neg(float32 a)
 {
     return float32_val(a) >> 31;
 }
 
-static inline int float32_is_zero(float32 a)
+static inline bool float32_is_zero(float32 a)
 {
     return (float32_val(a) & 0x7fffffff) == 0;
 }
 
-static inline int float32_is_any_nan(float32 a)
+static inline bool float32_is_any_nan(float32 a)
 {
     return ((float32_val(a) & ~(1 << 31)) > 0x7f800000UL);
 }
 
-static inline int float32_is_zero_or_denormal(float32 a)
+static inline bool float32_is_zero_or_denormal(float32 a)
 {
     return (float32_val(a) & 0x7f800000) == 0;
 }
@@ -540,8 +540,8 @@ float64 float64_minnum(float64, float64, float_status *status);
 float64 float64_maxnum(float64, float64, float_status *status);
 float64 float64_minnummag(float64, float64, float_status *status);
 float64 float64_maxnummag(float64, float64, float_status *status);
-int float64_is_quiet_nan(float64 a, float_status *status);
-int float64_is_signaling_nan(float64, float_status *status);
+bool float64_is_quiet_nan(float64 a, float_status *status);
+bool float64_is_signaling_nan(float64, float_status *status);
 float64 float64_silence_nan(float64, float_status *status);
 float64 float64_scalbn(float64, int, float_status *status);
 
@@ -561,27 +561,27 @@ static inline float64 float64_chs(float64 a)
     return make_float64(float64_val(a) ^ 0x8000000000000000LL);
 }
 
-static inline int float64_is_infinity(float64 a)
+static inline bool float64_is_infinity(float64 a)
 {
     return (float64_val(a) & 0x7fffffffffffffffLL ) == 0x7ff0000000000000LL;
 }
 
-static inline int float64_is_neg(float64 a)
+static inline bool float64_is_neg(float64 a)
 {
     return float64_val(a) >> 63;
 }
 
-static inline int float64_is_zero(float64 a)
+static inline bool float64_is_zero(float64 a)
 {
     return (float64_val(a) & 0x7fffffffffffffffLL) == 0;
 }
 
-static inline int float64_is_any_nan(float64 a)
+static inline bool float64_is_any_nan(float64 a)
 {
     return ((float64_val(a) & ~(1ULL << 63)) > 0x7ff0000000000000ULL);
 }
 
-static inline int float64_is_zero_or_denormal(float64 a)
+static inline bool float64_is_zero_or_denormal(float64 a)
 {
     return (float64_val(a) & 0x7ff0000000000000LL) == 0;
 }
@@ -708,7 +708,7 @@ static inline floatx80 floatx80_chs(floatx80 a)
     return a;
 }
 
-static inline int floatx80_is_infinity(floatx80 a)
+static inline bool floatx80_is_infinity(floatx80 a)
 {
 #if defined(TARGET_M68K)
     return (a.high & 0x7fff) == floatx80_infinity.high && !(a.low << 1);
@@ -718,22 +718,22 @@ static inline int floatx80_is_infinity(floatx80 a)
 #endif
 }
 
-static inline int floatx80_is_neg(floatx80 a)
+static inline bool floatx80_is_neg(floatx80 a)
 {
     return a.high >> 15;
 }
 
-static inline int floatx80_is_zero(floatx80 a)
+static inline bool floatx80_is_zero(floatx80 a)
 {
     return (a.high & 0x7fff) == 0 && a.low == 0;
 }
 
-static inline int floatx80_is_zero_or_denormal(floatx80 a)
+static inline bool floatx80_is_zero_or_denormal(floatx80 a)
 {
     return (a.high & 0x7fff) == 0;
 }
 
-static inline int floatx80_is_any_nan(floatx80 a)
+static inline bool floatx80_is_any_nan(floatx80 a)
 {
     return ((a.high & 0x7fff) == 0x7fff) && (a.low<<1);
 }
@@ -936,8 +936,8 @@ float128 float128_rem(float128, float128, float_status *status);
 float128 float128_sqrt(float128, float_status *status);
 FloatRelation float128_compare(float128, float128, float_status *status);
 FloatRelation float128_compare_quiet(float128, float128, float_status *status);
-int float128_is_quiet_nan(float128, float_status *status);
-int float128_is_signaling_nan(float128, float_status *status);
+bool float128_is_quiet_nan(float128, float_status *status);
+bool float128_is_signaling_nan(float128, float_status *status);
 float128 float128_silence_nan(float128, float_status *status);
 float128 float128_scalbn(float128, int, float_status *status);
 
@@ -953,22 +953,22 @@ static inline float128 float128_chs(float128 a)
     return a;
 }
 
-static inline int float128_is_infinity(float128 a)
+static inline bool float128_is_infinity(float128 a)
 {
     return (a.high & 0x7fffffffffffffffLL) == 0x7fff000000000000LL && a.low == 0;
 }
 
-static inline int float128_is_neg(float128 a)
+static inline bool float128_is_neg(float128 a)
 {
     return a.high >> 63;
 }
 
-static inline int float128_is_zero(float128 a)
+static inline bool float128_is_zero(float128 a)
 {
     return (a.high & 0x7fffffffffffffffLL) == 0 && a.low == 0;
 }
 
-static inline int float128_is_zero_or_denormal(float128 a)
+static inline bool float128_is_zero_or_denormal(float128 a)
 {
     return (a.high & 0x7fff000000000000LL) == 0;
 }
@@ -983,7 +983,7 @@ static inline bool float128_is_denormal(float128 a)
     return float128_is_zero_or_denormal(a) && !float128_is_zero(a);
 }
 
-static inline int float128_is_any_nan(float128 a)
+static inline bool float128_is_any_nan(float128 a)
 {
     return ((a.high >> 48) & 0x7fff) == 0x7fff &&
         ((a.low != 0) || ((a.high & 0xffffffffffffLL) != 0));
diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
index 025ee4f991..44f5b661f8 100644
--- a/fpu/softfloat-specialize.inc.c
+++ b/fpu/softfloat-specialize.inc.c
@@ -245,7 +245,7 @@ typedef struct {
 | NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int float16_is_quiet_nan(float16 a_, float_status *status)
+bool float16_is_quiet_nan(float16 a_, float_status *status)
 {
 #ifdef NO_SIGNALING_NANS
     return float16_is_any_nan(a_);
@@ -264,7 +264,7 @@ int float16_is_quiet_nan(float16 a_, float_status *status)
 | NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int float16_is_signaling_nan(float16 a_, float_status *status)
+bool float16_is_signaling_nan(float16 a_, float_status *status)
 {
 #ifdef NO_SIGNALING_NANS
     return 0;
@@ -283,7 +283,7 @@ int float16_is_signaling_nan(float16 a_, float_status *status)
 | NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int float32_is_quiet_nan(float32 a_, float_status *status)
+bool float32_is_quiet_nan(float32 a_, float_status *status)
 {
 #ifdef NO_SIGNALING_NANS
     return float32_is_any_nan(a_);
@@ -302,7 +302,7 @@ int float32_is_quiet_nan(float32 a_, float_status *status)
 | NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int float32_is_signaling_nan(float32 a_, float_status *status)
+bool float32_is_signaling_nan(float32 a_, float_status *status)
 {
 #ifdef NO_SIGNALING_NANS
     return 0;
@@ -637,7 +637,7 @@ static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
 | NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int float64_is_quiet_nan(float64 a_, float_status *status)
+bool float64_is_quiet_nan(float64 a_, float_status *status)
 {
 #ifdef NO_SIGNALING_NANS
     return float64_is_any_nan(a_);
@@ -657,7 +657,7 @@ int float64_is_quiet_nan(float64 a_, float_status *status)
 | NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int float64_is_signaling_nan(float64 a_, float_status *status)
+bool float64_is_signaling_nan(float64 a_, float_status *status)
 {
 #ifdef NO_SIGNALING_NANS
     return 0;
@@ -939,7 +939,7 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
 | NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int float128_is_quiet_nan(float128 a, float_status *status)
+bool float128_is_quiet_nan(float128 a, float_status *status)
 {
 #ifdef NO_SIGNALING_NANS
     return float128_is_any_nan(a);
@@ -959,7 +959,7 @@ int float128_is_quiet_nan(float128 a, float_status *status)
 | signaling NaN; otherwise returns 0.
 *----------------------------------------------------------------------------*/
 
-int float128_is_signaling_nan(float128 a, float_status *status)
+bool float128_is_signaling_nan(float128 a, float_status *status)
 {
 #ifdef NO_SIGNALING_NANS
     return 0;
-- 
2.20.1


