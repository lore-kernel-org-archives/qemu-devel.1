Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DF8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6E120767
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8cXOBxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6E120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8S1-0000mf-Kw
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LM-0007OK-LQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:40890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LK-00042V-So
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id r15so2396266wmh.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DV70SUScUdqPzNymMy3qLlGOl369ajSjrjm6ELQSjHE=;
 b=E8cXOBxVHTBG6UPo9i30bXwYy3frdLKmhfl1xGrQ+X9xL8qpvifbZFnepR6NEkw+qq
 ItBlwnnv4hP4ZYGVyim96kAyJeIgLdyRF9ZgkBKSpsb2a2nnsLyABUr1tJVVCfO05Xup
 /et/2TEyZ+Eg+xjiUuqQQpxMUHGBVNUc6EM2ELdgR1jIQUj08tj++9gx1lCLiEoP+mCe
 untHuNCGUqritWTe+pc/eVd8ZWOOvKkrEwZC97a/Srmz3NyJydJYTmKKirM49dIuUqGG
 72T7kcCVrA/H1G4vttetyzIxya4oY8RF0fR9+x2nBitukxPp1xPTp8NuhgDH66FrGHUJ
 QZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DV70SUScUdqPzNymMy3qLlGOl369ajSjrjm6ELQSjHE=;
 b=U+qzbYf/YK6hKWxP/q7nb2ReUWR7cU0GxfkkLgQLgPs68fHnqHk6+vUw0PENVUcoyw
 nTZ3JEnib5End21RX3mexZa/cgqLR8o8xUYGzMIF/Q8Hgs/xPTMn2ObAzw6ojqSpxdcJ
 1STyT8kWyXaHYUHR8wHfA0Mvq9oa6guzOWU7r/GvFtgGHEtoufvGKMKWMsYFyBEuVUwQ
 h1phJ0Re/6KBSwikWZxI89UlYEjsd9njQxCiKQqpjhM0Co6h0SsQ3bG3HWbo4oWYK2Vh
 WTAFXWESROIAPczLuEEoxyp7ozknuUBgMDvrg+s+GUae96/c0kNLk6JG/z4MgiIfZbF9
 NBzQ==
X-Gm-Message-State: AOAM533zeQlcouBy+ALeGqyrxLZcLe73vo8eYsRCALw6yAH63xhJn2Qr
 iLnacL7ToSrAEqLMKfqbvvWT2DmHaxogUg==
X-Google-Smtp-Source: ABdhPJz5ryqBh9eNTlzH4vLj5AMGufE/OBlPpTd3g3OM6Xo5mDqFcU0VZkxbZVpKjqPuKcxHqXSEbg==
X-Received: by 2002:a1c:9c8c:: with SMTP id f134mr2302991wme.142.1592301441195; 
 Tue, 16 Jun 2020 02:57:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/23] target/arm: Convert Neon 2-reg-scalar VQRDMLAH,
 VQRDMLSH to decodetree
Date: Tue, 16 Jun 2020 10:56:52 +0100
Message-Id: <20200616095702.25848-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Convert the VQRDMLAH and VQRDMLSH insns in the 2-reg-scalar
group to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 6301016d5cf..59a075f154d 100644
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
+        return false;
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


