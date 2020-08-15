Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EC7C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02D423B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2LWH/Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F02D423B30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k70BD-00085q-5B
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 13:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k70AM-0007gJ-St
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:40:26 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34]:34745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k70AL-0004r6-40
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:40:26 -0400
Received: by mail-qv1-xf34.google.com with SMTP id t6so5849298qvw.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Dt3CKviEUaIARP3VoTRcas5wkm8EDq7dhBzT1P07KmY=;
 b=N2LWH/OrQhwtQi1q9rkIfT8KvyE3KjDBucs5l/nbT4+PFvvgbbLDqtNJOsJIZcVGCB
 lwlFBZcTP9XATBbneSUqQxJxTB802wyRzLD1+UtQJ67KmGTnECXBcSpMypVsjYhHQbvz
 yeu/jcg13ekCu6EE4D88I1pQeEtAWkR8eR4eIsvn1J1TpZscgju5SKOtlNo8CdyISrXT
 P1YTbanhKrVNiQN+D+o0/jtJpyl9h2m9GNssr3UeGC0aStG501WSrGC4H4rUsEF9P5n6
 eqwJvlbjtYVmMZFE+McVouXgIXqsBidoTXjICjIzr2+UZN4ZCf8tR+KdK6+m4OhuYJb5
 Ea+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dt3CKviEUaIARP3VoTRcas5wkm8EDq7dhBzT1P07KmY=;
 b=rXU+kWYHYbXm7pcTtQClYEllUcR9uxoUdwZUDBfpB1BEJ54RNgYBuLScLZKyY8+4Sa
 /exejGJzGZik2Rs4fomcMmPmbkfp/fXJ4zKYF+/XHmuZtqx9CIMWs1aP1FudyFrrxLrL
 36yEKAxGCPRM+SL9QUwkH4k/llJ6f0MiIgiPmCI7kxPuT3HgOJUgmIWds+zDEnonSBGU
 ci5qzmxLxsEzO2RaP1TDwX2/vyFUUiBFphAmzi5iisWGVyGw6OYp1OlCE5Vo2vVCLxsL
 aml9Ji7JhnwzM/QIJ7DMmPOaPhlXvQ1KHkwaN3ItemLirXlTPKwJr5uIlw/etEiUB5tI
 3lnA==
X-Gm-Message-State: AOAM533VYTjlK4boySeDwyjcmPGLIFyxN4rskiCSrutFUg5lNtrE5SAM
 suVr/E2nM1mhyorhbjpiE9nnXW3q/4sceQ==
X-Google-Smtp-Source: ABdhPJw8CO5SjYGiL3HJZfXvuZOqXjbdRb9J3jsbQExHhtNtvvMRivdCo8pV1cShZP5ZGk8Ya+tUFQ==
X-Received: by 2002:a62:7f15:: with SMTP id a21mr3690539pfd.191.1597455126728; 
 Fri, 14 Aug 2020 18:32:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/20] target/arm: Generalize inl_qrdmlah_* helper functions
Date: Fri, 14 Aug 2020 18:31:39 -0700
Message-Id: <20200815013145.539409-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf34.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Unify add/sub helpers and add a parameter for rounding.
This will allow saturating non-rounding to reuse this code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vec_helper.c | 80 +++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 7d76412ee0..bbd1141dfc 100644
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
+    ret = ((int64_t)src3 << 31) + (round << 30);
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
2.25.1


