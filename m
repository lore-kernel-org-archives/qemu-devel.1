Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F27C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3DF205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uosSERFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3DF205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFCQ-0007Yp-FQ
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkx-0004Au-5B
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkv-00061g-WE
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:38 -0400
Received: by mail-wr1-x432.google.com with SMTP id y3so4399869wrt.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=e6cgW2MC3cIx02BNuA5zMpLm8/tIJhuVDzZD2EIoPTU=;
 b=uosSERFfYREgOaGrhl7QsE8opUOYh7pw8vCP0ieD8zYDG/+S7sfrBI6uhslP3yWEhj
 fuHPVjROQclXiGaijk/PsnB+0ost4+3hbz4DIYJ36xkNrs+g3Uoion9EzTUlYGN3yYNR
 Z91AiFT3K2aFIPF/lVhUd+OJMKWi47iXMGm7zsICzoLtaY6v6HlKWeHYAoFpoBwhzvHQ
 R4Lu7MYo6P6yLzNmHNAQKGCgz56I7O5IorRRv8xn0s7cSFPJmhx8phSEqUD10cXlNDsS
 0O1l3sK8S0nGQJhGAo5mCQksFIcFspePztZATMWq8Ov0QnxRZX892PBTy6YW0ASOVdzn
 A+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e6cgW2MC3cIx02BNuA5zMpLm8/tIJhuVDzZD2EIoPTU=;
 b=rwTe5dzzL08YTSUWnC2xvzkWaDO+zSRTdAK4tbAsIjtZxoVZitYCP6UmfDQ9o3fqOl
 3pwL+mJlYDdQxyDBoT/hd3Fwyivnu9+xv2N/sH0xDICLDyoBx3fhz/Uejp8HeunWoRaC
 mMfLJhbyHkLAfPUXk2nZxgdcQvUz/YF4I5rxgv45ED7f1Q8ODqYJ8bxl/JjzsuJDnkKR
 V4oFTLJeyvwLoZ9WCuuQrqswucO/m3PDbUlXVbqVWhzZhMeJNJv/GkeH6JsMrnvHHYsr
 hR5Q6fDn2t0c4qC8FskKhc3xnIBdPH1kgVmanksqPabvwQcyb6yT1OgYu6HD1SZDWXUj
 xtYQ==
X-Gm-Message-State: AOAM532TBjtNedYzAJQXpwr8ac3tX80Vw6//2XedeIb2mR/VkuJ1BolU
 +vr3LahXPhkk/wIb/4w4TSaOjU9VYqRTCw==
X-Google-Smtp-Source: ABdhPJzYc971s33ue5P4qJjaHievbn5gyzRq/O2tgvNVOHhPBHp48c6EEa3Z58RZOtf6WBiohwkGEQ==
X-Received: by 2002:adf:e408:: with SMTP id g8mr6167414wrm.363.1589466156239; 
 Thu, 14 May 2020 07:22:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/45] target/arm: Convert Neon fp
 VMAX/VMIN/VMAXNM/VMINNM/VRECPS/VRSQRTS to decodetree
Date: Thu, 14 May 2020 15:21:37 +0100
Message-Id: <20200514142138.20875-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon fp VMAX/VMIN/VMAXNM/VMINNM/VRECPS/VRSQRTS 3-reg-same
insns to decodetree. (These are all the remaining non-accumulation
instructions in this group.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200512163904.10918-17-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  6 +++
 target/arm/translate-neon.inc.c | 70 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 42 +-------------------
 3 files changed, 78 insertions(+), 40 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 29cf54c217c..9c288865070 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -188,5 +188,11 @@ VCGE_fp_3s       1111 001 1 0 . 0 . .... .... 1110 ... 0 .... @3same_fp
 VACGE_fp_3s      1111 001 1 0 . 0 . .... .... 1110 ... 1 .... @3same_fp
 VCGT_fp_3s       1111 001 1 0 . 1 . .... .... 1110 ... 0 .... @3same_fp
 VACGT_fp_3s      1111 001 1 0 . 1 . .... .... 1110 ... 1 .... @3same_fp
+VMAX_fp_3s       1111 001 0 0 . 0 . .... .... 1111 ... 0 .... @3same_fp
+VMIN_fp_3s       1111 001 0 0 . 1 . .... .... 1111 ... 0 .... @3same_fp
 VPMAX_fp_3s      1111 001 1 0 . 0 . .... .... 1111 ... 0 .... @3same_fp_q0
 VPMIN_fp_3s      1111 001 1 0 . 1 . .... .... 1111 ... 0 .... @3same_fp_q0
+VRECPS_fp_3s     1111 001 0 0 . 0 . .... .... 1111 ... 1 .... @3same_fp
+VRSQRTS_fp_3s    1111 001 0 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
+VMAXNM_fp_3s     1111 001 1 0 . 0 . .... .... 1111 ... 1 .... @3same_fp
+VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index eeea71e3bec..5e9e53c5c32 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1119,6 +1119,8 @@ DO_3S_FP(VCGE, gen_helper_neon_cge_f32, false)
 DO_3S_FP(VCGT, gen_helper_neon_cgt_f32, false)
 DO_3S_FP(VACGE, gen_helper_neon_acge_f32, false)
 DO_3S_FP(VACGT, gen_helper_neon_acgt_f32, false)
+DO_3S_FP(VMAX, gen_helper_vfp_maxs, false)
+DO_3S_FP(VMIN, gen_helper_vfp_mins, false)
 
 static void gen_VMLA_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
                             TCGv_ptr fpstatus)
