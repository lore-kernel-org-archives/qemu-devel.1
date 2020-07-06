Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51729C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F57C206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXil+WvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F57C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsaqz-0002TY-Ar
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaq4-0000oj-FJ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:47:56 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:40392)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaq2-0000oI-PQ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:47:56 -0400
Received: by mail-pf1-x430.google.com with SMTP id u5so17622745pfn.7
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5fZcWsFgtINbL3J+mcEvZWKMQgiYWvYOG6ARA8oxr8g=;
 b=PXil+WvOeuL0lV3Id9Lll8hPOJEdOK8GZlVB8wtopDF45lS6cfrUuORooubQ6CpDCa
 7KhAnqAV+NxK6Vm6AX/Wb4OKN2jyHeIr7Y5Ay/NCOgk8/qoVGE0n8WN3XA45lsmZGHmE
 dJzGvWpdvRsxUU4zIVBPcDh2KNpYslwv5HpXyQ9tUzMMSA+N44S2cGYMYAiak4goaIJC
 +iy1lKOdpBhRalZhimvFzcwUAw+vJvbpHdDUoT54/Ze4/+ryuoyRyFt/UmQEbi46RXov
 vTJZuWewOfle7eoDLIj/4FaHbGFnfGrEST+J6T4n5E77FzfIKqbJTGtC4HOd0Rp+XlBF
 isZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5fZcWsFgtINbL3J+mcEvZWKMQgiYWvYOG6ARA8oxr8g=;
 b=Q8+JUG7hA/71JK89cKOxhE6v3u2kETAVhQr04TGknMR33EJ13Oj/2cX0sL9nXyi5ry
 yZjtaGLJcLfBDSYhvO84lFr6rAAH6XS/52mbYeLh9eUUOyNQJH16Ix1pqxNO9z42jH3i
 84eDqJuouWaAyR+g6VnHmFoWY1iG3LEKFvivxoQ3yZ5NnG0WjnRvzGFGqxclBYg9kD3o
 fPgSs1jlV03n7+ky7CN76Q7z1F2EAy4EuFzzcp5RVbx2Af8yFeMpa4iXEUq8AM6bAln6
 vrCKrD3aXHIiCS1oApt5r2UF/+DOV93Ct+U2KAxGFieAMleRnVkpjUHrzWB7UpU7bhGS
 tI+Q==
X-Gm-Message-State: AOAM531vzftRGLYTIrmRTEk9JHpo5rGzGmDXIS0OkeshRPonuioZ0xff
 SidhRoTRZhrlCwh8IBbWsqAYhILc
X-Google-Smtp-Source: ABdhPJywhiwHXKrlETP8/g7miSNEbQFEeNnEYLdRLf/B8FUxWQVkbEwkzrv0DMC0kNXxm6NZsjKL7Q==
X-Received: by 2002:a63:5a1a:: with SMTP id o26mr41747427pgb.420.1594079273222; 
 Mon, 06 Jul 2020 16:47:53 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id e15sm19647649pgt.17.2020.07.06.16.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 16:47:52 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/21] softfloat: pass float_status pointer to pickNaN
