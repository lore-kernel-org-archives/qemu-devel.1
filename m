Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE69DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988FF206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPrYbLma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988FF206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOWR-0007CN-Co
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSi-0001Rs-Db
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:48 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53626)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSf-0003oB-VG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:47 -0400
Received: by mail-wm1-x341.google.com with SMTP id l26so5211992wme.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wni/dGEed62jncJPkUlwCdre2iUdp+Zdjh1wJWP4ySE=;
 b=MPrYbLmaHMpd6035ULPQvtxMNyKuk6f1r70g76Hy6U/6xjDCGxQkChaIQI6bo73X+A
 H4Q1FZ7lo0A8rVbAvqRmEtyeVzmJGd05N6QLsnoPvT80L7cf7fQGxkjocj0Iss6y9gLl
 BbjfndyL9eib2kiKhsS/Nw+snWBy0EOhHggB3s+Zj+Ttic6ZqKDajmv+Dlp6FZqOb1fZ
 Xq2ma77hZkFv/0IPzLxE8PIo7LnOT5/oxAYZLQiqI9d/QZ81rMdD2wifzCXe903ik36Z
 h65N7yuQM1owKTD5sKHFGf/ChppFXfBli+gEd4rhX69+F1W4Ji0fQ9xuPjmgvd/kYgRj
 xXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Wni/dGEed62jncJPkUlwCdre2iUdp+Zdjh1wJWP4ySE=;
 b=j4K/SYCOhIual9Z04IVz5bN6udVCkRGmqJSR46+9oo/Ck+dBIwcid7MI8WF4D57WIi
 5JDX37LGyyxiXLq3ivG+EwXykUOXDKc6lx9V9Bwb+WxseKYbiPs80rOWbDqhpF2w+002
 UFaVnNJYEFrrriIeKNPhcsb3QfMTiIwiq8IYsY+IpGbW82suEa6KiPXMrCtOR7cTdT0y
 phr64P0hLikESDOmb1qLcF5/ewS2K32vu+Pzi2ok8ziMkVgI/ne6DoeA18NLmP30pOpj
 Ghw8Qe2T2q+bFX0DdLi70Ra/R1Bst1uX5TP8o35YxCZgM4sli93t/+/jUGaQaFWHuwMv
 gsIA==
X-Gm-Message-State: AOAM533wGGwgxyhQb5CkHbskOl/byqfijYHvTly+QKj+s3GSgwWXfPHG
 JVJN64udFUrSy9JfQdY3SsLVfqtbpCsaTg==
X-Google-Smtp-Source: ABdhPJw9BAukTY3Cogm7q6BOun0Ffli6cgjev+9klNqpFD0D0B0GxEiKQdh74uWCgcnPY8i7WDfjvQ==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr8410052wma.168.1591886737938; 
 Thu, 11 Jun 2020 07:45:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h18sm5271658wru.7.2020.06.11.07.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:45:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/10] target/arm: Convert Neon 2-reg-scalar float multiplies
 to decodetree
Date: Thu, 11 Jun 2020 15:45:23 +0100
Message-Id: <20200611144529.8873-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200611144529.8873-1-peter.maydell@linaro.org>
References: <20200611144529.8873-1-peter.maydell@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>
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


