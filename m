Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3EEC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288A82242F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoS1iQ3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288A82242F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcDU-0003xo-58
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7L-0005tr-JG
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:19 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7J-0005pG-M0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:19 -0400
Received: by mail-pl1-x644.google.com with SMTP id o9so1800500plx.10
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NlmDoKUnT++Y4HE65X/AaQrAu9Ha43jQPJiWJ9I7vlY=;
 b=ZoS1iQ3T33oGbjteeKwJK/ZCChN8xz344QrrFqZP/6fVnjwArTBNd6F4agfo3jZXFb
 6Uh7oZ5bRZakzb8olVdYZGzdBDKtXUQje1JJrOi1quzkTcq0Be2hD6QVzxGcRhE9VKnX
 erHgP/6TfXM7kegpq8auEAcZ0LntGkb+sfcPAfa3LlyyvWcT4g5cXphaslD1tLi3Zquv
 er+C/J8Arq0KEyNCA5CpHzNkaIJkszy7CedtTuiQrVxE4nx2t7p22BpBomaNTD0bvqQO
 YFXQieYgANVu1r05DtQcw3U882I06reXjqfDSnzLS8hZIt6LD8LP0LigJmUIpCDqjxA5
 Zk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NlmDoKUnT++Y4HE65X/AaQrAu9Ha43jQPJiWJ9I7vlY=;
 b=eBgBlh2qN1Wmd7BI3bvvjjDGYROuBHAcop4JC7D/FpuK+AXe1HPEyRM2Pr2PjVgxZd
 snVLKZtPLSJVBg9MCyDtU9hbaOLXuB1mG9fJPJATsUno9TiLzinewModWjH6pu6l+H4w
 QcCZcPJqWcjk/lBcI+gGLzUI1G0ZlTRmCuNaLnO4I4GnixUwXou5kSXsAGHIP7V7QHZS
 eeuIONjTiR/r9vhEfsQYgnM/ewApFlQ00UhNuZd7IvsVLHBOmRstCVXolWx/mr/XnP/e
 iFukhAB2/HRxRbUMIH8GMBGEWU1idCA/i6rn5vqsVEAPlnbysFgTiRitDjE26gpji3qK
 NlBw==
X-Gm-Message-State: AOAM533tQfB/FExpbmcdfVkMg9CJAugw5n1OP6C+RwgT6Ixh9trICQve
 OAsmfE3MRMu8i+gJBWxBLGSurSOKG3DjLw==
X-Google-Smtp-Source: ABdhPJzXo266fh5quVImjkfLczkve0pjau6+PryKTtTvJ6O3xReOHF50k/irC2gwKGU601jqWbeppQ==
X-Received: by 2002:a17:902:a9c9:b029:d6:2d8f:f7b4 with SMTP id
 b9-20020a170902a9c9b02900d62d8ff7b4mr5705024plr.2.1603855635796; 
 Tue, 27 Oct 2020 20:27:15 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d26sm3764413pfo.82.2020.10.27.20.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 20:27:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/11] target/arm: Expand read/write_neon_element32 to all
 MemOp
Date: Tue, 27 Oct 2020 20:26:58 -0700
Message-Id: <20201028032703.201526-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028032703.201526-1-richard.henderson@linaro.org>
References: <20201028032703.201526-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can then use this to improve VMOV (scalar to gp) and
VMOV (gp to scalar) so that we simply perform the memory
operation that we wanted, rather than inserting or
extracting from a 32-bit quantity.

These were the last uses of neon_load/store_reg, so remove them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c         | 50 +++++++++++++-----------
 target/arm/translate-vfp.c.inc | 71 +++++-----------------------------
 2 files changed, 37 insertions(+), 84 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0ed9eab0b0..55d5f4ed73 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1106,9 +1106,9 @@ static long neon_full_reg_offset(unsigned reg)
  * Return the offset of a 2**SIZE piece of a NEON register, at index ELE,
  * where 0 is the least significant end of the register.
  */
