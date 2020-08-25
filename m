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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F18C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4A9206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wbt2pVqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4A9206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgXe-0001RJ-IN
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4a-0000mR-EL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:40 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4S-00024w-A9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:40 -0400
Received: by mail-pg1-x541.google.com with SMTP id o5so7681091pgb.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Om47t/eP4gknkyo+HoA7eqvwr7+ry/2ZpY7FF2j9M9k=;
 b=wbt2pVqfzcx/yEJcPfUr7wXoUuRwRp65tJVp3Bh5YpOzdox+btB1XquC3/EvxOwlDX
 NR6Nia4p0VVUh7kqAkEBOyt8mS50lvx3uJUp/BNQeLVM4GD/LdyVQcfrir9InBjMBr77
 RK+s0MUFnnMzrQOK9f5kNlL/qGz+2UkaXfb6qHRvInbvxkDU3hAGumYx733y65XaXont
 l0IuDwAbCnFm6xwI9ubgjCmZ3GBEFYt0SmWOZCFE8w9YmDZZ7V6XxpXy0589hm7ra6Ab
 WHAPaMa1ZpehVIQjcbVqdbCqKd7tRiyKvmbuyJMX5CSG6CIYGSqiMzHzWr/RYIIUYcDx
 x5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Om47t/eP4gknkyo+HoA7eqvwr7+ry/2ZpY7FF2j9M9k=;
 b=HipgzBC+KkS2bf3E/yAmIv+BevX6hBv9sK6f8OcxJFPq0YyVOntcLThTPmlK5IgsjK
 eBDdFQ14uPx6D7NtyVNosvv5UDVa8hmCfCWT8VY1vOvHumEK7tDzlbIkBhxBoNSjIVGI
 HVf8I9zDomHArog9qcSZ0evptEFQn7d0AlHn+H8/g5nfzu+qR3AyEp4f/iU5sZ9xj8Ot
 N/9VxAp78pvC4+FLBCU1NcCTzoutf6B8Q0DbglsxsvGK7y9+Nb8zAH1S3TYzXFI1I7za
 t3r4qMdmwovT+kGT6w5QtpRgPsO2WyFrWAplEBVUqkmNDip3Bm4dvX0rNI0DmWvrvYLB
 /cew==
X-Gm-Message-State: AOAM532FP1zhtuLMPDh0f00rUugFF3WKzoa6feM8C2Drgf9tJ3rYH2Dl
 BVDyNt/zD4xSzf1zRO6xHZFXLYer30qxFw==
X-Google-Smtp-Source: ABdhPJyIRT+9d7HpW7VwkIYLYss18PiEGqQLj302nZZFwgTvwwaIq1e5/6FfSE4BzonYkojxmg+xzA==
X-Received: by 2002:a62:5543:: with SMTP id j64mr1768353pfb.45.1598389289343; 
 Tue, 25 Aug 2020 14:01:29 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 74/77] target/microblaze: Remove last of old decoder
Date: Tue, 25 Aug 2020 13:59:47 -0700
Message-Id: <20200825205950.730499-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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

All instructions have been convered.  Issue sigill if decodetree
does not match.  Remove argument decode from DisasContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 75 +----------------------------------
 1 file changed, 2 insertions(+), 73 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0a05b49f8e..2df22e8c2a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -65,13 +65,7 @@ typedef struct DisasContext {
     bool r0_set;
 
     /* Decoder.  */
-    int type_b;
-    uint32_t ir;
     uint32_t ext_imm;
-    uint8_t opcode;
-    uint8_t rd, ra, rb;
-    uint16_t imm;
-
     unsigned int cpustate_changed;
     unsigned int tb_flags;
     unsigned int tb_flags_to_set;
@@ -184,21 +178,6 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     return cond_user;
 }
 
-static int32_t dec_alu_typeb_imm(DisasContext *dc)
-{
-    tcg_debug_assert(dc->type_b);
-    return typeb_imm(dc, (int16_t)dc->imm);
-}
-
-static inline TCGv_i32 *dec_alu_op_b(DisasContext *dc)
-{
-    if (dc->type_b) {
-        tcg_gen_movi_i32(cpu_imm, dec_alu_typeb_imm(dc));
-        return &cpu_imm;
-    }
-    return &cpu_R[dc->rb];
-}
-
 static TCGv_i32 reg_for_read(DisasContext *dc, int reg)
 {
     if (likely(reg != 0)) {
@@ -1094,7 +1073,7 @@ static bool setup_dslot(DisasContext *dc)
     }
 
     dc->tb_flags_to_set |= D_FLAG;
-    if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
+    if (dc->tb_flags & IMM_FLAG) {
         dc->tb_flags_to_set |= BIMM_FLAG;
     }
     return false;
@@ -1576,16 +1555,6 @@ static void do_rte(DisasContext *dc)
     dc->tb_flags &= ~DRTE_FLAG;
 }
 
-static void dec_null(DisasContext *dc)
-{
-    if (trap_illegal(dc, true)) {
-        return;
-    }
-    qemu_log_mask(LOG_GUEST_ERROR, "unknown insn pc=%x opc=%x\n",
-                  (uint32_t)dc->base.pc_next, dc->opcode);
-    dc->abort_at_next_insn = 1;
-}
-
 /* Insns connected to FSL or AXI stream attached devices.  */
 static bool do_get(DisasContext *dc, int rd, int rb, int imm, int ctrl)
 {
@@ -1651,46 +1620,6 @@ static bool trans_putd(DisasContext *dc, arg_putd *arg)
     return do_put(dc, arg->ra, arg->rb, 0, arg->ctrl);
 }
 
-static struct decoder_info {
-    struct {
-        uint32_t bits;
-        uint32_t mask;
-    };
-    void (*dec)(DisasContext *dc);
-} decinfo[] = {
-    {{0, 0}, dec_null}
-};
-
-static void old_decode(DisasContext *dc, uint32_t ir)
-{
-    int i;
-
-    dc->ir = ir;
-
-    if (ir == 0) {
-        trap_illegal(dc, dc->cpu->cfg.opcode_0_illegal);
-        /* Don't decode nop/zero instructions any further.  */
-        return;
-    }
-
-    /* bit 2 seems to indicate insn type.  */
-    dc->type_b = ir & (1 << 29);
-
-    dc->opcode = EXTRACT_FIELD(ir, 26, 31);
-    dc->rd = EXTRACT_FIELD(ir, 21, 25);
-    dc->ra = EXTRACT_FIELD(ir, 16, 20);
-    dc->rb = EXTRACT_FIELD(ir, 11, 15);
-    dc->imm = EXTRACT_FIELD(ir, 0, 15);
-
-    /* Large switch for all insns.  */
-    for (i = 0; i < ARRAY_SIZE(decinfo); i++) {
-        if ((dc->opcode & decinfo[i].mask) == decinfo[i].bits) {
-            decinfo[i].dec(dc);
-            break;
-        }
-    }
-}
-
 static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
@@ -1757,7 +1686,7 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 
     ir = cpu_ldl_code(env, dc->base.pc_next);
     if (!decode(dc, ir)) {
-        old_decode(dc, ir);
+        trap_illegal(dc, true);
     }
 
     if (dc->r0) {
-- 
2.25.1


