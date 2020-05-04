Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E48BC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8D8206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euiHPRdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8D8206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaZv-0000gg-Bk
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI3-0000k9-9d
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:43 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:42155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI1-00018P-W0
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:42 -0400
Received: by mail-wr1-x42e.google.com with SMTP id s8so10394122wrt.9
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SaReUKo4kU55P0PRPMCZjcwtch028hCF4xzjR7V7Obs=;
 b=euiHPRdBGB9CcbwQuxchLDNRlTfJAdSwqoIRW57zp8z6jsl/Ldijxb3VwPZugUs/2k
 p727BWoPjEFMlk0O4+zm9u6vp6tTtLB62M05I9SSDLIKkwmRa0ZpJUKdONJpdNCeRutO
 ty5I4K/8J4hBzvrQ/XqPzLpotPolImxvyWTrAPGZeEU+++UzB7pxD1cPnRo5wXVB+HFa
 vQeTBRb50Btx1GPT9fSPlNOrgmCwfibf0SSm5q4HMHhXFaz2U3JIXa1na/rT8LFoA3aA
 7Vm3yPOwXMTcwWNDU+7VR0WlkUbCeBWnvmtE32H2I1RHJ7m//1x7A95tEUk53ytOdcCZ
 jIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SaReUKo4kU55P0PRPMCZjcwtch028hCF4xzjR7V7Obs=;
 b=oN491tcgaaJHriJWF/IijfyQ2iYJiIQhh7CxmByA4R8Idi5UL8m+PRvnNWcam5VhjG
 Mv3hN1xRxJz0lIz46DpYmq6By1HcKsp40dn0gHyA+LP5Yj6HHCm/vAjyYi4zQH29dkYN
 PLl5qcE148jxQH5WzZhTH6rHSry8TB0mfqdAh1IxbvaHrXAUfTva2C7OcNETWY12CyvW
 yZtweTMw30QXq2bmMvODx1Zprk7sOhZUVCNDHLemdt44Aevm9zQQlAiySXD1pIhcQg/D
 fzlJdPQ1CmL4ukul9xWbGsN4B4UGf7IlZT3uz9h5oIWoiTD2fuX66ohaNudO4kn2tmbD
 R1ug==
X-Gm-Message-State: AGi0PuZU4zKeOHQNulRBn4+a8WufUiwv/ZX94McCLxbDImV+1ztBOPcW
 qqzlfXq+ciZhY6Jd9T4VX8b1k8xVUqIqsQ==
X-Google-Smtp-Source: APiQypLePD/2WMiN6s490G7TzrFfhOFmWeLCw7fZ/8DV13YH6ljBBXuVZ0suGvjIuAe22EgIlu7YtA==
X-Received: by 2002:adf:9264:: with SMTP id 91mr6151552wrj.362.1588595620158; 
 Mon, 04 May 2020 05:33:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/39] target/arm: Convert VFM[AS]L (vector) to decodetree
Date: Mon,  4 May 2020 13:32:56 +0100
Message-Id: <20200504123309.3808-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Convert the VFM[AS]L (vector) insns to decodetree.  This is the last
insn in the legacy decoder for the 3same_ext group, so we can
delete the legacy decoder function for the group entirely.

Note that in disas_thumb2_insn() the parts of this encoding space
where the decodetree decoder returns false will correctly be directed
to illegal_op by the "(insn & (1 << 28))" check so they won't fall
into disas_coproc_insn() by mistake.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-8-peter.maydell@linaro.org
---
 target/arm/neon-shared.decode   |  6 +++
 target/arm/translate-neon.inc.c | 31 +++++++++++
 target/arm/translate.c          | 92 +--------------------------------
 3 files changed, 38 insertions(+), 91 deletions(-)

diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index c9c641905d3..90cd5c871e2 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -43,3 +43,9 @@ VCADD          1111 110 rot:1 1 . 0 size:1 .... .... 1000 . q:1 . 0 .... \
 # VUDOT and VSDOT
 VDOT           1111 110 00 . 10 .... .... 1101 . q:1 . u:1 .... \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+# VFM[AS]L
+VFML           1111 110 0 s:1 . 10 .... .... 1000 . 0 . 1 .... \
+               vm=%vm_sp vn=%vn_sp vd=%vd_dp q=0
+VFML           1111 110 0 s:1 . 10 .... .... 1000 . 1 . 1 .... \
+               vm=%vm_dp vn=%vn_dp vd=%vd_dp q=1
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 6537506c5b6..6c58abc54b5 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -136,3 +136,34 @@ static bool trans_VDOT(DisasContext *s, arg_VDOT *a)
                        opr_sz, opr_sz, 0, fn_gvec);
     return true;
 }
