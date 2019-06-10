Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1639EC43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 21:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20BF2089E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 21:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqmnhwqT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20BF2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49858 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haRym-0008Lg-VE
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 17:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59932)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1haRsX-000400-Pt
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 17:31:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1haRie-0003kh-G6
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 17:20:46 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44400)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1haRic-0003e8-IW
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 17:20:43 -0400
Received: by mail-pf1-x444.google.com with SMTP id t16so5998197pfe.11
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 14:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=3lr0o73FiESqF3ro4y65KpIp6NWMTeuZSyXbnqDnst0=;
 b=YqmnhwqTAz2nX5/SX3kcAN2HhTXp1mwhIJPS/Bf2K+VK9vmuhaEyNXW2lFTIxMiKBb
 AQRcQBfTAPkrv6AzQQnxSZAy8xRt+VGfH4zkSOrXKtCqJdU8gOVUDIs8Fj0fFBI7sgRx
 rvN7GAf5CU7FEgQq2uBJw2Ph8oLMsZ6+GvA8z8kQrvhfCsTboZJEKhwTZObOI9V/DjqQ
 j45e+tjV9dkv7b7aN7YXSGnzHs3GDJ1Nm3ZG1WMmH5xuE1Wsc4U6VIRYEGAMjnNV267D
 4fRZMmR+9mNmRcVxEE19ZXyC8DuOu4xH7w9a0wVvoA6TG4htr7EYgMOv2nz254XotOuT
 oXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=3lr0o73FiESqF3ro4y65KpIp6NWMTeuZSyXbnqDnst0=;
 b=Sj+OwU63QVc4uY0CsIuDqO2vxKDmZfhZUWX0d5k1PtOcjqarKbvOhMmqYC9qS/iUGk
 WU1DndZfQPRspEeyJu0Cj7a2f6hzz+tpaSftWC67TLcOuT8ELOPJJid1d6MhAVRRtXKm
 J59KLhtEb1yRDLP8A7xsawezokcgDyCvRdQYauayDkObNbYeDGYAluuPbmHJBrvwK+Ih
 QJuBCSA1ur6sIdL+J4MeOMBdAekqKK/3HEiXcUj4v1ow+M33kdZ7wTsPc9xq/qMEirGy
 uRhrrB/Skon30rLzpMccIR9M6n2IfZkxiwOMYE4YLhPGtBgNVZl3pUkn/5tFyCVzN/C8
 pIig==
X-Gm-Message-State: APjAAAWIqSi7oyulhFZ7V/l8t4bcoYFj0yOHVGXQm9wFRid4hzWlGSaG
 TRUfPAXNaBv8CPrtFp7hRawXdA==
X-Google-Smtp-Source: APXvYqzPOGFXw20jA5ka08O2CBQ2YubqKrE/n9umS4A00kqACVBz4vUyevsUeO5gWKLfizsJKTLoIQ==
X-Received: by 2002:a63:2cc9:: with SMTP id s192mr17062857pgs.24.1560201634555; 
 Mon, 10 Jun 2019 14:20:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id
 j7sm11347859pfa.184.2019.06.10.14.20.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 14:20:33 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190606193012.37715-1-mrolnik@gmail.com>
 <20190606193012.37715-5-mrolnik@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9c74618e-eb1e-0225-11dc-fe51e634d265@linaro.org>
Date: Mon, 10 Jun 2019 14:20:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606193012.37715-5-mrolnik@gmail.com>
Content-Type: multipart/mixed; boundary="------------EFD781CD99319222A38E45B8"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v21 4/7] target/avr: Add instruction
 translation
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------EFD781CD99319222A38E45B8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 6/6/19 12:30 PM, Michael Rolnik wrote:
> +        if (ctx.check_skip > 0) {
> +            TCGLabel *skip = gen_new_label();
> +            TCGLabel *done = gen_new_label();
> +
> +            tcg_gen_brcondi_tl(TCG_COND_NE, cpu_skip, 0, skip);
> +                translate(&ctx);
> +                tcg_gen_br(done);
> +            gen_set_label(skip);
> +                tcg_gen_movi_tl(cpu_skip, 0);
> +                tcg_gen_movi_tl(cpu_pc, ctx.npc);
> +            gen_set_label(done);
> +            ctx.check_skip--;
> +        } else {
> +            translate(&ctx);
> +        }