-static long neon_element_offset(int reg, int element, MemOp size)
+static long neon_element_offset(int reg, int element, MemOp memop)
 {
-    int element_size = 1 << size;
+    int element_size = 1 << (memop & MO_SIZE);
     int ofs = element * element_size;
 #ifdef HOST_WORDS_BIGENDIAN
     /*
@@ -1132,19 +1132,6 @@ static long vfp_reg_offset(bool dp, unsigned reg)
     }
 }
 
-static TCGv_i32 neon_load_reg(int reg, int pass)
-{
-    TCGv_i32 tmp = tcg_temp_new_i32();
-    tcg_gen_ld_i32(tmp, cpu_env, neon_element_offset(reg, pass, MO_32));
-    return tmp;
-}
-
-static void neon_store_reg(int reg, int pass, TCGv_i32 var)
-{
-    tcg_gen_st_i32(var, cpu_env, neon_element_offset(reg, pass, MO_32));
-    tcg_temp_free_i32(var);
-}
-
 static inline void neon_load_reg64(TCGv_i64 var, int reg)
 {
     tcg_gen_ld_i64(var, cpu_env, vfp_reg_offset(1, reg));
@@ -1165,12 +1152,25 @@ static inline void neon_store_reg32(TCGv_i32 var, int reg)
     tcg_gen_st_i32(var, cpu_env, vfp_reg_offset(false, reg));
 }
 
-static void read_neon_element32(TCGv_i32 dest, int reg, int ele, MemOp size)
+static void read_neon_element32(TCGv_i32 dest, int reg, int ele, MemOp memop)
 {
-    long off = neon_element_offset(reg, ele, size);
+    long off = neon_element_offset(reg, ele, memop);
 
-    switch (size) {
-    case MO_32:
+    switch (memop) {
+    case MO_SB:
+        tcg_gen_ld8s_i32(dest, cpu_env, off);
+        break;
+    case MO_UB:
+        tcg_gen_ld8u_i32(dest, cpu_env, off);
+        break;
+    case MO_SW:
+        tcg_gen_ld16s_i32(dest, cpu_env, off);
+        break;
+    case MO_UW:
+        tcg_gen_ld16u_i32(dest, cpu_env, off);
+        break;
+    case MO_UL:
+    case MO_SL:
         tcg_gen_ld_i32(dest, cpu_env, off);
         break;
     default:
@@ -1178,11 +1178,17 @@ static void read_neon_element32(TCGv_i32 dest, int reg, int ele, MemOp size)
     }
 }
 
-static void write_neon_element32(TCGv_i32 src, int reg, int ele, MemOp size)
+static void write_neon_element32(TCGv_i32 src, int reg, int ele, MemOp memop)
 {
-    long off = neon_element_offset(reg, ele, size);
+    long off = neon_element_offset(reg, ele, memop);
 
-    switch (size) {
+    switch (memop) {
+    case MO_8:
+        tcg_gen_st8_i32(src, cpu_env, off);
+        break;
+    case MO_16:
+        tcg_gen_st16_i32(src, cpu_env, off);
+        break;
     case MO_32:
         tcg_gen_st_i32(src, cpu_env, off);
         break;
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 368bae0a73..28f22f9872 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -511,11 +511,9 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
 {
     /* VMOV scalar to general purpose register */
     TCGv_i32 tmp;
-    int pass;
-    uint32_t offset;
 
-    /* SIZE == 2 is a VFP instruction; otherwise NEON.  */
-    if (a->size == 2
+    /* SIZE == MO_32 is a VFP instruction; otherwise NEON.  */
+    if (a->size == MO_32
         ? !dc_isar_feature(aa32_fpsp_v2, s)
         : !arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -526,44 +524,12 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
         return false;
     }
 
-    offset = a->index << a->size;
-    pass = extract32(offset, 2, 1);
-    offset = extract32(offset, 0, 2) * 8;
-
     if (!vfp_access_check(s)) {
         return true;
     }
 
-    tmp = neon_load_reg(a->vn, pass);
-    switch (a->size) {
-    case 0:
-        if (offset) {
-            tcg_gen_shri_i32(tmp, tmp, offset);
-        }
-        if (a->u) {
-            gen_uxtb(tmp);
-        } else {
-            gen_sxtb(tmp);
-        }
-        break;
-    case 1:
-        if (a->u) {
-            if (offset) {
-                tcg_gen_shri_i32(tmp, tmp, 16);
-            } else {
-                gen_uxth(tmp);
-            }
-        } else {
-            if (offset) {
-                tcg_gen_sari_i32(tmp, tmp, 16);
-            } else {
-                gen_sxth(tmp);
-            }
-        }
-        break;
-    case 2:
-        break;
-    }
+    tmp = tcg_temp_new_i32();
+    read_neon_element32(tmp, a->vn, a->index, a->size | (a->u ? 0 : MO_SIGN));
     store_reg(s, a->rt, tmp);
 
     return true;
@@ -572,12 +538,10 @@ static bool trans_VMOV_to_gp(DisasContext *s, arg_VMOV_to_gp *a)
 static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
 {
     /* VMOV general purpose register to scalar */
-    TCGv_i32 tmp, tmp2;
-    int pass;
-    uint32_t offset;
+    TCGv_i32 tmp;
 
-    /* SIZE == 2 is a VFP instruction; otherwise NEON.  */
-    if (a->size == 2
+    /* SIZE == MO_32 is a VFP instruction; otherwise NEON.  */
+    if (a->size == MO_32
         ? !dc_isar_feature(aa32_fpsp_v2, s)
         : !arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -588,30 +552,13 @@ static bool trans_VMOV_from_gp(DisasContext *s, arg_VMOV_from_gp *a)
         return false;
     }
 
-    offset = a->index << a->size;
-    pass = extract32(offset, 2, 1);
-    offset = extract32(offset, 0, 2) * 8;
-
     if (!vfp_access_check(s)) {
         return true;
     }
 
     tmp = load_reg(s, a->rt);
-    switch (a->size) {
-    case 0:
-        tmp2 = neon_load_reg(a->vn, pass);
-        tcg_gen_deposit_i32(tmp, tmp2, tmp, offset, 8);
-        tcg_temp_free_i32(tmp2);
-        break;
-    case 1:
-        tmp2 = neon_load_reg(a->vn, pass);
-        tcg_gen_deposit_i32(tmp, tmp2, tmp, offset, 16);
-        tcg_temp_free_i32(tmp2);
-        break;
-    case 2:
-        break;
-    }
-    neon_store_reg(a->vn, pass, tmp);
+    write_neon_element32(tmp, a->vn, a->index, a->size);
+    tcg_temp_free_i32(tmp);
 
     return true;
 }
-- 
2.25.1


