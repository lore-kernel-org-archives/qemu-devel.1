Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0A9C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B830F218B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBfq2eFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B830F218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4OM-0000Qc-Ih
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57605)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mq-0002lQ-VX
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mo-0007tj-22
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:55 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:42696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mn-0007kv-Kp
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:53 -0400
Received: by mail-pl1-x629.google.com with SMTP id ay6so25055652plb.9
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GoQmT1N8IU0T5z5+kFmORBhM2hYdVyMn2yGubYbJrVU=;
 b=GBfq2eFV1G5lsZB/WX3pGNcloK6upS0papCHl/UXrwsYp5VXqeYW+fLFC8i1eTjELU
 78mEuOAAPL62ASIEUm7glkaNSqiIwf3v+hfKZozFCTGrapHYABQoTawYkcyIc2ELBzOK
 SDon1V+FkCkxbhdQUBR62bfEnK4o47FvBHI/jb5SNAvH9sEwEbh7+tU80Hqx0zoaIqCp
 zAGCM0GktRXRroLWSimtWX8meuOOc44a1reUuCXyhavWA9FvSyXUXywRTpR9oT8mCQrI
 pMkFFbdwSZUvOlq9kGujkuPpQPT43/HIdDiqOdWwidXFN7pmCdDdtU6TVjdDnajrMchR
 lOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GoQmT1N8IU0T5z5+kFmORBhM2hYdVyMn2yGubYbJrVU=;
 b=DBbBlXkW+B0ArNuRNY0zoZIfk01izB44b2ngfRu3RaKDbV6t6lPGWwqIrhGTi78qUf
 /k2TMjnJo4eb6WmcitWm+itKTYYTaUAI8dtfR6UVdgSrYUGfFv2XcHJ4jdN6jbQXXXjW
 JG4bdEhmmZA9tutwv4EjS/bdoFWdDitvzJWfz3ac/y1Cf2qsJXT7c8Ys0Yu4coiyYEPM
 izq1LrUu6wudRa2A7NCUMvVsB0C13IdDFitSfIl1whbtMEtoyZYwa1xOPA5bvdbPV5QS
 lq/i9HyGh3ZpW2MEcnqM6/ze/57uF/pAauOJVSPjNpsb9Hh4aOlHPi34uHKXct18vmVK
 LYDA==
X-Gm-Message-State: APjAAAXqkWhY4BYDcOdzWlJ0nqWb794FMq5W99ptTQ2WxE81GM/n2q0t
 JPJPEUmsCy4u7/jAD8bFvpgtrFHYT6Q=
X-Google-Smtp-Source: APXvYqzuPxjXezwokKyoSJe/jJW6Og90+IPbgFiK3kAMhbe/BJiSJiUmJxhPHOeGx+ulUTc3iUgC0A==
X-Received: by 2002:a17:902:8ec3:: with SMTP id
 x3mr95853641plo.313.1564163450345; 
 Fri, 26 Jul 2019 10:50:50 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:39 -0700
Message-Id: <20190726175032.6769-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: [Qemu-devel] [PATCH 14/67] target/arm: Convert multiply and
 multiply accumulate
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 214 ++++++++++++++++++++++++-----------------
 target/arm/a32.decode  |  17 ++++
 target/arm/t32.decode  |  19 ++++
 3 files changed, 163 insertions(+), 87 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ee7d53dfa5..354a52d36c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7376,21 +7376,6 @@ static void gen_storeq_reg(DisasContext *s, int rlow, int rhigh, TCGv_i64 val)
     store_reg(s, rhigh, tmp);
 }
 
