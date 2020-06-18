Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0A4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5D12080D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfbRBBOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5D12080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmMX-0004xc-4o
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm9Q-0003Ml-Lj
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:46374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm9M-0002TO-AC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:44 -0400
Received: by mail-pl1-x62d.google.com with SMTP id n2so1893743pld.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xoHgIAY17yfpGcExuE867XgxlZJHV+9UTPtnsy6m1Tw=;
 b=WfbRBBOYiTumsOcQsykyHhiaP2kZ6+i1TZrlJaulSs48ZoeWNU+RlzqrBtK6jDQakA
 qu81oagnb6huXwRycH4WO1emg84ruC/df046mfmt1t/UkPDLGBGNo1w15iEigKyp4DYC
 7a5/C51wGXmdx9zV6me89iRC/yXrQL2nb3ifVbkgZFkNVUewRAJ4b6KaFk/mePh89K9P
 L+vAzNjshz0DGZr9U8lw8OAyn2d+5l7WZp+TmIFeMVLSbZG1QpAjyB0MQVzd1+WYehgH
 tK3SBb0OML520IXWXa0As/jRLUblImt4DPY8Y6zszQR+kBbN6q9oTApbFyl3VbBPAEY0
 Dulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xoHgIAY17yfpGcExuE867XgxlZJHV+9UTPtnsy6m1Tw=;
 b=r3oCEPn/Hb2TQBGtTbsf2zb/XjC9M9h4GyB6Q/3rLcw1ON8Zi9+e4uI0zNqQ8eo2M4
 LjhbHt8lShqYH+uh/eoGRXmp6+j8ehB+7yixbjwJVsimsl+fSbTtE/gxJtrvEHOd5c0f
 r6xtRiiD8Tc6XgKcnLZ92spjdkctQTQWBl80cstUWeg0BcYV/phWAjHc+8keJgRvboXk
 fzBeekcV5xPUz64eg4uGhC2c3BqjruCwTfaTB2WRHT6kR2zjhsh1+fXcq+nebUc0EH89
 uE1K37J3p8skFCi5j5zgeXCfAsE50U43jyqe7mQZmjCC+GOgzEkLGv/VQSgSGko1sRgX
 X9bA==
X-Gm-Message-State: AOAM533foHScmGviArnpwsJp/pxuhVQZdYV3C6suQpE8ITLmYPlDePG2
 +MoA6Vhs4w0Bufi7RgfEGdz9xD4McZU=
X-Google-Smtp-Source: ABdhPJwz817iFax58OgNrbwBdmVKkwS27N9WWrID3GRHPs05Ab+gCzKaaI707y8uI3OdIXZbTvnquQ==
X-Received: by 2002:a17:902:8544:: with SMTP id
 d4mr2189966plo.234.1592454458497; 
 Wed, 17 Jun 2020 21:27:38 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u61sm964897pjb.7.2020.06.17.21.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:27:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 016/100] target/arm: Implement SVE2 Integer Multiply -
 Unpredicated
Date: Wed, 17 Jun 2020 21:25:20 -0700
Message-Id: <20200618042644.1685561-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index 2a20c8174c..236fa438c6 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -686,6 +686,16 @@ DEF_HELPER_FLAGS_3(gvec_cgt0_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
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
index 4f580a25e7..31f67e0955 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1093,3 +1093,13 @@ ST1_zprz        1110010 .. 00 ..... 100 ... ..... ..... \
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
index 92a4e3f030..850e2fda15 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5361,3 +5361,53 @@ static bool trans_MOVPRFX_z(DisasContext *s, arg_rpr_esz *a)
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
index 7d76412ee0..cd58bfb84f 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1452,3 +1452,99 @@ DO_ABA(gvec_uaba_s, uint32_t)
 DO_ABA(gvec_uaba_d, uint64_t)
 
 #undef DO_ABA
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


