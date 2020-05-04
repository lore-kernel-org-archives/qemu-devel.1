Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11126C47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29212073E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCPYuWoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29212073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaRu-0003PY-Pu
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI6-0000sT-Cc
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:46 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI5-0001Cl-6Z
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:46 -0400
Received: by mail-wr1-x436.google.com with SMTP id g13so20679599wrb.8
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=neqdvUxpmLjYSwX6T+ANCkxHJDmHVzkKcKiliL8Wzk8=;
 b=PCPYuWoyLG9uC0SdabfvoIEZ05NGDVInhW+yUS/7cFfp2TfBgBvrcGJJ++dC/F3xSw
 Nctj89IV9Qjhh6ZcKQjwzG5WVDmIgf1Ne8ivMhXf/qPgi6dUMJHORNUE8seYfDdYoWBw
 VZvKvdnCCUbUjFiOQXYnuNGVu8tX0wLtue4jB02oPbs6oDWhvRZUF/Wo/7n/QPAn/T+W
 8T0/Jvs5PJCviDS6khXv8sr2y4J7FKkfSkoUeZckTk13h5KlKi6mKMaiuXRfMoL11MEd
 YK6+SSM9Vw7d8UmUbxWDpzZ31k7bx89W8EjFJ9f2bwkq9gvO8IYrl5q7RMRMnw8/m5vD
 rp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=neqdvUxpmLjYSwX6T+ANCkxHJDmHVzkKcKiliL8Wzk8=;
 b=aZCEQ8ecHlfDuak3zOx8yW0DjmIV+GS3lB1C3DnNfnN4CmsnxQhdxPt18XsbmIZVsj
 sI+HDwW3PWgkJpo5y3kRRzVaFl9qc2Rf2pimUfqIKif5RmC7u9yWDG9penX5s7aRb8u3
 bteoMbltesPoqgCxPvia3iB9tNDasePXNbni8ouQWP7mD3tI/2bh6xlELnVt8W19pfl1
 cs6gFXEBlazC8ojN08xDMzJ3V3JDGRMwEenpl4EbjljPy79H4o0PlzC266FEwcc774oY
 T3hFvJK4kBq/B8Hy2jAt5i99mMrM7tAfRW2qoVoBBbKdbPtDgRL+nsVxbtBrIdURATLI
 uyZw==
X-Gm-Message-State: AGi0PuaBaT4x4Mg+KsFbmQKD4El7k4ZuNYM93PcElOAUP4UvtWiuyBRg
 rIcojUDW0uvhfl9hrs6fZvmiT4SA07n4fg==
X-Google-Smtp-Source: APiQypIfXqMeX5DDm9WNC6HRgOtLfGH9liQ8a5dWiHF5yX1SU9Wg6mjpNA3rY/q+43fStDWsObJLMw==
X-Received: by 2002:a5d:420a:: with SMTP id n10mr18137264wrq.235.1588595623322; 
 Mon, 04 May 2020 05:33:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/39] target/arm: Convert VFM[AS]L (scalar) to decodetree
Date: Mon,  4 May 2020 13:32:59 +0100
Message-Id: <20200504123309.3808-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Convert the VFM[AS]L (scalar) insns in the 2reg-scalar-ext group
to decodetree. These are the last ones in the group so we can remove
all the legacy decode for the group.

Note that in disas_thumb2_insn() the parts of this encoding space
where the decodetree decoder returns false will correctly be directed
to illegal_op by the "(insn & (1 << 28))" check so they won't fall
into disas_coproc_insn() by mistake.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-11-peter.maydell@linaro.org
---
 target/arm/neon-shared.decode   |   7 +++
 target/arm/translate-neon.inc.c |  32 ++++++++++
 target/arm/translate.c          | 107 +-------------------------------
 3 files changed, 40 insertions(+), 106 deletions(-)

diff --git a/target/arm/neon-shared.decode b/target/arm/neon-shared.decode
index 63a46c63c07..f297ba8cdfc 100644
--- a/target/arm/neon-shared.decode
+++ b/target/arm/neon-shared.decode
@@ -57,3 +57,10 @@ VCMLA_scalar   1111 1110 1 . rot:2 .... .... 1000 . q:1 . 0 .... \
 
 VDOT_scalar    1111 1110 0 . 10 .... .... 1101 . q:1 index:1 u:1 rm:4 \
                vm=%vm_dp vn=%vn_dp vd=%vd_dp
+
+%vfml_scalar_q0_rm 0:3 5:1
+%vfml_scalar_q1_index 5:1 3:1
+VFML_scalar    1111 1110 0 . 0 s:1 .... .... 1000 . 0 . 1 index:1 ... \
+               rm=%vfml_scalar_q0_rm vn=%vn_sp vd=%vd_dp q=0
+VFML_scalar    1111 1110 0 . 0 s:1 .... .... 1000 . 1 . 1 . rm:3 \
+               index=%vfml_scalar_q1_index vn=%vn_dp vd=%vd_dp q=1
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 7cc6ccb0697..b06542b8b83 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -242,3 +242,35 @@ static bool trans_VDOT_scalar(DisasContext *s, arg_VDOT_scalar *a)
     tcg_temp_free_ptr(fpst);
     return true;
 }
