Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07BAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA68208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/R4ZpFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA68208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBarm-0000Od-1H
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacz-0005S0-R0
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34070)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacx-0004Oq-OJ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id f7so641654wrw.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OPKXBbkLqo2TCq36FXO09aulVFiBuCstjo3muIWGp3Y=;
 b=Y/R4ZpFCEhM836RcCZQLDV/pxhK6WMVMQTnDBx4KSGfCT4ioBKzudTx/7c/fQ17Gd/
 gR703yMsKb+GljQchWvDqfHdWYKNRCrWD4yrklSvu7y7d3f71SwWkYkuacCjzRMlnU5Z
 ESdB/fqDzAZi1knN9BC4g87dEGv2OUvwIRRSUmkikDJr37dODFkqIA5Z5HVIy/LeCxLx
 J0l28nScHGZGloin4/QtPbOe831nupsklKssKl3unyKBeR0ZnpsD0owc0mPDTUVl+eK7
 HUGGV5mOE2JSreLUxbPluDJp059FUAVui04Ad+zIbT/B/jl/5A/c6QuMq40Rep5pFluV
 MbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OPKXBbkLqo2TCq36FXO09aulVFiBuCstjo3muIWGp3Y=;
 b=reeywEv/iQlhvw0GXm3j2MOvbFJswNvb1Qpczg6lU265KTDPYYop9PHweNaMJordf4
 S1v8hG4ObytdJV4vABhQU+mL8mXxnEp6S8z52d8sCMIY3dSH7RC6bnLy/U3oqKrR7YHT
 /1KZwC9H/rftvGd+eODWhWPlbtJxkYZSYYNKKLOJ0SJvBCdP3c4oCktJykvU9wOHWgs+
 YULoVZGWJ0m8avwLlMzquCcQJjIua3l2dyejkzdS2Y43CC5KMuj3U3bIeDeQNJ/XAztF
 79ZQniapahANLE8IjzEWO7ZqKh9p8ykrt5ed3/pvor6h84muNvw5X4hVBCAZq5W/DPMQ
 thnQ==
X-Gm-Message-State: AOAM531+HMtMmDCLBmjQ3lmrjIijwAy5qiP1P9qAb/8DbD6nHuDIfpwa
 SEAhO2oy+H6Oo5aaRil8FRTK+i72cbAFbmV4
X-Google-Smtp-Source: ABdhPJyMaqMUonEbEfhHEB0/zqz/zixzC0Genmwh3b5OcHzN/bwyricvZMHOCg4OonwYGeF8j5bqkQ==
X-Received: by 2002:a5d:6a45:: with SMTP id t5mr713793wrw.58.1598606693919;
 Fri, 28 Aug 2020 02:24:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/35] target/arm: Generalize inl_qrdmlah_* helper functions
Date: Fri, 28 Aug 2020 10:24:10 +0100
Message-Id: <20200828092413.22206-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Unify add/sub helpers and add a parameter for rounding.
This will allow saturating non-rounding to reuse this code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMM: fixed accidental use of '=' rather than '+=' in do_sqrdmlah_s]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vec_helper.c | 80 +++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 7d76412ee0d..9f10be03ed7 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -37,19 +37,24 @@
 #endif
 
 /* Signed saturating rounding doubling multiply-accumulate high half, 16-bit */
-static int16_t inl_qrdmlah_s16(int16_t src1, int16_t src2,
-                               int16_t src3, uint32_t *sat)
+static int16_t do_sqrdmlah_h(int16_t src1, int16_t src2, int16_t src3,
+                             bool neg, bool round, uint32_t *sat)
 {
-    /* Simplify:
+    /*
+     * Simplify:
      * = ((a3 << 16) + ((e1 * e2) << 1) + (1 << 15)) >> 16
      * = ((a3 << 15) + (e1 * e2) + (1 << 14)) >> 15
      */
     int32_t ret = (int32_t)src1 * src2;
-    ret = ((int32_t)src3 << 15) + ret + (1 << 14);
+    if (neg) {
+        ret = -ret;
+    }
+    ret += ((int32_t)src3 << 15) + (round << 14);
     ret >>= 15;
+
     if (ret != (int16_t)ret) {
         *sat = 1;
-        ret = (ret < 0 ? -0x8000 : 0x7fff);
+        ret = (ret < 0 ? INT16_MIN : INT16_MAX);
     }
     return ret;
 }
@@ -58,8 +63,9 @@ uint32_t HELPER(neon_qrdmlah_s16)(CPUARMState *env, uint32_t src1,
                                   uint32_t src2, uint32_t src3)
 {
     uint32_t *sat = &env->vfp.qc[0];
-    uint16_t e1 = inl_qrdmlah_s16(src1, src2, src3, sat);
-    uint16_t e2 = inl_qrdmlah_s16(src1 >> 16, src2 >> 16, src3 >> 16, sat);
+    uint16_t e1 = do_sqrdmlah_h(src1, src2, src3, false, true, sat);
+    uint16_t e2 = do_sqrdmlah_h(src1 >> 16, src2 >> 16, src3 >> 16,
+                                false, true, sat);
     return deposit32(e1, 16, 16, e2);
 }
 
