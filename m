Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89161C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5009B2078E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCojA4p/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5009B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8Nv-0003p7-Cu
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LC-00073a-8n
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:14 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LA-000415-D9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:14 -0400
Received: by mail-wr1-x436.google.com with SMTP id j10so20067759wrw.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=guH6/4Zqbrl2/zmFmbwWPQQrG54LzUK6JULINOQ0BgQ=;
 b=bCojA4p/08xlb956NPyHeR4jx75/ZuDmyciy93dmmroKv6tLVpyV1Ea7UGYSjtpCN+
 /H/vDiG84UkKipm/uyw6ITRUflAtvlPmUNRIGy0Q4HGFZq1IjhTime/ti9y+YpgDcI+N
 On8p0Nx9lNWbHFnrYrS36bqh7aMbQi9FI1Cx+p7iwxcL/LidCxnKcfB0Sxd0eq8Mw6uW
 pzIxv7+TX2fpDQQ1a3MEoDjkK2dD+6oAHcCI1nmDhSQxrxrffkEEMQQaTQrp6LoCgvxd
 b6FZlbEBL4/pB193LkpZ7tqq7emfZmdUZtCCIOzWQBamw8Gd17s/8LZp8tmP5eFsPSx8
 Nt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=guH6/4Zqbrl2/zmFmbwWPQQrG54LzUK6JULINOQ0BgQ=;
 b=Ept9a5AlPTfIxi2d2eEkwEmXXDOLI/TKZ+3OLFRbBj0ql0KzMCHUcuqrBzroDAJ4s9
 MDEMs8xzup15trtqrKM6qfQBIDnx7v5GJDU5HiwlRQlFCUQxbinGp/k4tOyrall3elm2
 yzQ283iVMrpOF/2s90tE8xCFvv3SJD3tM6lKx4Oc6k17mV5by6JtclHcWFFi2XBuT0Yr
 ooRL7FzU5d+68cS1qoQOOPx0OdSY4hEm6rw2iWFLMdGNrkSVwOQN3UNgyHB6geJpOH7S
 dC9bx5CA3PvdM7AaaClqx0WyFr9QfO1hk0xCsvHKFW2t8XxH5aSLaNPOhON9blY0t8Ij
 g+Dg==
X-Gm-Message-State: AOAM532xoOjGVD2aipd4hg3oXf4hZjBKSvi9CAHiTa/cjSKRr/fwG4bA
 Sk57UOb/QZ4rFGxev2hzw1DummXFiESO7Q==
X-Google-Smtp-Source: ABdhPJy/OgwKkxnl+WaKWpWdwBbyIwU3PWnD7+ViUogD/WRkWmSTp3VsaMErwf9eszp2h4zyPfGabw==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr2185461wro.108.1592301430477; 
 Tue, 16 Jun 2020 02:57:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/23] target/arm: Convert Neon 3-reg-diff VABAL,
 VABDL to decodetree
Date: Tue, 16 Jun 2020 10:56:43 +0100
Message-Id: <20200616095702.25848-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
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

