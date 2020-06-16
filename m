Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42F4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8540C20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptU2PNYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8540C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFLf-0001KK-Q3
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF5J-0001xl-FV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF5G-0007ZO-VM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:09:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id t18so21579876wru.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L7g+XpEeGGZVzbSRirQO8Y0StVZDY7uk47N2neXf45k=;
 b=ptU2PNYT/OX/+6S9F40danTTy2TLZjI2LdDlMau/c8tIi+DWFq2pkYCHSepuFzkVgR
 qgivSzVZJraxOkEIRdAvW7vnxnFA/htqfUVdez5I7v6VkLFXWNFMG1ZATpxgCp232JUq
 cV7XAaGlkTKZZgMz7nMxQ3xshpG3F9yO2zp/Opv+V6HQg6hwK9WukAC5oUvu3iWOTfBU
 MuNnd6cLKHMdegeJX0M7+VG5ZyxMvitWs8p37/m6h/qX+qyA0UCxvl+5sJg4Y3cteSqI
 FcbD06aG286IybqIX8hg+qznhaV6A0VFuzA2dDSwQdKOlBYOSU0BNHEHINC4ZwaiORde
 LwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L7g+XpEeGGZVzbSRirQO8Y0StVZDY7uk47N2neXf45k=;
 b=ha3rNXqyFwD7bG7wgZw5dJYrp1iV/3hKp1Ci+KNYEXTONo50+1NShTBjeruf4Sk5An
 VbdPDDr/FtZG6J+9Y6ejmEluo91ewZQZXDL46YEhEFqDdVVDm1M8ymZjW0t2Q+MLjx9e
 iBztZuYLYdNEHGGJalcPlnJ/zujTRqqTPLuU07A3H31os94H45qZ7pUWi5w7nPx6FQkG
 0+SWG2IB6XCzUmLwbiKQyzKYqB4nt+KAj36eRKZYl38EdMZ9YWt9JqgR7lPRqf3ke3d3
 MnROSFOTyp+yTyLvJFphStvDHfGRQL/H8TzSAg0PxjzZDIBE9bywPgb3ovtPrc1rrWA+
 JAHA==
X-Gm-Message-State: AOAM5331aTncwZ3fHkhQEd+O4AIUj9AmDEvwcP9+F4/LcwykFZoy9bG5
 N4lCoE3wTSD5GXwrIzLZqeOvbw==
X-Google-Smtp-Source: ABdhPJz6QLJ4+jc3EGOt/QxNQICgqAvo5ZthjEuT+SxGw2gj6hVFKkPwO5twL0q0tFijn3LXjc2L+g==
X-Received: by 2002:adf:ab09:: with SMTP id q9mr3983049wrc.79.1592327353281;
 Tue, 16 Jun 2020 10:09:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:09:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 20/21] target/arm: Convert Neon VTRN to decodetree
Date: Tue, 16 Jun 2020 18:08:43 +0100
Message-Id: <20200616170844.13318-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616170844.13318-1-peter.maydell@linaro.org>
References: <20200616170844.13318-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

Convert the Neon VTRN insn to decodetree. This is the last insn in the
Neon data-processing group, so we can remove all the now-unused old
decoder framework.

It's possible that there's a more efficient implementation of
VTRN, but for this conversion we just copy the existing approach.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |   2 +-
 target/arm/translate-neon.inc.c |  90 ++++++++
 target/arm/translate.c          | 363 +-------------------------------
 3 files changed, 93 insertions(+), 362 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 2f64841de52..686f9fbf46a 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -489,7 +489,7 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VNEG_F       1111 001 11 . 11 .. 01 .... 0 1111 . . 0 .... @2misc
 
     VSWP         1111 001 11 . 11 .. 10 .... 0 0000 . . 0 .... @2misc
-
+    VTRN         1111 001 11 . 11 .. 10 .... 0 0001 . . 0 .... @2misc
     VUZP         1111 001 11 . 11 .. 10 .... 0 0010 . . 0 .... @2misc
     VZIP         1111 001 11 . 11 .. 10 .... 0 0011 . . 0 .... @2misc
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 01da7fad462..8cc7f5db544 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3968,3 +3968,93 @@ static bool trans_VSWP(DisasContext *s, arg_2misc *a)
 
     return true;
 }
