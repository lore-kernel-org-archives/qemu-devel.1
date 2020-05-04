Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8B0C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5082071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fwsXjslw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5082071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaTm-0007AX-GP
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIG-0001Jl-Gk
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:50436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaIF-0001J1-Gd
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id x25so8241584wmc.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=k+auw6GnoooTvjmohrID71iS0A2v1EONDZbnfxDt2JM=;
 b=fwsXjslwRQK869LYnv/Qm1wTR6mt+LwTA9gFyB7VFM6MIjS2Y5SHh6M7m6Ghqzy8CF
 KDWv0mjhtzmJk3b3+O+NUMkFk0uOR92Y8Gq/lPwpT+gr3nfUfsROl9cyzfUot5haZwoY
 BH/+hKK8c3Rif+M7IWGFVjFdxu0TixSNJDPW+O5UDtZoKY54T7iAWW+xNck3eHSRc18r
 DeS10lsAB/Piv3wcxLJIiGq3L3F1e5HrVhGKgcjkmCDS3MTP+lrLhx9INh0PWaZ6jHGz
 ZKa6h6sH83M8WlQ9r78dR9F+YTZbVnXLEDVb/frQcDQ/3dWhG2Ss+U77wGxei+3DP0x9
 W9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k+auw6GnoooTvjmohrID71iS0A2v1EONDZbnfxDt2JM=;
 b=sKzbbNrwuM0OhTKOWfV+jKLzHYQBDgxVNihp6CPtELVrI/qBAAeKJWueSyXO1lKbw2
 N5/gKeIVpMZKep71+TE0j6cniXCmNQxcr53R/38nRkNmyIuq+Ws09xh2OTQaYNH4X4KQ
 1fWOJ14dD297BDVAatbdD1YNjDrJqiza98qahafc5OYSKqPrWJ41w6Dum5WQobjRq2uX
 s5nO0j628J4EZ5DT0LJ678FIoncNVZU3ZKw9fLMEN27TML9n0VtBO6FzT/3mJwWw3RV4
 k7B2EIlGW+24XsayUvsfSjOqSaKj0Gpi3nf0QVLJEL2cKxbNABX7Hh8r7mvXq2xF5GjP
 XLcw==
X-Gm-Message-State: AGi0Pubv64n/qRSvr90G5cyCgvetnr1oZ7IvgxbIzQdtz0+tLPBCIdxY
 LCe438ZYh+bUyRmxdp2JgeKOpcwH7P3xfg==
X-Google-Smtp-Source: APiQypIAS28oi/VkwNuQL46/PtYtdMu/9sm440tPWNo8y1DgdgE4uZTLkaV8bidzXVMZ19t0j/CNKw==
X-Received: by 2002:a1c:68d7:: with SMTP id d206mr13506529wmc.29.1588595633713; 
 Mon, 04 May 2020 05:33:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/39] target/arm: Convert Neon 3-reg-same VMUL, VMLA, VMLS,
 VSHL to decodetree
Date: Mon,  4 May 2020 13:33:08 +0100
Message-Id: <20200504123309.3808-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Convert the Neon VMUL, VMLA, VMLS and VSHL insns in the
3-reg-same grouping to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-20-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  9 +++++++
 target/arm/translate-neon.inc.c | 44 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 28 +++------------------
 3 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ab59b349aaa..ec3a92fe753 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -65,6 +65,9 @@ VCGT_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 0 .... @3same
 VCGE_S_3s        1111 001 0 0 . .. .... .... 0011 . . . 1 .... @3same
 VCGE_U_3s        1111 001 1 0 . .. .... .... 0011 . . . 1 .... @3same
 
+VSHL_S_3s        1111 001 0 0 . .. .... .... 0100 . . . 0 .... @3same
+VSHL_U_3s        1111 001 1 0 . .. .... .... 0100 . . . 0 .... @3same
+
 VMAX_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 0 .... @3same
 VMAX_U_3s        1111 001 1 0 . .. .... .... 0110 . . . 0 .... @3same
 VMIN_S_3s        1111 001 0 0 . .. .... .... 0110 . . . 1 .... @3same
@@ -75,3 +78,9 @@ VSUB_3s          1111 001 1 0 . .. .... .... 1000 . . . 0 .... @3same
 
 VTST_3s          1111 001 0 0 . .. .... .... 1000 . . . 1 .... @3same
 VCEQ_3s          1111 001 1 0 . .. .... .... 1000 . . . 1 .... @3same
