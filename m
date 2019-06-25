Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HEXHASH_WORD,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C3DC48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4272084B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4272084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58298 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiP5-00032l-1d
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hfiNP-0001TE-KO
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hfiNN-0007MK-5U
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:08:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hfiNM-0007Ky-Rp
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:08:33 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so8706491pgj.7
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 03:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=Jd/fqITN7FR2Pz7gLFby2abtXP6zvvhjk2Ht3cDAfuc=;
 b=lE358VTHOSb+2+dDfgfloQ6Ih+cG2t0t9CXmcPAaRPLqoXJsL0Pn96ams70xtWl4q/
 7zHjEZXyCZzId1Fkhz2KhiNm6EX+fCj2InrGFjkneB6Cb0iXWN65V8QGmd1s8yWrdkz9
 O5VmUjxvJbF2xdfu8eLPOqqpCXQON5I2Kwtuo92LSp582EOAQoL//NePuFlHtvdzwpqD
 bohYa0BJ8570qdmhoa9KQLB+U0TrhLaUj1Q++znW1986YYOyPAYMV8aSLw3KSiusstYC
 rM09tyK3aqphdGFZ+tppwGdso817YYskjHKo/CN+Imghtt/z9+zuo0ZdA/C7gGc0aOEp
 X3VA==
X-Gm-Message-State: APjAAAW+7v1Lsfo4ZDyd1M08NcEN303LV6obUDV78ZWXKpzj/5ygh8EN
 FWrXchmaaYmvEX5a6atA8QpZew==
X-Google-Smtp-Source: APXvYqxU878/UJtbv5lQWRmMEnwBODuDcqsa/CDSJFrhTRtbTvyjOLhgWdcmDTHl5qFdnPQnPPpVHg==
X-Received: by 2002:a65:5303:: with SMTP id m3mr15670704pgq.393.1561457311239; 
 Tue, 25 Jun 2019 03:08:31 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id z13sm5411127pjn.32.2019.06.25.03.08.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 03:08:30 -0700 (PDT)