Convert the Neon 3-reg-diff insns VABAL and VABDL to decodetree.
Like almost all the remaining insns in this group, these are
a combination of a two-input operation which returns a double width
result and then a possible accumulation of that double width
result into the destination.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.h          |   1 +
 target/arm/neon-dp.decode       |   6 ++
 target/arm/translate-neon.inc.c | 132 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  31 +-------
 4 files changed, 142 insertions(+), 28 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index c937dfe9bf0..62ed5c4780c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -371,6 +371,7 @@ typedef void NeonGenTwo64OpEnvFn(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
 typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
 typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
 typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
+typedef void NeonGenTwoOpWidenFn(TCGv_i64, TCGv_i32, TCGv_i32);
 typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index a2234dfa4f3..4f0aaaf6bb2 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -442,7 +442,13 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VADDHN_3d    1111 001 0 1 . .. .... .... 0100 . 0 . 0 .... @3diff
     VRADDHN_3d   1111 001 1 1 . .. .... .... 0100 . 0 . 0 .... @3diff
 
+    VABAL_S_3d   1111 001 0 1 . .. .... .... 0101 . 0 . 0 .... @3diff
+    VABAL_U_3d   1111 001 1 1 . .. .... .... 0101 . 0 . 0 .... @3diff
+
     VSUBHN_3d    1111 001 0 1 . .. .... .... 0110 . 0 . 0 .... @3diff
     VRSUBHN_3d   1111 001 1 1 . .. .... .... 0110 . 0 . 0 .... @3diff
+
+    VABDL_S_3d   1111 001 0 1 . .. .... .... 0111 . 0 . 0 .... @3diff
+    VABDL_U_3d   1111 001 1 1 . .. .... .... 0111 . 0 . 0 .... @3diff
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 0c3965802a5..bea9360ce3f 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2019,3 +2019,135 @@ DO_NARROW_3D(VADDHN, add, narrow, tcg_gen_extrh_i64_i32)
 DO_NARROW_3D(VSUBHN, sub, narrow, tcg_gen_extrh_i64_i32)
 DO_NARROW_3D(VRADDHN, add, narrow_round, gen_narrow_round_high_u32)
 DO_NARROW_3D(VRSUBHN, sub, narrow_round, gen_narrow_round_high_u32)
+
+static bool do_long_3d(DisasContext *s, arg_3diff *a,
+                       NeonGenTwoOpWidenFn *opfn,
+                       NeonGenTwo64OpFn *accfn)
+{
+    /*
+     * 3-regs different lengths, long operations.
+     * These perform an operation on two inputs that returns a double-width
+     * result, and then possibly perform an accumulation operation of
+     * that result into the double-width destination.
+     */
+    TCGv_i64 rd0, rd1, tmp;
+    TCGv_i32 rn, rm;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
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
+        /* size == 3 case, which is an entirely different insn group */
+        return false;
+    }
+
+    if (a->vd & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    rd0 = tcg_temp_new_i64();
+    rd1 = tcg_temp_new_i64();
+
+    rn = neon_load_reg(a->vn, 0);
+    rm = neon_load_reg(a->vm, 0);
+    opfn(rd0, rn, rm);
+    tcg_temp_free_i32(rn);
+    tcg_temp_free_i32(rm);
+
+    rn = neon_load_reg(a->vn, 1);
+    rm = neon_load_reg(a->vm, 1);
+    opfn(rd1, rn, rm);
+    tcg_temp_free_i32(rn);
+    tcg_temp_free_i32(rm);
+
+    /* Don't store results until after all loads: they might overlap */
+    if (accfn) {
+        tmp = tcg_temp_new_i64();
+        neon_load_reg64(tmp, a->vd);
+        accfn(tmp, tmp, rd0);
+        neon_store_reg64(tmp, a->vd);
+        neon_load_reg64(tmp, a->vd + 1);
+        accfn(tmp, tmp, rd1);
+        neon_store_reg64(tmp, a->vd + 1);
+        tcg_temp_free_i64(tmp);
+    } else {
+        neon_store_reg64(rd0, a->vd);
+        neon_store_reg64(rd1, a->vd + 1);
+    }
+
+    tcg_temp_free_i64(rd0);
+    tcg_temp_free_i64(rd1);
+
+    return true;
+}
+
+static bool trans_VABDL_S_3d(DisasContext *s, arg_3diff *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        gen_helper_neon_abdl_s16,
+        gen_helper_neon_abdl_s32,
+        gen_helper_neon_abdl_s64,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VABDL_U_3d(DisasContext *s, arg_3diff *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        gen_helper_neon_abdl_u16,
+        gen_helper_neon_abdl_u32,
+        gen_helper_neon_abdl_u64,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VABAL_S_3d(DisasContext *s, arg_3diff *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        gen_helper_neon_abdl_s16,
+        gen_helper_neon_abdl_s32,
+        gen_helper_neon_abdl_s64,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const addfn[] = {
+        gen_helper_neon_addl_u16,
+        gen_helper_neon_addl_u32,
+        tcg_gen_add_i64,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], addfn[a->size]);
+}
+
+static bool trans_VABAL_U_3d(DisasContext *s, arg_3diff *a)
+{
+    static NeonGenTwoOpWidenFn * const opfn[] = {
+        gen_helper_neon_abdl_u16,
+        gen_helper_neon_abdl_u32,
+        gen_helper_neon_abdl_u64,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const addfn[] = {
+        gen_helper_neon_addl_u16,
+        gen_helper_neon_addl_u32,
+        tcg_gen_add_i64,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], addfn[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3fe39cd4f49..37fe9d46e0b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5243,9 +5243,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {0, 0, 0, 7}, /* VSUBL: handled by decodetree */
                     {0, 0, 0, 7}, /* VSUBW: handled by decodetree */
                     {0, 0, 0, 7}, /* VADDHN: handled by decodetree */
-                    {0, 0, 0, 0}, /* VABAL */
+                    {0, 0, 0, 7}, /* VABAL */
                     {0, 0, 0, 7}, /* VSUBHN: handled by decodetree */
-                    {0, 0, 0, 0}, /* VABDL */
+                    {0, 0, 0, 7}, /* VABDL */
                     {0, 0, 0, 0}, /* VMLAL */
                     {0, 0, 0, 9}, /* VQDMLAL */
                     {0, 0, 0, 0}, /* VMLSL */
@@ -5306,31 +5306,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         tmp2 = neon_load_reg(rm, pass);
                     }
                     switch (op) {
-                    case 5: case 7: /* VABAL, VABDL */
-                        switch ((size << 1) | u) {
-                        case 0:
-                            gen_helper_neon_abdl_s16(cpu_V0, tmp, tmp2);
-                            break;
-                        case 1:
-                            gen_helper_neon_abdl_u16(cpu_V0, tmp, tmp2);
-                            break;
-                        case 2:
-                            gen_helper_neon_abdl_s32(cpu_V0, tmp, tmp2);
-                            break;
-                        case 3:
-                            gen_helper_neon_abdl_u32(cpu_V0, tmp, tmp2);
-                            break;
-                        case 4:
-                            gen_helper_neon_abdl_s64(cpu_V0, tmp, tmp2);
-                            break;
-                        case 5:
-                            gen_helper_neon_abdl_u64(cpu_V0, tmp, tmp2);
-                            break;
-                        default: abort();
-                        }
-                        tcg_temp_free_i32(tmp2);
-                        tcg_temp_free_i32(tmp);
-                        break;
                     case 8: case 9: case 10: case 11: case 12: case 13:
                         /* VMLAL, VQDMLAL, VMLSL, VQDMLSL, VMULL, VQDMULL */
                         gen_neon_mull(cpu_V0, tmp, tmp2, size, u);
@@ -5349,7 +5324,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         case 10: /* VMLSL */
                             gen_neon_negl(cpu_V0, size);
                             /* Fall through */
-                        case 5: case 8: /* VABAL, VMLAL */
+                        case 8: /* VABAL, VMLAL */
                             gen_neon_addl(size);
                             break;
                         case 9: case 11: /* VQDMLAL, VQDMLSL */
-- 
2.20.1


