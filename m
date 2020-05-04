Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD26CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72249206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqJzS+4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72249206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVaY6-0005UB-HL
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI7-0000wZ-Sw
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:54614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVaI6-0001Gt-P5
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:33:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id h4so8230764wmb.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AyE32l/nhnjqAyuiiAGRqGOtoiKIQuFPk0xddUd+Avo=;
 b=lqJzS+4FVlUl6Y7/B9i4/IwMM4RIqNbTdNkICrfwJvfjoEvn+qFbl9BgwRKwavVtDb
 iO8aovesZ5dBnjfoM075DbBY6P8BfD5S7cV2XsZpvgncCP5IPRt9dViAvOGEdVfDtE7m
 tCyfaAsVu8HuoYiEskKAwgGp7XzcQxaWl5BOwpEEJRLw5Xi8cvhXSgmmIkiMZSReySab
 LTeYy83KoncgcBJ+mDIuEdx2zxLXGlg04BuNESpfsrkgZBx52o9Dh1qEf5BijdNiy+eb
 ik1UnZbTwYClf1p4bgg7URnId9r+qK6g2yM1/PhVQ/ATVONSpvw8jgicKVocxEEORIiu
 CsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AyE32l/nhnjqAyuiiAGRqGOtoiKIQuFPk0xddUd+Avo=;
 b=kW2KPJkGDIQbzvArMFVNOGqaTTRnTqj7hiczywIfAtvHcBCBGXlsHjSrwcX/v0HIaO
 PrUGiJA/KwEm6aMyXGXSdz9UmaK2gjWnKKBiFmpC7nPPWYhkvBunZxfhGZdpZF03ov2p
 QmbHnjkH+44m+4zDrv+YmhhVGfVgyx9j6uFXTM7KvJobQZ6uAUmfMJtfOiSKtbaP+lXr
 zbRQPIO/rQMjirxu/xXZWNBzR/8xBU7KLkuQy+ehJDyQBzBvjduWVlMskPl3hVHmKfMC
 MO6VhCC5fo4IpLeLpIuwD2WoA2Y7xT6LiWzr5mpFvQXUmyyCNah8I0LuIr4v0f28v5Ov
 4blw==
X-Gm-Message-State: AGi0PuZ2G07YEY/RozapE4F3BXyfADxBERXjH+/z4AIC1Ff0EEMN7bUO
 xY3lhfb9smZIESBd+5XEdoPB23J9Y44J+w==
X-Google-Smtp-Source: APiQypItqu//ZA00ZirYii430eWaCJe6eoOGMqT+mBfHVXNakHekn5ErfzJQ7TdSvIs9Byo/yp3E9Q==
X-Received: by 2002:a1c:2457:: with SMTP id k84mr13550274wmk.96.1588595624803; 
 Mon, 04 May 2020 05:33:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q4sm12253608wrx.9.2020.05.04.05.33.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 05:33:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/39] target/arm: Convert Neon load/store multiple structures
 to decodetree
Date: Mon,  4 May 2020 13:33:00 +0100
Message-Id: <20200504123309.3808-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200504123309.3808-1-peter.maydell@linaro.org>
References: <20200504123309.3808-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Convert the Neon "load/store multiple structures" insns to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200430181003.21682-12-peter.maydell@linaro.org
---
 target/arm/neon-ls.decode       |   7 ++
 target/arm/translate-neon.inc.c | 124 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  91 +----------------------
 3 files changed, 133 insertions(+), 89 deletions(-)

diff --git a/target/arm/neon-ls.decode b/target/arm/neon-ls.decode
index 2b16c9256df..dd03d5a37bd 100644
--- a/target/arm/neon-ls.decode
+++ b/target/arm/neon-ls.decode
@@ -27,3 +27,10 @@
 #   0b1111_1001_xxx0_xxxx_xxxx_xxxx_xxxx_xxxx
 # This file works on the A32 encoding only; calling code for T32 has to
 # transform the insn into the A32 version first.
