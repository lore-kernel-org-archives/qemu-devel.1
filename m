Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E31C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2ACB2075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pua7zVpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2ACB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjaU-0000XN-2j
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCu-00031D-Iq
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:36 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55521)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCs-00063e-Ch
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id a65so115636wme.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xy+ZubFcXYrLF856j9b+3uusVXUFpAlU1KC0lHWaBwE=;
 b=pua7zVpNWlV0iUY2dpD8xs7MB4FPlriCsqvW0yf1Fj77iskCur3NX++XpRjX+tgMkD
 36RYgU2o/qkHU18uRBqdl3idPaPzSS4+Vta/g85qSP9lW8ILdMBkSFVXZowpiKEXbzqd
 tBj+4hmpTw9uEp/SHrNAy0J4V/qa8g4aKU3/40rl9P+AZMD4lxwwRdHa6mXgDl2tsVPe
 /fPXwnC/CmWWCEU+yYB4Oyt5+AzJtB3Zg8UrrSrL7bs71V9fKdtJwmN4vUwPWdYGlMcV
 SaoXFElSEoTJnpfpuus/JzVtk4mTlKUYKpj9LVqR/SLgzwXiTxc4+k7wnzRKv+tOMosr
 es0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xy+ZubFcXYrLF856j9b+3uusVXUFpAlU1KC0lHWaBwE=;
 b=axJbJjHSUIzW7w+VAvF7mROxIyanCouEQMJA88AA1mWXPOqXr8+FgCMzmkO1iv5mMy
 jrIY/hLbKaQ5el9UjwqJDdwFkrtop63lVIbjEcItRMvFr/bFBQ2ahmxNVXm24trYrn7C
 T09RL7mQ6356zz2dsbU3TLOrkzG1KCqTFql6d0946nzvXfWLZ/vrN2ARjwKOzMnTUrr7
 hvMgPcjtNBv/1y5l9lEf+A1f3SThcZA6m35o1ELMAHuckBk8KBnkTGE5CX2r/pzZ/GcL
 9HzS2CfXpDr0JpAqXN2JX23FtBmdJ9dCuo9yc5rpabWnYx8WZR8vd+X3n9boSIhc/Oe/
 hJ7A==
X-Gm-Message-State: AOAM531QGEM+ifqPsn/S8s/f3h6cd3U5RHdgALrTqOb1Htoa19+H+Hgo
 oRw0vYUfjiLXOXULPgSBOKSf8A==
X-Google-Smtp-Source: ABdhPJw9LMUyXQ9iNQCkFysbVld7Ltt8u40KLEk4Ai/ZMCteCChhv4620HD8SqmpMGtfHj7kvC7unA==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr22962wmh.37.1598639672968;
 Fri, 28 Aug 2020 11:34:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 30/45] target/arm: Implement fp16 for Neon VMLA,
 VMLS operations
Date: Fri, 28 Aug 2020 19:33:39 +0100
Message-Id: <20200828183354.27913-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

