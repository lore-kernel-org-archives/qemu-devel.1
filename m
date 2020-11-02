Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F8BC388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8659720657
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtlOcKNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8659720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdPA-0005lB-Kb
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLX-0000dK-KA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:19 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:43584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLV-0006PD-IB
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:19 -0500
Received: by mail-wr1-x433.google.com with SMTP id g12so15468650wrp.10
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uOowFsU/Wl7DM2DhiQSboTeZ8PmxUU3zA8lUWHXMoCA=;
 b=qtlOcKNHD51bFJMnKxmfmDOoVCuBP0Vx2FGUlByo2agEZlknsXubwiOFl10ZpzXjZ1
 SRELv2cUPfIgsJSpfIABJiBgiPm8q7V4YvjxrniHlHxZwvrr0wQQE26DxpN8NyZdNeK3
 zDgmHTrv1knShz1RIlaq2qOUGzy5HwubnstHrxuapvkh/1l91XoDQO0csJy/TS6kASU4
 IacZcRS5kwI7CT+bBT42CLswwmadMXdnOrn1k6J7jtqp1p60dOA6CMVKP31zZOs6lN3A
 Gf2wh1DZC54tkwfKLUNhAOg2MLRZhmQMM5nWIexkgQhqzikpV0slfTapforLly5z9x73
 sVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uOowFsU/Wl7DM2DhiQSboTeZ8PmxUU3zA8lUWHXMoCA=;
 b=HntypfU5iONwfJboBtS+d3gW2ju0w8y3W8vT55OrvJpumuWBUN9qRx7GIMua/mKfyW
 a8LirE6n0PXcfE866yUTU9EPllI5u7OsAkhbbDiXZvwQGoheWJ7Qxir9wwvmXVYr3xed
 cm9tC+F1bDcaJ976yCGXfuWBf5ItSzLELNPc5jYDu9oNjMXvmSseqdFT0QhnGQDgMRm1
 RHHRpsMR+RLcXI37ZzNNka96LJjtJi/jJykH47om5Ch5RrPeqG87p+HD3MagH9AE80Bl
 annuYB4r+bK2h92BLedDPVapR1fp4DafWjurEdi5JV7vF3Pb23v/JCT4ZD7CXQXtQc9Z
 wl/g==
X-Gm-Message-State: AOAM531qHfMRrVe78Y/85Quw6uabj7kiifWyuD0EuF1s293Exl1KdCUD
 XS692G4f8Uydk67Otx18ol4TJ/BBYVmBoA==
X-Google-Smtp-Source: ABdhPJzeoJZN6uwSNMyJJXhMomsfyeFGhLOlGHTVCxtz68EeLmiyxDqdVgX9rHU7DCBiY7BnysFVew==
X-Received: by 2002:adf:eec7:: with SMTP id a7mr21407223wrp.294.1604337015858; 
 Mon, 02 Nov 2020 09:10:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/26] target/arm: Expand read/write_neon_element32 to all MemOp
Date: Mon,  2 Nov 2020 17:09:45 +0000
Message-Id: <20201102171005.30690-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We can then use this to improve VMOV (scalar to gp) and
VMOV (gp to scalar) so that we simply perform the memory
operation that we wanted, rather than inserting or
extracting from a 32-bit quantity.

These were the last uses of neon_load/store_reg, so remove them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201030022618.785675-7-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c         | 50 +++++++++++++-----------
 target/arm/translate-vfp.c.inc | 71 +++++-----------------------------
 2 files changed, 37 insertions(+), 84 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0ed9eab0b0d..55d5f4ed73b 100644
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
index 368bae0a73d..28f22f98729 100644
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
2.20.1