+static void gen_neon_trn_u8(TCGv_i32 t0, TCGv_i32 t1)
+{
+    TCGv_i32 rd, tmp;
+
+    rd = tcg_temp_new_i32();
+    tmp = tcg_temp_new_i32();
+
+    tcg_gen_shli_i32(rd, t0, 8);
+    tcg_gen_andi_i32(rd, rd, 0xff00ff00);
+    tcg_gen_andi_i32(tmp, t1, 0x00ff00ff);
+    tcg_gen_or_i32(rd, rd, tmp);
+
+    tcg_gen_shri_i32(t1, t1, 8);
+    tcg_gen_andi_i32(t1, t1, 0x00ff00ff);
+    tcg_gen_andi_i32(tmp, t0, 0xff00ff00);
+    tcg_gen_or_i32(t1, t1, tmp);
+    tcg_gen_mov_i32(t0, rd);
+
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(rd);
+}
+
+static void gen_neon_trn_u16(TCGv_i32 t0, TCGv_i32 t1)
+{
+    TCGv_i32 rd, tmp;
+
+    rd = tcg_temp_new_i32();
+    tmp = tcg_temp_new_i32();
+
+    tcg_gen_shli_i32(rd, t0, 16);
+    tcg_gen_andi_i32(tmp, t1, 0xffff);
+    tcg_gen_or_i32(rd, rd, tmp);
+    tcg_gen_shri_i32(t1, t1, 16);
+    tcg_gen_andi_i32(tmp, t0, 0xffff0000);
+    tcg_gen_or_i32(t1, t1, tmp);
+    tcg_gen_mov_i32(t0, rd);
+
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(rd);
+}
+
+static bool trans_VTRN(DisasContext *s, arg_2misc *a)
+{
+    TCGv_i32 tmp, tmp2;
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
+    if (a->size == 3) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    if (a->size == 2) {
+        for (pass = 0; pass < (a->q ? 4 : 2); pass += 2) {
+            tmp = neon_load_reg(a->vm, pass);
+            tmp2 = neon_load_reg(a->vd, pass + 1);
+            neon_store_reg(a->vm, pass, tmp2);
+            neon_store_reg(a->vd, pass + 1, tmp);
+        }
+    } else {
+        for (pass = 0; pass < (a->q ? 4 : 2); pass++) {
+            tmp = neon_load_reg(a->vm, pass);
+            tmp2 = neon_load_reg(a->vd, pass);
+            if (a->size == 0) {
+                gen_neon_trn_u8(tmp, tmp2);
+            } else {
+                gen_neon_trn_u16(tmp, tmp2);
+            }
+            neon_store_reg(a->vm, pass, tmp2);
+            neon_store_reg(a->vd, pass, tmp);
+        }
+    }
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e8cd4a9c61f..581b0b5cde4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2934,183 +2934,6 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
     gen_rfe(s, pc, load_cpu_field(spsr));
 }
 
