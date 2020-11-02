Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745C7C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6BA422265
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5qqoApr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BA422265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdU6-0004dz-Un
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLk-0000qe-6c
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:32 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLh-0006Y4-4F
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:31 -0500
Received: by mail-wr1-x42e.google.com with SMTP id y12so15492625wrp.6
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LMG2S8LqH/n4F3uuVEqblkPOM6DnMxO6M2jtzxBxXgI=;
 b=N5qqoAprFC/a1VNvUfyGCrREqdxgd7y9wB7wOx7aXGMRO63+zS+nF2eBKZuMJaM4Ig
 3TG3VAP3gDeU1n0u529d18RZ303lM6wk7bwhglFQqK7exMREYc2iQPC0XlUmcRXaj/yE
 f8DfquWVlTbil5Hlhc6bUdCJkoGRKyQQnnnaMLCUH+e9BFKDz8Md9v1G8oM8yxCoav7l
 LPfpKp3enBxEAUAGWrqTHBK0U/YSQALBvdpxOA7AydjtiW8puahzhfJc32GA/wnM/+mK
 b5tssRgqz2sAM4JlwoNekmii6HF60OTu6/9KfBObtz/mpoRkwFDEgdvcPCmWOPX8LYNw
 HBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LMG2S8LqH/n4F3uuVEqblkPOM6DnMxO6M2jtzxBxXgI=;
 b=uAMP6LY8WYynz34LVdWA4znkOuYCFnt4BZ0LH3yyvp5WC0aC6yFNLpBGNIOQGvy5Mc
 Hgb2lPcyVet9erFfhMUkdQxTyNmK7aZW8vE/GrGVImLkZ6UA7mBCXf8hv3WyfZ5jaS0G
 lBkbJdPPjqmj6crM4Tey/sffTKcR/DgKiIk957jDdkOBQ+APOScm8mafisKJP4VJ2UeA
 pMgW0Oxr4cOQ/9mZivEBoK46rP/VPQK3Z+S6VFehdgFR8sHkY+Tz0RxlzxS293lnPGCg
 JxktF5UTZuqxT9bqpUQMjyGw1M9FSAitB+XPPRNQO3l6hyk71x7pfdRQbeOvaTD7Nutg
 u70A==
X-Gm-Message-State: AOAM533Ofc0GZJtHnaO84rNMX9DxuDYplRZw8B2Emfg9ljn28KEWcobj
 i2Hu6jjBhxmiq3VuMbgxJQnqlvbs1Yn1YQ==
X-Google-Smtp-Source: ABdhPJxGMM2626CThcGrtmMQ1z5ifu+/g0XlLI0ku19brVltxEqfwCiKGkXXs6fQ2YnwF/3wagw/YQ==
X-Received: by 2002:adf:cd87:: with SMTP id q7mr21344432wrj.169.1604337026803; 
 Mon, 02 Nov 2020 09:10:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/26] target/arm: Add read/write_neon_element64
Date: Mon,  2 Nov 2020 17:09:47 +0000
Message-Id: <20201102171005.30690-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Replace all uses of neon_load/store_reg64 within translate-neon.c.inc.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201030022618.785675-9-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c          | 26 +++++++++
 target/arm/translate-neon.c.inc | 94 ++++++++++++++++-----------------
 2 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 8491ab705b4..4fb0a62200f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1178,6 +1178,19 @@ static void read_neon_element32(TCGv_i32 dest, int reg, int ele, MemOp memop)
     }
 }
 
