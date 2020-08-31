Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A047C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6ED52073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E449g7d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ED52073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmWw-00055D-9X
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKf-00051U-Vu
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:38709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKd-00062d-Eh
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:57 -0400
Received: by mail-pl1-x630.google.com with SMTP id t11so3246329plr.5
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VmZy4CC4Agx9NCtoKuwwK/fciLRRLjW+EqgcQ2NqDr4=;
 b=E449g7d+r8CF+mQmmHyn7Y4ZDSyA8MnTGStnXPxlv5Hahzld2awxCU40EQpMQqwLJ+
 Jtwe9F/bpWc2L/4ZBQHBeplnNG8lsvfXJh6liRcXqwhABrFGLszDKqgL9XnKporMSWqB
 kBHBGV4RsA8bIx+77+Y+JOQt2Vgd3S89oMjq56qZ/QKcXjTUkFk4dJNthrFzh4lPqPFp
 BCK/n8KTX2IUA3ypbv8NR37fAlUJJ21mollhKHdGdd0R2xqX55pbslRMGUUSg9fOB7vZ
 oOXmwZPu+wNEFJOGVASqJ2NUc0AkzXWNhMskSvxForzlNdQCEqHs4hhM5vbcvD2TDkBy
 AApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VmZy4CC4Agx9NCtoKuwwK/fciLRRLjW+EqgcQ2NqDr4=;
 b=a2n1C9B7qGixk9ruk/wFsaR8sZ1gDS2wOSqzilnpkE5EKqhrYcRHoqDwnTfnZclFdH
 KgwCOaY/v7X61zx6+fJPJZv7STret3uDrarH6zfpQje30h37QMpEVR6xr9FUb2znJTsN
 CbyXYusFqQRzFqDAIP5la6vvE+WtI5S/IZV6qO8lQRrFaQG0OFnuv4b88ybDfJqyI+3g
 Yr/4sMTlBksyfiUUiM0kQDdqCgxEQJZugvwj/6Sn1oMW09Z7Z2tZOGMYd3VZHL5yhw4/
 5o9FOyg6pGor7YiMev7h0pXqGMs3hTKzKaas/e6kh5ldivCtKSO8cOB/0gAuo06kUiSF
 gLbg==
X-Gm-Message-State: AOAM5325e5vAXfARHUYEhmp6Vtz2p91vN8Qutg9VXKGsTyaHh4ZRBVxz
 GL1BoL56v8LM9SmxN1JvfB9ALlBeQDET7A==
X-Google-Smtp-Source: ABdhPJyZ5SKXLChMHyzFRmGkbgloul+tAhv79ntdLjMKkeaRDc257eWMtsrT+hf4RP0c3kaz9Mq7MQ==
X-Received: by 2002:a17:90a:9307:: with SMTP id p7mr71088pjo.105.1598890013296; 
 Mon, 31 Aug 2020 09:06:53 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/76] target/microblaze: Convert dec_add to decodetree
Date: Mon, 31 Aug 2020 09:05:21 -0700
Message-Id: <20200831160601.833692-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds infrastrucure for translation of instructions, which could
not be added before their first use.  Cache a temporary which
represents r0 as the immediate 0 value, or a sink.

Move the special case of opcode_0_illegal from old_decode()
into decodetree as well, lest this get interpreted as add.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  24 ++++
 target/microblaze/translate.c  | 197 ++++++++++++++++++++++++++-------
 2 files changed, 178 insertions(+), 43 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 1ed9ca0731..5f289a446c 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -16,3 +16,27 @@
 # You should have received a copy of the GNU Lesser General Public
 # License along with this library; if not, see <http://www.gnu.org/licenses/>.
 #
