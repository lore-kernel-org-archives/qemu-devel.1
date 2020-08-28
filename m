Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C14C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC911207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MpqZXVdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC911207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBffE-0004tS-UH
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFT-0002K1-I2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:59 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:42642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFR-0005QZ-C4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id 17so731158pfw.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y7g+vxFhMw85rMJ1Bmcl22gP9lkhC8wxslY5gGE46W4=;
 b=MpqZXVdRv1W9+xV3clZrD0rtke4Ef3DzUsgmJfpDv/+wGWwJnmzZykIODF8eVdtpyY
 nQFz6sAvea9S+KaUWaoNJu3+Ow4aQkUqDx6z7AuY8xAqhYQntNgaDe9wvzSYtPg2tvdq
 tCe0C8QS5ZKTQKvefOxZ6wsGLqpSYH+sfCDakRyODbzTMa78oc7HO5Mv5fibJAEl3WHC
 5X/4MEVfRW1nMrTjD/uHDdjGgllTHdNuQc+HI2Qyax5m6BbrX4OzKYcemahhaREylpYj
 x9oEU56sJ/H8iaQbcxCFzH/NWcV1iRV4GDgXpuZrMLPFF+oJiGADQumFcETc+xiJ6h9d
 tRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y7g+vxFhMw85rMJ1Bmcl22gP9lkhC8wxslY5gGE46W4=;
 b=N5SavT7UNtsjw/10cKLoMWkK/Mtzq3yDYkgETRBb9AT9XYNMAb8bI88mznckwncYoq
 6bpzncjM35WXrWMSa0wrKlHeKCThDrw0qbE7HUFhiy3whf5hcVNqFNRkOHdz1SOS8Ziv
 s8HE2H0D6z8u23oQjETkKdh5t6edgkrShOs6h3nSPWxiyYGPdaYW731Bxn+lW9TQTPTx
 cyZpMiC7igeR8EAgeaCo/qZSoN/ugRkWIkZlLKFqhrFfiUI9xT3GsRdnCgx/NuEdqXSC
 DuJ+DD/Axa1bfuz65dHQty6WALjKG+b+dw9llXEiqBtJKn/g2BddsCU51OVThnqUZcvP
 vLsA==
X-Gm-Message-State: AOAM531mAmNteA4P8QqhT8fC4TriGz4B+72DbfYQBmjAWFR54eQT+Ugd
 lUP27cgiemwbAbeMhtHRLp5av9tSqtTILg==
X-Google-Smtp-Source: ABdhPJz23OTls4QlXE9p421BkJ6aCRBW5411HgTqzCS260ChSYeie3eJeOvRAwR4NR4pCv4FsBrdUg==
X-Received: by 2002:a62:1b0e:: with SMTP id b14mr1494489pfb.281.1598624455699; 
 Fri, 28 Aug 2020 07:20:55 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 66/76] target/microblaze: Convert dec_br to decodetree
Date: Fri, 28 Aug 2020 07:19:19 -0700
Message-Id: <20200828141929.77854-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/microblaze/insns.decode | 14 ++++++
 target/microblaze/translate.c  | 87 +++++++++++++++++++---------------
 2 files changed, 63 insertions(+), 38 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 8eba47d90c..340dd999b6 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -68,6 +68,20 @@ andi            101001 ..... ..... ................     @typeb
 andn            100011 ..... ..... ..... 000 0000 0000  @typea
 andni           101011 ..... ..... ................     @typeb
 
+br              100110 ..... 00000 ..... 000 0000 0000  @typea_br
+bra             100110 ..... 01000 ..... 000 0000 0000  @typea_br
+brd             100110 ..... 10000 ..... 000 0000 0000  @typea_br
+brad            100110 ..... 11000 ..... 000 0000 0000  @typea_br
+brld            100110 ..... 10100 ..... 000 0000 0000  @typea_br
+brald           100110 ..... 11100 ..... 000 0000 0000  @typea_br
+
+bri             101110 ..... 00000 ................     @typeb_br
+brai            101110 ..... 01000 ................     @typeb_br
+brid            101110 ..... 10000 ................     @typeb_br
+braid           101110 ..... 11000 ................     @typeb_br
+brlid           101110 ..... 10100 ................     @typeb_br
+bralid          101110 ..... 11100 ................     @typeb_br
+
 brk             100110 ..... 01100 ..... 000 0000 0000  @typea_br
 brki            101110 ..... 01100 ................     @typeb_br
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 1545974669..5c6e6e599e 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1048,6 +1048,53 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
     return true;
 }
 