-static void gen_neon_trn_u8(TCGv_i32 t0, TCGv_i32 t1)
-{
-    TCGv_i32 rd, tmp;
-
-    rd = tcg_temp_new_i32();
-    tmp = tcg_temp_new_i32();
-
-    tcg_gen_shli_i32(rd, t0, 8);
-    tcg_gen_andi_i32(rd, rd, 0xff00ff00);
-    tcg_gen_andi_i32(tmp, t1, 0x00ff00ff);
-    tcg_gen_or_i32(rd, rd, tmp);
-
-    tcg_gen_shri_i32(t1, t1, 8);
-    tcg_gen_andi_i32(t1, t1, 0x00ff00ff);
-    tcg_gen_andi_i32(tmp, t0, 0xff00ff00);
-    tcg_gen_or_i32(t1, t1, tmp);
-    tcg_gen_mov_i32(t0, rd);
-
-    tcg_temp_free_i32(tmp);
-    tcg_temp_free_i32(rd);
-}
-
-static void gen_neon_trn_u16(TCGv_i32 t0, TCGv_i32 t1)
-{
-    TCGv_i32 rd, tmp;
-
-    rd = tcg_temp_new_i32();
-    tmp = tcg_temp_new_i32();
-
-    tcg_gen_shli_i32(rd, t0, 16);
-    tcg_gen_andi_i32(tmp, t1, 0xffff);
-    tcg_gen_or_i32(rd, rd, tmp);
-    tcg_gen_shri_i32(t1, t1, 16);
-    tcg_gen_andi_i32(tmp, t0, 0xffff0000);
-    tcg_gen_or_i32(t1, t1, tmp);
-    tcg_gen_mov_i32(t0, rd);
-
-    tcg_temp_free_i32(tmp);
-    tcg_temp_free_i32(rd);
-}
-
-/* Symbolic constants for op fields for Neon 2-register miscellaneous.
- * The values correspond to bits [17:16,10:7]; see the ARM ARM DDI0406B
- * table A7-13.
- */
-#define NEON_2RM_VREV64 0
-#define NEON_2RM_VREV32 1
-#define NEON_2RM_VREV16 2
-#define NEON_2RM_VPADDL 4
-#define NEON_2RM_VPADDL_U 5
-#define NEON_2RM_AESE 6 /* Includes AESD */
-#define NEON_2RM_AESMC 7 /* Includes AESIMC */
-#define NEON_2RM_VCLS 8
-#define NEON_2RM_VCLZ 9
-#define NEON_2RM_VCNT 10
-#define NEON_2RM_VMVN 11
-#define NEON_2RM_VPADAL 12
-#define NEON_2RM_VPADAL_U 13
-#define NEON_2RM_VQABS 14
-#define NEON_2RM_VQNEG 15
-#define NEON_2RM_VCGT0 16
-#define NEON_2RM_VCGE0 17
-#define NEON_2RM_VCEQ0 18
-#define NEON_2RM_VCLE0 19
-#define NEON_2RM_VCLT0 20
-#define NEON_2RM_SHA1H 21
-#define NEON_2RM_VABS 22
-#define NEON_2RM_VNEG 23
-#define NEON_2RM_VCGT0_F 24
-#define NEON_2RM_VCGE0_F 25
-#define NEON_2RM_VCEQ0_F 26
-#define NEON_2RM_VCLE0_F 27
-#define NEON_2RM_VCLT0_F 28
-#define NEON_2RM_VABS_F 30
-#define NEON_2RM_VNEG_F 31
-#define NEON_2RM_VSWP 32
-#define NEON_2RM_VTRN 33
-#define NEON_2RM_VUZP 34
-#define NEON_2RM_VZIP 35
-#define NEON_2RM_VMOVN 36 /* Includes VQMOVN, VQMOVUN */
-#define NEON_2RM_VQMOVN 37 /* Includes VQMOVUN */
-#define NEON_2RM_VSHLL 38
-#define NEON_2RM_SHA1SU1 39 /* Includes SHA256SU0 */
-#define NEON_2RM_VRINTN 40
-#define NEON_2RM_VRINTX 41
-#define NEON_2RM_VRINTA 42
-#define NEON_2RM_VRINTZ 43
-#define NEON_2RM_VCVT_F16_F32 44
-#define NEON_2RM_VRINTM 45
-#define NEON_2RM_VCVT_F32_F16 46
-#define NEON_2RM_VRINTP 47
-#define NEON_2RM_VCVTAU 48
-#define NEON_2RM_VCVTAS 49
-#define NEON_2RM_VCVTNU 50
-#define NEON_2RM_VCVTNS 51
-#define NEON_2RM_VCVTPU 52
-#define NEON_2RM_VCVTPS 53
-#define NEON_2RM_VCVTMU 54
-#define NEON_2RM_VCVTMS 55
-#define NEON_2RM_VRECPE 56
-#define NEON_2RM_VRSQRTE 57
-#define NEON_2RM_VRECPE_F 58
-#define NEON_2RM_VRSQRTE_F 59
-#define NEON_2RM_VCVT_FS 60
-#define NEON_2RM_VCVT_FU 61
-#define NEON_2RM_VCVT_SF 62
-#define NEON_2RM_VCVT_UF 63
-
-/* Each entry in this array has bit n set if the insn allows
- * size value n (otherwise it will UNDEF). Since unallocated
- * op values will have no bits set they always UNDEF.
- */
-static const uint8_t neon_2rm_sizes[] = {
-    [NEON_2RM_VREV64] = 0x7,
-    [NEON_2RM_VREV32] = 0x3,
-    [NEON_2RM_VREV16] = 0x1,
-    [NEON_2RM_VPADDL] = 0x7,
-    [NEON_2RM_VPADDL_U] = 0x7,
-    [NEON_2RM_AESE] = 0x1,
-    [NEON_2RM_AESMC] = 0x1,
-    [NEON_2RM_VCLS] = 0x7,
-    [NEON_2RM_VCLZ] = 0x7,
-    [NEON_2RM_VCNT] = 0x1,
-    [NEON_2RM_VMVN] = 0x1,
-    [NEON_2RM_VPADAL] = 0x7,
-    [NEON_2RM_VPADAL_U] = 0x7,
-    [NEON_2RM_VQABS] = 0x7,
-    [NEON_2RM_VQNEG] = 0x7,
-    [NEON_2RM_VCGT0] = 0x7,
-    [NEON_2RM_VCGE0] = 0x7,
-    [NEON_2RM_VCEQ0] = 0x7,
-    [NEON_2RM_VCLE0] = 0x7,
-    [NEON_2RM_VCLT0] = 0x7,
-    [NEON_2RM_SHA1H] = 0x4,
-    [NEON_2RM_VABS] = 0x7,
-    [NEON_2RM_VNEG] = 0x7,
-    [NEON_2RM_VCGT0_F] = 0x4,
-    [NEON_2RM_VCGE0_F] = 0x4,
-    [NEON_2RM_VCEQ0_F] = 0x4,
-    [NEON_2RM_VCLE0_F] = 0x4,
-    [NEON_2RM_VCLT0_F] = 0x4,
-    [NEON_2RM_VABS_F] = 0x4,
-    [NEON_2RM_VNEG_F] = 0x4,
-    [NEON_2RM_VSWP] = 0x1,
-    [NEON_2RM_VTRN] = 0x7,
-    [NEON_2RM_VUZP] = 0x7,
-    [NEON_2RM_VZIP] = 0x7,
-    [NEON_2RM_VMOVN] = 0x7,
-    [NEON_2RM_VQMOVN] = 0x7,
-    [NEON_2RM_VSHLL] = 0x7,
-    [NEON_2RM_SHA1SU1] = 0x4,
-    [NEON_2RM_VRINTN] = 0x4,
-    [NEON_2RM_VRINTX] = 0x4,
-    [NEON_2RM_VRINTA] = 0x4,
-    [NEON_2RM_VRINTZ] = 0x4,
-    [NEON_2RM_VCVT_F16_F32] = 0x2,
-    [NEON_2RM_VRINTM] = 0x4,
-    [NEON_2RM_VCVT_F32_F16] = 0x2,
-    [NEON_2RM_VRINTP] = 0x4,
-    [NEON_2RM_VCVTAU] = 0x4,
-    [NEON_2RM_VCVTAS] = 0x4,
-    [NEON_2RM_VCVTNU] = 0x4,
-    [NEON_2RM_VCVTNS] = 0x4,
-    [NEON_2RM_VCVTPU] = 0x4,
-    [NEON_2RM_VCVTPS] = 0x4,
-    [NEON_2RM_VCVTMU] = 0x4,
-    [NEON_2RM_VCVTMS] = 0x4,
-    [NEON_2RM_VRECPE] = 0x4,
-    [NEON_2RM_VRSQRTE] = 0x4,
-    [NEON_2RM_VRECPE_F] = 0x4,
-    [NEON_2RM_VRSQRTE_F] = 0x4,
-    [NEON_2RM_VCVT_FS] = 0x4,
-    [NEON_2RM_VCVT_FU] = 0x4,
-    [NEON_2RM_VCVT_SF] = 0x4,
-    [NEON_2RM_VCVT_UF] = 0x4,
-};
-
 static void gen_gvec_fn3_qc(uint32_t rd_ofs, uint32_t rn_ofs, uint32_t rm_ofs,
                             uint32_t opr_sz, uint32_t max_sz,
                             gen_helper_gvec_3_ptr *fn)