+
+&typea          rd ra rb
+&typeb          rd ra imm
+
+# Include any IMM prefix in the value reported.
+%extimm         0:s16 !function=typeb_imm
+
+@typea          ...... rd:5 ra:5 rb:5 ... .... ....     &typea
+@typeb          ...... rd:5 ra:5 ................       &typeb imm=%extimm
+
+###
+
+{
+  zero          000000 00000 00000 00000 000 0000 0000
+  add           000000 ..... ..... ..... 000 0000 0000  @typea
+}
+addc            000010 ..... ..... ..... 000 0000 0000  @typea
+addk            000100 ..... ..... ..... 000 0000 0000  @typea
+addkc           000110 ..... ..... ..... 000 0000 0000  @typea
+
+addi            001000 ..... ..... ................     @typeb
+addic           001010 ..... ..... ................     @typeb
+addik           001100 ..... ..... ................     @typeb
+addikc          001110 ..... ..... ................     @typeb
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index e624093745..de822bd7b7 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -58,6 +58,9 @@ typedef struct DisasContext {
     DisasContextBase base;
     MicroBlazeCPU *cpu;
 
+    TCGv_i32 r0;
+    bool r0_set;
+
     /* Decoder.  */
     int type_b;
     uint32_t ir;
@@ -81,6 +84,14 @@ typedef struct DisasContext {
     int abort_at_next_insn;
 } DisasContext;
 
+static int typeb_imm(DisasContext *dc, int x)
+{
+    if (dc->tb_flags & IMM_FLAG) {
+        return deposit32(dc->ext_imm, 0, 16, x);
+    }
+    return x;
+}
+
 /* Include the auto-generated decoder.  */
 #include "decode-insns.c.inc"
 
@@ -176,11 +187,7 @@ static bool trap_userspace(DisasContext *dc, bool cond)
 static int32_t dec_alu_typeb_imm(DisasContext *dc)
 {
     tcg_debug_assert(dc->type_b);
-    if (dc->tb_flags & IMM_FLAG) {
-        return dc->ext_imm | dc->imm;
-    } else {
-        return (int16_t)dc->imm;
-    }
+    return typeb_imm(dc, (int16_t)dc->imm);
 }
 
 static inline TCGv_i32 *dec_alu_op_b(DisasContext *dc)
@@ -192,44 +199,146 @@ static inline TCGv_i32 *dec_alu_op_b(DisasContext *dc)
     return &cpu_R[dc->rb];
 }
 
