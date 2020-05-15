Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FD9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DD7206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 19:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBajGoxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DD7206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfch-0003tf-2T
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 15:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfax-0001i3-6U
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:07 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfav-0001pY-8J
 for qemu-devel@nongnu.org; Fri, 15 May 2020 15:02:06 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ms17so1384603pjb.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q+zetOzBE/rjpE5+NH0tkW8q8EOrighVmn58Jc6eUfU=;
 b=bBajGoxYkKwXA5YfYj5AC2rfN6tI2AJ4Z6S6pqdGwvOqazMxP9vVtRT4CvcB+JV1AQ
 8VeckrgpfKeJmVK3WhkLOu+nEYnx6pG01POHpSiwKy76EbKUEHzpV3/nbAQgMvn+Qk0F
 hNBMd7wTscES82BX59sxk+CYvNHe4D6mFsWeYscRpv+UI+U7FabvX8WKwxIhEDzK6f6K
 LbgF1q/ICucFHka9dHwLehi/9N60vbKLNNaoUhcSmV2horceOD87su3sW4433gnofzy7
 cdmMPfVRhrHuIvCJzY0EspyNDlTmgnFU1E4ZmnV2DQ+Pio3dCZkXNUybfFmFJneZf370
 jZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q+zetOzBE/rjpE5+NH0tkW8q8EOrighVmn58Jc6eUfU=;
 b=gSMrEkZbil1ipb43tT7U4biXaPOIw7MFpKEYMhvYuxIh603IX8AX1/2u53I0Yxd0Tq
 7EhRifPaiWArMcENrRc3MKySMvTFlltQYj3Ue8HSZle2T8IjUoxVGZqiyWdXDaqw2GA/
 c+1Q7tsIY4IB0PgNU/AEfCCrFwLps17s7me0KRq5Qi5fe20MozktYg6sVkW+iQ2tDU+l
 bTp18NwjRgmIMOZyM37CjAg92IHkrm+pMO+2U98+5JkmmTe8u6jGodjO/vp43U53XHFI
 juTtY67Rtjmk93+i6zGTWdaQYrXLNgJzP79lo+bTphKBslqzttcFS9MXyquQwhAUZ9CN
 uidg==
X-Gm-Message-State: AOAM532IByBHU0LMb9X6oD2ijBNHMwmlSwe4Ejh+hU5rjhr+IabpOOPS
 DCvaJJsiHwQcJ6o0gl6aF/yGE1QK5bQ=
X-Google-Smtp-Source: ABdhPJzEDGdvbIKjoN/j3txq1ee6kD0y0U9e2jdRCremG9HGf5N67cXtZ/z56LEqxTNEOLeGXeo9wQ==
X-Received: by 2002:a17:902:e905:: with SMTP id
 k5mr5085016pld.232.1589569322943; 
 Fri, 15 May 2020 12:02:02 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q21sm2485719pfg.131.2020.05.15.12.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 12:02:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/10] softfloat: Name compare relation enum
Date: Fri, 15 May 2020 12:01:48 -0700
Message-Id: <20200515190153.6017-6-richard.henderson@linaro.org>
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

Give the previously unnamed enum a typedef name.  Use it in the
prototypes of compare functions.  Use it to hold the results
of the compare functions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h         | 25 +++++++++++----------
 target/i386/ops_sse.h           |  8 +++----
 fpu/softfloat.c                 | 40 ++++++++++++++++++---------------
 target/arm/vfp_helper.c         |  2 +-
 target/hppa/op_helper.c         |  7 +++---
 target/i386/fpu_helper.c        |  8 +++----
 target/openrisc/fpu_helper.c    |  4 ++--
 target/ppc/int_helper.c         | 13 ++++++-----
 target/s390x/fpu_helper.c       | 22 +++++++++---------
 target/sparc/fop_helper.c       |  4 ++--
 target/unicore32/ucf64_helper.c |  6 ++---
 target/xtensa/fpu_helper.c      |  6 ++---
 12 files changed, 75 insertions(+), 70 deletions(-)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index ca75f764aa..7f84235122 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -85,12 +85,13 @@ this code that are retained.
 /*----------------------------------------------------------------------------
 | Software IEC/IEEE floating-point ordering relations
 *----------------------------------------------------------------------------*/
