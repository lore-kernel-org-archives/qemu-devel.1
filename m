Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F59C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE62C20757
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7pih++M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE62C20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfXw-0006Ru-2g
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfF2-0001Mv-EB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfF0-0005Fs-AT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:32 -0400
Received: by mail-pg1-x543.google.com with SMTP id h12so524325pgm.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YIctU8hXX/5ptRAA41BRa5uos4yy4oPefDUhcGsxhrA=;
 b=o7pih++MixUC9mvbhmV4+J2X6pzyBvw64k8qTK5IBfzV16h7Rww/rox1x7OVno/QT/
 7Ug9SapUGr9AFkUK2W/+pMivJPCMY2If1YA8dXZAa7Tx47G4BEu7pvxgC+4x6MlcfqYb
 XG2wEPCHMN7BHN9VNFT/E0ca7pAwy0wQXw/CF8Vc8roDcP4i/KpLW62T2K/lpP0llyqH
 3G+moeUNbGNUsgS7vgVlHlV7rzafmxoV2FBT0wC6bFZPqecFPecXPpg//2dtqcX29LHP
 K4xX8rDqXy69x1GhyBHHzEE73jTGqWcsoRia7Qz7QglTuFMR5tEJjwbNmgfxYOY0HXzh
 aliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YIctU8hXX/5ptRAA41BRa5uos4yy4oPefDUhcGsxhrA=;
 b=fqB9uPvUTLpvNU5EEPyQB+i4e7CFpvKeXZoJZ35uXkxP9gNf1UeQi98AVSPmghP6lZ
 fGayGo/oFw/i93HxYgVy6J40Bu+Hm+XtHIlMIYdeEMlBbTkXjfaTxGO64vEDrM/DClXn
 J1nA0EJ3WIdB2qxw/B0FTauUEdyJ0Yb4nhVo40610BuGpOl4u5bSmO2mhiJRyDauOC3S
 6kvhpbOvOcDHxfkmDYWa/lKdSaL4V4AZU/syntBGouyDpA9CC+hFVnSjyhMyG1eWezom
 zydqTFip/RnOkO0c8hpVHIHPXx3t7PYmZNbV6ux5P46U9z77YEn1qZuMOp1ilpF7l60p
 xXog==
X-Gm-Message-State: AOAM530+2iGluruRTTRL5wfNYKUu5fc1U3nWB71/cc7qzsnjjiqRscpR
 4fjkhrua3hmE2MTuawomVKB5zWSLxhDipA==
X-Google-Smtp-Source: ABdhPJymjRbBor4vpD1/rrkURgSAsVyiXld2SMluDKXep88qYVzdtz5IZhuO/GoFUaryZdyH6scNCg==
X-Received: by 2002:a65:58c9:: with SMTP id e9mr1431858pgu.66.1598624428466;
 Fri, 28 Aug 2020 07:20:28 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 45/76] target/microblaze: Convert dec_barrel to decodetree
Date: Fri, 28 Aug 2020 07:18:58 -0700
Message-Id: <20200828141929.77854-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  20 ++++++
 target/microblaze/translate.c  | 125 +++++++++++++++++----------------
 2 files changed, 86 insertions(+), 59 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index d265e36044..4644defbfe 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -30,6 +30,15 @@
 # Officially typea, but with rb==0, which is not used.
 @typea0         ...... rd:5 ra:5 ................       &typea0
 
