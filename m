Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E60C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF5120767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hYuTThoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF5120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8PQ-0005es-0U
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LL-0007Lu-Ks
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LJ-00042O-Qx
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id r9so2256970wmh.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sZUWr7cFc5vA75i1UGQGc4QT3z+7eSHFyv5+i5pQSDA=;
 b=hYuTThojagqkzl1nahWtplua0sNrpfzEL3onOEk2s/MiwJs98VFdLqzZK0zAWvwl+b
 TdrmBf2iv5Z01ml6PU0izSR1tFN359SvGJ+zYuBIunqqCz98pqwmvIYP/iB0Q8KczHos
 DUQzxhf0J4R54CMQF1iDPtJixGGQKcNS76SQdmg86tL3KSk9rgeykIQtb2HykDUQ4kwF
 4o6kbkBRyQiCb0TaQaTN7eBF6hCHpRkzVb8LhUrGkXjcTpVFXdcaCAXIYp+PSMtOjTZT
 i4waqvrFvL7UB//JwjN3+Gu1cFxqDw7fj5AvwMb2FsOpZa7GhagMAD83v0jwGg2eUiXV
 Hfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sZUWr7cFc5vA75i1UGQGc4QT3z+7eSHFyv5+i5pQSDA=;
 b=gzG4+LqXYPBafO9rZlob4rrIM1U0+EDFCXU3VKCARssVPfsaWG6h1z3LckE3421Ws+
 TieQM5nPrDKA42WdfKAQ7D/31weI+aikhzudEjH/H0y9j6/MxMjER6T9ANPDNjjv6lIR
 pYULZ0zE1glU61J2dd7bSBQLZHgSRHwelKe/Z9vdIS3kxuXXNjW1ZlsZgBZ2GREC5NTC
 2JtkVpgGzb98YzbDc6iS19FJw8wY59ffhe6y5vAKvPIhoTBOb144fN9hmSZousx/7VhO
 +7t5Ry+/RBDxgzQK69I3IsNXV/Wet6qwin1HYD9bRPF2Dd8PHeDcEQ6ax+NL9KZCUMM2
 fY9A==
X-Gm-Message-State: AOAM532grKFZJZDlZIrkUAlfql0LMVBD2/3a3b3Z+U4VaH2Fc9xDAuMA
 BmO1Q8cPQtTKAlXP4hZzDxgWvd+SNEvqPg==
X-Google-Smtp-Source: ABdhPJxZqKMtGHCUIrz+kQn70fYykeoxyjJhkFNoU4yOx6qGyrO8K+h/J3PfFwKqzNxOt7NmdthjRQ==
X-Received: by 2002:a1c:2cd7:: with SMTP id s206mr2262099wms.109.1592301440068; 
 Tue, 16 Jun 2020 02:57:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/23] target/arm: Convert Neon 2-reg-scalar VQDMULH,
 VQRDMULH to decodetree
Date: Tue, 16 Jun 2020 10:56:51 +0100
Message-Id: <20200616095702.25848-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Convert the VQDMULH and VQRDMULH insns in the 2-reg-scalar group
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/neon-dp.decode       |  3 +++
 target/arm/translate-neon.inc.c | 29 +++++++++++++++++++++++
 target/arm/translate.c          | 42 ++-------------------------------
 3 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index cc2ee9641d6..105cf2b2db3 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -485,5 +485,8 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VMUL_2sc     1111 001 . 1 . .. .... .... 1000 . 1 . 0 .... @2scalar
     VMUL_F_2sc   1111 001 . 1 . .. .... .... 1001 . 1 . 0 .... @2scalar
+
+    VQDMULH_2sc  1111 001 . 1 . .. .... .... 1100 . 1 . 0 .... @2scalar
+    VQRDMULH_2sc 1111 001 . 1 . .. .... .... 1101 . 1 . 0 .... @2scalar
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index a5c7d60bdac..6301016d5cf 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2546,3 +2546,32 @@ static bool trans_VMLS_F_2sc(DisasContext *s, arg_2scalar *a)
 
     return do_2scalar(s, a, opfn[a->size], accfn[a->size]);
 }
+
+WRAP_ENV_FN(gen_VQDMULH_16, gen_helper_neon_qdmulh_s16)
+WRAP_ENV_FN(gen_VQDMULH_32, gen_helper_neon_qdmulh_s32)
+WRAP_ENV_FN(gen_VQRDMULH_16, gen_helper_neon_qrdmulh_s16)
+WRAP_ENV_FN(gen_VQRDMULH_32, gen_helper_neon_qrdmulh_s32)
+
+static bool trans_VQDMULH_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpFn * const opfn[] = {
+        NULL,
+        gen_VQDMULH_16,
+        gen_VQDMULH_32,
+        NULL,
+    };
+
+    return do_2scalar(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VQRDMULH_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenTwoOpFn * const opfn[] = {
+        NULL,
+        gen_VQRDMULH_16,
+        gen_VQRDMULH_32,
+        NULL,
+    };
+
+    return do_2scalar(s, a, opfn[a->size], NULL);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e4a6a38c782..5d0e00f92e0 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2973,19 +2973,6 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
 
 #define CPU_V001 cpu_V0, cpu_V0, cpu_V1
 
-static TCGv_i32 neon_load_scratch(int scratch)
-{
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_ld_i32(tmp, cpu_env, offsetof(CPUARMState, vfp.scratch[scratch]));
-    return tmp;
-}
-
-static void neon_store_scratch(int scratch, TCGv_i32 var)
-{
-    tcg_gen_st_i32(var, cpu_env, offsetof(CPUARMState, vfp.scratch[scratch]));
-    tcg_temp_free_i32(var);
-}
-
 static int gen_neon_unzip(int rd, int rm, int size, int q)
 {
     TCGv_ptr pd, pm;
@@ -5190,35 +5177,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case 1: /* Float VMLA scalar */
                 case 5: /* Floating point VMLS scalar */
                 case 9: /* Floating point VMUL scalar */
-                    return 1; /* handled by decodetree */
-
                 case 12: /* VQDMULH scalar */
                 case 13: /* VQRDMULH scalar */
-                    if (u && ((rd | rn) & 1)) {
-                        return 1;
-                    }
-                    tmp = neon_get_scalar(size, rm);
-                    neon_store_scratch(0, tmp);
-                    for (pass = 0; pass < (u ? 4 : 2); pass++) {
-                        tmp = neon_load_scratch(0);
-                        tmp2 = neon_load_reg(rn, pass);
-                        if (op == 12) {
-                            if (size == 1) {
-                                gen_helper_neon_qdmulh_s16(tmp, cpu_env, tmp, tmp2);
-                            } else {
-                                gen_helper_neon_qdmulh_s32(tmp, cpu_env, tmp, tmp2);
-                            }
-                        } else {
-                            if (size == 1) {
-                                gen_helper_neon_qrdmulh_s16(tmp, cpu_env, tmp, tmp2);
-                            } else {
-                                gen_helper_neon_qrdmulh_s32(tmp, cpu_env, tmp, tmp2);
-                            }
-                        }
-                        tcg_temp_free_i32(tmp2);
-                        neon_store_reg(rd, pass, tmp);
-                    }
-                    break;
+                    return 1; /* handled by decodetree */
+
                 case 3: /* VQDMLAL scalar */
                 case 7: /* VQDMLSL scalar */
                 case 11: /* VQDMULL scalar */
-- 
2.20.1


