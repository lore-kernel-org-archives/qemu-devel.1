Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69753C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAFF2098B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjdJ2bCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAFF2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlF5r-0002yZ-EB
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF4w-00010g-JB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF4u-0007R7-GE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id g10so3581366wmh.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J9rY0KgHARtmNDmyguZ1hMN7+xt6+4WGmPZIRF6AfUg=;
 b=WjdJ2bCcj5bT81TCIz8SHurcRW+FqARvWWycUCTyqoBjNON1nnt2eSV6M0xw9rT3r5
 lNk7H/S2UPnxNCdEBog5quz4+QugHPreOL6j89jQyIUnsxDmKeHUuAtIodsEsjGkVGlq
 tIaq4uReGo96HHFWuJ7TntzmUsNhK4Or2whISRCQVRXTAsxRDoRcoi1Xm2AESFqpAzh1
 PB4gVhkVnEYDvWN7OL1YtkJej1G7VTKSKsdLurEH5JB3CMync2L+/9WkKbxC40A+mwXy
 jZR0AutaVE+9qbeGKhTggZ6fbhijTDdK/Ow8pSVsvDtTIKGuNPIEtJoVBJryDNDHKWEf
 4V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J9rY0KgHARtmNDmyguZ1hMN7+xt6+4WGmPZIRF6AfUg=;
 b=oYpdSb1RxkKsOFwimbP2yUqQ0A/vJ3i1O2AQxPhPLtECZLzIUom/teWZLKR5idYG0Y
 0MN4Ar1TfXOnpD0TMJfgM/2M1O2j70fPLrrY+av5qNzGHvHtcEVKLVicjz6z31haQgjB
 gckeem4L1RKMGOyFn8Fp9mmIxRxYndNsyUmkBMhUO/cjgDKFvDk3mjyMVKxv6dTczKZe
 LCVB1nCsdrunuXYmkEefWtdao7zSTYU16Kg2fspD3F2SpSDEj25nUclijrXZ3MCQ+fH0
 Hwk0LZdvFYgzS46k6siDVwGcwzHUoOtWZyp43A17LDssuDSNC8aR2U6BSPS78uBsLDgU
 sQNQ==
X-Gm-Message-State: AOAM533ga0OO3/BCjFJ6lG/T/otpDXi/JOQCIEVxpKBu3S9vFjaXCs5+
 EgvU7ZYvqxIbPBvJ8L+xkgNPrw==
X-Google-Smtp-Source: ABdhPJx+EPHWyEB0ZT1gQkd0SMwd1znghGpwZNa/olfk4pyd42P1YxXas5BNNgo8hbeGhYnotWTpSg==
X-Received: by 2002:a1c:bb05:: with SMTP id l5mr4103347wmf.141.1592327331031; 
 Tue, 16 Jun 2020 10:08:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:08:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 02/21] target/arm: Convert Neon 2-reg-misc pairwise ops to
 decodetree
Date: Tue, 16 Jun 2020 18:08:25 +0100
Message-Id: <20200616170844.13318-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

Convert the pairwise ops VPADDL and VPADAL in the 2-reg-misc grouping
to decodetree.

At this point we can get rid of the weird CPU_V001 #define that was
used to avoid having to explicitly list all the arguments being
passed to some TCG gen/helper functions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |   6 ++
 target/arm/translate-neon.inc.c | 149 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  35 +-------
 3 files changed, 157 insertions(+), 33 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index e12fdf30957..dd521baa07d 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -441,6 +441,12 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
                  &2misc vm=%vm_dp vd=%vd_dp
 
     VREV64       1111 001 11 . 11 .. 00 .... 0 0000 . . 0 .... @2misc
+
+    VPADDL_S     1111 001 11 . 11 .. 00 .... 0 0100 . . 0 .... @2misc
+    VPADDL_U     1111 001 11 . 11 .. 00 .... 0 0101 . . 0 .... @2misc
+
+    VPADAL_S     1111 001 11 . 11 .. 00 .... 0 1100 . . 0 .... @2misc
+    VPADAL_U     1111 001 11 . 11 .. 00 .... 0 1101 . . 0 .... @2misc
   ]
 
   # Subgroup for size != 0b11
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 90431a5383f..2f7bd0d556f 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3020,3 +3020,152 @@ static bool trans_VREV64(DisasContext *s, arg_VREV64 *a)
     }
     return true;
 }
