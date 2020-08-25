Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55612C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:47:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B102071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zu1rPsZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B102071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgmY-0001TI-5x
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4K-0000d6-JX
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:24 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4I-00022n-8y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:24 -0400
Received: by mail-pf1-x442.google.com with SMTP id k18so8291662pfp.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U/xg7pKRu/7l+32EdVsp/pmb28o9isw6bULWSNvN3q8=;
 b=zu1rPsZahCWj6U+5r+ChwJOfXGAuSalR2CrhBLfYgSh2k0/4D2kaCTwEmeOLynl26r
 Ix68mMc+H7B0Guu+wp8Z4W5fsI0QhfYGSp+eavVSlqYzxvRZFymK0HPnrGpzeyC1iEG/
 xTt+tnU1FGMUbmbx8i5p0mSwkfBES/43c/6jy83J+PwO0IiBrHxCx95p8Oc822FZJlEn
 /kTbwQgnq2QqDgllCjOTTBlMN8Hox4zXiG1mlgo4u3xErWCgHNpBzLRWhW/Q6PMp9wed
 zKqTE0NcY8MsU3vqZcWI8icvQsjnOmH7DENdhOuXEi4YhX/CZ/yxBJvBjQ0ioUxxD3Mc
 t++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U/xg7pKRu/7l+32EdVsp/pmb28o9isw6bULWSNvN3q8=;
 b=c096Z1v+Bs3f9XXe8K2xwGqGDSO+BROBJ6PnfcNWJCZ7oPdOZBY/BZmFTDLxx77VBo
 NmkjBkOYcZGUmMSPvaOI7FIQCXalbwdvQY1OxHFC6uCEUGg4tS6Cdk05w5IArV0UMXR4
 H2Wma1PLkb9rNWwzBOMySxmLIFBabjq6EP5qBPReRFWly2tRxx9fywqdVT9lIVxztm31
 TzX1LfTEwWhdmFWGUYx2q6a4QrfPPjUkT+AQD6nLvF7izotiQZceIbC+NB6SlHKt0Bph
 PSeuSW6a580v68HYJIYPTYu29bM04IjwSw7g7u3bWEXzBMqLoUX7LjGXcIXcoA34zk1+
 lLlw==
X-Gm-Message-State: AOAM533qpvT3v5FFmv/VH0DdlE2Ixse4PjXdVHaQ+aAf40mItr/Lqp62
 IYiOvhd68ywyWtmjDsr64QZfv1sAm8tU7w==
X-Google-Smtp-Source: ABdhPJy4CXL8bKZA59ZiycY/1ojngCORr7geDfuGpAtUIQd33avHdrCrglt8VSBx1Mu/fGmrUoIKuw==
X-Received: by 2002:aa7:84d4:: with SMTP id x20mr9059039pfn.96.1598389280332; 
 Tue, 25 Aug 2020 14:01:20 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 67/77] target/microblaze: Convert dec_br to decodetree
Date: Tue, 25 Aug 2020 13:59:40 -0700
Message-Id: <20200825205950.730499-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode | 14 +++++
 target/microblaze/translate.c  | 98 +++++++++++++++++++---------------
 2 files changed, 68 insertions(+), 44 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 77b073be9e..94520e92dd 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -65,6 +65,20 @@ andi            101001 ..... ..... ................     @typeb
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
index 5bd771671b..73c956cd76 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1087,6 +1087,58 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
     return true;
 }
 
+static bool setup_dslot(DisasContext *dc)
+{
+    if (wait_for_next_tb(dc)) {
+        return true;
+    }
+
+    dc->tb_flags_to_set |= D_FLAG;
+    if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
+        dc->tb_flags_to_set |= BIMM_FLAG;
+    }
+    return false;
+}
+
+static bool do_branch(DisasContext *dc, int dest_rb, int dest_imm,
+                      bool delay, bool abs, int link)
+{
+    uint32_t add_pc;
+
+    if (delay && setup_dslot(dc)) {
+        return true;
+    }
+
+    if (link) {
+        tcg_gen_movi_i32(cpu_R[link], dc->base.pc_next);
+    }
+
+    /* Store the branch taken destination into btarget.  */
+    add_pc = abs ? 0 : dc->base.pc_next;
+    if (dest_rb) {
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
+    { return do_branch(dc, 0, arg->imm, DELAY, ABS, LINK ? arg->rd : 0); }
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
@@ -1393,19 +1445,6 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-static bool dec_setup_dslot(DisasContext *dc)
-{
-    if (wait_for_next_tb(dc)) {
-        return true;
-    }
-
-    dc->tb_flags_to_set |= D_FLAG;
-    if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
-        dc->tb_flags_to_set |= BIMM_FLAG;
-    }
-    return false;
-}
-
 static void dec_bcc(DisasContext *dc)
 {
     static const TCGCond mb_to_tcg_cc[] = {
@@ -1423,7 +1462,7 @@ static void dec_bcc(DisasContext *dc)
     cc = EXTRACT_FIELD(dc->ir, 21, 23);
     dslot = dc->ir & (1 << 25);
 
-    if (dslot && dec_setup_dslot(dc)) {
+    if (dslot && setup_dslot(dc)) {
         return;
     }
 
@@ -1452,34 +1491,6 @@ static void dec_bcc(DisasContext *dc)
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
-    if (dslot && dec_setup_dslot(dc)) {
-        return;
-    }
-
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
@@ -1548,7 +1559,7 @@ static void dec_rts(DisasContext *dc)
         return;
     }
 
-    if (dec_setup_dslot(dc)) {
+    if (setup_dslot(dc)) {
         return;
     }
 
@@ -1612,7 +1623,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_BR, dec_br},
     {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
     {DEC_MSR, dec_msr},
-- 
2.25.1


