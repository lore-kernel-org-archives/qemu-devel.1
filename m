Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C448DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9420B21852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaJr1kFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9420B21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmEH-0005Uu-MX
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm9K-0003A9-JO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:39 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm9F-0002Qc-Md
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:38 -0400
Received: by mail-pg1-x542.google.com with SMTP id l63so2314270pge.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aaz2Qf7pXADcmL2cGWC7LCDFCBZO1PEf+8YzG/KsA2g=;
 b=OaJr1kFcKg3rjlgscqL3F6SK/M7OVtIHoMlYub1YwRs+WTL/iICxbb0bnW3vxryVk3
 7x+Ga8AZ7qw5vHneNVhAN9CaZFxNmYEo6k+ZV2A6jSLNk/ELJEIKXZRslUgTlxuLfneP
 hmq/CQjtVwaKssfLkoFZdXTl4/2bpzD+Y//HVf8w3jCaoO6eeIUT1/2MbP7n3l5NZ0yt
 8C2WCfipr/iyNRiuzDnlZnHc9T9XvVVRpFYM0AY/fuQWwtQOMJFhnls+ehLQbnvf0JWK
 ZJYplshfPyNb08YvJAZ2c6UaO4xm2ayF6S5OBUtqmg+n8IZSrkaIySkClM5HrAuJ9+ZN
 7L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aaz2Qf7pXADcmL2cGWC7LCDFCBZO1PEf+8YzG/KsA2g=;
 b=FliWTHUnCqWpSVS0/UGZk0gegRSGK66NuGCW4XOYdNraLPNqVlpgiEh3pD8U71aFj8
 pAc1HMqRBlpwDv4OTD6s9C7nC2GhQH6J42nzU0dkw/bgs2p0MwGZzAFzzOZ6YIV1Kxnm
 dtQipz8qwEE8mkMCw9RUdsZZxaOsdvNvhO1/A2KrKZnVAf1wIGbp++YJV9hK+YbvrNk/
 mdmAsgQxO9bzl3srttndSoiECnpFtbhfFscRuhM8cZ6UsySy1Ln0Xx/0cMe3E1h9sOX7
 5ZtorVyFjGqfdsVjOP7vICNRrkCu+AbvT2KLDJ6J9ysHk6JNObLTaqZ5F9i5ps9q5R/6
 j7Iw==
X-Gm-Message-State: AOAM531SUUyBUIOEUIakWlhTlr9mgV0Iw8rA6lKmPqmJwXCMFDIVlTv3
 84QuGniL+mMQ9aRe38+Z6863XRg4sqc=
X-Google-Smtp-Source: ABdhPJyWOq/Jne7XQMs4Wy5cPkMgfHj4zm04Eo+4NzEDJCa5nfcaeirtVQPnu/rjXDJ52q8mk2PzPg==
X-Received: by 2002:a63:3814:: with SMTP id f20mr1810930pga.266.1592454450821; 
 Wed, 17 Jun 2020 21:27:30 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u61sm964897pjb.7.2020.06.17.21.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:27:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 010/100] target/arm: Merge helper_sve_clr_* and
 helper_sve_movz_*