In future, do not indent code like this.

I had been thinking of a slightly more complex solution that does not require
every TB to begin with a conditional branch testing cpu_skip.  This also has
the property that we almost never write to cpu_skip at all -- the condition is
consumed immediately within host registers without being written back to ENV.
The only time we do write to cpu_skip is for debugging, single-stepping, or
when we are forced to break the TB for other unusual reasons.

The following implements this solution.  It's based on some other cleanups that
I have made, and commented upon here.  The full tree can be found at

  https://github.com/rth7680/qemu/commits/review/avr-21


r~

--------------EFD781CD99319222A38E45B8
Content-Type: text/x-patch;
 name="0001-fixup-target-avr-Add-instruction-translation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-fixup-target-avr-Add-instruction-translation.patch"

>From 893b021bc042c5cb5e7d9cf7d6ff3d9e2cfc25de Mon Sep 17 00:00:00 2001
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 9 Jun 2019 21:38:38 -0700
Subject: [PATCH] !fixup target/avr: Add instruction translation

Reorganize instruction skipping.

Put the known state of env->skip into TBFLAGS, which allows the
first instruction to not test cpu_skip directly.  It either knows
that we need not skip (almost always), or that we must skip (rarely).

Put the in-flight skipping state into tcg variables.  This allows
us to consume the skip state without writing it out to cpu_skip.
---
 target/avr/cpu.h       |   4 +
 target/avr/translate.c | 248 +++++++++++++++++++++++++++--------------
 2 files changed, 167 insertions(+), 85 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index a086aca30c..a0de72d75b 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -187,6 +187,7 @@ int avr_cpu_memory_rw_debug(CPUState *cs, vaddr address, uint8_t *buf,
 
 enum {
     TB_FLAGS_FULL_ACCESS = 1,
+    TB_FLAGS_SKIP = 2,
 };
 
 static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong *pc,
@@ -200,6 +201,9 @@ static inline void cpu_get_tb_cpu_state(CPUAVRState *env, target_ulong *pc,
     if (env->fullacc) {
         flags |= TB_FLAGS_FULL_ACCESS;
     }
+    if (env->skip) {
+        flags |= TB_FLAGS_SKIP;
+    }
 
     *pflags = flags;
 }
diff --git a/target/avr/translate.c b/target/avr/translate.c
index dd22abf93a..4d9e2afa26 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -78,7 +78,11 @@ struct DisasContext {
     int memidx;
     int bstate;
     int singlestep;
-    int check_skip;
+
+    TCGv skip_var0;
+    TCGv skip_var1;
+    TCGCond skip_cond;
+    bool free_skip_var0;
 };
 
 static int to_A(DisasContext *ctx, int indx) { return 16 + (indx % 16); }
@@ -583,38 +587,45 @@ static bool trans_BLD(DisasContext *ctx, arg_BLD *a)
  */
 static bool trans_BRBC(DisasContext *ctx, arg_BRBC *a)
 {
-    TCGLabel *taken = gen_new_label();
+    TCGLabel *not_taken = gen_new_label();
+    TCGCond cond = TCG_COND_EQ;
+    TCGv var;
 
     switch (a->bit) {
     case 0x00:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Cf, 0, taken);
+        var = cpu_Cf;
         break;
     case 0x01:
-        tcg_gen_brcondi_i32(TCG_COND_NE, cpu_Zf, 0, taken);
+        cond = TCG_COND_NE;
+        var = cpu_Zf;
         break;
     case 0x02:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Nf, 0, taken);
+        var = cpu_Nf;
         break;
     case 0x03:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Vf, 0, taken);
+        var = cpu_Vf;
         break;
     case 0x04:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Sf, 0, taken);
+        var = cpu_Sf;
         break;
     case 0x05:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Hf, 0, taken);
+        var = cpu_Hf;
         break;
     case 0x06:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Tf, 0, taken);
+        var = cpu_Tf;
         break;
     case 0x07:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_If, 0, taken);
+        var = cpu_If;
         break;
+    default:
+        g_assert_not_reached();
     }
 