-static void dec_add(DisasContext *dc)
+static TCGv_i32 reg_for_read(DisasContext *dc, int reg)
 {
-    unsigned int k, c;
-    TCGv_i32 cf;
-
-    k = dc->opcode & 4;
-    c = dc->opcode & 2;
-
-    /* Take care of the easy cases first.  */
-    if (k) {
-        /* k - keep carry, no need to update MSR.  */
-        /* If rd == r0, it's a nop.  */
-        if (dc->rd) {
-            tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-
-            if (c) {
-                /* c - Add carry into the result.  */
-                tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cpu_msr_c);
-            }
+    if (likely(reg != 0)) {
+        return cpu_R[reg];
+    }
+    if (!dc->r0_set) {
+        if (dc->r0 == NULL) {
+            dc->r0 = tcg_temp_new_i32();
         }
-        return;
+        tcg_gen_movi_i32(dc->r0, 0);
+        dc->r0_set = true;
+    }
+    return dc->r0;
+}
+
+static TCGv_i32 reg_for_write(DisasContext *dc, int reg)
+{
+    if (likely(reg != 0)) {
+        return cpu_R[reg];
+    }
+    if (dc->r0 == NULL) {
+        dc->r0 = tcg_temp_new_i32();
+    }
+    return dc->r0;
+}
+
+static bool do_typea(DisasContext *dc, arg_typea *arg, bool side_effects,
+                     void (*fn)(TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 rd, ra, rb;
+
+    if (arg->rd == 0 && !side_effects) {
+        return true;
     }
 
-    /* From now on, we can assume k is zero.  So we need to update MSR.  */
-    /* Extract carry.  */
-    cf = tcg_temp_new_i32();
-    if (c) {
-        tcg_gen_mov_i32(cf, cpu_msr_c);
-    } else {
-        tcg_gen_movi_i32(cf, 0);
+    rd = reg_for_write(dc, arg->rd);
+    ra = reg_for_read(dc, arg->ra);
+    rb = reg_for_read(dc, arg->rb);
+    fn(rd, ra, rb);
+    return true;
+}
+
+static bool do_typeb_imm(DisasContext *dc, arg_typeb *arg, bool side_effects,
+                         void (*fni)(TCGv_i32, TCGv_i32, int32_t))
+{
+    TCGv_i32 rd, ra;
+
+    if (arg->rd == 0 && !side_effects) {
+        return true;
     }
 
-    gen_helper_carry(cpu_msr_c, cpu_R[dc->ra], *(dec_alu_op_b(dc)), cf);
-    if (dc->rd) {
-        tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-        tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cf);
+    rd = reg_for_write(dc, arg->rd);
+    ra = reg_for_read(dc, arg->ra);
+    fni(rd, ra, arg->imm);
+    return true;
+}
+
+static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
+                         void (*fn)(TCGv_i32, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 rd, ra, imm;
+
+    if (arg->rd == 0 && !side_effects) {
+        return true;
     }
-    tcg_temp_free_i32(cf);
+
+    rd = reg_for_write(dc, arg->rd);
+    ra = reg_for_read(dc, arg->ra);
+    imm = tcg_const_i32(arg->imm);
+
+    fn(rd, ra, imm);
+
+    tcg_temp_free_i32(imm);
+    return true;
+}
+
+#define DO_TYPEA(NAME, SE, FN) \
+    static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
+    { return do_typea(dc, a, SE, FN); }
+
+#define DO_TYPEBI(NAME, SE, FNI) \
+    static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
+    { return do_typeb_imm(dc, a, SE, FNI); }
+
+#define DO_TYPEBV(NAME, SE, FN) \
+    static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
+    { return do_typeb_val(dc, a, SE, FN); }
+
+/* No input carry, but output carry. */
+static void gen_add(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 zero = tcg_const_i32(0);
+
+    tcg_gen_add2_i32(out, cpu_msr_c, ina, zero, inb, zero);
+
+    tcg_temp_free_i32(zero);
+}
+
+/* Input and output carry. */
+static void gen_addc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_add2_i32(tmp, cpu_msr_c, ina, zero, cpu_msr_c, zero);
+    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
+
+    tcg_temp_free_i32(tmp);
+    tcg_temp_free_i32(zero);
+}
+
+/* Input carry, but no output carry. */
+static void gen_addkc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    tcg_gen_add_i32(out, ina, inb);
+    tcg_gen_add_i32(out, out, cpu_msr_c);
+}
+
+DO_TYPEA(add, true, gen_add)
+DO_TYPEA(addc, true, gen_addc)
+DO_TYPEA(addk, false, tcg_gen_add_i32)
+DO_TYPEA(addkc, true, gen_addkc)
+
+DO_TYPEBV(addi, true, gen_add)
+DO_TYPEBV(addic, true, gen_addc)
+DO_TYPEBI(addik, false, tcg_gen_addi_i32)
+DO_TYPEBV(addikc, true, gen_addkc)
+
+static bool trans_zero(DisasContext *dc, arg_zero *arg)
+{
+    /* If opcode_0_illegal, trap.  */
+    if (dc->cpu->cfg.opcode_0_illegal) {
+        trap_illegal(dc, true);
+        return true;
+    }
+    /*
+     * Otherwise, this is "add r0, r0, r0".
+     * Continue to trans_add so that MSR[C] gets cleared.
+     */
+    return false;
 }
 
 static void dec_sub(DisasContext *dc)
@@ -1488,7 +1597,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_ADD, dec_add},
     {DEC_SUB, dec_sub},
     {DEC_AND, dec_and},
     {DEC_XOR, dec_xor},
@@ -1515,12 +1623,6 @@ static void old_decode(DisasContext *dc, uint32_t ir)
 
     dc->ir = ir;
 
-    if (ir == 0) {
-        trap_illegal(dc, dc->cpu->cfg.opcode_0_illegal);
-        /* Don't decode nop/zero instructions any further.  */
-        return;
-    }
-
     /* bit 2 seems to indicate insn type.  */
     dc->type_b = ir & (1 << 29);
 
@@ -1552,6 +1654,8 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     dc->cpustate_changed = 0;
     dc->abort_at_next_insn = 0;
     dc->ext_imm = dc->base.tb->cs_base;
+    dc->r0 = NULL;
+    dc->r0_set = false;
 
     bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
     dc->base.max_insns = MIN(dc->base.max_insns, bound);
@@ -1600,6 +1704,13 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
     if (!decode(dc, ir)) {
         old_decode(dc, ir);
     }
+
+    if (dc->r0) {
+        tcg_temp_free_i32(dc->r0);
+        dc->r0 = NULL;
+        dc->r0_set = false;
+    }
+
     if (dc->clear_imm && (dc->tb_flags & IMM_FLAG)) {
         dc->tb_flags &= ~IMM_FLAG;
         tcg_gen_discard_i32(cpu_imm);
-- 
2.25.1


