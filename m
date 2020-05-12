Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0449CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D986206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEbNz3QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D986206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYYCH-00038U-H7
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwK-0006yU-M3
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYXwJ-0006N5-6l
 for qemu-devel@nongnu.org; Tue, 12 May 2020 12:39:32 -0400
Received: by mail-wm1-x343.google.com with SMTP id w19so9435217wmc.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jvTpgwbd+LTkl54Kt4cTm/vhOyWXxlbq+3ojpz64Gk8=;
 b=sEbNz3QB4lL4aDrpkmxAcr6fgTDjTqatABWw3sURm2rR6Dd8qAllDmwCLs+TES7AWI
 Ew1enGJ1mQ6m3iB50WAhoJy/C5xd07nBba73QQEdlv3qK4LmzTKnhDTrbiDmfKV1Jrra
 tuibWe3bgwrCjxHMWsfQsdiuNg3lcXLuP4oIzao2TZUC7Yu45TP7uZ8SXv2dSB5MmNdD
 D4t65L0kx1jfVHR97B6s7ferIeY85z1C72393a+eLxWAv0NbMvYzmlet2H5y6/HHO0YD
 jA6gkBS+vOLI3ul3jrbLncAaQqBHd5Jh/3Ef5vjBY2qePKRJ8pALG+B7l7zHyy8K8HQU
 djpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jvTpgwbd+LTkl54Kt4cTm/vhOyWXxlbq+3ojpz64Gk8=;
 b=qUU8O1Qh33K6d94cvXBlJ7dYMqEO+SZKvYEsJ8nTJEyxvhhan81YSBM++GSGKO5Ff+
 FMSTMBfC6EMHlR/KUMiupbdg/yBCtIL47Qzk4Un+aI/YiT9epG3pVkhd4QuMFNNDB2EF
 BXkOXy3m3rpyWly1/mZC9FMzVlE4UAfehC6rcspPRS+0PFg3rgxdv6F4x+ZF7jszFmWb
 AXsB6fgfixdZfmBPKgNexRfXD3M4Vo34h9u0qiIbswtQsaZ67wbYvReEZs3GNfsv33ej
 RXCS/rf1xqjXfxAfZb5t+WHW7P9wFrlZqf5hk4oKi03ZgOaO+V0BZvfaxL25NMw2Ue+j
 v3jA==
X-Gm-Message-State: AGi0PuYLdAf46ducuuq3eibZZOK/62uD+c+epM4tCXDidYTJb/HAi2No
 VzxFVBQUvwOwjE3T3VZ2evyvS+2wU51Ajg==
X-Google-Smtp-Source: APiQypJMpv1fCmXHkv2Bfkl+PKG4vCSv65KMdHOM5CdwMyt+AiFVsfDwGwQ6cLzbCVtmBjl/aUHNIA==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr22810671wmz.29.1589301569642; 
 Tue, 12 May 2020 09:39:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o205sm18525981wmo.32.2020.05.12.09.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:39:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 17/17] target/arm: Convert NEON VFMA,
 VFMS 3-reg-same insns to decodetree
Date: Tue, 12 May 2020 17:39:04 +0100
Message-Id: <20200512163904.10918-18-peter.maydell@linaro.org>
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

Convert the Neon floating point VFMA and VFMS insn to decodetree.
These are the last insns in the 3-reg-same group so we can
remove all the support/loop code from the old decoder.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |   3 +
 target/arm/translate-neon.inc.c |  41 ++++++++
 target/arm/translate.c          | 176 +-------------------------------
 3 files changed, 46 insertions(+), 174 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index c276faf8cce..f53bf8a4494 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -175,6 +175,9 @@ SHA256H2_3s      1111 001 1 0 . 01 .... .... 1100 . 1 . 0 .... \
 SHA256SU1_3s     1111 001 1 0 . 10 .... .... 1100 . 1 . 0 .... \
                  vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
+VFMA_fp_3s       1111 001 0 0 . 0 . .... .... 1100 ... 1 .... @3same_fp
+VFMS_fp_3s       1111 001 0 0 . 1 . .... .... 1100 ... 1 .... @3same_fp
+
 VQRDMLSH_3s      1111 001 1 0 . .. .... .... 1100 ... 1 .... @3same
 
 VADD_fp_3s       1111 001 0 0 . 0 . .... .... 1101 ... 0 .... @3same_fp
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 263d2b47132..7212876e8f0 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -1207,6 +1207,47 @@ static bool trans_VRSQRTS_fp_3s(DisasContext *s, arg_3same *a)
     return do_3same(s, a, gen_VRSQRTS_fp_3s);
 }
 