-    gen_goto_tb(ctx, 1, ctx->npc);
-    gen_set_label(taken);
-    gen_goto_tb(ctx, 0, ctx->npc + a->imm);
+    tcg_gen_brcondi_i32(tcg_invert_cond(cond), var, 0, not_taken);
+    gen_goto_tb(ctx, 1, ctx->npc + a->imm);
+    gen_set_label(not_taken);
+
+    ctx->bstate = DISAS_CHAIN;
     return true;
 }
 
@@ -626,38 +637,45 @@ static bool trans_BRBC(DisasContext *ctx, arg_BRBC *a)
  */
 static bool trans_BRBS(DisasContext *ctx, arg_BRBS *a)
 {
-    TCGLabel *taken = gen_new_label();
+    TCGLabel *not_taken = gen_new_label();
+    TCGCond cond = TCG_COND_NE;
+    TCGv var;
 
     switch (a->bit) {
     case 0x00:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Cf, 1, taken);
+        var = cpu_Cf;
         break;
     case 0x01:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Zf, 0, taken);
+        cond = TCG_COND_EQ;
+        var = cpu_Zf;
         break;
     case 0x02:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Nf, 1, taken);
+        var = cpu_Nf;
         break;
     case 0x03:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Vf, 1, taken);
+        var = cpu_Vf;
         break;
     case 0x04:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Sf, 1, taken);
+        var = cpu_Sf;
         break;
     case 0x05:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Hf, 1, taken);
+        var = cpu_Hf;
         break;
     case 0x06:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_Tf, 1, taken);
+        var = cpu_Tf;
         break;
     case 0x07:
-        tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_If, 1, taken);
+        var = cpu_If;
         break;
+    default:
+        g_assert_not_reached();
     }
 
-    gen_goto_tb(ctx, 1, ctx->npc);
-    gen_set_label(taken);
-    gen_goto_tb(ctx, 0, ctx->npc + a->imm);
+    tcg_gen_brcondi_i32(tcg_invert_cond(cond), var, 0, not_taken);
+    gen_goto_tb(ctx, 1, ctx->npc + a->imm);
+    gen_set_label(not_taken);
+
+    ctx->bstate = DISAS_CHAIN;
     return true;
 }
 
@@ -882,13 +900,9 @@ static bool trans_CPI(DisasContext *ctx, arg_CPI *a)
  */
 static bool trans_CPSE(DisasContext *ctx, arg_CPSE *a)
 {
-    TCGv Rd = cpu_r[a->rd];
-    TCGv Rr = cpu_r[a->rr];
-
-    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_skip, Rd, Rr);
-
-    ctx->check_skip++;
-
+    ctx->skip_cond = TCG_COND_EQ;
+    ctx->skip_var0 = cpu_r[a->rd];
+    ctx->skip_var1 = cpu_r[a->rr];
     return true;
 }
 
@@ -2220,18 +2234,13 @@ static bool trans_SBI(DisasContext *ctx, arg_SBI *a)
  */
 static bool trans_SBIC(DisasContext *ctx, arg_SBIC *a)
 {
-    TCGv data = tcg_temp_new_i32();
-    TCGv port = tcg_const_i32(a->reg);
+    TCGv temp = tcg_const_i32(a->reg);
 
-    gen_helper_inb(data, cpu_env, port);
-
-    tcg_gen_andi_tl(data, data, 1 << a->bit);
-    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_skip, data, 0);
-
-    tcg_temp_free_i32(port);
-    tcg_temp_free_i32(data);
-
-    ctx->check_skip++;
+    gen_helper_inb(temp, cpu_env, temp);
+    tcg_gen_andi_tl(temp, temp, 1 << a->bit);
+    ctx->skip_cond = TCG_COND_EQ;
+    ctx->skip_var0 = temp;
+    ctx->free_skip_var0 = true;
 
     return true;
 }
@@ -2243,18 +2252,13 @@ static bool trans_SBIC(DisasContext *ctx, arg_SBIC *a)
  */
 static bool trans_SBIS(DisasContext *ctx, arg_SBIS *a)
 {
-    TCGv data = tcg_temp_new_i32();
-    TCGv port = tcg_const_i32(a->reg);
+    TCGv temp = tcg_const_i32(a->reg);
 
-    gen_helper_inb(data, cpu_env, port);
-
-    tcg_gen_andi_tl(data, data, 1 << a->bit);
-    tcg_gen_setcondi_tl(TCG_COND_NE, cpu_skip, data, 0);
-
-    tcg_temp_free_i32(port);
-    tcg_temp_free_i32(data);
-
-    ctx->check_skip++;
+    gen_helper_inb(temp, cpu_env, temp);
+    tcg_gen_andi_tl(temp, temp, 1 << a->bit);
+    ctx->skip_cond = TCG_COND_NE;
+    ctx->skip_var0 = temp;
+    ctx->free_skip_var0 = true;
 
     return true;
 }
