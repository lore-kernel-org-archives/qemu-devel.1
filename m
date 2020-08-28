Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108A5C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13A82075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dETlM1Qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13A82075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBalm-0005eh-1Z
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBact-00059p-Ez
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:35120)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacr-0004MO-CM
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:51 -0400
Received: by mail-wr1-x432.google.com with SMTP id e16so636620wrm.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9OEvYlAJnxCsF9R7lzprB3K7WPYrkSLw8yXVJNlRrBw=;
 b=dETlM1QjzVZu5IwZd30DysjMJ/8AuCPBMUZqG2/g06c5MVT1oqi2DfpF6RXYs7SM1V
 iZD/8ZhvbAmu7ZCjvhDIAaZuGbuUduKLzycqReaDzvfQei4gUINugilbj2laYRTIbPfE
 274ftZPiSC+MmIhR+wM1epVshOoCzTflf0KtDa6PCHNg0aHEP5jvH+CVC9OKLsyspIXy
 vXgiJmiwkxMS+Vov06WMtnxkFDJgzF/y78p5aRenJ+qkjBYw35PlSFVbTRgj6tNYaQq/
 +k/gREiHWNXWjB2JhLKhHlZ96J7BsQ1ZGufudmcC+z+Y3BGfLfhHeH8WVanMZqQH1w6T
 3CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9OEvYlAJnxCsF9R7lzprB3K7WPYrkSLw8yXVJNlRrBw=;
 b=J144cfYQMqxOdTek8DyrGwlsw3NX4BpMTorlZTCfR9wsigHG/FehBtf6xtW1gwaX63
 1Wun5TNMsdFPL9XNG1brJOS8C2Qv65Ar/vX4dnFOk8IGZH3p+Qtp8ClOGQ1vzMjlVgCC
 37D2Hyiz8UWJ2ThYpRq877tXdo0n0w2mOU0pkBAD0bT8BENvKUCu+cQORPZ8PNtFoc8E
 4GOK0/LsBjnTzIgBxDXZSSKACuuBc5Z2q1XZH+7UNSYhpq8ATvt37DZ69R62fgrrx3wY
 BhWxvhF702mj9Ke5KPpDKSt5D3lL4yyEEb5+doJSaHQvbnEXUdjOq1Lyo6DVxl36UuMK
 Ax4w==
X-Gm-Message-State: AOAM531WGIr3tPuEcKOtMBghaKGknDfzHONei8raIfZq2a9pDqxYfqNm
 LXn6LGcuoaKcgO1/x593jLIB4tsY/wmTkHKa
X-Google-Smtp-Source: ABdhPJyYX1g+EbO1azq5t6EnUIFV96okmWbIpNTJT2SVJpB2+42L+NFf6ZAOa96qa3ScHX2ZednFRw==
X-Received: by 2002:adf:f5c7:: with SMTP id k7mr640836wrp.230.1598606687597;
 Fri, 28 Aug 2020 02:24:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/35] target/arm: Merge helper_sve_clr_* and helper_sve_movz_*
Date: Fri, 28 Aug 2020 10:24:05 +0100
Message-Id: <20200828092413.22206-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

The existing clr functions have only one vector argument, and so
can only clear in place.  The existing movz functions have two
vector arguments, and so can clear while moving.  Merge them, with
a flag that controls the sense of active vs inactive elements
being cleared.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |  5 ---
 target/arm/sve_helper.c    | 70 ++++++++------------------------------
 target/arm/translate-sve.c | 53 +++++++++++------------------
 3 files changed, 34 insertions(+), 94 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 63c4a087caa..4411c47120d 100644
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
index 382fa82bc8a..4758d46f34d 100644
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
index 96bfd32bbec..aba156d5ab6 100644
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
@@ -5049,8 +5038,7 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 
     /* Zero the inactive elements.  */
     gen_set_label(over);
-    do_movz_zpz(s, a->rd, a->rd, a->pg, esz);
-    return true;
+    return do_movz_zpz(s, a->rd, a->rd, a->pg, esz, false);
 }
 
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
@@ -5833,8 +5821,5 @@ static bool trans_MOVPRFX_m(DisasContext *s, arg_rpr_esz *a)
 
 static bool trans_MOVPRFX_z(DisasContext *s, arg_rpr_esz *a)
 {
-    if (sve_access_check(s)) {
-        do_movz_zpz(s, a->rd, a->rn, a->pg, a->esz);
-    }
-    return true;
+    return do_movz_zpz(s, a->rd, a->rn, a->pg, a->esz, false);
 }
-- 
2.20.1


