Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5716C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C33B20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ch0WxBXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C33B20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8Ur-0005vc-Nb
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LK-0007Ju-PL
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:50859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LI-00042J-NW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id l17so2270265wmj.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=23d4ikKHygUSPjEtYPoGQYCQtYreim892dcDOB8v5FU=;
 b=Ch0WxBXq2SUUX600BrWoLTha5u4CzEegojrD1LGXl5y0brHdNPyb0czP+LScYci6V2
 zuuVNVv5tJvIpsCX8UjiPU1VunkcuMmtSvWOz+1Y3IXRYF7UGdELTWn/hB9TL4gWx+mJ
 PAQJL5tTHG+rWFcfsbeIG6eHoC2qZ/xrcBubzQgyS+tBV4BYuobcTvpnKo18bcbpqawb
 5t85geqcWxydZGfdmuKP8xLt9Ui4+6oi0Lv2imCCgOa5CraUv9dCL1HWWn9TkRVcFNWt
 CnqMIruO+AoLl0MUjlP37UjlcGzrWs1Ih8lqvU2Wu94ApyM+/HxArRbfIlSIk0nNSNlA
 9oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=23d4ikKHygUSPjEtYPoGQYCQtYreim892dcDOB8v5FU=;
 b=D3UknCCB91JhGtBhr/R5IgbwdEPmhdDpxNH75UFQwbdiV3y0tkb5Lt2cgCv9boaZzO
 JJw5CEgqfv0jJ6+UVAizC9+4xpYHgQ/NvN7IRW9kAQATGId+46NZL39nP+wkIKGJFLz0
 dXGaFwnGfcSiGojSSzGXIX7CcgPik4mZHglSPyTtqnGUv22j/uZcNtpMbG7GCA1hF2+J
 okwbt7Jnbz374TWZ0XPh9Z3ZK75L/YOyKm+OtVHW58GaymrIOVp/c47NrXBsnBRU0nC1
 2m+CuunfJu2QU4yDXwEbSlGhM6k9OrtrhZFcbQ9IcvqBAKcLoUk70njOWYQVrhOO+Fo8
 bWmA==
X-Gm-Message-State: AOAM533IEbo4d5TOIYXAwUQxAsWNjH/Ul4gRCZARrO1eiDrn3vqTpY0U
 L+wOiAnIH+OkuH2NxAFwyVbXFqeeoA7hlg==
X-Google-Smtp-Source: ABdhPJwIKYiOMiBOneOF5gV9VvmFknUVQqKZIwsgeFNK8qJClRds1GR/58rggPglmLHzZbrrB8DgPQ==
X-Received: by 2002:a1c:bc0a:: with SMTP id m10mr2278155wmf.173.1592301439001; 
 Tue, 16 Jun 2020 02:57:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/23] target/arm: Convert Neon 2-reg-scalar float multiplies
 to decodetree
Date: Tue, 16 Jun 2020 10:56:50 +0100
Message-Id: <20200616095702.25848-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the float versions of VMLA, VMLS and VMUL in the Neon
2-reg-scalar group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
As noted in the comment on the WRAP_FP_FN macro, we could have
had a do_2scalar_fp() function, but for 3 insns it seemed
simpler to just do the wrapping to get hold of the fpstatus ptr.
(These are the only fp insns in the group.)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  3 ++
 target/arm/translate-neon.inc.c | 65 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 37 ++-----------------
 3 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 983747b785f..cc2ee9641d6 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -478,9 +478,12 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
                  &2scalar vm=%vm_dp vn=%vn_dp vd=%vd_dp
 
     VMLA_2sc     1111 001 . 1 . .. .... .... 0000 . 1 . 0 .... @2scalar
+    VMLA_F_2sc   1111 001 . 1 . .. .... .... 0001 . 1 . 0 .... @2scalar
 
     VMLS_2sc     1111 001 . 1 . .. .... .... 0100 . 1 . 0 .... @2scalar
+    VMLS_F_2sc   1111 001 . 1 . .. .... .... 0101 . 1 . 0 .... @2scalar
 
     VMUL_2sc     1111 001 . 1 . .. .... .... 1000 . 1 . 0 .... @2scalar
+    VMUL_F_2sc   1111 001 . 1 . .. .... .... 1001 . 1 . 0 .... @2scalar
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 478a0dd5c1d..a5c7d60bdac 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2481,3 +2481,68 @@ static bool trans_VMLS_2sc(DisasContext *s, arg_2scalar *a)
 
     return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
 }