+static void setup_dslot(DisasContext *dc, bool type_b)
+{
+    dc->tb_flags_to_set |= D_FLAG;
+    if (type_b && (dc->tb_flags & IMM_FLAG)) {
+        dc->tb_flags_to_set |= BIMM_FLAG;
+    }
+}
+
+static bool do_branch(DisasContext *dc, int dest_rb, int dest_imm,
+                      bool delay, bool abs, int link)
+{
+    uint32_t add_pc;
+
+    if (delay) {
+        setup_dslot(dc, dest_rb < 0);
+    }
+
+    if (link) {
+        tcg_gen_movi_i32(cpu_R[link], dc->base.pc_next);
+    }
+
+    /* Store the branch taken destination into btarget.  */
+    add_pc = abs ? 0 : dc->base.pc_next;
+    if (dest_rb > 0) {
+        dc->jmp_dest = -1;
+        tcg_gen_addi_i32(cpu_btarget, cpu_R[dest_rb], add_pc);
+    } else {
+        dc->jmp_dest = add_pc + dest_imm;
+        tcg_gen_movi_i32(cpu_btarget, dc->jmp_dest);
+    }
+    dc->jmp_cond = TCG_COND_ALWAYS;
+    return true;
+}
+
+#define DO_BR(NAME, NAMEI, DELAY, ABS, LINK)                               \
+    static bool trans_##NAME(DisasContext *dc, arg_typea_br *arg)          \
+    { return do_branch(dc, arg->rb, 0, DELAY, ABS, LINK ? arg->rd : 0); }  \
+    static bool trans_##NAMEI(DisasContext *dc, arg_typeb_br *arg)         \
+    { return do_branch(dc, -1, arg->imm, DELAY, ABS, LINK ? arg->rd : 0); }
+
+DO_BR(br, bri, false, false, false)
+DO_BR(bra, brai, false, true, false)
+DO_BR(brd, brid, true, false, false)
+DO_BR(brad, braid, true, true, false)
+DO_BR(brld, brlid, true, false, true)
+DO_BR(brald, bralid, true, true, true)
+
 static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
 {
     if (trap_userspace(dc, true)) {
@@ -1372,14 +1419,6 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-static void dec_setup_dslot(DisasContext *dc)
-{
-    dc->tb_flags_to_set |= D_FLAG;
-    if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
-        dc->tb_flags_to_set |= BIMM_FLAG;
-    }
-}
-
 static void dec_bcc(DisasContext *dc)
 {
     static const TCGCond mb_to_tcg_cc[] = {
@@ -1398,7 +1437,7 @@ static void dec_bcc(DisasContext *dc)
     dslot = dc->ir & (1 << 25);
 
     if (dslot) {
-        dec_setup_dslot(dc);
+        setup_dslot(dc, dc->type_b);
     }
 
     dc->jmp_cond = mb_to_tcg_cc[cc];
@@ -1426,33 +1465,6 @@ static void dec_bcc(DisasContext *dc)
     tcg_temp_free_i32(next);
 }
 
-static void dec_br(DisasContext *dc)
-{
-    unsigned int dslot, link, abs;
-    uint32_t add_pc;
-
-    dslot = dc->ir & (1 << 20);
-    abs = dc->ir & (1 << 19);
-    link = dc->ir & (1 << 18);
-
-    if (dslot) {
-        dec_setup_dslot(dc);
-    }
-    if (link && dc->rd) {
-        tcg_gen_movi_i32(cpu_R[dc->rd], dc->base.pc_next);
-    }
-
-    add_pc = abs ? 0 : dc->base.pc_next;
-    if (dc->type_b) {
-        dc->jmp_dest = add_pc + dec_alu_typeb_imm(dc);
-        tcg_gen_movi_i32(cpu_btarget, dc->jmp_dest);
-    } else {
-        dc->jmp_dest = -1;
-        tcg_gen_addi_i32(cpu_btarget, cpu_R[dc->rb], add_pc);
-    }
-    dc->jmp_cond = TCG_COND_ALWAYS;
-}
-
 static inline void do_rti(DisasContext *dc)
 {
     TCGv_i32 t0, t1;
@@ -1521,7 +1533,7 @@ static void dec_rts(DisasContext *dc)
         return;
     }
 
-    dec_setup_dslot(dc);
+    setup_dslot(dc, true);
 
     if (i_bit) {
         dc->tb_flags |= DRTI_FLAG;
@@ -1583,7 +1595,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_BR, dec_br},
     {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
     {DEC_MSR, dec_msr},
-- 
2.25.1