@@ -2319,15 +2323,12 @@ static bool trans_SBIW(DisasContext *ctx, arg_SBIW *a)
 static bool trans_SBRC(DisasContext *ctx, arg_SBRC *a)
 {
     TCGv Rr = cpu_r[a->rr];
-    TCGv t0 = tcg_temp_new_i32();
 
-    tcg_gen_andi_tl(t0, Rr, 1 << a->bit);
-    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_skip, t0, 0);
-
-    tcg_temp_free_i32(t0);
-
-    ctx->check_skip++;
+    ctx->skip_cond = TCG_COND_EQ;
+    ctx->skip_var0 = tcg_temp_new();
+    ctx->free_skip_var0 = true;
 
+    tcg_gen_andi_tl(ctx->skip_var0, Rr, 1 << a->bit);
     return true;
 }
 
@@ -2338,15 +2339,12 @@ static bool trans_SBRC(DisasContext *ctx, arg_SBRC *a)
 static bool trans_SBRS(DisasContext *ctx, arg_SBRS *a)
 {
     TCGv Rr = cpu_r[a->rr];
-    TCGv t0 = tcg_temp_new_i32();
 
-    tcg_gen_andi_tl(t0, Rr, 1 << a->bit);
-    tcg_gen_setcondi_tl(TCG_COND_NE, cpu_skip, t0, 0);
-
-    tcg_temp_free_i32(t0);
-
-    ctx->check_skip++;
+    ctx->skip_cond = TCG_COND_NE;
+    ctx->skip_var0 = tcg_temp_new();
+    ctx->free_skip_var0 = true;
 
+    tcg_gen_andi_tl(ctx->skip_var0, Rr, 1 << a->bit);
     return true;
 }
 
@@ -2722,6 +2720,51 @@ static void translate(DisasContext *ctx)
     }
 }
 
+/* Standardize the cpu_skip condition to NE.  */
+static bool canonicalize_skip(DisasContext *ctx)
+{
+    switch (ctx->skip_cond) {
+    case TCG_COND_NEVER:
+        /* Normal case: cpu_skip is known to be false.  */
+        return false;
+
+    case TCG_COND_ALWAYS:
+        /*
+         * Breakpoint case: cpu_skip is known to be true, via TB_FLAGS_SKIP.
+         * The breakpoint is on the instruction being skipped, at the start
+         * of the TranslationBlock.  No need to update.
+         */
+        return false;
+
+    case TCG_COND_NE:
+        if (ctx->skip_var1 == NULL) {
+            tcg_gen_mov_tl(cpu_skip, ctx->skip_var0);
+        } else {
+            tcg_gen_xor_tl(cpu_skip, ctx->skip_var0, ctx->skip_var1);
+            ctx->skip_var1 = NULL;
+        }
+        break;
+
+    default:
+        /* Convert to a NE condition vs 0. */
+        if (ctx->skip_var1 == NULL) {
+            tcg_gen_setcondi_tl(ctx->skip_cond, cpu_skip, ctx->skip_var0, 0);
+        } else {
+            tcg_gen_setcond_tl(ctx->skip_cond, cpu_skip,
+                               ctx->skip_var0, ctx->skip_var1);
+            ctx->skip_var1 = NULL;
+        }
+        ctx->skip_cond = TCG_COND_NE;
+        break;
+    }
+    if (ctx->free_skip_var0) {
+        tcg_temp_free(ctx->skip_var0);
+        ctx->free_skip_var0 = false;
+    }
+    ctx->skip_var0 = cpu_skip;
+    return true;
+}
+
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 {
     CPUAVRState *env = cs->env_ptr;
@@ -2731,6 +2774,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
         .env = env,
         .memidx = 0,
         .bstate = DISAS_NEXT,
+        .skip_cond = TCG_COND_NEVER,
         .singlestep = cs->singlestep_enabled,
     };
     target_ulong pc_start = tb->pc / 2;