@@ -1137,6 +1139,74 @@ static void gen_VMLS_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
 DO_3S_FP(VMLA, gen_VMLA_fp_3s, true)
 DO_3S_FP(VMLS, gen_VMLS_fp_3s, true)
 
+static bool trans_VMAXNM_fp_3s(DisasContext *s, arg_3same *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
+        return false;
+    }
+
+    if (a->size != 0) {
+        /* TODO fp16 support */
+        return false;
+    }
+
+    return do_3same_fp(s, a, gen_helper_vfp_maxnums, false);
+}
+
+static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
+{
+    if (!arm_dc_feature(s, ARM_FEATURE_V8)) {
+        return false;
+    }
+
+    if (a->size != 0) {
+        /* TODO fp16 support */
+        return false;
+    }
+
+    return do_3same_fp(s, a, gen_helper_vfp_minnums, false);
+}
+
+WRAP_ENV_FN(gen_VRECPS_tramp, gen_helper_recps_f32)
+
+static void gen_VRECPS_fp_3s(unsigned vece, uint32_t rd_ofs,
+                             uint32_t rn_ofs, uint32_t rm_ofs,
+                             uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 ops = { .fni4 = gen_VRECPS_tramp };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops);
+}
+
+static bool trans_VRECPS_fp_3s(DisasContext *s, arg_3same *a)
+{
+    if (a->size != 0) {
+        /* TODO fp16 support */
+        return false;
+    }
+
+    return do_3same(s, a, gen_VRECPS_fp_3s);
+}
+
+WRAP_ENV_FN(gen_VRSQRTS_tramp, gen_helper_rsqrts_f32)
+
+static void gen_VRSQRTS_fp_3s(unsigned vece, uint32_t rd_ofs,
+                              uint32_t rn_ofs, uint32_t rm_ofs,
+                              uint32_t oprsz, uint32_t maxsz)
+{
+    static const GVecGen3 ops = { .fni4 = gen_VRSQRTS_tramp };
+    tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz, &ops);
+}
+
+static bool trans_VRSQRTS_fp_3s(DisasContext *s, arg_3same *a)
+{
+    if (a->size != 0) {
+        /* TODO fp16 support */
+        return false;
+    }
+
+    return do_3same(s, a, gen_VRSQRTS_fp_3s);
+}
+
 static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
 {
     /* FP operations handled pairwise 32 bits at a time */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 23e3705172b..c1d4fab8e80 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5436,6 +5436,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_FLOAT_MULTIPLY:
         case NEON_3R_FLOAT_CMP:
         case NEON_3R_FLOAT_ACMP:
+        case NEON_3R_FLOAT_MINMAX:
+        case NEON_3R_FLOAT_MISC:
             /* Already handled by decodetree */
             return 1;
         }
@@ -5445,17 +5447,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             return 1;
         }
         switch (op) {
-        case NEON_3R_FLOAT_MINMAX:
-            if (u) {
-                return 1; /* VPMIN/VPMAX handled by decodetree */
-            }
-            break;
-        case NEON_3R_FLOAT_MISC:
-            /* VMAXNM/VMINNM in ARMv8 */
-            if (u && !arm_dc_feature(s, ARM_FEATURE_V8)) {
-                return 1;
-            }
-            break;
         case NEON_3R_VFM_VQRDMLSH:
             if (!dc_isar_feature(aa32_simdfmac, s)) {
                 return 1;
@@ -5471,35 +5462,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         tmp = neon_load_reg(rn, pass);
         tmp2 = neon_load_reg(rm, pass);
         switch (op) {
-        case NEON_3R_FLOAT_MINMAX:
-        {
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            if (size == 0) {
-                gen_helper_vfp_maxs(tmp, tmp, tmp2, fpstatus);
-            } else {
-                gen_helper_vfp_mins(tmp, tmp, tmp2, fpstatus);
-            }
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
-        case NEON_3R_FLOAT_MISC:
-            if (u) {
-                /* VMAXNM/VMINNM */
-                TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                if (size == 0) {
-                    gen_helper_vfp_maxnums(tmp, tmp, tmp2, fpstatus);
-                } else {
-                    gen_helper_vfp_minnums(tmp, tmp, tmp2, fpstatus);
-                }
-                tcg_temp_free_ptr(fpstatus);
-            } else {
-                if (size == 0) {
-                    gen_helper_recps_f32(tmp, cpu_env, tmp, tmp2);
-                } else {
-                    gen_helper_rsqrts_f32(tmp, cpu_env, tmp, tmp2);
-              }
-            }
-            break;
         case NEON_3R_VFM_VQRDMLSH:
         {
             /* VFMA, VFMS: fused multiply-add */
-- 
2.20.1