+static void gen_VFMA_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
+                            TCGv_ptr fpstatus)
+{
+    gen_helper_vfp_muladds(vd, vn, vm, vd, fpstatus);
+}
+
+static bool trans_VFMA_fp_3s(DisasContext *s, arg_3same *a)
+{
+    if (!dc_isar_feature(aa32_simdfmac, s)) {
+        return false;
+    }
+
+    if (a->size != 0) {
+        /* TODO fp16 support */
+        return false;
+    }
+
+    return do_3same_fp(s, a, gen_VFMA_fp_3s, true);
+}
+
+static void gen_VFMS_fp_3s(TCGv_i32 vd, TCGv_i32 vn, TCGv_i32 vm,
+                            TCGv_ptr fpstatus)
+{
+    gen_helper_vfp_negs(vn, vn);
+    gen_helper_vfp_muladds(vd, vn, vm, vd, fpstatus);
+}
+
+static bool trans_VFMS_fp_3s(DisasContext *s, arg_3same *a)
+{
+    if (!dc_isar_feature(aa32_simdfmac, s)) {
+        return false;
+    }
+
+    if (a->size != 0) {
+        /* TODO fp16 support */
+        return false;
+    }
+
+    return do_3same_fp(s, a, gen_VFMS_fp_3s, true);
+}
+
 static bool do_3same_fp_pair(DisasContext *s, arg_3same *a, VFPGen3OpSPFn *fn)
 {
     /* FP operations handled pairwise 32 bits at a time */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index c1d4fab8e80..4c9bb8b5ac0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3391,78 +3391,6 @@ static void gen_neon_narrow_op(int op, int u, int size,
     }
 }
 
