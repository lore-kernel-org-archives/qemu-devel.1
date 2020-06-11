Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D67C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F85F2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKbVUUSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F85F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOXI-00082s-Eb
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSl-0001Uc-QH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34111)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOSk-0003rZ-1x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:45:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id u26so7115528wmn.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ha29nD9STSEXti9LVVGKrzWg/TQORlHiDcjPJW4gwWc=;
 b=SKbVUUSLxltVE1kVP5JQZdR+xZp/xWRCGF+fI7AM9scIoy4Hs7zxBIDk9KC4uHxb9t
 U8RLImzXrj2uU0263XbTMjYXI55154XeLxnaU5R4ZIfTIUcv+pRswF+BbU1zhYhNSyD+
 Bs28jsd2cl0dLbKm0kHGV5TdSjRF8ut4BlWbvW3+uNkMQLd6fmzQ9PzBpcB4r4xIhtMZ
 XR8/g3W3k6hJVsYfcUzTq2goeRcQ70utI1BqSfcBSUmE9GAOB467SoGL8gqZcSSVefYE
 3eGYD4iXYUg3TyA3c38QHavoid83JDoP4EMsefB5f6AJ9xlgr8HwJpxVmrAVwV1fFXGh
 Ns+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ha29nD9STSEXti9LVVGKrzWg/TQORlHiDcjPJW4gwWc=;
 b=GloLe1mhVE2EQ/uvM0AlYAqDNV+I4aLqx+ZLuEFxOdCZjra8dV1bGY+aeKr4hdHwb/
 dHS/MmFmGERQCqDmls21oQI13koy7MEhs9KbxBVIIPW6o9HFPuwfLw+GOAmq7fK8SM3H
 7Hw7B4t2sjQxx7mS7gVJQRpP4+E7MInwj363AgqK02RXcuYGGschlIneBzbvZ/VkO35M
 2ajMR2DLgVpKi3vYfSyPR6hdvVaSpHkY1ksoMGnfR+3fvZXooW8Ghe1fjEg4Q+KVCN9Y
 POJRq84HbCtpMPwH1JL+WMS2+rotjTmJhdOtVmil4ibYd5+JyU6Yna4UNYb41cw2rg4L
 3aug==
X-Gm-Message-State: AOAM531He60Ozu+xKBN8KAENbgk2m2qJ0XcbQBXRIlGzhnY3MFJdDrva
 yUWG0HPegbZqIHPgN67ZQPwlXTiGC8L6vw==
X-Google-Smtp-Source: ABdhPJyVPilwIt05LmUsaTENst1gE+CSYoZa07lURwGrUcmKcz2RO4R799TnAbt8lzRE/YvRlF1ysg==
X-Received: by 2002:a7b:c1d4:: with SMTP id a20mr8254325wmj.153.1591886740327; 
 Thu, 11 Jun 2020 07:45:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id h18sm5271658wru.7.2020.06.11.07.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 07:45:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/10] target/arm: Convert Neon 2-reg-scalar VQRDMLAH,
 VQRDMLSH to decodetree
Date: Thu, 11 Jun 2020 15:45:25 +0100
Message-Id: <20200611144529.8873-7-peter.maydell@linaro.org>
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

Convert the VQRDMLAH and VQRDMLSH insns in the 2-reg-scalar
group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  3 ++
 target/arm/translate-neon.inc.c | 74 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 38 +----------------
 3 files changed, 79 insertions(+), 36 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 105cf2b2db3..7b069abe628 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -488,5 +488,8 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VQDMULH_2sc  1111 001 . 1 . .. .... .... 1100 . 1 . 0 .... @2scalar
     VQRDMULH_2sc 1111 001 . 1 . .. .... .... 1101 . 1 . 0 .... @2scalar
+
+    VQRDMLAH_2sc 1111 001 . 1 . .. .... .... 1110 . 1 . 0 .... @2scalar
+    VQRDMLSH_2sc 1111 001 . 1 . .. .... .... 1111 . 1 . 0 .... @2scalar
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 6301016d5cf..19344ac331d 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2575,3 +2575,77 @@ static bool trans_VQRDMULH_2sc(DisasContext *s, arg_2scalar *a)
 
     return do_2scalar(s, a, opfn[a->size], NULL);
 }