Date: Mon,  6 Jul 2020 16:47:18 -0700
Message-Id: <20200706234737.32378-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706234737.32378-1-jcmvbkbc@gmail.com>
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pass float_status structure pointer to the pickNaN so that
machine-specific settings are available to NaN selection code.
Add use_first_nan property to float_status and use it in Xtensa-specific
pickNaN.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Alex Bennée" <alex.bennee@linaro.org>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 fpu/softfloat-specialize.inc.c  | 30 ++++++++++++++++++++++++------
 fpu/softfloat.c                 |  2 +-
 include/fpu/softfloat-helpers.h |  5 +++++
 include/fpu/softfloat-types.h   |  1 +
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
index b26bc039b0b6..e17327b405c5 100644
--- a/fpu/softfloat-specialize.inc.c
+++ b/fpu/softfloat-specialize.inc.c
@@ -368,7 +368,7 @@ static float32 commonNaNToFloat32(commonNaNT a, float_status *status)
 *----------------------------------------------------------------------------*/
 
 static int pickNaN(FloatClass a_cls, FloatClass b_cls,
-                   bool aIsLargerSignificand)
+                   bool aIsLargerSignificand, float_status *status)
 {
 #if defined(TARGET_ARM) || defined(TARGET_MIPS) || defined(TARGET_HPPA)
     /* ARM mandated NaN propagation rules (see FPProcessNaNs()), take
@@ -401,7 +401,7 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     } else {
         return 1;
     }
-#elif defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
+#elif defined(TARGET_PPC) || defined(TARGET_M68K)
     /* PowerPC propagation rules:
      *  1. A if it sNaN or qNaN
      *  2. B if it sNaN or qNaN
@@ -426,6 +426,24 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     } else {
         return 1;
     }
+#elif defined(TARGET_XTENSA)
+    /*
+     * Xtensa has two NaN propagation modes.
+     * Which one is active is controlled by float_status::use_first_nan.
+     */
+    if (status->use_first_nan) {
+        if (is_nan(a_cls)) {
+            return 0;
+        } else {
+            return 1;
+        }
+    } else {
+        if (is_nan(b_cls)) {
+            return 1;
+        } else {
+            return 0;
+        }
+    }
 #else
     /* This implements x87 NaN propagation rules:
      * SNaN + QNaN => return the QNaN
@@ -613,7 +631,7 @@ static float32 propagateFloat32NaN(float32 a, float32 b, float_status *status)
         aIsLargerSignificand = (av < bv) ? 1 : 0;
     }
 
-    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
         if (is_snan(b_cls)) {
             return float32_silence_nan(b, status);
         }
@@ -751,7 +769,7 @@ static float64 propagateFloat64NaN(float64 a, float64 b, float_status *status)
         aIsLargerSignificand = (av < bv) ? 1 : 0;
     }
 
-    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
         if (is_snan(b_cls)) {
             return float64_silence_nan(b, status);
         }
@@ -915,7 +933,7 @@ floatx80 propagateFloatx80NaN(floatx80 a, floatx80 b, float_status *status)
         aIsLargerSignificand = (a.high < b.high) ? 1 : 0;
     }
 
-    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
         if (is_snan(b_cls)) {
             return floatx80_silence_nan(b, status);
         }
@@ -1063,7 +1081,7 @@ static float128 propagateFloat128NaN(float128 a, float128 b,
         aIsLargerSignificand = (a.high < b.high) ? 1 : 0;
     }
 
-    if (pickNaN(a_cls, b_cls, aIsLargerSignificand)) {
+    if (pickNaN(a_cls, b_cls, aIsLargerSignificand, status)) {
         if (is_snan(b_cls)) {
             return float128_silence_nan(b, status);
         }
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5e9746c2876f..a89056a1816e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -881,7 +881,7 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
     } else {
         if (pickNaN(a.cls, b.cls,
                     a.frac > b.frac ||
-                    (a.frac == b.frac && a.sign < b.sign))) {
+                    (a.frac == b.frac && a.sign < b.sign), s)) {
             a = b;
         }
         if (is_snan(a.cls)) {
diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index e842f83a1285..2f0674fbddec 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -95,6 +95,11 @@ static inline void set_snan_bit_is_one(bool val, float_status *status)
     status->snan_bit_is_one = val;
 }
 
+static inline void set_use_first_nan(bool val, float_status *status)
+{
+    status->use_first_nan = val;
+}
+
 static inline void set_no_signaling_nans(bool val, float_status *status)
 {
     status->no_signaling_nans = val;
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 10bd208e559f..aaee6e4cdd23 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -167,6 +167,7 @@ typedef struct float_status {
     bool default_nan_mode;
     /* not always used -- see snan_bit_is_one() in softfloat-specialize.h */
     bool snan_bit_is_one;
+    bool use_first_nan;
     bool no_signaling_nans;
 } float_status;
 
-- 
2.20.1