+
+%vd_dp  22:1 12:4
+
+# Neon load/store multiple structures
+
+VLDST_multiple 1111 0100 0 . l:1 0 rn:4 .... itype:4 size:2 align:2 rm:4 \
+               vd=%vd_dp
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index b06542b8b83..966c0d92012 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -274,3 +274,127 @@ static bool trans_VFML_scalar(DisasContext *s, arg_VFML_scalar *a)
                        gen_helper_gvec_fmlal_idx_a32);
     return true;
 }
+
+static struct {
+    int nregs;
+    int interleave;
+    int spacing;
+} const neon_ls_element_type[11] = {
+    {1, 4, 1},
+    {1, 4, 2},
+    {4, 1, 1},
+    {2, 2, 2},
+    {1, 3, 1},
+    {1, 3, 2},
+    {3, 1, 1},
+    {1, 1, 1},
+    {1, 2, 1},
+    {1, 2, 2},
+    {2, 1, 1}
+};
+
+static void gen_neon_ldst_base_update(DisasContext *s, int rm, int rn,
+                                      int stride)
+{
+    if (rm != 15) {
+        TCGv_i32 base;
+
+        base = load_reg(s, rn);
+        if (rm == 13) {
+            tcg_gen_addi_i32(base, base, stride);
+        } else {
+            TCGv_i32 index;
+            index = load_reg(s, rm);
+            tcg_gen_add_i32(base, base, index);
+            tcg_temp_free_i32(index);
+        }
+        store_reg(s, rn, base);
+    }
+}
+
+static bool trans_VLDST_multiple(DisasContext *s, arg_VLDST_multiple *a)
+{
+    /* Neon load/store multiple structures */
+    int nregs, interleave, spacing, reg, n;
+    MemOp endian = s->be_data;
+    int mmu_idx = get_mem_index(s);
+    int size = a->size;
+    TCGv_i64 tmp64;
+    TCGv_i32 addr, tmp;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist */
+    if (!dc_isar_feature(aa32_simd_r32, s) && (a->vd & 0x10)) {
+        return false;
+    }
+    if (a->itype > 10) {
+        return false;
+    }
+    /* Catch UNDEF cases for bad values of align field */
+    switch (a->itype & 0xc) {
+    case 4:
+        if (a->align >= 2) {
+            return false;
+        }
+        break;
+    case 8:
+        if (a->align == 3) {
+            return false;
+        }
+        break;
+    default:
+        break;
+    }
+    nregs = neon_ls_element_type[a->itype].nregs;
+    interleave = neon_ls_element_type[a->itype].interleave;
+    spacing = neon_ls_element_type[a->itype].spacing;
+    if (size == 3 && (interleave | spacing) != 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    /* For our purposes, bytes are always little-endian.  */
+    if (size == 0) {
+        endian = MO_LE;
+    }
+    /*
+     * Consecutive little-endian elements from a single register
+     * can be promoted to a larger little-endian operation.
+     */
+    if (interleave == 1 && endian == MO_LE) {
+        size = 3;
+    }
+    tmp64 = tcg_temp_new_i64();
+    addr = tcg_temp_new_i32();
+    tmp = tcg_const_i32(1 << size);
+    load_reg_var(s, addr, a->rn);
+    for (reg = 0; reg < nregs; reg++) {
+        for (n = 0; n < 8 >> size; n++) {
+            int xs;
+            for (xs = 0; xs < interleave; xs++) {
+                int tt = a->vd + reg + spacing * xs;
+
+                if (a->l) {
+                    gen_aa32_ld_i64(s, tmp64, addr, mmu_idx, endian | size);
+                    neon_store_element64(tt, n, size, tmp64);
+                } else {
+                    neon_load_element64(tmp64, tt, n, size);
+                    gen_aa32_st_i64(s, tmp64, addr, mmu_idx, endian | size);
+                }
+                tcg_gen_add_i32(addr, addr, tmp);
+            }
+        }
+    }
+    tcg_temp_free_i32(addr);
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i64(tmp64);
+
+    gen_neon_ldst_base_update(s, a->rm, a->rn, nregs * interleave * 8);
+    return true;
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index e269642a480..be56cbb0614 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3214,45 +3214,19 @@ static void gen_neon_trn_u16(TCGv_i32 t0, TCGv_i32 t1)
 }
 
 
-static struct {
-    int nregs;
-    int interleave;
-    int spacing;
-} const neon_ls_element_type[11] = {
-    {1, 4, 1},
-    {1, 4, 2},
-    {4, 1, 1},
-    {2, 2, 2},
-    {1, 3, 1},
-    {1, 3, 2},
-    {3, 1, 1},
-    {1, 1, 1},
-    {1, 2, 1},
-    {1, 2, 2},
-    {2, 1, 1}
-};
-
 /* Translate a NEON load/store element instruction.  Return nonzero if the
    instruction is invalid.  */
 static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
 {
     int rd, rn, rm;
-    int op;
     int nregs;
-    int interleave;
-    int spacing;
     int stride;
     int size;
     int reg;
     int load;
-    int n;
     int vec_size;
-    int mmu_idx;
-    MemOp endian;
     TCGv_i32 addr;
     TCGv_i32 tmp;
-    TCGv_i32 tmp2;
-    TCGv_i64 tmp64;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return 1;
@@ -3274,70 +3248,9 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
     rn = (insn >> 16) & 0xf;
     rm = insn & 0xf;
     load = (insn & (1 << 21)) != 0;
-    endian = s->be_data;
-    mmu_idx = get_mem_index(s);
     if ((insn & (1 << 23)) == 0) {
-        /* Load store all elements.  */
-        op = (insn >> 8) & 0xf;
-        size = (insn >> 6) & 3;
-        if (op > 10)
-            return 1;
-        /* Catch UNDEF cases for bad values of align field */
-        switch (op & 0xc) {
-        case 4:
-            if (((insn >> 5) & 1) == 1) {
-                return 1;
-            }
-            break;
-        case 8:
-            if (((insn >> 4) & 3) == 3) {
-                return 1;
-            }
-            break;
-        default:
-            break;
-        }
-        nregs = neon_ls_element_type[op].nregs;
-        interleave = neon_ls_element_type[op].interleave;
-        spacing = neon_ls_element_type[op].spacing;
-        if (size == 3 && (interleave | spacing) != 1) {
-            return 1;
-        }
-        /* For our purposes, bytes are always little-endian.  */
-        if (size == 0) {
-            endian = MO_LE;
-        }
-        /* Consecutive little-endian elements from a single register
-         * can be promoted to a larger little-endian operation.
-         */
-        if (interleave == 1 && endian == MO_LE) {
-            size = 3;
-        }
-        tmp64 = tcg_temp_new_i64();
-        addr = tcg_temp_new_i32();
-        tmp2 = tcg_const_i32(1 << size);
-        load_reg_var(s, addr, rn);
-        for (reg = 0; reg < nregs; reg++) {
-            for (n = 0; n < 8 >> size; n++) {
-                int xs;
-                for (xs = 0; xs < interleave; xs++) {
-                    int tt = rd + reg + spacing * xs;
-
-                    if (load) {
-                        gen_aa32_ld_i64(s, tmp64, addr, mmu_idx, endian | size);
-                        neon_store_element64(tt, n, size, tmp64);
-                    } else {
-                        neon_load_element64(tmp64, tt, n, size);
-                        gen_aa32_st_i64(s, tmp64, addr, mmu_idx, endian | size);
-                    }
-                    tcg_gen_add_i32(addr, addr, tmp2);
-                }
-            }
-        }
-        tcg_temp_free_i32(addr);
-        tcg_temp_free_i32(tmp2);
-        tcg_temp_free_i64(tmp64);
-        stride = nregs * interleave * 8;
+        /* Load store all elements -- handled already by decodetree */
+        return 1;
     } else {
         size = (insn >> 10) & 3;
         if (size == 3) {
-- 
2.20.1