Convert the Neon floating-point VMLA and VMLS insns over to using a
gvec helper, and use this to implement the fp16 case.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  6 +++++
 target/arm/vec_helper.c         | 42 +++++++++++++++++++++++++++++++++
 target/arm/translate-neon.c.inc | 33 ++------------------------
 3 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index f621940e69d..6f6c96711b7 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -659,6 +659,12 @@ DEF_HELPER_FLAGS_5(gvec_fmaxnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i3
 DEF_HELPER_FLAGS_5(gvec_fminnum_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fminnum_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmla_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmls_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmls_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index f551f86d5a5..5da5969c1c0 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -842,6 +842,48 @@ DO_3OP(gvec_rsqrts_d, helper_rsqrtsf_f64, float64)
 #endif
 #undef DO_3OP
 
+/* Non-fused multiply-add (unlike float16_muladd etc, which are fused) */
+static float16 float16_muladd_nf(float16 dest, float16 op1, float16 op2,
+                                 float_status *stat)
+{
+    return float16_add(dest, float16_mul(op1, op2, stat), stat);
+}
+
+static float32 float32_muladd_nf(float32 dest, float32 op1, float32 op2,
+                                 float_status *stat)
+{
+    return float32_add(dest, float32_mul(op1, op2, stat), stat);
+}
+
+static float16 float16_mulsub_nf(float16 dest, float16 op1, float16 op2,
+                                 float_status *stat)
+{
+    return float16_sub(dest, float16_mul(op1, op2, stat), stat);
+}
+
+static float32 float32_mulsub_nf(float32 dest, float32 op1, float32 op2,
+                                 float_status *stat)
+{
+    return float32_sub(dest, float32_mul(op1, op2, stat), stat);
+}
+
+#define DO_MULADD(NAME, FUNC, TYPE) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
+{                                                                          \
+    intptr_t i, oprsz = simd_oprsz(desc);                                  \
+    TYPE *d = vd, *n = vn, *m = vm;                                        \
+    for (i = 0; i < oprsz / sizeof(TYPE); i++) {                           \
+        d[i] = FUNC(d[i], n[i], m[i], stat);                               \
+    }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
+}
+
+DO_MULADD(gvec_fmla_h, float16_muladd_nf, float16)
+DO_MULADD(gvec_fmla_s, float32_muladd_nf, float32)
+
+DO_MULADD(gvec_fmls_h, float16_mulsub_nf, float16)
+DO_MULADD(gvec_fmls_s, float32_mulsub_nf, float32)
+
 /* For the indexed ops, SVE applies the index per 128-bit vector segment.
  * For AdvSIMD, there is of course only one such vector segment.
  */
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 13858aaa08b..1f2522f120a 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1119,37 +1119,8 @@ DO_3S_FP_GVEC(VACGE, gen_helper_gvec_facge_s, gen_helper_gvec_facge_h)
 DO_3S_FP_GVEC(VACGT, gen_helper_gvec_facgt_s, gen_helper_gvec_facgt_h)
 DO_3S_FP_GVEC(VMAX, gen_helper_gvec_fmax_s, gen_helper_gvec_fmax_h)
 DO_3S_FP_GVEC(VMIN, gen_helper_gvec_fmin_s, gen_helper_gvec_fmin_h)
-
-/*
- * For all the functions using this macro, size == 1 means fp16,
- * which is an architecture extension we don't implement yet.
- */
-#define DO_3S_FP(INSN,FUNC,READS_VD)                                \
-    static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
-    {                                                               \
-        if (a->size != 0) {                                         \
-            /* TODO fp16 support */                                 \
-            return false;                                           \
-        }                                                           \
-        return do_3same_fp(s, a, FUNC, READS_VD);                   \
-    }
-
-static void gen_VMLA_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
-                            TCGv_ptr fpstatus)
-{
-    gen_helper_vfp_muls(vn, vn, vm, fpstatus);
-    gen_helper_vfp_adds(vd, vd, vn, fpstatus);
-}
-
-static void gen_VMLS_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
-                            TCGv_ptr fpstatus)
-{
-    gen_helper_vfp_muls(vn, vn, vm, fpstatus);
-    gen_helper_vfp_subs(vd, vd, vn, fpstatus);
-}
-
-DO_3S_FP(VMLA, gen_VMLA_fp_3s, true)
-DO_3S_FP(VMLS, gen_VMLS_fp_3s, true)
+DO_3S_FP_GVEC(VMLA, gen_helper_gvec_fmla_s, gen_helper_gvec_fmla_h)
+DO_3S_FP_GVEC(VMLS, gen_helper_gvec_fmls_s, gen_helper_gvec_fmls_h)
 
 WRAP_FP_GVEC(gen_VMAXNM_fp32_3s, FPST_STD, gen_helper_gvec_fmaxnum_s)
 WRAP_FP_GVEC(gen_VMAXNM_fp16_3s, FPST_STD_F16, gen_helper_gvec_fmaxnum_h)
-- 
2.20.1


