Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8240CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D586206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MN77JafK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D586206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYY38-0007mM-LX
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw9-0006Xx-H8
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39442)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXw8-00067w-EA
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:21 -0400
Received: by mail-wr1-x443.google.com with SMTP id l18so16281850wrn.6
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DO73kxC/ieb1z/wK6QeuNNqcIXsVWMQQ5sDynNEanWc=;
 b=MN77JafK1S/SsT5S+Me5dRKdjuh1PATCiSXfCAzYb6/VAIkfY27NEdwBwSarDYBVU2
 /BHfTGG3ZNlsJthj2rUWpC4gnR+ija1RpHBbg4QVMBMGb7W5XLzolufYnhTD/dYWhQNd
 qAkzKZrF7oqeRLW6AiAZIHrzgai6yapwrbdoGfeHy1fazzCQghPeOTKLNOTpfNr5anyO
 J7A/FNIhXjBh1+RW3V/dwMDVLmmOy1shCfuCB+MoOnBOhnJq6sNzOaIuLILRtwz8FtXf
 LlTZ3/4dK13as0cLCifBg+FVcPylFWiDhj6bpnXV3myb90loImNEcWwG/Ml2ilzyIUXL
 x4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DO73kxC/ieb1z/wK6QeuNNqcIXsVWMQQ5sDynNEanWc=;
 b=cAI4l9bJLS0ePZodXTUtMmAuE73DF940c7J7UF8WsUgd9dTDjs9+i3U/+kujsytJWf
 7VEFtNQ3fU4tvcHlw+m9oKrTlewP182rTJxrdLJdP9qPJ8PQgREUryKt/wMzmJus0TWa
 OG/C/OZvn0ZyxAwVdywRlNbBb9CNJy0Lb5NlIzrYK2bV0MtsOgrDqAIK+JzQHdzfrXwI
 ntwFI+AV9j0SJtD53UwfXbQrG1r3V5XiNUwnvxz7JCzsFerd3LXCt+QHd6bnMt2V9JXN
 1UIJ1OpDw1/cLh9hun61LsRCiP5a7w8faq61M7aF/I84SC6yZE+uBQRT63ks+K0ffZTp
 NBgQ==
X-Gm-Message-State: AGi0Pua7iAOVa34jYqY27+zYW1Maj5KFqFdYW6RwT7ObvEU1mv29Tt7d
 5bJs7QowVsYhpjzmpgn8gzQihoQS4EB7Pg==
X-Google-Smtp-Source: APiQypKKATuRdb92nWiylLf3aQE8SKv8RK1ewXrdgyExc9B60V40SaGpqQdZhLjk83CQse3e7kuktg==
X-Received: by 2002:adf:814a:: with SMTP id 68mr26355317wrm.177.1589301559036; 
 Tue, 12 May 2020 09:39:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 08/17] target/arm: Convert Neon VPMAX/VPMIN 3-reg-same
 insns to decodetree
Date: Tue, 12 May 2020 17:38:55 +0100
Message-Id: <20200512163904.10918-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon integer VPMAX and VPMIN 3-reg-same insns to
decodetree. These are 'pairwise' operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  9 +++++
 target/arm/translate-neon.inc.c | 71 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 17 +-------
 3 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index e0da5a39fc2..03f39a0b44b 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -42,6 +42,9 @@
 @3same           .... ... . . . size:2 .... .... .... . q:1 . . .... \
                  &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
+@3same_q0        .... ... . . . size:2 .... .... .... . 0 . . .... \
+                 &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp q=0
+
 VHADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 0 .... @3same
 VHADD_U_3s       1111 001 1 0 . .. .... .... 0000 . . . 0 .... @3same
 VQADD_S_3s       1111 001 0 0 . .. .... .... 0000 . . . 1 .... @3same
@@ -144,6 +147,12 @@ VMLS_3s          1111 001 1 0 . .. .... .... 1001 . . . 0 .... @3same
 VMUL_3s          1111 001 0 0 . .. .... .... 1001 . . . 1 .... @3same
 VMUL_p_3s        1111 001 1 0 . .. .... .... 1001 . . . 1 .... @3same
 
+VPMAX_S_3s       1111 001 0 0 . .. .... .... 1010 . . . 0 .... @3same_q0
+VPMAX_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 0 .... @3same_q0
+
+VPMIN_S_3s       1111 001 0 0 . .. .... .... 1010 . . . 1 .... @3same_q0
+VPMIN_U_3s       1111 001 1 0 . .. .... .... 1010 . . . 1 .... @3same_q0
+
 VQRDMLAH_3s      1111 001 1 0 . .. .... .... 1011 ... 1 .... @3same
 
 SHA1_3s          1111 001 0 0 . optype:2 .... .... 1100 . 1 . 0 .... \
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 7097c18f334..7db6b856598 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -924,3 +924,74 @@ DO_3SAME_32_ENV(VQSHL_S, qshl_s)
 DO_3SAME_32_ENV(VQSHL_U, qshl_u)
 DO_3SAME_32_ENV(VQRSHL_S, qrshl_s)
 DO_3SAME_32_ENV(VQRSHL_U, qrshl_u)