+
+static bool trans_VFML_scalar(DisasContext *s, arg_VFML_scalar *a)
+{
+    int opr_sz;
+
+    if (!dc_isar_feature(aa32_fhm, s)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd & 0x10) || (a->q && (a->vn & 0x10)))) {
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
+                       vfp_reg_offset(a->q, a->rm),
+                       cpu_env, opr_sz, opr_sz,
+                       (a->index << 2) | a->s, /* is_2 == 0 */
+                       gen_helper_gvec_fmlal_idx_a32);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8574d0964f7..e269642a480 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2610,8 +2610,6 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
 }
 
 #define VFP_REG_SHR(x, n) (((n) > 0) ? (x) >> (n) : (x) << -(n))
-#define VFP_SREG(insn, bigbit, smallbit) \
-  ((VFP_REG_SHR(insn, bigbit - 1) & 0x1e) | (((insn) >> (smallbit)) & 1))
 #define VFP_DREG(reg, insn, bigbit, smallbit) do { \
     if (dc_isar_feature(aa32_simd_r32, s)) { \
         reg = (((insn) >> (bigbit)) & 0x0f) \
@@ -2622,11 +2620,8 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
         reg = ((insn) >> (bigbit)) & 0x0f; \
     }} while (0)
 
-#define VFP_SREG_D(insn) VFP_SREG(insn, 12, 22)
 #define VFP_DREG_D(reg, insn) VFP_DREG(reg, insn, 12, 22)
-#define VFP_SREG_N(insn) VFP_SREG(insn, 16,  7)
 #define VFP_DREG_N(reg, insn) VFP_DREG(reg, insn, 16,  7)
-#define VFP_SREG_M(insn) VFP_SREG(insn,  0,  5)
 #define VFP_DREG_M(reg, insn) VFP_DREG(reg, insn,  0,  5)
 
 static void gen_neon_dup_low16(TCGv_i32 var)
@@ -7032,94 +7027,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     return 0;
 }
 
-/* Advanced SIMD two registers and a scalar extension.
- *  31             24   23  22   20   16   12  11   10   9    8        3     0
- * +-----------------+----+---+----+----+----+---+----+---+----+---------+----+
- * | 1 1 1 1 1 1 1 0 | o1 | D | o2 | Vn | Vd | 1 | o3 | 0 | o4 | N Q M U | Vm |
- * +-----------------+----+---+----+----+----+---+----+---+----+---------+----+
- *
- */
-
-static int disas_neon_insn_2reg_scalar_ext(DisasContext *s, uint32_t insn)
-{
-    gen_helper_gvec_3 *fn_gvec = NULL;
-    gen_helper_gvec_3_ptr *fn_gvec_ptr = NULL;
-    int rd, rn, rm, opr_sz, data;
-    int off_rn, off_rm;
-    bool is_long = false, q = extract32(insn, 6, 1);
-    bool ptr_is_env = false;
-
-    if ((insn & 0xffa00f10) == 0xfe000810) {
-        /* VFM[AS]L -- 1111 1110 0.0S .... .... 1000 .Q.1 .... */
-        int is_s = extract32(insn, 20, 1);
-        int vm20 = extract32(insn, 0, 3);
-        int vm3 = extract32(insn, 3, 1);
-        int m = extract32(insn, 5, 1);
-        int index;
-
-        if (!dc_isar_feature(aa32_fhm, s)) {
-            return 1;
-        }
-        if (q) {
-            rm = vm20;
-            index = m * 2 + vm3;
-        } else {
-            rm = vm20 * 2 + m;
-            index = vm3;
-        }
-        is_long = true;
-        data = (index << 2) | is_s; /* is_2 == 0 */
-        fn_gvec_ptr = gen_helper_gvec_fmlal_idx_a32;
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
-        if (rn & q & !is_long) {
-            return 1;
-        }
-        off_rn = vfp_reg_offset(1, rn);
-        off_rm = vfp_reg_offset(1, rm);
-    } else {
-        rn = VFP_SREG_N(insn);
-        off_rn = vfp_reg_offset(0, rn);
-        off_rm = vfp_reg_offset(0, rm);
-    }
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
 static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 {
     int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
@@ -10843,12 +10750,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                     }
                 }
             }
-        } else if ((insn & 0x0f000a00) == 0x0e000800
-                   && arm_dc_feature(s, ARM_FEATURE_V8)) {
-            if (disas_neon_insn_2reg_scalar_ext(s, insn)) {
-                goto illegal_op;
-            }
-            return;
         }
         goto illegal_op;
     }
@@ -11026,13 +10927,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
             break;
         }
-        if ((insn & 0xff000a00) == 0xfe000800
-            && arm_dc_feature(s, ARM_FEATURE_V8)) {
-            /* The Thumb2 and ARM encodings are identical.  */
-            if (disas_neon_insn_2reg_scalar_ext(s, insn)) {
-                goto illegal_op;
-            }
-        } else if (((insn >> 24) & 3) == 3) {
+        if (((insn >> 24) & 3) == 3) {
             /* Translate into the equivalent ARM encoding.  */
             insn = (insn & 0xe2ffffff) | ((insn & (1 << 28)) >> 4) | (1 << 28);
             if (disas_neon_data_insn(s, insn)) {
-- 
2.20.1