+
+static bool do_2misc_pairwise(DisasContext *s, arg_2misc *a,
+                              NeonGenWidenFn *widenfn,
+                              NeonGenTwo64OpFn *opfn,
+                              NeonGenTwo64OpFn *accfn)
+{
+    /*
+     * Pairwise long operations: widen both halves of the pair,
+     * combine the pairs with the opfn, and then possibly accumulate
+     * into the destination with the accfn.
+     */
+    int pass;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if ((a->vd | a->vm) & a->q) {
+        return false;
+    }
+
+    if (!widenfn) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    for (pass = 0; pass < a->q + 1; pass++) {
+        TCGv_i32 tmp;
+        TCGv_i64 rm0_64, rm1_64, rd_64;
+
+        rm0_64 = tcg_temp_new_i64();
+        rm1_64 = tcg_temp_new_i64();
+        rd_64 = tcg_temp_new_i64();
+        tmp = neon_load_reg(a->vm, pass * 2);
+        widenfn(rm0_64, tmp);
+        tcg_temp_free_i32(tmp);
+        tmp = neon_load_reg(a->vm, pass * 2 + 1);
+        widenfn(rm1_64, tmp);
+        tcg_temp_free_i32(tmp);
+        opfn(rd_64, rm0_64, rm1_64);
+        tcg_temp_free_i64(rm0_64);
+        tcg_temp_free_i64(rm1_64);
+
+        if (accfn) {
+            TCGv_i64 tmp64 = tcg_temp_new_i64();
+            neon_load_reg64(tmp64, a->vd + pass);
+            accfn(rd_64, tmp64, rd_64);
+            tcg_temp_free_i64(tmp64);
+        }
+        neon_store_reg64(rd_64, a->vd + pass);
+        tcg_temp_free_i64(rd_64);
+    }
+    return true;
+}
+
+static bool trans_VPADDL_S(DisasContext *s, arg_2misc *a)
+{
+    static NeonGenWidenFn * const widenfn[] = {
+        gen_helper_neon_widen_s8,
+        gen_helper_neon_widen_s16,
+        tcg_gen_ext_i32_i64,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const opfn[] = {
+        gen_helper_neon_paddl_u16,
+        gen_helper_neon_paddl_u32,
+        tcg_gen_add_i64,
+        NULL,
+    };
+
+    return do_2misc_pairwise(s, a, widenfn[a->size], opfn[a->size], NULL);
+}
+
+static bool trans_VPADDL_U(DisasContext *s, arg_2misc *a)
+{
+    static NeonGenWidenFn * const widenfn[] = {
+        gen_helper_neon_widen_u8,
+        gen_helper_neon_widen_u16,
+        tcg_gen_extu_i32_i64,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const opfn[] = {
+        gen_helper_neon_paddl_u16,
+        gen_helper_neon_paddl_u32,
+        tcg_gen_add_i64,
+        NULL,
+    };
+
+    return do_2misc_pairwise(s, a, widenfn[a->size], opfn[a->size], NULL);
+}
+
+static bool trans_VPADAL_S(DisasContext *s, arg_2misc *a)
+{
+    static NeonGenWidenFn * const widenfn[] = {
+        gen_helper_neon_widen_s8,
+        gen_helper_neon_widen_s16,
+        tcg_gen_ext_i32_i64,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const opfn[] = {
+        gen_helper_neon_paddl_u16,
+        gen_helper_neon_paddl_u32,
+        tcg_gen_add_i64,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const accfn[] = {
+        gen_helper_neon_addl_u16,
+        gen_helper_neon_addl_u32,
+        tcg_gen_add_i64,
+        NULL,
+    };
+
+    return do_2misc_pairwise(s, a, widenfn[a->size], opfn[a->size],
+                             accfn[a->size]);
+}
+
+static bool trans_VPADAL_U(DisasContext *s, arg_2misc *a)
+{
+    static NeonGenWidenFn * const widenfn[] = {
+        gen_helper_neon_widen_u8,
+        gen_helper_neon_widen_u16,
+        tcg_gen_extu_i32_i64,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const opfn[] = {
+        gen_helper_neon_paddl_u16,
+        gen_helper_neon_paddl_u32,
+        tcg_gen_add_i64,
+        NULL,
+    };
+    static NeonGenTwo64OpFn * const accfn[] = {
+        gen_helper_neon_addl_u16,
+        gen_helper_neon_addl_u32,
+        tcg_gen_add_i64,
+        NULL,
+    };
+
+    return do_2misc_pairwise(s, a, widenfn[a->size], opfn[a->size],
+                             accfn[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5fca38b5fae..4405b034f77 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2934,8 +2934,6 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
     gen_rfe(s, pc, load_cpu_field(spsr));
 }
 
-#define CPU_V001 cpu_V0, cpu_V0, cpu_V1
-
 static int gen_neon_unzip(int rd, int rm, int size, int q)
 {
     TCGv_ptr pd, pm;
@@ -3117,16 +3115,6 @@ static inline void gen_neon_widen(TCGv_i64 dest, TCGv_i32 src, int size, int u)
     tcg_temp_free_i32(src);
 }
 
-static inline void gen_neon_addl(int size)
-{
-    switch (size) {
-    case 0: gen_helper_neon_addl_u16(CPU_V001); break;
-    case 1: gen_helper_neon_addl_u32(CPU_V001); break;
-    case 2: tcg_gen_add_i64(CPU_V001); break;
-    default: abort();
-    }
-}
-
 static void gen_neon_narrow_op(int op, int u, int size,
                                TCGv_i32 dest, TCGv_i64 src)
 {
@@ -5092,29 +5080,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 }
                 switch (op) {
                 case NEON_2RM_VREV64:
-                    /* handled by decodetree */
-                    return 1;
                 case NEON_2RM_VPADDL: case NEON_2RM_VPADDL_U:
                 case NEON_2RM_VPADAL: case NEON_2RM_VPADAL_U:
-                    for (pass = 0; pass < q + 1; pass++) {
-                        tmp = neon_load_reg(rm, pass * 2);
-                        gen_neon_widen(cpu_V0, tmp, size, op & 1);
-                        tmp = neon_load_reg(rm, pass * 2 + 1);
-                        gen_neon_widen(cpu_V1, tmp, size, op & 1);
-                        switch (size) {
-                        case 0: gen_helper_neon_paddl_u16(CPU_V001); break;
-                        case 1: gen_helper_neon_paddl_u32(CPU_V001); break;
-                        case 2: tcg_gen_add_i64(CPU_V001); break;
-                        default: abort();
-                        }
-                        if (op >= NEON_2RM_VPADAL) {
-                            /* Accumulate.  */
-                            neon_load_reg64(cpu_V1, rd + pass);
-                            gen_neon_addl(size);
-                        }
-                        neon_store_reg64(cpu_V0, rd + pass);
-                    }
-                    break;
+                    /* handled by decodetree */
+                    return 1;
                 case NEON_2RM_VTRN:
                     if (size == 2) {
                         int n;
-- 
2.20.1