+
+static bool do_3same_pair(DisasContext *s, arg_3same *a, NeonGenTwoOpFn *fn)
+{
+    /* Operations handled pairwise 32 bits at a time */
+    TCGv_i32 tmp, tmp2, tmp3;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (a->size == 3) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    assert(a->q == 0); /* enforced by decode patterns */
+
+    /*
+     * Note that we have to be careful not to clobber the source operands
+     * in the "vm == vd" case by storing the result of the first pass too
+     * early. Since Q is 0 there are always just two passes, so instead
+     * of a complicated loop over each pass we just unroll.
+     */
+    tmp = neon_load_reg(a->vn, 0);
+    tmp2 = neon_load_reg(a->vn, 1);
+    fn(tmp, tmp, tmp2);
+    tcg_temp_free_i32(tmp2);
+
+    tmp3 = neon_load_reg(a->vm, 0);
+    tmp2 = neon_load_reg(a->vm, 1);
+    fn(tmp3, tmp3, tmp2);
+    tcg_temp_free_i32(tmp2);
+
+    neon_store_reg(a->vd, 0, tmp);
+    neon_store_reg(a->vd, 1, tmp3);
+    return true;
+}
+
+#define DO_3SAME_PAIR(INSN, func)                                       \
+    static bool trans_##INSN##_3s(DisasContext *s, arg_3same *a)        \
+    {                                                                   \
+        static NeonGenTwoOpFn * const fns[] = {                         \
+            gen_helper_neon_##func##8,                                  \
+            gen_helper_neon_##func##16,                                 \
+            gen_helper_neon_##func##32,                                 \
+        };                                                              \
+        if (a->size > 2) {                                              \
+            return false;                                               \
+        }                                                               \
+        return do_3same_pair(s, a, fns[a->size]);                       \
+    }
+
+/* 32-bit pairwise ops end up the same as the elementwise versions.  */
+#define gen_helper_neon_pmax_s32  tcg_gen_smax_i32
+#define gen_helper_neon_pmax_u32  tcg_gen_umax_i32
+#define gen_helper_neon_pmin_s32  tcg_gen_smin_i32
+#define gen_helper_neon_pmin_u32  tcg_gen_umin_i32
+
+DO_3SAME_PAIR(VPMAX_S, pmax_s)
+DO_3SAME_PAIR(VPMIN_S, pmin_s)
+DO_3SAME_PAIR(VPMAX_U, pmax_u)
+DO_3SAME_PAIR(VPMIN_U, pmin_u)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3aabb18720b..82be4d40282 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3011,12 +3011,6 @@ static inline void gen_neon_rsb(int size, TCGv_i32 t0, TCGv_i32 t1)
     }
 }
 
-/* 32-bit pairwise ops end up the same as the elementwise versions.  */
-#define gen_helper_neon_pmax_s32  tcg_gen_smax_i32
-#define gen_helper_neon_pmax_u32  tcg_gen_umax_i32
-#define gen_helper_neon_pmin_s32  tcg_gen_smin_i32
-#define gen_helper_neon_pmin_u32  tcg_gen_umin_i32
-
 #define GEN_NEON_INTEGER_OP_ENV(name) do { \
     switch ((size << 1) | u) { \
     case 0: \
@@ -5442,6 +5436,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VQSHL:
         case NEON_3R_VRSHL:
         case NEON_3R_VQRSHL:
+        case NEON_3R_VPMAX:
+        case NEON_3R_VPMIN:
             /* Already handled by decodetree */
             return 1;
         }
@@ -5453,8 +5449,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         pairwise = 0;
         switch (op) {
         case NEON_3R_VPADD_VQRDMLAH:
-        case NEON_3R_VPMAX:
-        case NEON_3R_VPMIN:
             pairwise = 1;
             break;
         case NEON_3R_FLOAT_ARITH:
@@ -5511,13 +5505,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tmp2 = neon_load_reg(rm, pass);
         }
         switch (op) {
-            break;
-        case NEON_3R_VPMAX:
-            GEN_NEON_INTEGER_OP(pmax);
-            break;
-        case NEON_3R_VPMIN:
-            GEN_NEON_INTEGER_OP(pmin);
-            break;
         case NEON_3R_VQDMULH_VQRDMULH: /* Multiply high.  */
             if (!u) { /* VQDMULH */
                 switch (size) {
-- 
2.20.1