+
+VMLA_3s          1111 001 0 0 . .. .... .... 1001 . . . 0 .... @3same
+VMLS_3s          1111 001 1 0 . .. .... .... 1001 . . . 0 .... @3same
+
+VMUL_3s          1111 001 0 0 . .. .... .... 1001 . . . 1 .... @3same
+VMUL_p_3s        1111 001 1 0 . .. .... .... 1001 . . . 1 .... @3same
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 854ab70cd79..50b77b6d714 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -631,6 +631,7 @@ DO_3SAME_NO_SZ_3(VMAX_S, tcg_gen_gvec_smax)
 DO_3SAME_NO_SZ_3(VMAX_U, tcg_gen_gvec_umax)
 DO_3SAME_NO_SZ_3(VMIN_S, tcg_gen_gvec_smin)
 DO_3SAME_NO_SZ_3(VMIN_U, tcg_gen_gvec_umin)
+DO_3SAME_NO_SZ_3(VMUL, tcg_gen_gvec_mul)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
@@ -668,3 +669,46 @@ DO_3SAME_GVEC4(VQADD_S, sqadd_op)
 DO_3SAME_GVEC4(VQADD_U, uqadd_op)
 DO_3SAME_GVEC4(VQSUB_S, sqsub_op)
 DO_3SAME_GVEC4(VQSUB_U, uqsub_op)
+
+static void gen_VMUL_p_3s(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                           uint32_t rm_ofs, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, oprsz, maxsz,
+                       0, gen_helper_gvec_pmul_b);
+}
+
+static bool trans_VMUL_p_3s(DisasContext *s, arg_3same *a)
+{
+    if (a->size != 0) {
+        return false;
+    }
+    return do_3same(s, a, gen_VMUL_p_3s);
+}
+
+#define DO_3SAME_GVEC3_NO_SZ_3(INSN, OPARRAY)                           \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs,                          \
+                       oprsz, maxsz, &OPARRAY[vece]);                   \
+    }                                                                   \
+    DO_3SAME_NO_SZ_3(INSN, gen_##INSN##_3s)
+
+
+DO_3SAME_GVEC3_NO_SZ_3(VMLA, mla_op)
+DO_3SAME_GVEC3_NO_SZ_3(VMLS, mls_op)
+
+#define DO_3SAME_GVEC3_SHIFT(INSN, OPARRAY)                             \
+    static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
+                                uint32_t rn_ofs, uint32_t rm_ofs,       \
+                                uint32_t oprsz, uint32_t maxsz)         \
+    {                                                                   \
+        /* Note the operation is vshl vd,vm,vn */                       \
+        tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs,                          \
+                       oprsz, maxsz, &OPARRAY[vece]);                   \
+    }                                                                   \
+    DO_3SAME(INSN, gen_##INSN##_3s)
+
+DO_3SAME_GVEC3_SHIFT(VSHL_S, sshl_op)
+DO_3SAME_GVEC3_SHIFT(VSHL_U, ushl_op)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 13ce1a5fc1d..025747c0bd4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4848,31 +4848,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             }
             return 1;
 
-        case NEON_3R_VMUL: /* VMUL */
-            if (u) {
-                /* Polynomial case allows only P8.  */
-                if (size != 0) {
-                    return 1;
-                }
-                tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
-                                   0, gen_helper_gvec_pmul_b);
-            } else {
-                tcg_gen_gvec_mul(size, rd_ofs, rn_ofs, rm_ofs,
-                                 vec_size, vec_size);
-            }
-            return 0;
-
-        case NEON_3R_VML: /* VMLA, VMLS */
-            tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, vec_size, vec_size,
-                           u ? &mls_op[size] : &mla_op[size]);
-            return 0;
-
-        case NEON_3R_VSHL:
-            /* Note the operation is vshl vd,vm,vn */
-            tcg_gen_gvec_3(rd_ofs, rm_ofs, rn_ofs, vec_size, vec_size,
-                           u ? &ushl_op[size] : &sshl_op[size]);
-            return 0;
-
         case NEON_3R_VADD_VSUB:
         case NEON_3R_LOGIC:
         case NEON_3R_VMAX:
@@ -4882,6 +4857,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
         case NEON_3R_VCGE:
         case NEON_3R_VQADD:
         case NEON_3R_VQSUB:
+        case NEON_3R_VMUL:
+        case NEON_3R_VML:
+        case NEON_3R_VSHL:
             /* Already handled by decodetree */
             return 1;
         }
-- 
2.20.1