@@ -4822,178 +4645,6 @@ void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
-/* Translate a NEON data processing instruction.  Return nonzero if the
-   instruction is invalid.
-   We process data in a mixture of 32-bit and 64-bit chunks.
-   Mostly we use 32-bit chunks so we can use normal scalar instructions.  */
-
-static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
-{
-    int op;
-    int q;
-    int rd, rm;
-    int size;
-    int pass;
-    int u;
-    TCGv_i32 tmp, tmp2;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return 1;
-    }
-
-    /* FIXME: this access check should not take precedence over UNDEF
-     * for invalid encodings; we will generate incorrect syndrome information
-     * for attempts to execute invalid vfp/neon encodings with FP disabled.
-     */
-    if (s->fp_excp_el) {
-        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
-                           syn_simd_access_trap(1, 0xe, false), s->fp_excp_el);
-        return 0;
-    }
-
-    if (!s->vfp_enabled)
-      return 1;
-    q = (insn & (1 << 6)) != 0;
-    u = (insn >> 24) & 1;
-    VFP_DREG_D(rd, insn);
-    VFP_DREG_M(rm, insn);
-    size = (insn >> 20) & 3;
-
-    if ((insn & (1 << 23)) == 0) {
-        /* Three register same length: handled by decodetree */
-        return 1;
-    } else if (insn & (1 << 4)) {
-        /* Two registers and shift or reg and imm: handled by decodetree */
-        return 1;
-    } else { /* (insn & 0x00800010 == 0x00800000) */
-        if (size != 3) {
-            /*
-             * Three registers of different lengths, or two registers and
-             * a scalar: handled by decodetree
-             */
-            return 1;
-        } else { /* size == 3 */
-            if (!u) {
-                /* Extract: handled by decodetree */
-                return 1;
-            } else if ((insn & (1 << 11)) == 0) {
-                /* Two register misc.  */
-                op = ((insn >> 12) & 0x30) | ((insn >> 7) & 0xf);
-                size = (insn >> 18) & 3;
-                /* UNDEF for unknown op values and bad op-size combinations */
-                if ((neon_2rm_sizes[op] & (1 << size)) == 0) {
-                    return 1;
-                }
-                if (q && ((rm | rd) & 1)) {
-                    return 1;
-                }
-                switch (op) {
-                case NEON_2RM_VREV64:
-                case NEON_2RM_VPADDL: case NEON_2RM_VPADDL_U:
-                case NEON_2RM_VPADAL: case NEON_2RM_VPADAL_U:
-                case NEON_2RM_VUZP:
-                case NEON_2RM_VZIP:
-                case NEON_2RM_VMOVN: case NEON_2RM_VQMOVN:
-                case NEON_2RM_VSHLL:
-                case NEON_2RM_VCVT_F16_F32:
-                case NEON_2RM_VCVT_F32_F16:
-                case NEON_2RM_VMVN:
-                case NEON_2RM_VNEG:
-                case NEON_2RM_VABS:
-                case NEON_2RM_VCEQ0:
-                case NEON_2RM_VCGT0:
-                case NEON_2RM_VCLE0:
-                case NEON_2RM_VCGE0:
-                case NEON_2RM_VCLT0:
-                case NEON_2RM_AESE: case NEON_2RM_AESMC:
-                case NEON_2RM_SHA1H:
-                case NEON_2RM_SHA1SU1:
-                case NEON_2RM_VREV32:
-                case NEON_2RM_VREV16:
-                case NEON_2RM_VCLS:
-                case NEON_2RM_VCLZ:
-                case NEON_2RM_VCNT:
-                case NEON_2RM_VABS_F:
-                case NEON_2RM_VNEG_F:
-                case NEON_2RM_VRECPE:
-                case NEON_2RM_VRSQRTE:
-                case NEON_2RM_VQABS:
-                case NEON_2RM_VQNEG:
-                case NEON_2RM_VRECPE_F:
-                case NEON_2RM_VRSQRTE_F:
-                case NEON_2RM_VCVT_FS:
-                case NEON_2RM_VCVT_FU:
-                case NEON_2RM_VCVT_SF:
-                case NEON_2RM_VCVT_UF:
-                case NEON_2RM_VRINTX:
-                case NEON_2RM_VCGT0_F:
-                case NEON_2RM_VCGE0_F:
-                case NEON_2RM_VCEQ0_F:
-                case NEON_2RM_VCLE0_F:
-                case NEON_2RM_VCLT0_F:
-                case NEON_2RM_VRINTN:
-                case NEON_2RM_VRINTA:
-                case NEON_2RM_VRINTM:
-                case NEON_2RM_VRINTP:
-                case NEON_2RM_VRINTZ:
-                case NEON_2RM_VCVTAU:
-                case NEON_2RM_VCVTAS:
-                case NEON_2RM_VCVTNU:
-                case NEON_2RM_VCVTNS:
-                case NEON_2RM_VCVTPU:
-                case NEON_2RM_VCVTPS:
-                case NEON_2RM_VCVTMU:
-                case NEON_2RM_VCVTMS:
-                case NEON_2RM_VSWP:
-                    /* handled by decodetree */
-                    return 1;
-                case NEON_2RM_VTRN:
-                    if (size == 2) {
-                        int n;
-                        for (n = 0; n < (q ? 4 : 2); n += 2) {
-                            tmp = neon_load_reg(rm, n);
-                            tmp2 = neon_load_reg(rd, n + 1);
-                            neon_store_reg(rm, n, tmp2);
-                            neon_store_reg(rd, n + 1, tmp);
-                        }
-                    } else {
-                        goto elementwise;
-                    }
-                    break;
-
-                default:
-                elementwise:
-                    for (pass = 0; pass < (q ? 4 : 2); pass++) {
-                        tmp = neon_load_reg(rm, pass);
-                        switch (op) {
-                        case NEON_2RM_VTRN:
-                            tmp2 = neon_load_reg(rd, pass);
-                            switch (size) {
-                            case 0: gen_neon_trn_u8(tmp, tmp2); break;
-                            case 1: gen_neon_trn_u16(tmp, tmp2); break;
-                            default: abort();
-                            }
-                            neon_store_reg(rm, pass, tmp2);
-                            break;
-                        default:
-                            /* Reserved op values were caught by the
-                             * neon_2rm_sizes[] check earlier.
-                             */
-                            abort();
-                        }
-                        neon_store_reg(rd, pass, tmp);
-                    }
-                    break;
-                }
-            } else {
-                /* VTBL, VTBX, VDUP: handled by decodetree */
-                return 1;
-            }
-        }
-    }
-    return 0;
-}
-
 static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 {
     int cpnum, is64, crn, crm, opc1, opc2, isread, rt, rt2;
@@ -8694,13 +8345,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         }
         /* fall back to legacy decoder */
 
-        if (((insn >> 25) & 7) == 1) {
-            /* NEON Data processing.  */
-            if (disas_neon_data_insn(s, insn)) {
-                goto illegal_op;
-            }
-            return;
-        }
         if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
@@ -8888,11 +8532,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             break;
         }
         if (((insn >> 24) & 3) == 3) {
-            /* Translate into the equivalent ARM encoding.  */
-            insn = (insn & 0xe2ffffff) | ((insn & (1 << 28)) >> 4) | (1 << 28);
-            if (disas_neon_data_insn(s, insn)) {
-                goto illegal_op;
-            }
+            /* Neon DP, but failed disas_neon_dp() */
+            goto illegal_op;
         } else if (((insn >> 8) & 0xe) == 10) {
             /* VFP, but failed disas_vfp.  */
             goto illegal_op;
-- 
2.20.1