@@ -73,35 +79,18 @@ void HELPER(gvec_qrdmlah_s16)(void *vd, void *vn, void *vm,
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 2; ++i) {
-        d[i] = inl_qrdmlah_s16(n[i], m[i], d[i], vq);
+        d[i] = do_sqrdmlah_h(n[i], m[i], d[i], false, true, vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-/* Signed saturating rounding doubling multiply-subtract high half, 16-bit */
-static int16_t inl_qrdmlsh_s16(int16_t src1, int16_t src2,
-                               int16_t src3, uint32_t *sat)
-{
-    /* Similarly, using subtraction:
-     * = ((a3 << 16) - ((e1 * e2) << 1) + (1 << 15)) >> 16
-     * = ((a3 << 15) - (e1 * e2) + (1 << 14)) >> 15
-     */
-    int32_t ret = (int32_t)src1 * src2;
-    ret = ((int32_t)src3 << 15) - ret + (1 << 14);
-    ret >>= 15;
-    if (ret != (int16_t)ret) {
-        *sat = 1;
-        ret = (ret < 0 ? -0x8000 : 0x7fff);
-    }
-    return ret;
-}
-
 uint32_t HELPER(neon_qrdmlsh_s16)(CPUARMState *env, uint32_t src1,
                                   uint32_t src2, uint32_t src3)
 {
     uint32_t *sat = &env->vfp.qc[0];
-    uint16_t e1 = inl_qrdmlsh_s16(src1, src2, src3, sat);
-    uint16_t e2 = inl_qrdmlsh_s16(src1 >> 16, src2 >> 16, src3 >> 16, sat);
+    uint16_t e1 = do_sqrdmlah_h(src1, src2, src3, true, true, sat);
+    uint16_t e2 = do_sqrdmlah_h(src1 >> 16, src2 >> 16, src3 >> 16,
+                                true, true, sat);
     return deposit32(e1, 16, 16, e2);
 }
 
@@ -115,19 +104,23 @@ void HELPER(gvec_qrdmlsh_s16)(void *vd, void *vn, void *vm,
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 2; ++i) {
-        d[i] = inl_qrdmlsh_s16(n[i], m[i], d[i], vq);
+        d[i] = do_sqrdmlah_h(n[i], m[i], d[i], true, true, vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
 /* Signed saturating rounding doubling multiply-accumulate high half, 32-bit */
-static int32_t inl_qrdmlah_s32(int32_t src1, int32_t src2,
-                               int32_t src3, uint32_t *sat)
+static int32_t do_sqrdmlah_s(int32_t src1, int32_t src2, int32_t src3,
+                             bool neg, bool round, uint32_t *sat)
 {
     /* Simplify similarly to int_qrdmlah_s16 above.  */
     int64_t ret = (int64_t)src1 * src2;
-    ret = ((int64_t)src3 << 31) + ret + (1 << 30);
+    if (neg) {
+        ret = -ret;
+    }
+    ret += ((int64_t)src3 << 31) + (round << 30);
     ret >>= 31;
+
     if (ret != (int32_t)ret) {
         *sat = 1;
         ret = (ret < 0 ? INT32_MIN : INT32_MAX);
@@ -139,7 +132,7 @@ uint32_t HELPER(neon_qrdmlah_s32)(CPUARMState *env, int32_t src1,
                                   int32_t src2, int32_t src3)
 {
     uint32_t *sat = &env->vfp.qc[0];
-    return inl_qrdmlah_s32(src1, src2, src3, sat);
+    return do_sqrdmlah_s(src1, src2, src3, false, true, sat);
 }
 
 void HELPER(gvec_qrdmlah_s32)(void *vd, void *vn, void *vm,
@@ -152,31 +145,16 @@ void HELPER(gvec_qrdmlah_s32)(void *vd, void *vn, void *vm,
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        d[i] = inl_qrdmlah_s32(n[i], m[i], d[i], vq);
+        d[i] = do_sqrdmlah_s(n[i], m[i], d[i], false, true, vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
-/* Signed saturating rounding doubling multiply-subtract high half, 32-bit */
-static int32_t inl_qrdmlsh_s32(int32_t src1, int32_t src2,
-                               int32_t src3, uint32_t *sat)
-{
-    /* Simplify similarly to int_qrdmlsh_s16 above.  */
-    int64_t ret = (int64_t)src1 * src2;
-    ret = ((int64_t)src3 << 31) - ret + (1 << 30);
-    ret >>= 31;
-    if (ret != (int32_t)ret) {
-        *sat = 1;
-        ret = (ret < 0 ? INT32_MIN : INT32_MAX);
-    }
-    return ret;
-}
-
 uint32_t HELPER(neon_qrdmlsh_s32)(CPUARMState *env, int32_t src1,
                                   int32_t src2, int32_t src3)
 {
     uint32_t *sat = &env->vfp.qc[0];
-    return inl_qrdmlsh_s32(src1, src2, src3, sat);
+    return do_sqrdmlah_s(src1, src2, src3, true, true, sat);
 }
 
 void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
@@ -189,7 +167,7 @@ void HELPER(gvec_qrdmlsh_s32)(void *vd, void *vn, void *vm,
     uintptr_t i;
 
     for (i = 0; i < opr_sz / 4; ++i) {
-        d[i] = inl_qrdmlsh_s32(n[i], m[i], d[i], vq);
+        d[i] = do_sqrdmlah_s(n[i], m[i], d[i], true, true, vq);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
-- 
2.20.1