+# Officially typeb, but any immediate extension is unused.
+@typeb_bs       ...... rd:5 ra:5 ..... ...... imm:5     &typeb
+
+# For convenience, extract the two imm_w/imm_s fields, then pack
+# them back together as "imm".  Doing this makes it easiest to
+# match the required zero at bit 5.
+%ieimm          6:5 0:5
+@typeb_ie       ...... rd:5 ra:5 ..... ..... . .....    &typeb imm=%ieimm
+
 ###
 
 {
@@ -51,6 +60,17 @@ andi            101001 ..... ..... ................     @typeb
 andn            100011 ..... ..... ..... 000 0000 0000  @typea
 andni           101011 ..... ..... ................     @typeb
 
+bsrl            010001 ..... ..... ..... 000 0000 0000  @typea
+bsra            010001 ..... ..... ..... 010 0000 0000  @typea
+bsll            010001 ..... ..... ..... 100 0000 0000  @typea
+
+bsrli           011001 ..... ..... 00000 000000 .....   @typeb_bs
+bsrai           011001 ..... ..... 00000 010000 .....   @typeb_bs
+bslli           011001 ..... ..... 00000 100000 .....   @typeb_bs
+
+bsefi           011001 ..... ..... 01000 .....0 .....   @typeb_ie
+bsifi           011001 ..... ..... 10000 .....0 .....   @typeb_ie
+
 clz             100100 ..... ..... 00000 000 1110 0000  @typea0
 
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 2d57f76548..964525f75e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -368,6 +368,72 @@ DO_TYPEBI(andi, false, tcg_gen_andi_i32)
 DO_TYPEA(andn, false, tcg_gen_andc_i32)
 DO_TYPEBI(andni, false, gen_andni)
 
+static void gen_bsra(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_andi_i32(tmp, inb, 31);
+    tcg_gen_sar_i32(out, ina, tmp);
+    tcg_temp_free_i32(tmp);
+}
+
+static void gen_bsrl(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_andi_i32(tmp, inb, 31);
+    tcg_gen_shr_i32(out, ina, tmp);
+    tcg_temp_free_i32(tmp);
+}
+
+static void gen_bsll(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_andi_i32(tmp, inb, 31);
+    tcg_gen_shl_i32(out, ina, tmp);
+    tcg_temp_free_i32(tmp);
+}
+
+static void gen_bsefi(TCGv_i32 out, TCGv_i32 ina, int32_t imm)
+{
+    /* Note that decodetree has extracted and reassembled imm_w/imm_s. */
+    int imm_w = extract32(imm, 5, 5);
+    int imm_s = extract32(imm, 0, 5);
+
+    if (imm_w + imm_s > 32 || imm_w == 0) {
+        /* These inputs have an undefined behavior.  */
+        qemu_log_mask(LOG_GUEST_ERROR, "bsefi: Bad input w=%d s=%d\n",
+                      imm_w, imm_s);
+    } else {
+        tcg_gen_extract_i32(out, ina, imm_s, imm_w);
+    }
+}
+
+static void gen_bsifi(TCGv_i32 out, TCGv_i32 ina, int32_t imm)
+{
+    /* Note that decodetree has extracted and reassembled imm_w/imm_s. */
+    int imm_w = extract32(imm, 5, 5);
+    int imm_s = extract32(imm, 0, 5);
+    int width = imm_w - imm_s + 1;
+
+    if (imm_w < imm_s) {
+        /* These inputs have an undefined behavior.  */
+        qemu_log_mask(LOG_GUEST_ERROR, "bsifi: Bad input w=%d s=%d\n",
+                      imm_w, imm_s);
+    } else {
+        tcg_gen_deposit_i32(out, out, ina, imm_s, width);
+    }
+}
+
+DO_TYPEA_CFG(bsra, use_barrel, false, gen_bsra)
+DO_TYPEA_CFG(bsrl, use_barrel, false, gen_bsrl)
+DO_TYPEA_CFG(bsll, use_barrel, false, gen_bsll)
+
+DO_TYPEBI_CFG(bsrai, use_barrel, false, tcg_gen_sari_i32)
+DO_TYPEBI_CFG(bsrli, use_barrel, false, tcg_gen_shri_i32)
+DO_TYPEBI_CFG(bslli, use_barrel, false, tcg_gen_shli_i32)
+
+DO_TYPEBI_CFG(bsefi, use_barrel, false, gen_bsefi)
+DO_TYPEBI_CFG(bsifi, use_barrel, false, gen_bsifi)
+
 static void gen_clz(TCGv_i32 out, TCGv_i32 ina)
 {
     tcg_gen_clzi_i32(out, ina, 32);
@@ -771,64 +837,6 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-static void dec_barrel(DisasContext *dc)
-{
-    TCGv_i32 t0;
-    unsigned int imm_w, imm_s;
-    bool s, t, e = false, i = false;
-
-    if (trap_illegal(dc, !dc->cpu->cfg.use_barrel)) {
-        return;
-    }
-
-    if (dc->type_b) {
-        /* Insert and extract are only available in immediate mode.  */
-        i = extract32(dc->imm, 15, 1);
-        e = extract32(dc->imm, 14, 1);
-    }
-    s = extract32(dc->imm, 10, 1);
-    t = extract32(dc->imm, 9, 1);
-    imm_w = extract32(dc->imm, 6, 5);
-    imm_s = extract32(dc->imm, 0, 5);
-
-    if (e) {
-        if (imm_w + imm_s > 32 || imm_w == 0) {
-            /* These inputs have an undefined behavior.  */
-            qemu_log_mask(LOG_GUEST_ERROR, "bsefi: Bad input w=%d s=%d\n",
-                          imm_w, imm_s);
-        } else {
-            tcg_gen_extract_i32(cpu_R[dc->rd], cpu_R[dc->ra], imm_s, imm_w);
-        }
-    } else if (i) {
-        int width = imm_w - imm_s + 1;
-
-        if (imm_w < imm_s) {
-            /* These inputs have an undefined behavior.  */
-            qemu_log_mask(LOG_GUEST_ERROR, "bsifi: Bad input w=%d s=%d\n",
-                          imm_w, imm_s);
-        } else {
-            tcg_gen_deposit_i32(cpu_R[dc->rd], cpu_R[dc->rd], cpu_R[dc->ra],
-                                imm_s, width);
-        }
-    } else {
-        t0 = tcg_temp_new_i32();
-
-        tcg_gen_mov_i32(t0, *(dec_alu_op_b(dc)));
-        tcg_gen_andi_i32(t0, t0, 31);
-
-        if (s) {
-            tcg_gen_shl_i32(cpu_R[dc->rd], cpu_R[dc->ra], t0);
-        } else {
-            if (t) {
-                tcg_gen_sar_i32(cpu_R[dc->rd], cpu_R[dc->ra], t0);
-            } else {
-                tcg_gen_shr_i32(cpu_R[dc->rd], cpu_R[dc->ra], t0);
-            }
-        }
-        tcg_temp_free_i32(t0);
-    }
-}
-
 static inline void sync_jmpstate(DisasContext *dc)
 {
     if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
@@ -1551,7 +1559,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_BARREL, dec_barrel},
     {DEC_LD, dec_load},
     {DEC_ST, dec_store},
     {DEC_IMM, dec_imm},
-- 
2.25.1


