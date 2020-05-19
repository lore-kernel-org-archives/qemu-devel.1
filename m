Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8A1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BD12075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="saZnCBSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BD12075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5Vo-0004cX-5t
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RP-0004f8-EK
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:07 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:46323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RO-0006Cm-8e
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:07 -0400
Received: by mail-pf1-x42e.google.com with SMTP id 145so161074pfw.13
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9krfltsdrPyRRqutGHrEb2XJlVU12BnO8AU9UkCykds=;
 b=saZnCBSHamuCrS7yQ6dkqinrIqi2BifI58CI8L+xnX57s1tBz7fEiGXtRwg8DzcLPf
 SNG8ndYVJHeqGTwzRmUWegUbxbgD3lzQ8lBGa9rt0MFkoQ9oS1Xb5aRicjFQ/f+Y9ch1
 /wKFGW1dOqWTwLxx7btacDyfp3T1Xq7xj1x0A6u/9O5EivRVqhYAS8SIXesI8wLSP62T
 AMNyTzG0fvP0dw8m3gevxybOAIcOuI52aJvdJ8cLKzUP65D43O1ctHoSmhi6Z6qHR2BA
 CJTSVXMRhB87PxHBr6vYWOKgtvl+dGIhjDTTRoD4PPj+e05zxWnEBGZgQJCuRbw328RE
 cyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9krfltsdrPyRRqutGHrEb2XJlVU12BnO8AU9UkCykds=;
 b=N5ZJMQ/6CL2sbbDckkCQdY72eu/1C+zzBQXtZUDsVIkzV5CsyPvV6ujqOl/oQfBPTa
 FmV+6U+8eBZspzSAhL3SLOqIE+/rI8E9jo5wiYLps+98B7InK4iQYUa+D9+/eYwuNlIn
 irSR5JJUTzbZ3b0sFfS6ceophfcXS86C61rddX5ijyw4RDaG9RVl5k/RkhPFaQ1j1e9l
 KnazsRvzTDGbgXJOqXRp6w7ZkOu/uGl+97AI1tsNW58RtdR60AXWNOVI4TbZvMahF5Gf
 03+XKCGAKcDBFjE+CMN64Q8a1mEOY9nMdwzu893plmYkWQMlNZ36tvTR2iaVEsu+pXWU
 TFfg==
X-Gm-Message-State: AOAM532eVBpEIDA2Nwgdvh7p8h7qNM7wbBQwHa3mgARuaMgAxFgFRcG6
 Bt5H2Iz5CxFOKyOuecBc81gyrhuIPHc=
X-Google-Smtp-Source: ABdhPJyBwLv1XFtm3rQ12e4H8e5tXv9YXXRgEP2aBAxGTs6B+YqCRFNvA8Qlxv7QNX/pRE85DcK+ug==
X-Received: by 2002:a63:1e4c:: with SMTP id p12mr86745pgm.355.1589907003385;
 Tue, 19 May 2020 09:50:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gx21sm96685pjb.47.2020.05.19.09.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:50:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] softfloat: Change tininess_before_rounding to bool
Date: Tue, 19 May 2020 09:49:50 -0700
Message-Id: <20200519164957.26920-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519164957.26920-1-richard.henderson@linaro.org>
References: <20200519164957.26920-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Slightly tidies the usage within softfloat.c and the
representation in float_status.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h |  8 ++---
 include/fpu/softfloat-types.h   |  8 ++---
 fpu/softfloat.c                 | 54 ++++++++++++---------------------
 tests/fp/fp-test.c              |  2 +-
 4 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 528d7ebd9f..40d32a6d5d 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -53,9 +53,9 @@ this code that are retained.
 
 #include "fpu/softfloat-types.h"
 
-static inline void set_float_detect_tininess(int val, float_status *status)
+static inline void set_float_detect_tininess(bool val, float_status *status)
 {
-    status->float_detect_tininess = val;
+    status->tininess_before_rounding = val;
 }
 
 static inline void set_float_rounding_mode(int val, float_status *status)
@@ -94,9 +94,9 @@ static inline void set_snan_bit_is_one(bool val, float_status *status)
     status->snan_bit_is_one = val;
 }
 