+
+static bool do_vqrdmlah_2sc(DisasContext *s, arg_2scalar *a,
+                            NeonGenThreeOpEnvFn *opfn)
+{
+    /*
+     * VQRDMLAH/VQRDMLSH: this is like do_2scalar, but the opfn
+     * performs a kind of fused op-then-accumulate using a helper
+     * function that takes all of rd, rn and the scalar at once.
+     */
+    TCGv_i32 scalar;
+    int pass;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    if (!dc_isar_feature(aa32_rdm, s)) {
+        return 1;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!opfn) {
+        /* Bad size (including size == 3, which is a different insn group) */
+        return false;
+    }
+
+    if (a->q && ((a->vd | a->vn) & 1)) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    scalar = neon_get_scalar(a->size, a->vm);
+
+    for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+        TCGv_i32 rn = neon_load_reg(a->vn, pass);
+        TCGv_i32 rd = neon_load_reg(a->vd, pass);
+        opfn(rd, cpu_env, rn, scalar, rd);
+        tcg_temp_free_i32(rn);
+        neon_store_reg(a->vd, pass, rd);
+    }
+    tcg_temp_free_i32(scalar);
+
+    return true;
+}
+
+static bool trans_VQRDMLAH_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenThreeOpEnvFn *opfn[] = {
+        NULL,
+        gen_helper_neon_qrdmlah_s16,
+        gen_helper_neon_qrdmlah_s32,
+        NULL,
+    };
+    return do_vqrdmlah_2sc(s, a, opfn[a->size]);
+}
+
+static bool trans_VQRDMLSH_2sc(DisasContext *s, arg_2scalar *a)
+{
+    static NeonGenThreeOpEnvFn *opfn[] = {
+        NULL,
+        gen_helper_neon_qrdmlsh_s16,
+        gen_helper_neon_qrdmlsh_s32,
+        NULL,
+    };
+    return do_vqrdmlah_2sc(s, a, opfn[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5d0e00f92e0..f0db029f66d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5179,6 +5179,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case 9: /* Floating point VMUL scalar */
                 case 12: /* VQDMULH scalar */
                 case 13: /* VQRDMULH scalar */
+                case 14: /* VQRDMLAH scalar */
+                case 15: /* VQRDMLSH scalar */
                     return 1; /* handled by decodetree */
 
                 case 3: /* VQDMLAL scalar */
@@ -5238,42 +5240,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         neon_store_reg64(cpu_V0, rd + pass);
                     }
                     break;
-                case 14: /* VQRDMLAH scalar */
-                case 15: /* VQRDMLSH scalar */
-                    {
-                        NeonGenThreeOpEnvFn *fn;
-
-                        if (!dc_isar_feature(aa32_rdm, s)) {
-                            return 1;
-                        }
-                        if (u && ((rd | rn) & 1)) {
-                            return 1;
-                        }
-                        if (op == 14) {
-                            if (size == 1) {
-                                fn = gen_helper_neon_qrdmlah_s16;
-                            } else {
-                                fn = gen_helper_neon_qrdmlah_s32;
-                            }
-                        } else {
-                            if (size == 1) {
-                                fn = gen_helper_neon_qrdmlsh_s16;
-                            } else {
-                                fn = gen_helper_neon_qrdmlsh_s32;
-                            }
-                        }
-
-                        tmp2 = neon_get_scalar(size, rm);
-                        for (pass = 0; pass < (u ? 4 : 2); pass++) {
-                            tmp = neon_load_reg(rn, pass);
-                            tmp3 = neon_load_reg(rd, pass);
-                            fn(tmp, cpu_env, tmp, tmp2, tmp3);
-                            tcg_temp_free_i32(tmp3);
-                            neon_store_reg(rd, pass, tmp);
-                        }
-                        tcg_temp_free_i32(tmp2);
-                    }
-                    break;
                 default:
                     g_assert_not_reached();
                 }
-- 
2.20.1