@@ -2750,8 +2794,14 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
     gen_tb_start(tb);
 
     ctx.npc = pc_start;
-    ctx.check_skip = 1;
+    if (tb->flags & TB_FLAGS_SKIP) {
+        ctx.skip_cond = TCG_COND_ALWAYS;
+        ctx.skip_var0 = cpu_skip;
+    }
+
     do {
+        TCGLabel *skip_label = NULL;
+
         /* translate current instruction */
         tcg_gen_insn_start(ctx.npc);
         num_insns++;
@@ -2765,25 +2815,46 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
         if (unlikely(!ctx.singlestep &&
                 (cpu_breakpoint_test(cs, OFFSET_CODE + ctx.npc * 2, BP_ANY) ||
                  cpu_breakpoint_test(cs, OFFSET_DATA + ctx.npc * 2, BP_ANY)))) {
+            canonicalize_skip(&ctx);
             tcg_gen_movi_tl(cpu_pc, ctx.npc);
             gen_helper_debug(cpu_env);
             goto done_generating;
         }
 
-        if (ctx.check_skip > 0) {
-            TCGLabel *skip = gen_new_label();
-            TCGLabel *done = gen_new_label();
-
-            tcg_gen_brcondi_tl(TCG_COND_NE, cpu_skip, 0, skip);
-                translate(&ctx);
-                tcg_gen_br(done);
-            gen_set_label(skip);
+        /* Conditionally skip the next instruction, if indicated.  */
+        if (ctx.skip_cond != TCG_COND_NEVER) {
+            skip_label = gen_new_label();
+            if (ctx.skip_var0 == cpu_skip) {
+                /*
+                 * Copy cpu_skip so that we may zero it before the branch.
+                 * This ensures that cpu_skip is non-zero after the label
+                 * if and only if the skipped insn itself sets a skip.
+                 */
+                ctx.free_skip_var0 = true;
+                ctx.skip_var0 = tcg_temp_new();
+                tcg_gen_mov_tl(ctx.skip_var0, cpu_skip);
                 tcg_gen_movi_tl(cpu_skip, 0);
-                tcg_gen_movi_tl(cpu_pc, ctx.npc);
-            gen_set_label(done);
-            ctx.check_skip--;
-        } else {
-            translate(&ctx);
+            }
+            if (ctx.skip_var1 == NULL) {
+                tcg_gen_brcondi_tl(ctx.skip_cond, ctx.skip_var0, 0, skip_label);
+            } else {
+                tcg_gen_brcond_tl(ctx.skip_cond, ctx.skip_var0,
+                                  ctx.skip_var1, skip_label);
+                ctx.skip_var1 = NULL;
+            }
+            if (ctx.free_skip_var0) {
+                tcg_temp_free(ctx.skip_var0);
+                ctx.free_skip_var0 = false;
+            }
+            ctx.skip_cond = TCG_COND_NEVER;
+            ctx.skip_var0 = NULL;
+        }
+
+        translate(&ctx);
+
+        if (skip_label) {
+            canonicalize_skip(&ctx);
+            gen_set_label(skip_label);
         }
     } while (ctx.bstate == DISAS_NEXT
              && num_insns < max_insns
@@ -2794,15 +2865,22 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
         gen_io_end();
     }
 
+    bool nonconst_skip = canonicalize_skip(&ctx);
+
     switch (ctx.bstate) {
     case DISAS_NORETURN:
+        assert(!nonconst_skip);
         break;
     case DISAS_NEXT:
     case DISAS_TOO_MANY:
     case DISAS_CHAIN:
-        /* Note gen_goto_tb checks singlestep.  */
-        gen_goto_tb(&ctx, 0, ctx.npc);
-        break;
+        if (!nonconst_skip) {
+            /* Note gen_goto_tb checks singlestep.  */
+            gen_goto_tb(&ctx, 0, ctx.npc);
+            break;
+        }
+        tcg_gen_movi_tl(cpu_pc, ctx.npc);
+        /* fall through */
     case DISAS_LOOKUP:
         if (!ctx.singlestep) {
             tcg_gen_lookup_and_goto_ptr();
-- 
2.17.1


--------------EFD781CD99319222A38E45B8--

