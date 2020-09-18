Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA27C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3D821534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BunxfReD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3D821534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLc3-00068N-WF
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGp-0007bO-Fp
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:07 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:52914)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGl-00073E-UM
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:07 -0400
Received: by mail-pj1-x1034.google.com with SMTP id bw23so784815pjb.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MZqEaovDbnBOwqIEr/pFkJYxrDx0MySV1/qTfCDSnq0=;
 b=BunxfReDcopXxAY2qtnK3SFfFlvWyYCDtQqXQOyv8k8O/eODLG5567dh0qfrOvEuiA
 vJxvn4gaqhDAu8p2h08ibSzqAkFUII0OZkHDy/CoJtLOwSgixjaSvT6nQyHRWdvvG/+p
 NqHD1rcLAEemI08B6MuZclKwOIHW0D3D5YVh1FRWyvVupLqV00k5HXut7sdAqfym5uf0
 DQ/D2yYcKnTcBr2WRCB3gkeI+F58YMfNVsrGJANGIR7JUbAyW+fyejk8iyoOoDFrsD03
 jIBRQjJeC7DZDAzqew5U0uV+mNO2koJ69kC++AE+BXSmzI/bWppECGq6I/L6JGUiWgMu
 i1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MZqEaovDbnBOwqIEr/pFkJYxrDx0MySV1/qTfCDSnq0=;
 b=di4OB+pQdL5nSCccWeC1Sj3VcRUptDrlb52Y5W5roNvXPydJCJmT4SwBz7Dv8/Kv8i
 iraz4KrWKMJGZZ57sXdtSKNm4i8l3E1zm96S89MtJXDmyQJ2fMNRZUJplfeq0RDXUm3m
 U+fHupInSLzXt70JoG6RqE5HBDiA4HCdwC5FNNLGeZUQw0/lxqPN8+bkpNr+Fok3uLZo
 c1Pfft+4Y/wqWcc8mrxZ5B2T/+Dq2FbVid2Ow0R1QyNoxu6fssOYbYVahzSDjoJDQOtz
 q0FWYb+tV2ZrMPpNwWdMXWb/iojisARiE93Gz70dy+VkEpo8WfSo+lnZ3epminy8hgpo
 xzZA==
X-Gm-Message-State: AOAM531iBge4imZhVhZvy+MrlH6VzMgtKPgouHII8GEul3U6D9I0BDiF
 ypRf8513Sws1kMwh+OXYpsOHckg+1B2Ecg==
X-Google-Smtp-Source: ABdhPJzCVMt96rhgIqnXHhm/vnhk8WmVW1DHo+fFYOI2M7CYLs8Z60o7HNAwCWB99eDwW2eS4QEwWg==
X-Received: by 2002:a17:902:a50b:b029:d1:e5e7:bdd2 with SMTP id
 s11-20020a170902a50bb02900d1e5e7bdd2mr16860906plq.50.1600454280679; 
 Fri, 18 Sep 2020 11:38:00 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:37:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/81] target/arm: Implement SVE2 Integer Multiply -
 Unpredicated
Date: Fri, 18 Sep 2020 11:36:35 -0700
Message-Id: <20200918183751.2787647-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For MUL, we can rely on generic support.  For SMULH and UMULH,
create some trivial helpers.  For PMUL, back in a21bb78e5817,
we organized helper_gvec_pmul_b in preparation for this use.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        | 10 ++++
 target/arm/sve.decode      | 10 ++++
 target/arm/translate-sve.c | 50 ++++++++++++++++++++
 target/arm/vec_helper.c    | 96 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 166 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 8defd7c801..94658169b2 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -815,6 +815,16 @@ DEF_HELPER_FLAGS_3(gvec_cgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_cge0_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_cge0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_smulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_smulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(gvec_umulh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umulh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umulh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_umulh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_sshl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sshl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ushl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 6425396ac1..2c71d9e446 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1090,3 +1090,13 @@ ST1_zprz        1110010 .. 00 ..... 100 ... ..... ..... \
                 @rprr_scatter_store xs=0 esz=3 scale=0
 ST1_zprz        1110010 .. 00 ..... 110 ... ..... ..... \
                 @rprr_scatter_store xs=1 esz=3 scale=0
+
+#### SVE2 Support
+
+### SVE2 Integer Multiply - Unpredicated
+
+# SVE2 integer multiply vectors (unpredicated)
+MUL_zzz         00000100 .. 1 ..... 0110 00 ..... .....  @rd_rn_rm
+SMULH_zzz       00000100 .. 1 ..... 0110 10 ..... .....  @rd_rn_rm
+UMULH_zzz       00000100 .. 1 ..... 0110 11 ..... .....  @rd_rn_rm
+PMUL_zzz        00000100 00 1 ..... 0110 01 ..... .....  @rd_rn_rm_e0
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 9095586fc9..04c5a2c8bd 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5805,3 +5805,53 @@ static bool trans_MOVPRFX_z(DisasContext *s, arg_rpr_esz *a)
 {
     return do_movz_zpz(s, a->rd, a->rn, a->pg, a->esz, false);
 }
+
+/*
+ * SVE2 Integer Multiply - Unpredicated
+ */
+
+static bool trans_MUL_zzz(DisasContext *s, arg_rrr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_fn_zzz(s, tcg_gen_gvec_mul, a->esz, a->rd, a->rn, a->rm);
+    }
+    return true;
+}
+
+static bool do_sve2_zzz_ool(DisasContext *s, arg_rrr_esz *a,
+                            gen_helper_gvec_3 *fn)
+{
+    if (fn == NULL || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_ool_zzz(s, fn, a->rd, a->rn, a->rm, 0);
+    }
+    return true;
+}
+
+static bool trans_SMULH_zzz(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_gvec_smulh_b, gen_helper_gvec_smulh_h,
+        gen_helper_gvec_smulh_s, gen_helper_gvec_smulh_d,
+    };
+    return do_sve2_zzz_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_UMULH_zzz(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_gvec_umulh_b, gen_helper_gvec_umulh_h,
+        gen_helper_gvec_umulh_s, gen_helper_gvec_umulh_d,
+    };
+    return do_sve2_zzz_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_PMUL_zzz(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_sve2_zzz_ool(s, a, gen_helper_gvec_pmul_b);
+}
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index a973454e4f..84e1ae3933 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1937,3 +1937,99 @@ DO_VRINT_RMODE(gvec_vrint_rm_h, helper_rinth, uint16_t)
 DO_VRINT_RMODE(gvec_vrint_rm_s, helper_rints, uint32_t)
 
 #undef DO_VRINT_RMODE
+
+/*
+ * NxN -> N highpart multiply
+ *
+ * TODO: expose this as a generic vector operation.
+ */
+
+void HELPER(gvec_smulh_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = ((int32_t)n[i] * m[i]) >> 8;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_smulh_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = ((int32_t)n[i] * m[i]) >> 16;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_smulh_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = ((int64_t)n[i] * m[i]) >> 32;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_smulh_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint64_t discard;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        muls64(&discard, &d[i], n[i], m[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_umulh_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint8_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz; ++i) {
+        d[i] = ((uint32_t)n[i] * m[i]) >> 8;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_umulh_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint16_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 2; ++i) {
+        d[i] = ((uint32_t)n[i] * m[i]) >> 16;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_umulh_s)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = ((uint64_t)n[i] * m[i]) >> 32;
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_umulh_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+    uint64_t discard;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        mulu64(&discard, &d[i], n[i], m[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.25.1