+
+/*
+ * Rather than have a float-specific version of do_2scalar just for
+ * three insns, we wrap a NeonGenTwoSingleOpFn to turn it into
+ * a NeonGenTwoOpFn.
+ */
+#define WRAP_FP_FN(WRAPNAME, FUNC)                              \
+    static void WRAPNAME(TCGv_i32 rd, TCGv_i32 rn, TCGv_i32 rm) \
+    {                                                           \
+        TCGv_ptr fpstatus = get_fpstatus_ptr(1);                \
+        FUNC(rd, rn, rm, fpstatus);                             \
+        tcg_temp_free_ptr(fpstatus);                            \
+    }
+
+WRAP_FP_FN(gen_VMUL_F_mul, gen_helper_vfp_muls)
+WRAP_FP_FN(gen_VMUL_F_add, gen_helper_vfp_adds)
+WRAP_FP_FN(gen_VMUL_F_sub, gen_helper_vfp_subs)
+
+static bool trans_VMUL_F_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpFn * const opfn[] = {
+        NULL,
+        NULL, /* TODO: fp16 support */
+        gen_VMUL_F_mul,
+        NULL,
+    };
+
+    return do_2scalar(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VMLA_F_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpFn * const opfn[] = {
+        NULL,
+        NULL, /* TODO: fp16 support */
+        gen_VMUL_F_mul,
+        NULL,
+    };
+    static NeonGenTwoOpFn * const accfn[] = {
+        NULL,
+        NULL, /* TODO: fp16 support */
+        gen_VMUL_F_add,
+        NULL,
+    };
+
+    return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
+}
+
+static bool trans_VMLS_F_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpFn * const opfn[] = {
+        NULL,
+        NULL, /* TODO: fp16 support */
+        gen_VMUL_F_mul,
+        NULL,
+    };
+    static NeonGenTwoOpFn * const accfn[] = {
+        NULL,
+        NULL, /* TODO: fp16 support */
+        gen_VMUL_F_sub,
+        NULL,
+    };
+
+    return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e9cc237ef80..e4a6a38c782 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5187,15 +5187,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case 0: /* Integer VMLA scalar */
                 case 4: /* Integer VMLS scalar */
                 case 8: /* Integer VMUL scalar */
-                    return 1; /* handled by decodetree */
-
                 case 1: /* Float VMLA scalar */
                 case 5: /* Floating point VMLS scalar */
                 case 9: /* Floating point VMUL scalar */
-                    if (size == 1) {
-                        return 1;
-                    }
-                    /* fall through */
+                    return 1; /* handled by decodetree */
+
                 case 12: /* VQDMULH scalar */
                 case 13: /* VQRDMULH scalar */
                     if (u && ((rd | rn) & 1)) {
@@ -5212,41 +5208,14 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             } else {
                                 gen_helper_neon_qdmulh_s32(tmp, cpu_env, tmp, tmp2);
                             }
-                        } else if (op == 13) {
+                        } else {
                             if (size == 1) {
                                 gen_helper_neon_qrdmulh_s16(tmp, cpu_env, tmp, tmp2);
                             } else {
                                 gen_helper_neon_qrdmulh_s32(tmp, cpu_env, tmp, tmp2);
                             }
-                        } else {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            gen_helper_vfp_muls(tmp, tmp, tmp2, fpstatus);
-                            tcg_temp_free_ptr(fpstatus);
                         }
                         tcg_temp_free_i32(tmp2);
-                        if (op < 8) {
-                            /* Accumulate.  */
-                            tmp2 = neon_load_reg(rd, pass);
-                            switch (op) {
-                            case 1:
-                            {
-                                TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                                gen_helper_vfp_adds(tmp, tmp, tmp2, fpstatus);
-                                tcg_temp_free_ptr(fpstatus);
-                                break;
-                            }
-                            case 5:
-                            {
-                                TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                                gen_helper_vfp_subs(tmp, tmp2, tmp, fpstatus);
-                                tcg_temp_free_ptr(fpstatus);
-                                break;
-                            }
-                            default:
-                                abort();
-                            }
-                            tcg_temp_free_i32(tmp2);
-                        }
                         neon_store_reg(rd, pass, tmp);
                     }
                     break;
-- 
2.20.1