+
+static bool trans_VFML(DisasContext *s, arg_VFML *a)
+{
+    int opr_sz;
+
+    if (!dc_isar_feature(aa32_fhm, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        (a->vd & 0x10)) {
+        return false;
+    }
+
+    if (a->vd & a->q) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    opr_sz = (1 + a->q) * 8;
+    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
+                       vfp_reg_offset(a->q, a->vn),
+                       vfp_reg_offset(a->q, a->vm),
+                       cpu_env, opr_sz, opr_sz, a->s, /* is_2 == 0 */
+                       gen_helper_gvec_fmlal_a32);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7d3aea8c98a..79cd9138fe7 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7032,84 +7032,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     return 0;
 }
 
-/* Advanced SIMD three registers of the same length extension.
- *  31           25    23  22    20   16   12  11   10   9    8        3     0
- * +---------------+-----+---+-----+----+----+---+----+---+----+---------+----+
- * | 1 1 1 1 1 1 0 | op1 | D | op2 | Vn | Vd | 1 | o3 | 0 | o4 | N Q M U | Vm |
- * +---------------+-----+---+-----+----+----+---+----+---+----+---------+----+
- */
-static int disas_neon_insn_3same_ext(DisasContext *s, uint32_t insn)
-{
-    gen_helper_gvec_3 *fn_gvec = NULL;
-    gen_helper_gvec_3_ptr *fn_gvec_ptr = NULL;
-    int rd, rn, rm, opr_sz;
-    int data = 0;
-    int off_rn, off_rm;
-    bool is_long = false, q = extract32(insn, 6, 1);
-    bool ptr_is_env = false;
-
-    if ((insn & 0xff300f10) == 0xfc200810) {
-        /* VFM[AS]L -- 1111 1100 S.10 .... .... 1000 .Q.1 .... */
-        int is_s = extract32(insn, 23, 1);
-        if (!dc_isar_feature(aa32_fhm, s)) {
-            return 1;
-        }
-        is_long = true;
-        data = is_s; /* is_2 == 0 */
-        fn_gvec_ptr = gen_helper_gvec_fmlal_a32;
-        ptr_is_env = true;
-    } else {
-        return 1;
-    }
-
-    VFP_DREG_D(rd, insn);
-    if (rd & q) {
-        return 1;
-    }
-    if (q || !is_long) {
-        VFP_DREG_N(rn, insn);
-        VFP_DREG_M(rm, insn);
-        if ((rn | rm) & q & !is_long) {
-            return 1;
-        }
-        off_rn = vfp_reg_offset(1, rn);
-        off_rm = vfp_reg_offset(1, rm);
-    } else {
-        rn = VFP_SREG_N(insn);
-        rm = VFP_SREG_M(insn);
-        off_rn = vfp_reg_offset(0, rn);
-        off_rm = vfp_reg_offset(0, rm);
-    }
-
-    if (s->fp_excp_el) {
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
-                           syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
-        return 0;
-    }
-    if (!s->vfp_enabled) {
-        return 1;
-    }
-
-    opr_sz = (1 + q) * 8;
-    if (fn_gvec_ptr) {
-        TCGv_ptr ptr;
-        if (ptr_is_env) {
-            ptr = cpu_env;
-        } else {
-            ptr = get_fpstatus_ptr(1);
-        }
-        tcg_gen_gvec_3_ptr(vfp_reg_offset(1, rd), off_rn, off_rm, ptr,
-                           opr_sz, opr_sz, data, fn_gvec_ptr);
-        if (!ptr_is_env) {
-            tcg_temp_free_ptr(ptr);
-        }
-    } else {
-        tcg_gen_gvec_3_ool(vfp_reg_offset(1, rd), off_rn, off_rm,
-                           opr_sz, opr_sz, data, fn_gvec);
-    }
-    return 0;
-}
-
 /* Advanced SIMD two registers and a scalar extension.
  *  31             24   23  22   20   16   12  11   10   9    8        3     0
  * +-----------------+----+---+----+----+----+---+----+---+----+---------+----+
@@ -10956,12 +10878,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     }
                 }
             }
-        } else if ((insn & 0x0e000a00) == 0x0c000800
-                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
-            if (disas_neon_insn_3same_ext(s, insn)) {
-                goto illegal_op;
-            }
-            return;
         } else if ((insn & 0x0f000a00) == 0x0e000800
                    && arm_dc_feature(s, ARM_FEATURE_V8)) {
             if (disas_neon_insn_2reg_scalar_ext(s, insn)) {
@@ -11145,15 +11061,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
             break;
         }
-        if ((insn & 0xfe000a00) == 0xfc000800
+        if ((insn & 0xff000a00) == 0xfe000800
             && arm_dc_feature(s, ARM_FEATURE_V8)) {
             /* The Thumb2 and ARM encodings are identical.  */
-            if (disas_neon_insn_3same_ext(s, insn)) {
-                goto illegal_op;
-            }
-        } else if ((insn & 0xff000a00) == 0xfe000800
-                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
-            /* The Thumb2 and ARM encodings are identical.  */
             if (disas_neon_insn_2reg_scalar_ext(s, insn)) {
                 goto illegal_op;
             }
-- 
2.20.1