-enum {
+
+typedef enum {
     float_relation_less      = -1,
     float_relation_equal     =  0,
     float_relation_greater   =  1,
     float_relation_unordered =  2
-};
+} FloatRelation;
 
 #include "fpu/softfloat-types.h"
 #include "fpu/softfloat-helpers.h"
@@ -231,8 +232,8 @@ float16 float16_maxnum(float16, float16, float_status *status);
 float16 float16_minnummag(float16, float16, float_status *status);
 float16 float16_maxnummag(float16, float16, float_status *status);
 float16 float16_sqrt(float16, float_status *status);
-int float16_compare(float16, float16, float_status *status);
-int float16_compare_quiet(float16, float16, float_status *status);
+FloatRelation float16_compare(float16, float16, float_status *status);
+FloatRelation float16_compare_quiet(float16, float16, float_status *status);
 
 int float16_is_quiet_nan(float16, float_status *status);
 int float16_is_signaling_nan(float16, float_status *status);
@@ -350,8 +351,8 @@ int float32_eq_quiet(float32, float32, float_status *status);
 int float32_le_quiet(float32, float32, float_status *status);
 int float32_lt_quiet(float32, float32, float_status *status);
 int float32_unordered_quiet(float32, float32, float_status *status);
-int float32_compare(float32, float32, float_status *status);
-int float32_compare_quiet(float32, float32, float_status *status);
+FloatRelation float32_compare(float32, float32, float_status *status);
+FloatRelation float32_compare_quiet(float32, float32, float_status *status);
 float32 float32_min(float32, float32, float_status *status);
 float32 float32_max(float32, float32, float_status *status);
 float32 float32_minnum(float32, float32, float_status *status);
@@ -506,8 +507,8 @@ int float64_eq_quiet(float64, float64, float_status *status);
 int float64_le_quiet(float64, float64, float_status *status);
 int float64_lt_quiet(float64, float64, float_status *status);
 int float64_unordered_quiet(float64, float64, float_status *status);
-int float64_compare(float64, float64, float_status *status);
-int float64_compare_quiet(float64, float64, float_status *status);
+FloatRelation float64_compare(float64, float64, float_status *status);
+FloatRelation float64_compare_quiet(float64, float64, float_status *status);
 float64 float64_min(float64, float64, float_status *status);
 float64 float64_max(float64, float64, float_status *status);
 float64 float64_minnum(float64, float64, float_status *status);
@@ -630,8 +631,8 @@ int floatx80_eq_quiet(floatx80, floatx80, float_status *status);
 int floatx80_le_quiet(floatx80, floatx80, float_status *status);
 int floatx80_lt_quiet(floatx80, floatx80, float_status *status);
 int floatx80_unordered_quiet(floatx80, floatx80, float_status *status);
-int floatx80_compare(floatx80, floatx80, float_status *status);
-int floatx80_compare_quiet(floatx80, floatx80, float_status *status);
+FloatRelation floatx80_compare(floatx80, floatx80, float_status *status);
+FloatRelation floatx80_compare_quiet(floatx80, floatx80, float_status *status);
 int floatx80_is_quiet_nan(floatx80, float_status *status);
 int floatx80_is_signaling_nan(floatx80, float_status *status);
 floatx80 floatx80_silence_nan(floatx80, float_status *status);
@@ -842,8 +843,8 @@ int float128_eq_quiet(float128, float128, float_status *status);
 int float128_le_quiet(float128, float128, float_status *status);
 int float128_lt_quiet(float128, float128, float_status *status);
 int float128_unordered_quiet(float128, float128, float_status *status);
-int float128_compare(float128, float128, float_status *status);
-int float128_compare_quiet(float128, float128, float_status *status);
+FloatRelation float128_compare(float128, float128, float_status *status);
+FloatRelation float128_compare_quiet(float128, float128, float_status *status);
 int float128_is_quiet_nan(float128, float_status *status);
 int float128_is_signaling_nan(float128, float_status *status);
 float128 float128_silence_nan(float128, float_status *status);
diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index ec1ec745d0..4658768de2 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -1031,7 +1031,7 @@ static const int comis_eflags[4] = {CC_C, CC_Z, 0, CC_Z | CC_P | CC_C};
 
 void helper_ucomiss(CPUX86State *env, Reg *d, Reg *s)
 {
-    int ret;
+    FloatRelation ret;
     float32 s0, s1;
 
     s0 = d->ZMM_S(0);
@@ -1042,7 +1042,7 @@ void helper_ucomiss(CPUX86State *env, Reg *d, Reg *s)
 
 void helper_comiss(CPUX86State *env, Reg *d, Reg *s)
 {
-    int ret;
+    FloatRelation ret;
     float32 s0, s1;
 
     s0 = d->ZMM_S(0);
@@ -1053,7 +1053,7 @@ void helper_comiss(CPUX86State *env, Reg *d, Reg *s)
 
 void helper_ucomisd(CPUX86State *env, Reg *d, Reg *s)
 {
-    int ret;
+    FloatRelation ret;
     float64 d0, d1;
 
     d0 = d->ZMM_D(0);
@@ -1064,7 +1064,7 @@ void helper_ucomisd(CPUX86State *env, Reg *d, Reg *s)
 
 void helper_comisd(CPUX86State *env, Reg *d, Reg *s)
 {
-    int ret;
+    FloatRelation ret;
     float64 d0, d1;
 
     d0 = d->ZMM_D(0);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 93d8a03de6..60b9ae5f05 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2848,8 +2848,8 @@ MINMAX(64, maxnummag, false, true, true)
 #undef MINMAX
 
 /* Floating point compare */
-static int compare_floats(FloatParts a, FloatParts b, bool is_quiet,
-                          float_status *s)
+static FloatRelation compare_floats(FloatParts a, FloatParts b, bool is_quiet,
+                                    float_status *s)
 {
     if (is_nan(a.cls) || is_nan(b.cls)) {
         if (!is_quiet ||
@@ -2920,17 +2920,17 @@ COMPARE(soft_f64_compare, QEMU_SOFTFLOAT_ATTR, 64)
 
 #undef COMPARE
 
-int float16_compare(float16 a, float16 b, float_status *s)
+FloatRelation float16_compare(float16 a, float16 b, float_status *s)
 {
     return soft_f16_compare(a, b, false, s);
 }
 
-int float16_compare_quiet(float16 a, float16 b, float_status *s)
+FloatRelation float16_compare_quiet(float16 a, float16 b, float_status *s)
 {
     return soft_f16_compare(a, b, true, s);
 }
 
-static int QEMU_FLATTEN
+static FloatRelation QEMU_FLATTEN
 f32_compare(float32 xa, float32 xb, bool is_quiet, float_status *s)
 {
     union_float32 ua, ub;
@@ -2959,17 +2959,17 @@ f32_compare(float32 xa, float32 xb, bool is_quiet, float_status *s)
     return soft_f32_compare(ua.s, ub.s, is_quiet, s);
 }
 
-int float32_compare(float32 a, float32 b, float_status *s)
+FloatRelation float32_compare(float32 a, float32 b, float_status *s)
 {
     return f32_compare(a, b, false, s);
 }
 
-int float32_compare_quiet(float32 a, float32 b, float_status *s)
+FloatRelation float32_compare_quiet(float32 a, float32 b, float_status *s)
 {
     return f32_compare(a, b, true, s);
 }
 
-static int QEMU_FLATTEN
+static FloatRelation QEMU_FLATTEN
 f64_compare(float64 xa, float64 xb, bool is_quiet, float_status *s)
 {
     union_float64 ua, ub;
@@ -2998,12 +2998,12 @@ f64_compare(float64 xa, float64 xb, bool is_quiet, float_status *s)
     return soft_f64_compare(ua.s, ub.s, is_quiet, s);
 }
 
-int float64_compare(float64 a, float64 b, float_status *s)
+FloatRelation float64_compare(float64 a, float64 b, float_status *s)
 {
     return f64_compare(a, b, false, s);
 }
 
-int float64_compare_quiet(float64 a, float64 b, float_status *s)
+FloatRelation float64_compare_quiet(float64 a, float64 b, float_status *s)
 {
     return f64_compare(a, b, true, s);
 }
@@ -7892,8 +7892,9 @@ int float128_unordered_quiet(float128 a, float128 b, float_status *status)
     return 0;
 }
 
-static inline int floatx80_compare_internal(floatx80 a, floatx80 b,
-                                            int is_quiet, float_status *status)
+static inline FloatRelation
+floatx80_compare_internal(floatx80 a, floatx80 b, bool is_quiet,
+                          float_status *status)
 {
     bool aSign, bSign;
 
@@ -7939,18 +7940,20 @@ static inline int floatx80_compare_internal(floatx80 a, floatx80 b,
     }
 }
 
-int floatx80_compare(floatx80 a, floatx80 b, float_status *status)
+FloatRelation floatx80_compare(floatx80 a, floatx80 b, float_status *status)
 {
     return floatx80_compare_internal(a, b, 0, status);
 }
 
-int floatx80_compare_quiet(floatx80 a, floatx80 b, float_status *status)
+FloatRelation floatx80_compare_quiet(floatx80 a, floatx80 b,
+                                     float_status *status)
 {
     return floatx80_compare_internal(a, b, 1, status);
 }
 
-static inline int float128_compare_internal(float128 a, float128 b,
-                                            int is_quiet, float_status *status)
+static inline FloatRelation
+float128_compare_internal(float128 a, float128 b, bool is_quiet,
+                          float_status *status)
 {
     bool aSign, bSign;
 
@@ -7983,12 +7986,13 @@ static inline int float128_compare_internal(float128 a, float128 b,
     }
 }
 
-int float128_compare(float128 a, float128 b, float_status *status)
+FloatRelation float128_compare(float128 a, float128 b, float_status *status)
 {
     return float128_compare_internal(a, b, 0, status);
 }
 
-int float128_compare_quiet(float128 a, float128 b, float_status *status)
+FloatRelation float128_compare_quiet(float128 a, float128 b,
+                                     float_status *status)
 {
     return float128_compare_internal(a, b, 1, status);
 }
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 0920694764..60dcd4bf14 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -281,7 +281,7 @@ float64 VFP_HELPER(sqrt, d)(float64 a, CPUARMState *env)
     return float64_sqrt(a, &env->vfp.fp_status);
 }
 
-static void softfloat_to_vfp_compare(CPUARMState *env, int cmp)
+static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
 {
     uint32_t flags;
     switch (cmp) {
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 7823706e9c..5685e303ab 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -523,7 +523,8 @@ uint64_t HELPER(fcnv_t_d_udw)(CPUHPPAState *env, float64 arg)
     return ret;
 }
 
-static void update_fr0_cmp(CPUHPPAState *env, uint32_t y, uint32_t c, int r)
+static void update_fr0_cmp(CPUHPPAState *env, uint32_t y,
+                           uint32_t c, FloatRelation r)
 {
     uint32_t shadow = env->fr0_shadow;
 
@@ -565,7 +566,7 @@ static void update_fr0_cmp(CPUHPPAState *env, uint32_t y, uint32_t c, int r)
 void HELPER(fcmp_s)(CPUHPPAState *env, float32 a, float32 b,
                     uint32_t y, uint32_t c)
 {
-    int r;
+    FloatRelation r;
     if (c & 1) {
         r = float32_compare(a, b, &env->fp_status);
     } else {
@@ -578,7 +579,7 @@ void HELPER(fcmp_s)(CPUHPPAState *env, float32 a, float32 b,
 void HELPER(fcmp_d)(CPUHPPAState *env, float64 a, float64 b,
                     uint32_t y, uint32_t c)
 {
-    int r;
+    FloatRelation r;
     if (c & 1) {
         r = float64_compare(a, b, &env->fp_status);
     } else {
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 792a128a6d..b34fa784eb 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -420,7 +420,7 @@ static const int fcom_ccval[4] = {0x0100, 0x4000, 0x0000, 0x4500};
 
 void helper_fcom_ST0_FT0(CPUX86State *env)
 {
-    int ret;
+    FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
     env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
@@ -428,7 +428,7 @@ void helper_fcom_ST0_FT0(CPUX86State *env)
 
 void helper_fucom_ST0_FT0(CPUX86State *env)
 {
-    int ret;
+    FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
     env->fpus = (env->fpus & ~0x4500) | fcom_ccval[ret + 1];
@@ -439,7 +439,7 @@ static const int fcomi_ccval[4] = {CC_C, CC_Z, 0, CC_Z | CC_P | CC_C};
 void helper_fcomi_ST0_FT0(CPUX86State *env)
 {
     int eflags;
-    int ret;
+    FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
     eflags = cpu_cc_compute_all(env, CC_OP);
@@ -450,7 +450,7 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
 void helper_fucomi_ST0_FT0(CPUX86State *env)
 {
     int eflags;
-    int ret;
+    FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
     eflags = cpu_cc_compute_all(env, CC_OP);
diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
index 6f75ea0505..f9e34fa2cc 100644
--- a/target/openrisc/fpu_helper.c
+++ b/target/openrisc/fpu_helper.c
@@ -155,13 +155,13 @@ FLOAT_CMP(un, unordered_quiet)
 target_ulong helper_float_ ## name ## _d(CPUOpenRISCState *env,           \
                                          uint64_t fdt0, uint64_t fdt1)    \
 {                                                                         \
-    int r = float64_compare_quiet(fdt0, fdt1, &env->fp_status);           \
+    FloatRelation r = float64_compare_quiet(fdt0, fdt1, &env->fp_status); \
     return expr;                                                          \
 }                                                                         \
 target_ulong helper_float_ ## name ## _s(CPUOpenRISCState *env,           \
                                          uint32_t fdt0, uint32_t fdt1)    \
 {                                                                         \
-    int r = float32_compare_quiet(fdt0, fdt1, &env->fp_status);           \
+    FloatRelation r = float32_compare_quiet(fdt0, fdt1, &env->fp_status); \
     return expr;                                                          \
 }
 
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 6d238b989d..be53cd6f68 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -770,8 +770,9 @@ VCMPNE(w, u32, uint32_t, 0)
                                                                         \
         for (i = 0; i < ARRAY_SIZE(r->f32); i++) {                      \
             uint32_t result;                                            \
-            int rel = float32_compare_quiet(a->f32[i], b->f32[i],       \
-                                            &env->vec_status);          \
+            FloatRelation rel =                                         \
+                float32_compare_quiet(a->f32[i], b->f32[i],             \
+                                      &env->vec_status);                \
             if (rel == float_relation_unordered) {                      \
                 result = 0;                                             \
             } else if (rel compare order) {                             \
@@ -803,15 +804,15 @@ static inline void vcmpbfp_internal(CPUPPCState *env, ppc_avr_t *r,
     int all_in = 0;
 
     for (i = 0; i < ARRAY_SIZE(r->f32); i++) {
-        int le_rel = float32_compare_quiet(a->f32[i], b->f32[i],
-                                           &env->vec_status);
+        FloatRelation le_rel = float32_compare_quiet(a->f32[i], b->f32[i],
+                                                     &env->vec_status);
         if (le_rel == float_relation_unordered) {
             r->u32[i] = 0xc0000000;
             all_in = 1;
         } else {
             float32 bneg = float32_chs(b->f32[i]);
-            int ge_rel = float32_compare_quiet(a->f32[i], bneg,
-                                               &env->vec_status);
+            FloatRelation ge_rel = float32_compare_quiet(a->f32[i], bneg,
+                                                         &env->vec_status);
             int le = le_rel != float_relation_greater;
             int ge = ge_rel != float_relation_less;
 
diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
index 8bb9f54fd0..f155bc048c 100644
--- a/target/s390x/fpu_helper.c
+++ b/target/s390x/fpu_helper.c
@@ -112,7 +112,7 @@ static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
     }
 }
 
-int float_comp_to_cc(CPUS390XState *env, int float_compare)
+int float_comp_to_cc(CPUS390XState *env, FloatRelation float_compare)
 {
     switch (float_compare) {
     case float_relation_equal:
@@ -368,7 +368,7 @@ uint64_t HELPER(lexb)(CPUS390XState *env, uint64_t ah, uint64_t al,
 /* 32-bit FP compare */
 uint32_t HELPER(ceb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
-    int cmp = float32_compare_quiet(f1, f2, &env->fpu_status);
+    FloatRelation cmp = float32_compare_quiet(f1, f2, &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
@@ -376,7 +376,7 @@ uint32_t HELPER(ceb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 /* 64-bit FP compare */
 uint32_t HELPER(cdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
-    int cmp = float64_compare_quiet(f1, f2, &env->fpu_status);
+    FloatRelation cmp = float64_compare_quiet(f1, f2, &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
@@ -385,9 +385,9 @@ uint32_t HELPER(cdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 uint32_t HELPER(cxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
                      uint64_t bh, uint64_t bl)
 {
-    int cmp = float128_compare_quiet(make_float128(ah, al),
-                                     make_float128(bh, bl),
-                                     &env->fpu_status);
+    FloatRelation cmp = float128_compare_quiet(make_float128(ah, al),
+                                               make_float128(bh, bl),
+                                               &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
@@ -675,7 +675,7 @@ uint64_t HELPER(fixb)(CPUS390XState *env, uint64_t ah, uint64_t al,
 /* 32-bit FP compare and signal */
 uint32_t HELPER(keb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
-    int cmp = float32_compare(f1, f2, &env->fpu_status);
+    FloatRelation cmp = float32_compare(f1, f2, &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
@@ -683,7 +683,7 @@ uint32_t HELPER(keb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 /* 64-bit FP compare and signal */
 uint32_t HELPER(kdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
-    int cmp = float64_compare(f1, f2, &env->fpu_status);
+    FloatRelation cmp = float64_compare(f1, f2, &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
@@ -692,9 +692,9 @@ uint32_t HELPER(kdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 uint32_t HELPER(kxb)(CPUS390XState *env, uint64_t ah, uint64_t al,
                      uint64_t bh, uint64_t bl)
 {
-    int cmp = float128_compare(make_float128(ah, al),
-                               make_float128(bh, bl),
-                               &env->fpu_status);
+    FloatRelation cmp = float128_compare(make_float128(ah, al),
+                                         make_float128(bh, bl),
+                                         &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return float_comp_to_cc(env, cmp);
 }
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 9eb9b75718..e6dd3fc313 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -264,7 +264,7 @@ void helper_fsqrtq(CPUSPARCState *env)
 #define GEN_FCMP(name, size, reg1, reg2, FS, E)                         \
     target_ulong glue(helper_, name) (CPUSPARCState *env)               \
     {                                                                   \
-        int ret;                                                        \
+        FloatRelation ret;                                              \
         target_ulong fsr;                                               \
         if (E) {                                                        \
             ret = glue(size, _compare)(reg1, reg2, &env->fp_status);    \
@@ -295,7 +295,7 @@ void helper_fsqrtq(CPUSPARCState *env)
 #define GEN_FCMP_T(name, size, FS, E)                                   \
     target_ulong glue(helper_, name)(CPUSPARCState *env, size src1, size src2)\
     {                                                                   \
-        int ret;                                                        \
+        FloatRelation ret;                                              \
         target_ulong fsr;                                               \
         if (E) {                                                        \
             ret = glue(size, _compare)(src1, src2, &env->fp_status);    \
diff --git a/target/unicore32/ucf64_helper.c b/target/unicore32/ucf64_helper.c
index e078e84437..12a91900f6 100644
--- a/target/unicore32/ucf64_helper.c
+++ b/target/unicore32/ucf64_helper.c
@@ -174,8 +174,7 @@ float64 HELPER(ucf64_absd)(float64 a)
 void HELPER(ucf64_cmps)(float32 a, float32 b, uint32_t c,
         CPUUniCore32State *env)
 {
-    int flag;
-    flag = float32_compare_quiet(a, b, &env->ucf64.fp_status);
+    FloatRelation flag = float32_compare_quiet(a, b, &env->ucf64.fp_status);
     env->CF = 0;
     switch (c & 0x7) {
     case 0: /* F */
@@ -223,8 +222,7 @@ void HELPER(ucf64_cmps)(float32 a, float32 b, uint32_t c,
 void HELPER(ucf64_cmpd)(float64 a, float64 b, uint32_t c,
         CPUUniCore32State *env)
 {
-    int flag;
-    flag = float64_compare_quiet(a, b, &env->ucf64.fp_status);
+    FloatRelation flag = float64_compare_quiet(a, b, &env->ucf64.fp_status);
     env->CF = 0;
     switch (c & 0x7) {
     case 0: /* F */
diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index f8bbb6cdd8..87487293f9 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -139,7 +139,7 @@ void HELPER(oeq_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
 
 void HELPER(ueq_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
 {
-    int v = float32_compare_quiet(a, b, &env->fp_status);
+    FloatRelation v = float32_compare_quiet(a, b, &env->fp_status);
     set_br(env, v == float_relation_equal || v == float_relation_unordered, br);
 }
 
@@ -150,7 +150,7 @@ void HELPER(olt_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
 
 void HELPER(ult_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
 {
-    int v = float32_compare_quiet(a, b, &env->fp_status);
+    FloatRelation v = float32_compare_quiet(a, b, &env->fp_status);
     set_br(env, v == float_relation_less || v == float_relation_unordered, br);
 }
 
@@ -161,6 +161,6 @@ void HELPER(ole_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
 
 void HELPER(ule_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
 {
-    int v = float32_compare_quiet(a, b, &env->fp_status);
+    FloatRelation v = float32_compare_quiet(a, b, &env->fp_status);
     set_br(env, v != float_relation_greater, br);
 }
-- 
2.20.1