-/* load a 32-bit value from a register and perform a 64-bit accumulate.  */
-static void gen_addq_lo(DisasContext *s, TCGv_i64 val, int rlow)
-{
-    TCGv_i64 tmp;
-    TCGv_i32 tmp2;
-
-    /* Load value and extend to 64 bits.  */
-    tmp = tcg_temp_new_i64();
-    tmp2 = load_reg(s, rlow);
-    tcg_gen_extu_i32_i64(tmp, tmp2);
-    tcg_temp_free_i32(tmp2);
-    tcg_gen_add_i64(val, val, tmp);
-    tcg_temp_free_i64(tmp);
-}
-
 /* load and add a 64-bit value from a register pair.  */
 static void gen_addq(DisasContext *s, TCGv_i64 val, int rlow, int rhigh)
 {
@@ -8068,6 +8053,128 @@ static bool trans_ORN_rri(DisasContext *s, arg_s_rri_rot *a)
 #undef DO_ANY
 #undef DO_LOGIC
 
+/*
+ * Multiply and multiply accumulate
+ */
+
+static bool op_mla(DisasContext *s, arg_s_rrrr *a, bool add)
+{
+    TCGv_i32 t1, t2;
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    tcg_gen_mul_i32(t1, t1, t2);
+    tcg_temp_free_i32(t2);
+    if (add) {
+        t2 = load_reg(s, a->ra);
+        tcg_gen_add_i32(t1, t1, t2);
+        tcg_temp_free_i32(t2);
+    }
+    if (a->s) {
+        gen_logic_CC(t1);
+    }
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+static bool trans_MUL(DisasContext *s, arg_MUL *a)
+{
+    return op_mla(s, a, false);
+}
+
+static bool trans_MLA(DisasContext *s, arg_MLA *a)
+{
+    return op_mla(s, a, true);
+}
+
+static bool trans_MLS(DisasContext *s, arg_MLS *a)
+{
+    TCGv_i32 t1, t2;
+
+    t1 = load_reg(s, a->rn);
+    t2 = load_reg(s, a->rm);
+    tcg_gen_mul_i32(t1, t1, t2);
+    tcg_temp_free_i32(t2);
+    t2 = load_reg(s, a->ra);
+    tcg_gen_sub_i32(t1, t2, t1);
+    tcg_temp_free_i32(t2);
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+static bool op_mlal(DisasContext *s, arg_s_rrrr *a, bool uns, bool add)
+{
+    TCGv_i32 t0, t1, t2, t3;
+
+    t0 = load_reg(s, a->rm);
+    t1 = load_reg(s, a->rn);
+    if (uns) {
+        tcg_gen_mulu2_i32(t0, t1, t0, t1);
+    } else {
+        tcg_gen_muls2_i32(t0, t1, t0, t1);
+    }
+    if (add) {
+        t2 = load_reg(s, a->ra);
+        t3 = load_reg(s, a->rd);
+        tcg_gen_add2_i32(t0, t1, t0, t1, t2, t3);
+        tcg_temp_free_i32(t2);
+        tcg_temp_free_i32(t3);
+    }
+    store_reg(s, a->ra, t0);
+    store_reg(s, a->rd, t1);
+    if (a->s) {
+        gen_logicq_cc(t0, t1);
+    }
+    return true;
+}
+
+static bool trans_UMULL(DisasContext *s, arg_UMULL *a)
+{
+    return op_mlal(s, a, true, false);
+}
+
+static bool trans_SMULL(DisasContext *s, arg_SMULL *a)
+{
+    return op_mlal(s, a, false, false);
+}
+
+static bool trans_UMLAL(DisasContext *s, arg_UMLAL *a)
+{
+    return op_mlal(s, a, true, true);
+}
+
+static bool trans_SMLAL(DisasContext *s, arg_SMLAL *a)
+{
+    return op_mlal(s, a, false, true);
+}
+
+static bool trans_UMAAL(DisasContext *s, arg_UMAAL *a)
+{
+    TCGv_i32 t0, t1, t2, zero;
+
+    if (s->thumb
+        ? !arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)
+        : !ENABLE_ARCH_6) {
+        return false;
+    }
+
+    t0 = load_reg(s, a->rm);
+    t1 = load_reg(s, a->rn);
+    tcg_gen_mulu2_i32(t0, t1, t0, t1);
+    zero = tcg_const_i32(0);
+    t2 = load_reg(s, a->ra);
+    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
+    tcg_temp_free_i32(t2);
+    t2 = load_reg(s, a->rd);
+    tcg_gen_add2_i32(t0, t1, t0, t1, t2, zero);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(zero);
+    store_reg(s, a->ra, t0);
+    store_reg(s, a->rd, t1);
+    return true;
+}
+
+
 /*
  * Legacy decoder.
  */
@@ -8612,71 +8719,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             sh = (insn >> 5) & 3;
             if (sh == 0) {
                 if (op1 == 0x0) {
-                    rd = (insn >> 16) & 0xf;
-                    rn = (insn >> 12) & 0xf;
-                    rs = (insn >> 8) & 0xf;
-                    rm = (insn) & 0xf;
-                    op1 = (insn >> 20) & 0xf;
-                    switch (op1) {
-                    case 0: case 1: case 2: case 3: case 6:
-                        /* 32 bit mul */
-                        tmp = load_reg(s, rs);
-                        tmp2 = load_reg(s, rm);
-                        tcg_gen_mul_i32(tmp, tmp, tmp2);
-                        tcg_temp_free_i32(tmp2);
-                        if (insn & (1 << 22)) {
-                            /* Subtract (mls) */
-                            ARCH(6T2);
-                            tmp2 = load_reg(s, rn);
-                            tcg_gen_sub_i32(tmp, tmp2, tmp);
-                            tcg_temp_free_i32(tmp2);
-                        } else if (insn & (1 << 21)) {
-                            /* Add */
-                            tmp2 = load_reg(s, rn);
-                            tcg_gen_add_i32(tmp, tmp, tmp2);
-                            tcg_temp_free_i32(tmp2);
-                        }
-                        if (insn & (1 << 20))
-                            gen_logic_CC(tmp);
-                        store_reg(s, rd, tmp);
-                        break;
-                    case 4:
-                        /* 64 bit mul double accumulate (UMAAL) */
-                        ARCH(6);
-                        tmp = load_reg(s, rs);
-                        tmp2 = load_reg(s, rm);
-                        tmp64 = gen_mulu_i64_i32(tmp, tmp2);
-                        gen_addq_lo(s, tmp64, rn);
-                        gen_addq_lo(s, tmp64, rd);
-                        gen_storeq_reg(s, rn, rd, tmp64);
-                        tcg_temp_free_i64(tmp64);
-                        break;
-                    case 8: case 9: case 10: case 11:
-                    case 12: case 13: case 14: case 15:
-                        /* 64 bit mul: UMULL, UMLAL, SMULL, SMLAL. */
-                        tmp = load_reg(s, rs);
-                        tmp2 = load_reg(s, rm);
-                        if (insn & (1 << 22)) {
-                            tcg_gen_muls2_i32(tmp, tmp2, tmp, tmp2);
-                        } else {
-                            tcg_gen_mulu2_i32(tmp, tmp2, tmp, tmp2);
-                        }
-                        if (insn & (1 << 21)) { /* mult accumulate */
-                            TCGv_i32 al = load_reg(s, rn);
-                            TCGv_i32 ah = load_reg(s, rd);
-                            tcg_gen_add2_i32(tmp, tmp2, tmp, tmp2, al, ah);
-                            tcg_temp_free_i32(al);
-                            tcg_temp_free_i32(ah);
-                        }
-                        if (insn & (1 << 20)) {
-                            gen_logicq_cc(tmp, tmp2);
-                        }
-                        store_reg(s, rn, tmp);
-                        store_reg(s, rd, tmp2);
-                        break;
-                    default:
-                        goto illegal_op;
-                    }
+                    /* Multiply and multiply accumulate.  */
+                    /* All done in decodetree.  Reach here for illegal ops.  */
+                    goto illegal_op;
                 } else {
                     rn = (insn >> 16) & 0xf;
                     rd = (insn >> 12) & 0xf;
@@ -10292,13 +10337,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                     }
                 }
                 if (op & 4) {
-                    /* umaal */
-                    if (!arm_dc_feature(s, ARM_FEATURE_THUMB_DSP)) {
-                        tcg_temp_free_i64(tmp64);
-                        goto illegal_op;
-                    }
-                    gen_addq_lo(s, tmp64, rs);
-                    gen_addq_lo(s, tmp64, rd);
+                    /* umaal, in decodetree */
+                    goto illegal_op;
                 } else if (op & 0x40) {
                     /* 64-bit accumulate.  */
                     gen_addq(s, tmp64, rs, rd);
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index 1db621576f..71846b79fd 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -25,6 +25,8 @@
 &s_rrr_shi       s rd rn rm shim shty
 &s_rrr_shr       s rn rd rm rs shty
 &s_rri_rot       s rn rd imm rot
+&s_rrrr          s rd rn rm ra
+&rrrr            rd rn rm ra
 
 # Data-processing (register)
 
@@ -105,3 +107,18 @@ ORR_rri          .... 001 1100 . .... .... ............       @s_rri_rot
 MOV_rri          .... 001 1101 . 0000 .... ............       @s_rxi_rot
 BIC_rri          .... 001 1110 . .... .... ............       @s_rri_rot
 MVN_rri          .... 001 1111 . 0000 .... ............       @s_rxi_rot
+
+# Multiply and multiply accumulate
+
+@s_rdamn         ---- .... ... s:1 rd:4 ra:4 rm:4 .... rn:4   &s_rrrr
+@s_rd0mn         ---- .... ... s:1 rd:4 .... rm:4 .... rn:4   &s_rrrr ra=0
+@rdamn           ---- .... ... .   rd:4 ra:4 rm:4 .... rn:4   &rrrr
+
+MUL              .... 0000 000 . .... 0000 .... 1001 ....     @s_rd0mn
+MLA              .... 0000 001 . .... .... .... 1001 ....     @s_rdamn
+UMAAL            .... 0000 010 0 .... .... .... 1001 ....     @rdamn
+MLS              .... 0000 011 0 .... .... .... 1001 ....     @rdamn
+UMULL            .... 0000 100 . .... .... .... 1001 ....     @s_rdamn
+UMLAL            .... 0000 101 . .... .... .... 1001 ....     @s_rdamn
+SMULL            .... 0000 110 . .... .... .... 1001 ....     @s_rdamn
+SMLAL            .... 0000 111 . .... .... .... 1001 ....     @s_rdamn
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 7bfd8ee854..8e301ed2a1 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -22,6 +22,8 @@
 &s_rrr_shi       !extern s rd rn rm shim shty
 &s_rrr_shr       !extern s rn rd rm rs shty
 &s_rri_rot       !extern s rn rd imm rot
+&s_rrrr          !extern s rd rn rm ra
+&rrrr            !extern rd rn rm ra
 
 # Data-processing (register-shifted register)
 
@@ -109,3 +111,20 @@ SBC_rri          1111 0.0 1011 . .... 0 ... .... ........     @s_rri_rot
   SUB_rri        1111 0.0 1101 . .... 0 ... .... ........     @s_rri_rot
 }
 RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
+
+# Multiply and multiply accumulate
+
+@s0_rnadm        .... .... .... rn:4 ra:4 rd:4 .... rm:4      &s_rrrr s=0
+@s0_rn0dm        .... .... .... rn:4 .... rd:4 .... rm:4      &s_rrrr ra=0 s=0
+@rnadm           .... .... .... rn:4 ra:4 rd:4 .... rm:4      &rrrr
+
+{
+  MUL            1111 1011 0000 .... 1111 .... 0000 ....      @s0_rn0dm
+  MLA            1111 1011 0000 .... .... .... 0000 ....      @s0_rnadm
+}
+MLS              1111 1011 0000 .... .... .... 0001 ....      @rnadm
+SMULL            1111 1011 1000 .... .... .... 0000 ....      @s0_rnadm
+UMULL            1111 1011 1010 .... .... .... 0000 ....      @s0_rnadm
+SMLAL            1111 1011 1100 .... .... .... 0000 ....      @s0_rnadm
+UMLAL            1111 1011 1110 .... .... .... 0000 ....      @s0_rnadm
+UMAAL            1111 1011 1110 .... .... .... 0110 ....      @rnadm
-- 
2.17.1


