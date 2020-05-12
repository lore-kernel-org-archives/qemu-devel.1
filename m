Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA39CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C216206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aj+xLkG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C216206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYY9u-0007bN-8P
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwI-0006uD-Vb
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:31 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwH-0006Lh-PE
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:30 -0400
Received: by mail-wm1-x343.google.com with SMTP id y24so24224360wma.4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rYOYRtg99xSCr5ET97yS6jthFxSiidOBBESmPdEt8oM=;
 b=aj+xLkG5shy+V/aSdioqQNdl0VFxdvf8MHu4Cevfb4KPWvpoD5Z7XmoDrLRJMLSxfz
 CgugOXN7Zlvzk3j57VHtiQGiM+yUcrILgnpb6GgT442yCUFW9nMPP13qMs6x/pbZ9H8n
 AcmkoKrFwpbknjz2jXIVPBJhjlQ7ve3FbyzZ1UwGoW29LehldJNvzRfNsiRVBWnppHNf
 CU882O42sCbjZ5iU06yjnyhj9T+wnl+RQMEFua3Q+rmnF5TbaqERitdvUE+Kly/0bHqa
 pGIAKDTm0shw4jQf7wyGJzUOgUd255tj6ztZV+ywAIeCEUspp4lNnGwf9BlLAfjDi304
 HIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rYOYRtg99xSCr5ET97yS6jthFxSiidOBBESmPdEt8oM=;
 b=aEjetbZGxu2JNi3JUZ/SwL5fyWr6uGQspqXtVGbmX6m/HjWnwo4HoTX5FRGVuC9UjD
 Hy9+Jc4JDmheM9fehtfAWKgfkSxWQA5hboyXICpDU/O+vWAo4KuYnq1ndWkSlTgs2Dc/
 xUoCsHY4EWhO32dwNdHTbeQZQkh4O5fyh7HViXeHDmueeU9cRTZUqamD8RklP4Dkkf3u
 BqnKHiWjVkoCMWVGQCK1fPTohZnbsERS9QbYfVU+lDeRoWk8wmo5S6ahM9WDsuarxEiz
 K8rSWM9DL3eN1MdZweXhiVRVyg+h3Er6G9wqcEcKs3XI1iq32OgwoZBC5J0JxNGDEhnR
 O3+w==
X-Gm-Message-State: AGi0Puag1vosD5iiQW8F1ekSh8X/4cM2JVh0705os2174YtKTjWo471j
 y5qe7VAiVCR6Dgpj6Ifl6oYW+Q==
X-Google-Smtp-Source: APiQypJQIZ9GRzW9aHCT1fq52a88j61AgsGwGl8tkzPNkkfZ0tbi1JS73YgFLcsGVmascEZgmF/Mbg==
X-Received: by 2002:a05:600c:2f17:: with SMTP id
 r23mr36608455wmn.81.1589301568454; 
 Tue, 12 May 2020 09:39:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 16/17] target/arm: Convert Neon fp
 VMAX/VMIN/VMAXNM/VMINNM/VRECPS/VRSQRTS to decodetree
Date: Tue, 12 May 2020 17:39:03 +0100
Message-Id: <20200512163904.10918-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512163904.10918-1-peter.maydell@linaro.org>
References: <20200512163904.10918-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

Convert the Neon fp VMAX/VMIN/VMAXNM/VMINNM/VRECPS/VRSQRTS 3-reg-same
insns to decodetree. (These are all the remaining non-accumulation
instructions in this group.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  6 +++
 target/arm/translate-neon.inc.c | 70 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 42 +-------------------
 3 files changed, 78 insertions(+), 40 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index bc5a3e0295c..c276faf8cce 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -189,5 +189,11 @@ VCGE_fp_3s       1111 001 1 0 . 0 . .... .... 1110 ... 0 .... @3same_fp
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
index eeea71e3bec..263d2b47132 100644
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
+            return false;
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
+            return false;
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