+static void read_neon_element64(TCGv_i64 dest, int reg, int ele, MemOp memop)
+{
+    long off = neon_element_offset(reg, ele, memop);
+
+    switch (memop) {
+    case MO_Q:
+        tcg_gen_ld_i64(dest, cpu_env, off);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void write_neon_element32(TCGv_i32 src, int reg, int ele, MemOp memop)
 {
     long off = neon_element_offset(reg, ele, memop);
@@ -1197,6 +1210,19 @@ static void write_neon_element32(TCGv_i32 src, int reg, int ele, MemOp memop)
     }
 }
 
+static void write_neon_element64(TCGv_i64 src, int reg, int ele, MemOp memop)
+{
+    long off = neon_element_offset(reg, ele, memop);
+
+    switch (memop) {
+    case MO_64:
+        tcg_gen_st_i64(src, cpu_env, off);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
 {
     TCGv_ptr ret = tcg_temp_new_ptr();
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 549381703ea..c2d67160f9e 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1265,9 +1265,9 @@ static bool do_2shift_env_64(DisasContext *s, arg_2reg_shift *a,
     for (pass = 0; pass < a->q + 1; pass++) {
         TCGv_i64 tmp = tcg_temp_new_i64();
 
-        neon_load_reg64(tmp, a->vm + pass);
+        read_neon_element64(tmp, a->vm, pass, MO_64);
         fn(tmp, cpu_env, tmp, constimm);
-        neon_store_reg64(tmp, a->vd + pass);
+        write_neon_element64(tmp, a->vd, pass, MO_64);
         tcg_temp_free_i64(tmp);
     }
     tcg_temp_free_i64(constimm);
@@ -1375,8 +1375,8 @@ static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
     rd = tcg_temp_new_i32();
 
     /* Load both inputs first to avoid potential overwrite if rm == rd */
-    neon_load_reg64(rm1, a->vm);
-    neon_load_reg64(rm2, a->vm + 1);
+    read_neon_element64(rm1, a->vm, 0, MO_64);
+    read_neon_element64(rm2, a->vm, 1, MO_64);
 
     shiftfn(rm1, rm1, constimm);
     narrowfn(rd, cpu_env, rm1);
@@ -1579,7 +1579,7 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
         tcg_gen_shli_i64(tmp, tmp, a->shift);
         tcg_gen_andi_i64(tmp, tmp, ~widen_mask);
     }
-    neon_store_reg64(tmp, a->vd);
+    write_neon_element64(tmp, a->vd, 0, MO_64);
 
     widenfn(tmp, rm1);
     tcg_temp_free_i32(rm1);
@@ -1587,7 +1587,7 @@ static bool do_vshll_2sh(DisasContext *s, arg_2reg_shift *a,
         tcg_gen_shli_i64(tmp, tmp, a->shift);
         tcg_gen_andi_i64(tmp, tmp, ~widen_mask);
     }
-    neon_store_reg64(tmp, a->vd + 1);
+    write_neon_element64(tmp, a->vd, 1, MO_64);
     tcg_temp_free_i64(tmp);
     return true;
 }
@@ -1822,7 +1822,7 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
     rm_64 = tcg_temp_new_i64();
 
     if (src1_wide) {
-        neon_load_reg64(rn0_64, a->vn);
+        read_neon_element64(rn0_64, a->vn, 0, MO_64);
     } else {
         TCGv_i32 tmp = tcg_temp_new_i32();
         read_neon_element32(tmp, a->vn, 0, MO_32);
@@ -1841,7 +1841,7 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
      * avoid incorrect results if a narrow input overlaps with the result.
      */
     if (src1_wide) {
-        neon_load_reg64(rn1_64, a->vn + 1);
+        read_neon_element64(rn1_64, a->vn, 1, MO_64);
     } else {
         TCGv_i32 tmp = tcg_temp_new_i32();
         read_neon_element32(tmp, a->vn, 1, MO_32);
@@ -1851,12 +1851,12 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
     rm = tcg_temp_new_i32();
     read_neon_element32(rm, a->vm, 1, MO_32);
 
-    neon_store_reg64(rn0_64, a->vd);
+    write_neon_element64(rn0_64, a->vd, 0, MO_64);
 
     widenfn(rm_64, rm);
     tcg_temp_free_i32(rm);
     opfn(rn1_64, rn1_64, rm_64);
-    neon_store_reg64(rn1_64, a->vd + 1);
+    write_neon_element64(rn1_64, a->vd, 1, MO_64);
 
     tcg_temp_free_i64(rn0_64);
     tcg_temp_free_i64(rn1_64);
@@ -1928,15 +1928,15 @@ static bool do_narrow_3d(DisasContext *s, arg_3diff *a,
     rd0 = tcg_temp_new_i32();
     rd1 = tcg_temp_new_i32();
 
-    neon_load_reg64(rn_64, a->vn);
-    neon_load_reg64(rm_64, a->vm);
+    read_neon_element64(rn_64, a->vn, 0, MO_64);
+    read_neon_element64(rm_64, a->vm, 0, MO_64);
 
     opfn(rn_64, rn_64, rm_64);
 
     narrowfn(rd0, rn_64);
 
-    neon_load_reg64(rn_64, a->vn + 1);
-    neon_load_reg64(rm_64, a->vm + 1);
+    read_neon_element64(rn_64, a->vn, 1, MO_64);
+    read_neon_element64(rm_64, a->vm, 1, MO_64);
 
     opfn(rn_64, rn_64, rm_64);
 
@@ -2036,16 +2036,16 @@ static bool do_long_3d(DisasContext *s, arg_3diff *a,
     /* Don't store results until after all loads: they might overlap */
     if (accfn) {
         tmp = tcg_temp_new_i64();
-        neon_load_reg64(tmp, a->vd);
+        read_neon_element64(tmp, a->vd, 0, MO_64);
         accfn(tmp, tmp, rd0);
-        neon_store_reg64(tmp, a->vd);
-        neon_load_reg64(tmp, a->vd + 1);
+        write_neon_element64(tmp, a->vd, 0, MO_64);
+        read_neon_element64(tmp, a->vd, 1, MO_64);
         accfn(tmp, tmp, rd1);
-        neon_store_reg64(tmp, a->vd + 1);
+        write_neon_element64(tmp, a->vd, 1, MO_64);
         tcg_temp_free_i64(tmp);
     } else {
-        neon_store_reg64(rd0, a->vd);
-        neon_store_reg64(rd1, a->vd + 1);
+        write_neon_element64(rd0, a->vd, 0, MO_64);
+        write_neon_element64(rd1, a->vd, 1, MO_64);
     }
 
     tcg_temp_free_i64(rd0);
@@ -2669,16 +2669,16 @@ static bool do_2scalar_long(DisasContext *s, arg_2scalar *a,
 
     if (accfn) {
         TCGv_i64 t64 = tcg_temp_new_i64();
-        neon_load_reg64(t64, a->vd);
+        read_neon_element64(t64, a->vd, 0, MO_64);
         accfn(t64, t64, rn0_64);
-        neon_store_reg64(t64, a->vd);
-        neon_load_reg64(t64, a->vd + 1);
+        write_neon_element64(t64, a->vd, 0, MO_64);
+        read_neon_element64(t64, a->vd, 1, MO_64);
         accfn(t64, t64, rn1_64);
-        neon_store_reg64(t64, a->vd + 1);
+        write_neon_element64(t64, a->vd, 1, MO_64);
         tcg_temp_free_i64(t64);
     } else {
-        neon_store_reg64(rn0_64, a->vd);
-        neon_store_reg64(rn1_64, a->vd + 1);
+        write_neon_element64(rn0_64, a->vd, 0, MO_64);
+        write_neon_element64(rn1_64, a->vd, 1, MO_64);
     }
     tcg_temp_free_i64(rn0_64);
     tcg_temp_free_i64(rn1_64);
@@ -2812,10 +2812,10 @@ static bool trans_VEXT(DisasContext *s, arg_VEXT *a)
         right = tcg_temp_new_i64();
         dest = tcg_temp_new_i64();
 
-        neon_load_reg64(right, a->vn);
-        neon_load_reg64(left, a->vm);
+        read_neon_element64(right, a->vn, 0, MO_64);
+        read_neon_element64(left, a->vm, 0, MO_64);
         tcg_gen_extract2_i64(dest, right, left, a->imm * 8);
-        neon_store_reg64(dest, a->vd);
+        write_neon_element64(dest, a->vd, 0, MO_64);
 
         tcg_temp_free_i64(left);
         tcg_temp_free_i64(right);
@@ -2831,21 +2831,21 @@ static bool trans_VEXT(DisasContext *s, arg_VEXT *a)
         destright = tcg_temp_new_i64();
 
         if (a->imm < 8) {
-            neon_load_reg64(right, a->vn);
-            neon_load_reg64(middle, a->vn + 1);
+            read_neon_element64(right, a->vn, 0, MO_64);
+            read_neon_element64(middle, a->vn, 1, MO_64);
             tcg_gen_extract2_i64(destright, right, middle, a->imm * 8);
-            neon_load_reg64(left, a->vm);
+            read_neon_element64(left, a->vm, 0, MO_64);
             tcg_gen_extract2_i64(destleft, middle, left, a->imm * 8);
         } else {
-            neon_load_reg64(right, a->vn + 1);
-            neon_load_reg64(middle, a->vm);
+            read_neon_element64(right, a->vn, 1, MO_64);
+            read_neon_element64(middle, a->vm, 0, MO_64);
             tcg_gen_extract2_i64(destright, right, middle, (a->imm - 8) * 8);
-            neon_load_reg64(left, a->vm + 1);
+            read_neon_element64(left, a->vm, 1, MO_64);
             tcg_gen_extract2_i64(destleft, middle, left, (a->imm - 8) * 8);
         }
 
-        neon_store_reg64(destright, a->vd);
-        neon_store_reg64(destleft, a->vd + 1);
+        write_neon_element64(destright, a->vd, 0, MO_64);
+        write_neon_element64(destleft, a->vd, 1, MO_64);
 
         tcg_temp_free_i64(destright);
         tcg_temp_free_i64(destleft);
@@ -3052,11 +3052,11 @@ static bool do_2misc_pairwise(DisasContext *s, arg_2misc *a,
 
         if (accfn) {
             TCGv_i64 tmp64 = tcg_temp_new_i64();
-            neon_load_reg64(tmp64, a->vd + pass);
+            read_neon_element64(tmp64, a->vd, pass, MO_64);
             accfn(rd_64, tmp64, rd_64);
             tcg_temp_free_i64(tmp64);
         }
-        neon_store_reg64(rd_64, a->vd + pass);
+        write_neon_element64(rd_64, a->vd, pass, MO_64);
         tcg_temp_free_i64(rd_64);
     }
     return true;
@@ -3254,9 +3254,9 @@ static bool do_vmovn(DisasContext *s, arg_2misc *a,
     rd0 = tcg_temp_new_i32();
     rd1 = tcg_temp_new_i32();
 
-    neon_load_reg64(rm, a->vm);
+    read_neon_element64(rm, a->vm, 0, MO_64);
     narrowfn(rd0, cpu_env, rm);
-    neon_load_reg64(rm, a->vm + 1);
+    read_neon_element64(rm, a->vm, 1, MO_64);
     narrowfn(rd1, cpu_env, rm);
     write_neon_element32(rd0, a->vd, 0, MO_32);
     write_neon_element32(rd1, a->vd, 1, MO_32);
@@ -3326,10 +3326,10 @@ static bool trans_VSHLL(DisasContext *s, arg_2misc *a)
 
     widenfn(rd, rm0);
     tcg_gen_shli_i64(rd, rd, 8 << a->size);
-    neon_store_reg64(rd, a->vd);
+    write_neon_element64(rd, a->vd, 0, MO_64);
     widenfn(rd, rm1);
     tcg_gen_shli_i64(rd, rd, 8 << a->size);
-    neon_store_reg64(rd, a->vd + 1);
+    write_neon_element64(rd, a->vd, 1, MO_64);
 
     tcg_temp_free_i64(rd);
     tcg_temp_free_i32(rm0);
@@ -3847,10 +3847,10 @@ static bool trans_VSWP(DisasContext *s, arg_2misc *a)
     rm = tcg_temp_new_i64();
     rd = tcg_temp_new_i64();
     for (pass = 0; pass < (a->q ? 2 : 1); pass++) {
-        neon_load_reg64(rm, a->vm + pass);
-        neon_load_reg64(rd, a->vd + pass);
-        neon_store_reg64(rm, a->vd + pass);
-        neon_store_reg64(rd, a->vm + pass);
+        read_neon_element64(rm, a->vm, pass, MO_64);
+        read_neon_element64(rd, a->vd, pass, MO_64);
+        write_neon_element64(rm, a->vd, pass, MO_64);
+        write_neon_element64(rd, a->vm, pass, MO_64);
     }
     tcg_temp_free_i64(rm);
     tcg_temp_free_i64(rd);
-- 
2.20.1