-/* Symbolic constants for op fields for Neon 3-register same-length.
- * The values correspond to bits [11:8,4]; see the ARM ARM DDI0406B
- * table A7-9.
- */
-#define NEON_3R_VHADD 0
-#define NEON_3R_VQADD 1
-#define NEON_3R_VRHADD 2
-#define NEON_3R_LOGIC 3 /* VAND,VBIC,VORR,VMOV,VORN,VEOR,VBIF,VBIT,VBSL */
-#define NEON_3R_VHSUB 4
-#define NEON_3R_VQSUB 5
-#define NEON_3R_VCGT 6
-#define NEON_3R_VCGE 7
-#define NEON_3R_VSHL 8
-#define NEON_3R_VQSHL 9
-#define NEON_3R_VRSHL 10
-#define NEON_3R_VQRSHL 11
-#define NEON_3R_VMAX 12
-#define NEON_3R_VMIN 13
-#define NEON_3R_VABD 14
-#define NEON_3R_VABA 15
-#define NEON_3R_VADD_VSUB 16
-#define NEON_3R_VTST_VCEQ 17
-#define NEON_3R_VML 18 /* VMLA, VMLS */
-#define NEON_3R_VMUL 19
-#define NEON_3R_VPMAX 20
-#define NEON_3R_VPMIN 21
-#define NEON_3R_VQDMULH_VQRDMULH 22
-#define NEON_3R_VPADD_VQRDMLAH 23
-#define NEON_3R_SHA 24 /* SHA1C,SHA1P,SHA1M,SHA1SU0,SHA256H{2},SHA256SU1 */
-#define NEON_3R_VFM_VQRDMLSH 25 /* VFMA, VFMS, VQRDMLSH */
-#define NEON_3R_FLOAT_ARITH 26 /* float VADD, VSUB, VPADD, VABD */
-#define NEON_3R_FLOAT_MULTIPLY 27 /* float VMLA, VMLS, VMUL */
-#define NEON_3R_FLOAT_CMP 28 /* float VCEQ, VCGE, VCGT */
-#define NEON_3R_FLOAT_ACMP 29 /* float VACGE, VACGT, VACLE, VACLT */
-#define NEON_3R_FLOAT_MINMAX 30 /* float VMIN, VMAX */
-#define NEON_3R_FLOAT_MISC 31 /* float VRECPS, VRSQRTS, VMAXNM/MINNM */
-
-static const uint8_t neon_3r_sizes[] = {
-    [NEON_3R_VHADD] = 0x7,
-    [NEON_3R_VQADD] = 0xf,
-    [NEON_3R_VRHADD] = 0x7,
-    [NEON_3R_LOGIC] = 0xf, /* size field encodes op type */
-    [NEON_3R_VHSUB] = 0x7,
-    [NEON_3R_VQSUB] = 0xf,
-    [NEON_3R_VCGT] = 0x7,
-    [NEON_3R_VCGE] = 0x7,
-    [NEON_3R_VSHL] = 0xf,
-    [NEON_3R_VQSHL] = 0xf,
-    [NEON_3R_VRSHL] = 0xf,
-    [NEON_3R_VQRSHL] = 0xf,
-    [NEON_3R_VMAX] = 0x7,
-    [NEON_3R_VMIN] = 0x7,
-    [NEON_3R_VABD] = 0x7,
-    [NEON_3R_VABA] = 0x7,
-    [NEON_3R_VADD_VSUB] = 0xf,
-    [NEON_3R_VTST_VCEQ] = 0x7,
-    [NEON_3R_VML] = 0x7,
-    [NEON_3R_VMUL] = 0x7,
-    [NEON_3R_VPMAX] = 0x7,
-    [NEON_3R_VPMIN] = 0x7,
-    [NEON_3R_VQDMULH_VQRDMULH] = 0x6,
-    [NEON_3R_VPADD_VQRDMLAH] = 0x7,
-    [NEON_3R_SHA] = 0xf, /* size field encodes op type */
-    [NEON_3R_VFM_VQRDMLSH] = 0x7, /* For VFM, size bit 1 encodes op */
-    [NEON_3R_FLOAT_ARITH] = 0x5, /* size bit 1 encodes op */
-    [NEON_3R_FLOAT_MULTIPLY] = 0x5, /* size bit 1 encodes op */
-    [NEON_3R_FLOAT_CMP] = 0x5, /* size bit 1 encodes op */
-    [NEON_3R_FLOAT_ACMP] = 0x5, /* size bit 1 encodes op */
-    [NEON_3R_FLOAT_MINMAX] = 0x5, /* size bit 1 encodes op */
-    [NEON_3R_FLOAT_MISC] = 0x5, /* size bit 1 encodes op */
-};
-
 /* Symbolic constants for op fields for Neon 2-register miscellaneous.
  * The values correspond to bits [17:16,10:7]; see the ARM ARM DDI0406B
  * table A7-13.
@@ -5383,108 +5311,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
     rm_ofs = neon_reg_offset(rm, 0);
 
     if ((insn & (1 << 23)) == 0) {
-        /* Three register same length.  */
-        op = ((insn >> 7) & 0x1e) | ((insn >> 4) & 1);
-        /* Catch invalid op and bad size combinations: UNDEF */
-        if ((neon_3r_sizes[op] & (1 << size)) == 0) {
-            return 1;
-        }
-        /* All insns of this form UNDEF for either this condition or the
-         * superset of cases "Q==1"; we catch the latter later.
-         */
-        if (q && ((rd | rn | rm) & 1)) {
-            return 1;
-        }
-        switch (op) {
-        case NEON_3R_VFM_VQRDMLSH:
-            if (!u) {
-                /* VFM, VFMS */
-                if (size == 1) {
-                    return 1;
-                }
-                break;
-            }
-            /* VQRDMLSH : handled by decodetree */
-            return 1;
-
-        case NEON_3R_VADD_VSUB:
-        case NEON_3R_LOGIC:
-        case NEON_3R_VMAX:
-        case NEON_3R_VMIN:
-        case NEON_3R_VTST_VCEQ:
-        case NEON_3R_VCGT:
-        case NEON_3R_VCGE:
-        case NEON_3R_VQADD:
-        case NEON_3R_VQSUB:
-        case NEON_3R_VMUL:
-        case NEON_3R_VML:
-        case NEON_3R_VSHL:
-        case NEON_3R_SHA:
-        case NEON_3R_VHADD:
-        case NEON_3R_VRHADD:
-        case NEON_3R_VHSUB:
-        case NEON_3R_VABD:
-        case NEON_3R_VABA:
-        case NEON_3R_VQSHL:
-        case NEON_3R_VRSHL:
-        case NEON_3R_VQRSHL:
-        case NEON_3R_VPMAX:
-        case NEON_3R_VPMIN:
-        case NEON_3R_VPADD_VQRDMLAH:
-        case NEON_3R_VQDMULH_VQRDMULH:
-        case NEON_3R_FLOAT_ARITH:
-        case NEON_3R_FLOAT_MULTIPLY:
-        case NEON_3R_FLOAT_CMP:
-        case NEON_3R_FLOAT_ACMP:
-        case NEON_3R_FLOAT_MINMAX:
-        case NEON_3R_FLOAT_MISC:
-            /* Already handled by decodetree */
-            return 1;
-        }
-
-        if (size == 3) {
-            /* 64-bit element instructions: handled by decodetree */
-            return 1;
-        }
-        switch (op) {
-        case NEON_3R_VFM_VQRDMLSH:
-            if (!dc_isar_feature(aa32_simdfmac, s)) {
-                return 1;
-            }
-            break;
-        default:
-            break;
-        }
-
-        for (pass = 0; pass < (q ? 4 : 2); pass++) {
-
-        /* Elementwise.  */
-        tmp = neon_load_reg(rn, pass);
-        tmp2 = neon_load_reg(rm, pass);
-        switch (op) {
-        case NEON_3R_VFM_VQRDMLSH:
-        {
-            /* VFMA, VFMS: fused multiply-add */
-            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-            TCGv_i32 tmp3 = neon_load_reg(rd, pass);
-            if (size) {
-                /* VFMS */
-                gen_helper_vfp_negs(tmp, tmp);
-            }
-            gen_helper_vfp_muladds(tmp, tmp, tmp2, tmp3, fpstatus);
-            tcg_temp_free_i32(tmp3);
-            tcg_temp_free_ptr(fpstatus);
-            break;
-        }
-        default:
-            abort();
-        }
-        tcg_temp_free_i32(tmp2);
-
-        neon_store_reg(rd, pass, tmp);
-
-        } /* for pass */
-        /* End of 3 register same size operations.  */
+        /* Three register same length: handled by decodetree */
+        return 1;
     } else if (insn & (1 << 4)) {
         if ((insn & 0x00380080) != 0) {
             /* Two registers and shift.  */
-- 
2.20.1