Date: Wed, 17 Jun 2020 21:25:14 -0700
Message-Id: <20200618042644.1685561-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The existing clr functions have only one vector argument, and so
can only clear in place.  The existing movz functions have two
vector arguments, and so can clear while moving.  Merge them, with
a flag that controls the sense of active vs inactive elements
being cleared.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  5 ---
 target/arm/sve_helper.c    | 70 ++++++++------------------------------
 target/arm/translate-sve.c | 53 +++++++++++------------------
 3 files changed, 34 insertions(+), 94 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 7a200755ac..3ccbdde63d 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -269,11 +269,6 @@ DEF_HELPER_FLAGS_3(sve_uminv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_uminv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_uminv_d, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_3(sve_clr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(sve_clr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(sve_clr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_FLAGS_3(sve_clr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-
 DEF_HELPER_FLAGS_4(sve_movz_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_movz_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_movz_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index e590db6637..8d7a09e6a4 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -956,85 +956,43 @@ uint32_t HELPER(sve_pnext)(void *vd, void *vg, uint32_t pred_desc)
     return flags;
 }
 
-/* Store zero into every active element of Zd.  We will use this for two
- * and three-operand predicated instructions for which logic dictates a
- * zero result.  In particular, logical shift by element size, which is
- * otherwise undefined on the host.
- *
- * For element sizes smaller than uint64_t, we use tables to expand
- * the N bits of the controlling predicate to a byte mask, and clear
- * those bytes.
+/*
+ * Copy Zn into Zd, and store zero into inactive elements.
+ * If inv, store zeros into the active elements.
  */
-void HELPER(sve_clr_b)(void *vd, void *vg, uint32_t desc)
-{
-    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
-    uint64_t *d = vd;
-    uint8_t *pg = vg;
-    for (i = 0; i < opr_sz; i += 1) {
-        d[i] &= ~expand_pred_b(pg[H1(i)]);
-    }
-}
-
-void HELPER(sve_clr_h)(void *vd, void *vg, uint32_t desc)
-{
-    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
-    uint64_t *d = vd;
-    uint8_t *pg = vg;
-    for (i = 0; i < opr_sz; i += 1) {
-        d[i] &= ~expand_pred_h(pg[H1(i)]);
-    }
-}
-
-void HELPER(sve_clr_s)(void *vd, void *vg, uint32_t desc)
-{
-    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
-    uint64_t *d = vd;
-    uint8_t *pg = vg;
-    for (i = 0; i < opr_sz; i += 1) {
-        d[i] &= ~expand_pred_s(pg[H1(i)]);
-    }
-}
-
-void HELPER(sve_clr_d)(void *vd, void *vg, uint32_t desc)
-{
-    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
-    uint64_t *d = vd;
-    uint8_t *pg = vg;
-    for (i = 0; i < opr_sz; i += 1) {
-        if (pg[H1(i)] & 1) {
-            d[i] = 0;
-        }
-    }
-}
-
-/* Copy Zn into Zd, and store zero into inactive elements.  */
 void HELPER(sve_movz_b)(void *vd, void *vn, void *vg, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t inv = -(uint64_t)(simd_data(desc) & 1);
     uint64_t *d = vd, *n = vn;
     uint8_t *pg = vg;
+
     for (i = 0; i < opr_sz; i += 1) {
-        d[i] = n[i] & expand_pred_b(pg[H1(i)]);
+        d[i] = n[i] & (expand_pred_b(pg[H1(i)]) ^ inv);
     }
 }
 
 void HELPER(sve_movz_h)(void *vd, void *vn, void *vg, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t inv = -(uint64_t)(simd_data(desc) & 1);
     uint64_t *d = vd, *n = vn;
     uint8_t *pg = vg;
+
     for (i = 0; i < opr_sz; i += 1) {
-        d[i] = n[i] & expand_pred_h(pg[H1(i)]);
+        d[i] = n[i] & (expand_pred_h(pg[H1(i)]) ^ inv);
     }
 }
 
 void HELPER(sve_movz_s)(void *vd, void *vn, void *vg, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t inv = -(uint64_t)(simd_data(desc) & 1);
     uint64_t *d = vd, *n = vn;
     uint8_t *pg = vg;
+
     for (i = 0; i < opr_sz; i += 1) {
-        d[i] = n[i] & expand_pred_s(pg[H1(i)]);
+        d[i] = n[i] & (expand_pred_s(pg[H1(i)]) ^ inv);
     }
 }
 
@@ -1043,8 +1001,10 @@ void HELPER(sve_movz_d)(void *vd, void *vn, void *vg, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc) / 8;
     uint64_t *d = vd, *n = vn;
     uint8_t *pg = vg;
+    uint8_t inv = simd_data(desc);
+
     for (i = 0; i < opr_sz; i += 1) {
-        d[i] = n[i] & -(uint64_t)(pg[H1(i)] & 1);
+        d[i] = n[i] & -(uint64_t)((pg[H1(i)] ^ inv) & 1);
     }
 }
 
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5d4f572b67..9687606a93 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -590,37 +590,26 @@ static bool trans_SADDV(DisasContext *s, arg_rpr_esz *a)
  *** SVE Shift by Immediate - Predicated Group
  */
 
-/* Store zero into every active element of Zd.  We will use this for two
- * and three-operand predicated instructions for which logic dictates a
- * zero result.
+/*
+ * Copy Zn into Zd, storing zeros into inactive elements.
+ * If invert, store zeros into the active elements.
  */
-static bool do_clr_zp(DisasContext *s, int rd, int pg, int esz)
-{
-    static gen_helper_gvec_2 * const fns[4] = {
-        gen_helper_sve_clr_b, gen_helper_sve_clr_h,
-        gen_helper_sve_clr_s, gen_helper_sve_clr_d,
-    };
-    if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, rd),
-                           pred_full_reg_offset(s, pg),
-                           vsz, vsz, 0, fns[esz]);
-    }
-    return true;
-}
-
-/* Copy Zn into Zd, storing zeros into inactive elements.  */
-static void do_movz_zpz(DisasContext *s, int rd, int rn, int pg, int esz)
+static bool do_movz_zpz(DisasContext *s, int rd, int rn, int pg,
+                        int esz, bool invert)
 {
     static gen_helper_gvec_3 * const fns[4] = {
         gen_helper_sve_movz_b, gen_helper_sve_movz_h,
         gen_helper_sve_movz_s, gen_helper_sve_movz_d,
     };
-    unsigned vsz = vec_full_reg_size(s);
-    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
-                       vec_full_reg_offset(s, rn),
-                       pred_full_reg_offset(s, pg),
-                       vsz, vsz, 0, fns[esz]);
+
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                           vec_full_reg_offset(s, rn),
+                           pred_full_reg_offset(s, pg),
+                           vsz, vsz, invert, fns[esz]);
+    }
+    return true;
 }
 
 static bool do_zpzi_ool(DisasContext *s, arg_rpri_esz *a,
@@ -664,7 +653,7 @@ static bool trans_LSR_zpzi(DisasContext *s, arg_rpri_esz *a)
     /* Shift by element size is architecturally valid.
        For logical shifts, it is a zeroing operation.  */
     if (a->imm >= (8 << a->esz)) {
-        return do_clr_zp(s, a->rd, a->pg, a->esz);
+        return do_movz_zpz(s, a->rd, a->rd, a->pg, a->esz, true);
     } else {
         return do_zpzi_ool(s, a, fns[a->esz]);
     }
@@ -682,7 +671,7 @@ static bool trans_LSL_zpzi(DisasContext *s, arg_rpri_esz *a)
     /* Shift by element size is architecturally valid.
        For logical shifts, it is a zeroing operation.  */
     if (a->imm >= (8 << a->esz)) {
-        return do_clr_zp(s, a->rd, a->pg, a->esz);
+        return do_movz_zpz(s, a->rd, a->rd, a->pg, a->esz, true);
     } else {
         return do_zpzi_ool(s, a, fns[a->esz]);
     }
@@ -700,7 +689,7 @@ static bool trans_ASRD(DisasContext *s, arg_rpri_esz *a)
     /* Shift by element size is architecturally valid.  For arithmetic
        right shift for division, it is a zeroing operation.  */
     if (a->imm >= (8 << a->esz)) {
-        return do_clr_zp(s, a->rd, a->pg, a->esz);
+        return do_movz_zpz(s, a->rd, a->rd, a->pg, a->esz, true);
     } else {
         return do_zpzi_ool(s, a, fns[a->esz]);
     }
@@ -4871,8 +4860,7 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 
     /* Zero the inactive elements.  */
     gen_set_label(over);
-    do_movz_zpz(s, a->rd, a->rd, a->pg, esz);
-    return true;
+    return do_movz_zpz(s, a->rd, a->rd, a->pg, esz, false);
 }
 
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
@@ -5385,8 +5373,5 @@ static bool trans_MOVPRFX_m(DisasContext *s, arg_rpr_esz *a)
 
 static bool trans_MOVPRFX_z(DisasContext *s, arg_rpr_esz *a)
 {
-    if (sve_access_check(s)) {
-        do_movz_zpz(s, a->rd, a->rn, a->pg, a->esz);
-    }
-    return true;
+    return do_movz_zpz(s, a->rd, a->rn, a->pg, a->esz, false);
 }
-- 
2.25.1