Date: Tue, 25 Jun 2019 03:08:30 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 03:06:19 PDT (-0700)
In-Reply-To: <CAKmqyKPhty4-EbgXTHMhUOGVkVnxCzmRB14wSbLG0BSrdzbv1A@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-94acab2f-b1df-4a4b-a29a-d51dd0405476@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.196
Subject: Re: [Qemu-devel] [PATCH v1 9/9] target/riscv: Add Zifencei and
 Zicsr as command line options
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
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Jun 2019 16:16:30 PDT (-0700), alistair23@gmail.com wrote:
> On Mon, Jun 24, 2019 at 2:31 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Mon, 17 Jun 2019 18:31:25 PDT (-0700), Alistair Francis wrote:
>> > For completeness let's add Zifencei and Zicsr as command line options,
>> > even though they can't be disabled at the moment.
>> >
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > ---
>> >  target/riscv/cpu.c | 9 +++++++++
>> >  target/riscv/cpu.h | 2 ++
>> >  2 files changed, 11 insertions(+)
>> >
>> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> > index 5af1c9b38c..53cf8607f7 100644
>> > --- a/target/riscv/cpu.c
>> > +++ b/target/riscv/cpu.c
>> > @@ -409,6 +409,13 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
>> >          set_misa(env, RVXLEN | target_misa);
>> >      }
>> >
>> > +    if (!cpu->cfg.ext_ifencei) {
>> > +        warn_report("QEMU does not support disabling Zifencei");
>> > +    }
>> > +    if (!cpu->cfg.ext_icsr) {
>> > +        warn_report("QEMU does not support disabling Zicsr");
>> > +    }
>> > +
>> >      riscv_cpu_register_gdb_regs_for_features(cs);
>> >
>> >      qemu_init_vcpu(cs);
>> > @@ -441,6 +448,8 @@ static Property riscv_cpu_properties[] = {
>> >      DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
>> >      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>> >      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>> > +    DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>> > +    DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
>> >      DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
>> >      DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
>> >      DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
>> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> > index 786f620564..b4c212dfcf 100644
>> > --- a/target/riscv/cpu.h
>> > +++ b/target/riscv/cpu.h
>> > @@ -222,6 +222,8 @@ typedef struct RISCVCPU {
>> >          bool ext_s;
>> >          bool ext_u;
>> >          bool ext_counters;
>> > +        bool ext_ifencei;
>> > +        bool ext_icsr;
>> >
>> >          char *priv_spec;
>> >          char *user_spec;
>>
>> I'd rather just support these, which seems about as hard as emitting a warning.
>> Disabling Zifencei is particularly useful, as the Linux ABI forbids it so this
>> way we can run tests that way.  Unless I'm missing something, I think these two
>> should do it:
>>
>> From 6d645eb1e8ba4d16431af40bf04e5c165475bf5a Mon Sep 17 00:00:00 2001
>> From: Palmer Dabbelt <palmer@sifive.com>
>> Date: Mon, 24 Jun 2019 01:59:05 -0700
>> Subject: [PATCH 1/2] RISC-V: Add support for the Zifencei extension
>>
>> fence.i has been split out of the base ISA as part of the ratification
>> process.  This patch adds a Zifencei argument, which disables the
>> fence.i instruction.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> This looks good.
>
>> ---
>>  target/riscv/cpu.c                      | 1 +
>>  target/riscv/cpu.h                      | 1 +
>>  target/riscv/insn_trans/trans_rvi.inc.c | 3 +++
>>  target/riscv/translate.c                | 3 +++
>>  4 files changed, 8 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index be90fa7d0808..bbad39a337b3 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -441,6 +441,7 @@ static Property riscv_cpu_properties[] = {
>>      DEFINE_PROP_BOOL("s", RISCVCPU, cfg.ext_s, true),
>>      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>>      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>> +    DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>>      DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
>>      DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
>>      DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 4d4e0f89e206..ba551cd3082c 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -223,6 +223,7 @@ typedef struct RISCVCPU {
>>          bool ext_s;
>>          bool ext_u;
>>          bool ext_counters;
>> +        bool ext_ifencei;
>>
>>          char *priv_spec;
>>          char *user_spec;
>> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
>> index 6cda078ed6ba..766594ba08ce 100644
>> --- a/target/riscv/insn_trans/trans_rvi.inc.c
>> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
>> @@ -484,6 +484,9 @@ static bool trans_fence(DisasContext *ctx, arg_fence *a)
>>
>>  static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
>>  {
>> +    if (!ctx->ext_ifencei)
>> +        return false;
>> +
>>      /*
>>       * FENCE_I is a no-op in QEMU,
>>       * however we need to end the translation block
>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>> index 313c27b70073..8d6ab732588d 100644
>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -54,6 +54,7 @@ typedef struct DisasContext {
>>         to any system register, which includes CSR_FRM, so we do not have
>>         to reset this known value.  */
>>      int frm;
>> +    bool ext_ifencei;
>>  } DisasContext;
>>
>>  #ifdef TARGET_RISCV64
>> @@ -752,6 +753,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>>  {
>>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>>      CPURISCVState *env = cs->env_ptr;
>> +    RISCVCPU *cpu = RISCV_CPU(cs);
>>
>>      ctx->pc_succ_insn = ctx->base.pc_first;
>>      ctx->mem_idx = ctx->base.tb->flags & TB_FLAGS_MMU_MASK;
>> @@ -759,6 +761,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>>      ctx->priv_ver = env->priv_ver;
>>      ctx->misa = env->misa;
>>      ctx->frm = -1;  /* unknown rounding mode */
>> +    ctx->ext_ifencei = cpu->cfg.ext_ifencei;
>>  }
>>
>>  static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>> --
>> 2.21.0
>>
>>
>> From 6d280048f076eb0f28ee0c4454a1ed8b130240cb Mon Sep 17 00:00:00 2001
>> From: Palmer Dabbelt <palmer@sifive.com>
>> Date: Mon, 24 Jun 2019 01:59:51 -0700
>> Subject: [PATCH 2/2] RISC-V: Add support for the Zicsr extension
>>
>> The various CSR instructions have been split out of the base ISA as part
>> of the ratification process.  This patch adds a Zicsr argument, which
>> disables all the CSR instructions.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> Couldn't we just do this in riscv_csrrw() to avoid passing it down to
> the translation?
>
> It gets called by all of these functions anyway.

Ya, that's much cleaner.

$ git show bc9e214eff71c6a5467e8311701de49d009069e9 | cat
commit bc9e214eff71c6a5467e8311701de49d009069e9
gpg: Signature made Tue 25 Jun 2019 02:59:24 AM PDT
gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
gpg:                issuer "palmer@dabbelt.com"
gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
Author: Palmer Dabbelt <palmer@sifive.com>
Date:   Mon Jun 24 01:59:51 2019 -0700

    RISC-V: Add support for the Zicsr extension

    The various CSR instructions have been split out of the base ISA as part
    of the ratification process.  This patch adds a Zicsr argument, which
    disables all the CSR instructions.

    Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index bbad39a337b3..915b9e77df33 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -442,6 +442,7 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
     DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
+    DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
     DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
     DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
     DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ba551cd3082c..0adb307f3298 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -224,6 +224,7 @@ typedef struct RISCVCPU {
         bool ext_u;
         bool ext_counters;
         bool ext_ifencei;
+        bool ext_icsr;

         char *priv_spec;
         char *user_spec;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index dad9ae4a147d..a2ae64bda42b 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -790,6 +790,7 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 {
     int ret;
     target_ulong old_value;
+    RISCVCPU *cpu = env_archcpu(env);

     /* check privileges and return -1 if check fails */
 #if !defined(CONFIG_USER_ONLY)
@@ -800,6 +801,10 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
     }
 #endif

+    /* ensure the CSR extension is enabled. */
+    if (!cpu->cfg.ext_icsr)
+        return -1;
+
     /* check predicate */
     if (!csr_ops[csrno].predicate || csr_ops[csrno].predicate(env, csrno) < 0) {
         return -1;

>
> Alistair
>
>> ---
>>  target/riscv/cpu.c                      |  1 +
>>  target/riscv/cpu.h                      |  1 +
>>  target/riscv/insn_trans/trans_rvi.inc.c | 18 ++++++++++++++++++
>>  target/riscv/translate.c                |  2 ++
>>  4 files changed, 22 insertions(+)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index bbad39a337b3..915b9e77df33 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -442,6 +442,7 @@ static Property riscv_cpu_properties[] = {
>>      DEFINE_PROP_BOOL("u", RISCVCPU, cfg.ext_u, true),
>>      DEFINE_PROP_BOOL("Counters", RISCVCPU, cfg.ext_counters, true),
>>      DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
>> +    DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
>>      DEFINE_PROP_STRING("priv_spec", RISCVCPU, cfg.priv_spec),
>>      DEFINE_PROP_BOOL("mmu", RISCVCPU, cfg.mmu, true),
>>      DEFINE_PROP_BOOL("pmp", RISCVCPU, cfg.pmp, true),
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index ba551cd3082c..0adb307f3298 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -224,6 +224,7 @@ typedef struct RISCVCPU {
>>          bool ext_u;
>>          bool ext_counters;
>>          bool ext_ifencei;
>> +        bool ext_icsr;
>>
>>          char *priv_spec;
>>          char *user_spec;
>> diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
>> index 766594ba08ce..66c5202cc5d6 100644
>> --- a/target/riscv/insn_trans/trans_rvi.inc.c
>> +++ b/target/riscv/insn_trans/trans_rvi.inc.c
>> @@ -524,6 +524,9 @@ static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
>>
>>  static bool trans_csrrw(DisasContext *ctx, arg_csrrw *a)
>>  {
>> +    if (!ctx->ext_icsr)
>> +        return false;
>> +
>>      TCGv source1, csr_store, dest, rs1_pass;
>>      RISCV_OP_CSR_PRE;
>>      gen_helper_csrrw(dest, cpu_env, source1, csr_store);
>> @@ -533,6 +536,9 @@ static bool trans_csrrw(DisasContext *ctx, arg_csrrw *a)
>>
>>  static bool trans_csrrs(DisasContext *ctx, arg_csrrs *a)
>>  {
>> +    if (!ctx->ext_icsr)
>> +        return false;
>> +
>>      TCGv source1, csr_store, dest, rs1_pass;
>>      RISCV_OP_CSR_PRE;
>>      gen_helper_csrrs(dest, cpu_env, source1, csr_store, rs1_pass);
>> @@ -542,6 +548,9 @@ static bool trans_csrrs(DisasContext *ctx, arg_csrrs *a)
>>
>>  static bool trans_csrrc(DisasContext *ctx, arg_csrrc *a)
>>  {
>> +    if (!ctx->ext_icsr)
>> +        return false;
>> +
>>      TCGv source1, csr_store, dest, rs1_pass;
>>      RISCV_OP_CSR_PRE;
>>      gen_helper_csrrc(dest, cpu_env, source1, csr_store, rs1_pass);
>> @@ -551,6 +560,9 @@ static bool trans_csrrc(DisasContext *ctx, arg_csrrc *a)
>>
>>  static bool trans_csrrwi(DisasContext *ctx, arg_csrrwi *a)
>>  {
>> +    if (!ctx->ext_icsr)
>> +        return false;
>> +
>>      TCGv source1, csr_store, dest, rs1_pass;
>>      RISCV_OP_CSR_PRE;
>>      gen_helper_csrrw(dest, cpu_env, rs1_pass, csr_store);
>> @@ -560,6 +572,9 @@ static bool trans_csrrwi(DisasContext *ctx, arg_csrrwi *a)
>>
>>  static bool trans_csrrsi(DisasContext *ctx, arg_csrrsi *a)
>>  {
>> +    if (!ctx->ext_icsr)
>> +        return false;
>> +
>>      TCGv source1, csr_store, dest, rs1_pass;
>>      RISCV_OP_CSR_PRE;
>>      gen_helper_csrrs(dest, cpu_env, rs1_pass, csr_store, rs1_pass);
>> @@ -569,6 +584,9 @@ static bool trans_csrrsi(DisasContext *ctx, arg_csrrsi *a)
>>
>>  static bool trans_csrrci(DisasContext *ctx, arg_csrrci *a)
>>  {
>> +    if (!ctx->ext_icsr)
>> +        return false;
>> +
>>      TCGv source1, csr_store, dest, rs1_pass;
>>      RISCV_OP_CSR_PRE;
>>      gen_helper_csrrc(dest, cpu_env, rs1_pass, csr_store, rs1_pass);
>> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>> index 8d6ab732588d..be46435b9a7b 100644
>> --- a/target/riscv/translate.c
>> +++ b/target/riscv/translate.c
>> @@ -55,6 +55,7 @@ typedef struct DisasContext {
>>         to reset this known value.  */
>>      int frm;
>>      bool ext_ifencei;
>> +    bool ext_icsr;
>>  } DisasContext;
>>
>>  #ifdef TARGET_RISCV64
>> @@ -762,6 +763,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>>      ctx->misa = env->misa;
>>      ctx->frm = -1;  /* unknown rounding mode */
>>      ctx->ext_ifencei = cpu->cfg.ext_ifencei;
>> +    ctx->ext_icsr = cpu->cfg.ext_icsr;
>>  }
>>
>>  static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
>> --
>> 2.21.0
>>