-static inline int get_float_detect_tininess(float_status *status)
+static inline bool get_float_detect_tininess(float_status *status)
 {
-    return status->float_detect_tininess;
+    return status->tininess_before_rounding;
 }
 
 static inline int get_float_rounding_mode(float_status *status)
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 619b875df6..874ddd9f93 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -116,10 +116,8 @@ typedef struct {
  * Software IEC/IEEE floating-point underflow tininess-detection mode.
  */
 
-enum {
-    float_tininess_after_rounding  = 0,
-    float_tininess_before_rounding = 1
-};
+#define float_tininess_after_rounding  false
+#define float_tininess_before_rounding true
 
 /*
  *Software IEC/IEEE floating-point rounding mode.
@@ -158,10 +156,10 @@ enum {
  */
 
 typedef struct float_status {
-    signed char float_detect_tininess;
     signed char float_rounding_mode;
     uint8_t     float_exception_flags;
     signed char floatx80_rounding_precision;
+    bool tininess_before_rounding;
     /* should denormalised results go to zero and set the inexact flag? */
     bool flush_to_zero;
     /* should denormalised inputs go to zero and set the input_denormal flag? */
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b741cf5bc3..65d457a548 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -744,8 +744,7 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
             p.cls = float_class_zero;
             goto do_zero;
         } else {
-            bool is_tiny = (s->float_detect_tininess
-                            == float_tininess_before_rounding)
+            bool is_tiny = s->tininess_before_rounding
                         || (exp < 0)
                         || !((frac + inc) & DECOMPOSED_OVERFLOW_BIT);
 
@@ -3579,11 +3578,9 @@ static float32 roundAndPackFloat32(bool zSign, int zExp, uint32_t zSig,
                 float_raise(float_flag_output_denormal, status);
                 return packFloat32(zSign, 0, 0);
             }
-            isTiny =
-                (status->float_detect_tininess
-                 == float_tininess_before_rounding)
-                || ( zExp < -1 )
-                || ( zSig + roundIncrement < 0x80000000 );
+            isTiny = status->tininess_before_rounding
+                  || (zExp < -1)
+                  || (zSig + roundIncrement < 0x80000000);
             shift32RightJamming( zSig, - zExp, &zSig );
             zExp = 0;
             roundBits = zSig & 0x7F;
@@ -3735,11 +3732,9 @@ static float64 roundAndPackFloat64(bool zSign, int zExp, uint64_t zSig,
                 float_raise(float_flag_output_denormal, status);
                 return packFloat64(zSign, 0, 0);
             }
-            isTiny =
-                   (status->float_detect_tininess
-                    == float_tininess_before_rounding)
-                || ( zExp < -1 )
-                || ( zSig + roundIncrement < UINT64_C(0x8000000000000000) );
+            isTiny = status->tininess_before_rounding
+                  || (zExp < -1)
+                  || (zSig + roundIncrement < UINT64_C(0x8000000000000000));
             shift64RightJamming( zSig, - zExp, &zSig );
             zExp = 0;
             roundBits = zSig & 0x3FF;
@@ -3878,11 +3873,9 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, bool zSign,
                 float_raise(float_flag_output_denormal, status);
                 return packFloatx80(zSign, 0, 0);
             }
-            isTiny =
-                   (status->float_detect_tininess
-                    == float_tininess_before_rounding)
-                || ( zExp < 0 )
-                || ( zSig0 <= zSig0 + roundIncrement );
+            isTiny = status->tininess_before_rounding
+                  || (zExp < 0 )
+                  || (zSig0 <= zSig0 + roundIncrement);
             shift64RightJamming( zSig0, 1 - zExp, &zSig0 );
             zExp = 0;
             roundBits = zSig0 & roundMask;
@@ -3956,12 +3949,10 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, bool zSign,
                                 floatx80_infinity_low);
         }
         if ( zExp <= 0 ) {
-            isTiny =
-                   (status->float_detect_tininess
-                    == float_tininess_before_rounding)
-                || ( zExp < 0 )
-                || ! increment
-                || ( zSig0 < UINT64_C(0xFFFFFFFFFFFFFFFF) );
+            isTiny = status->tininess_before_rounding
+                  || (zExp < 0)
+                  || !increment
+                  || (zSig0 < UINT64_C(0xFFFFFFFFFFFFFFFF));
             shift64ExtraRightJamming( zSig0, zSig1, 1 - zExp, &zSig0, &zSig1 );
             zExp = 0;
             if (isTiny && zSig1) {
@@ -4237,17 +4228,12 @@ static float128 roundAndPackFloat128(bool zSign, int32_t zExp,
                 float_raise(float_flag_output_denormal, status);
                 return packFloat128(zSign, 0, 0, 0);
             }
-            isTiny =
-                   (status->float_detect_tininess
-                    == float_tininess_before_rounding)
-                || ( zExp < -1 )
-                || ! increment
-                || lt128(
-                       zSig0,
-                       zSig1,
-                       UINT64_C(0x0001FFFFFFFFFFFF),
-                       UINT64_C(0xFFFFFFFFFFFFFFFF)
-                   );
+            isTiny = status->tininess_before_rounding
+                  || (zExp < -1)
+                  || !increment
+                  || lt128(zSig0, zSig1,
+                           UINT64_C(0x0001FFFFFFFFFFFF),
+                           UINT64_C(0xFFFFFFFFFFFFFFFF));
             shift128ExtraRightJamming(
                 zSig0, zSig1, zSig2, - zExp, &zSig0, &zSig1, &zSig2 );
             zExp = 0;
diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
index 7d0faf2b47..43ef9628c4 100644
--- a/tests/fp/fp-test.c
+++ b/tests/fp/fp-test.c
@@ -989,7 +989,7 @@ static void QEMU_NORETURN run_test(void)
 
                     verCases_tininessCode = 0;
                     slowfloat_detectTininess = tmode;
-                    qsf.float_detect_tininess = sf_tininess_to_qemu(tmode);
+                    qsf.tininess_before_rounding = sf_tininess_to_qemu(tmode);
 
                     if (attrs & FUNC_EFF_TININESSMODE ||
                         ((attrs & FUNC_EFF_TININESSMODE_REDUCEDPREC) &&
-- 
2.20.1


