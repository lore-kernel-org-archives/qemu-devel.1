Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9A5C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:39:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE852082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouY5OKpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE852082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaGq-0001Ai-O4
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1ixaFh-0000O1-4q
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ixaFe-0002Y8-OZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:38:45 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ixaFX-0002QA-J6; Fri, 31 Jan 2020 12:38:35 -0500
Received: by mail-lj1-x243.google.com with SMTP id d10so7913940ljl.9;
 Fri, 31 Jan 2020 09:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DrqES9Tf64KmtnNozYbJE6fWa6bO2MjNahv4/cbbReE=;
 b=ouY5OKpyu5PcIT8kii4YeYW8SY3uMe0O3MNXtkbuvazX4D+9mZ41SansW2FJVIA77E
 q+t4ft6W4PclNbEbc7smoak/vf+H2qLiLlGwI8J4OiBL3mx5ZWEJN7xfnOjHX4jl0JAP
 P9aXN/Qv34rq+thi8PfOD+ajYMnf40XuXgSoPzENKiVeZCIFfRjWB2CnmjwOLN1ls8Pw
 kTNXYEx6KR0CuTdfmUiFf2osGegLS5KS0PMTX7ol6UlG9ENyzloRqM8b6yk9ljG0EQME
 GYIqs89WdrN3TMpdkfTYF7KM+Z8ecodc+IYmSEpe9IwujmYMcFtwUFCtMpFDOOaevlPI
 uWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DrqES9Tf64KmtnNozYbJE6fWa6bO2MjNahv4/cbbReE=;
 b=rJay5F6b3Jz8Xa2BW5DCYruPhPshMTfA9eYhu/BRqjHhGFG9uncTvzudzjOsee6n8a
 O9QFzQwAAkdI5gexbYMEV2z0aJ0KQYSH7yh0kDTyS86Fu8ZqkH5wP+/I3pRSGdNkLFU6
 x5LL5dw+HWr2oMp64Ta1mlV9/vXUYDxfA2AFPb5eXvNYS73B+LtKyeO82m8J9HRKvEKE
 uXVWZCKi8NcCVUL7rFMuD2E56bw791uMgeVkFqbsBLXGV0aUHm3e4joqJgf9MxMWAXor
 MiqR5dJnhh3RHxiYszKkTAiCcbWfFkBVCKgV7K/LdxQ0Un15RjyZa6ADVyT81yrHLUTD
 6tRg==
X-Gm-Message-State: APjAAAUWEiqgNsckynXH96byINYfwJNqCfDEqkmpDDSxRBbKuDoEsGlX
 yDt++NYIb2XV549gkMPjkjpEKhmh90BkaG0F5yA=
X-Google-Smtp-Source: APXvYqxGTLOTnsvh9rW8+XBeozTuPIUvqxxeAebyKrCTnbLgsMVxl5ixAUJm2nxD4YzVMRxRX2CKut9MtXZujfFyLtA=
X-Received: by 2002:a2e:8119:: with SMTP id d25mr6612996ljg.76.1580492313266; 
 Fri, 31 Jan 2020 09:38:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575914822.git.alistair.francis@wdc.com>
 <8c0eebc3868757e9ed312ac35e1f5325d5a18e76.1575914822.git.alistair.francis@wdc.com>
 <mhng-b22b75ac-a0c4-4d53-909c-2a8fd9506cd3@palmerdabbelt-glaptop>
 <CAKmqyKPOn_ULNu6i+s-0k-GGkZ0Gz9adNQcD1UU77u9t77ZXXQ@mail.gmail.com>
 <mhng-a16e78e8-09fe-467b-b633-c6457a4177ec@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-a16e78e8-09fe-467b-b633-c6457a4177ec@palmerdabbelt-glaptop1>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2020 09:31:30 -0800
Message-ID: <CAKmqyKMkTHZK1dmMGdpRv7704c2WXcieSGOgkwh98RKfozLo_g@mail.gmail.com>
Subject: Re: [PATCH v1 15/36] target/riscv: Convert mstatus to pointers
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 6:48 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Tue, 21 Jan 2020 11:02:01 GMT (+0000), alistair23@gmail.com wrote:
> > On Wed, Jan 8, 2020 at 11:30 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> >>
> >> On Mon, 09 Dec 2019 10:11:19 PST (-0800), Alistair Francis wrote:
> >> > To handle the new Hypervisor CSR register aliasing let's use pointers.
> >>
> >> For some reason I thought we were making this explicit?  In other words,
> >> requiring that all callers provide which privilege mode they're using when
> >> accessing these CSRs, as opposed to swapping around pointers.  I don't actually
> >> care that much, but IIRC when we were talking with the ARM guys at Plumbers
> >> they were pretty adament that would end up being a much cleaner implementation
> >> as they'd tried this way and later changed over.
> >
> > I think their implementation is different so it doesn't apply the same here.
> >
> > My main concern is that due to the modularity of RISC-V I don't expect
> > all future developers to keep track of the Hypervisor extensions. This
> > way we always have the correct state in the registers.
> >
> > There is only one pointer variable left, so we could drop the pointer
> > swapping part, but for now it's still here.
>
> OK, so in the interest of moving things forwards let's just
>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks

>
> so we can merge this -- it's too big of a patch set to wait around on something
> so small for.  I think that was the last one missing a review, right?

I have made one small change and dismissed your review from a patch,
it also looks like one patch hasn't been reviewed either.

I'll send a v2 later today that has been rebased on master.

Alistair

>
> >
> > Alistair
> >
> >>
> >> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> > ---
> >> >  target/riscv/cpu.c        | 11 +++++++++--
> >> >  target/riscv/cpu.h        |  9 ++++++++-
> >> >  target/riscv/cpu_helper.c | 30 +++++++++++++++---------------
> >> >  target/riscv/csr.c        | 20 ++++++++++----------
> >> >  target/riscv/op_helper.c  | 14 +++++++-------
> >> >  5 files changed, 49 insertions(+), 35 deletions(-)
> >> >
> >> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >> > index a07c5689b3..e61cf46a73 100644
> >> > --- a/target/riscv/cpu.c
> >> > +++ b/target/riscv/cpu.c
> >> > @@ -236,7 +236,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> >> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
> >> >  #ifndef CONFIG_USER_ONLY
> >> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
> >> > -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> >> > +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", *env->mstatus);
> >> >      if (riscv_has_ext(env, RVH)) {
> >> >          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
> >> >          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env->vsstatus);
> >> > @@ -336,7 +336,7 @@ static void riscv_cpu_reset(CPUState *cs)
> >> >      mcc->parent_reset(cs);
> >> >  #ifndef CONFIG_USER_ONLY
> >> >      env->priv = PRV_M;
> >> > -    env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
> >> > +    *env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
> >> >      env->mcause = 0;
> >> >      env->pc = env->resetvec;
> >> >  #endif
> >> > @@ -465,8 +465,15 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
> >> >  static void riscv_cpu_init(Object *obj)
> >> >  {
> >> >      RISCVCPU *cpu = RISCV_CPU(obj);
> >> > +#ifndef CONFIG_USER_ONLY
> >> > +    CPURISCVState *env = &cpu->env;
> >> > +#endif
> >> >
> >> >      cpu_set_cpustate_pointers(cpu);
> >> > +
> >> > +#ifndef CONFIG_USER_ONLY
> >> > +    env->mstatus = &env->mstatus_novirt;
> >> > +#endif
> >> >  }
> >> >
> >> >  static const VMStateDescription vmstate_riscv_cpu = {
> >> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >> > index 21ae5a8b19..9dc8303c62 100644
> >> > --- a/target/riscv/cpu.h
> >> > +++ b/target/riscv/cpu.h
> >> > @@ -122,7 +122,7 @@ struct CPURISCVState {
> >> >      target_ulong resetvec;
> >> >
> >> >      target_ulong mhartid;
> >> > -    target_ulong mstatus;
> >> > +    target_ulong *mstatus;
> >> >
> >> >      target_ulong mip;
> >> >      uint32_t miclaim;
> >> > @@ -145,6 +145,13 @@ struct CPURISCVState {
> >> >      target_ulong mcause;
> >> >      target_ulong mtval;  /* since: priv-1.10.0 */
> >> >
> >> > +    /* The following registers are the "real" versions that the pointer
> >> > +     * versions point to. These should never be used unless you know what you
> >> > +     * are doing. To access these use the pointer versions instead. This is
> >> > +     * required to handle the Hypervisor register swapping.
> >> > +     */
> >> > +    target_ulong mstatus_novirt;
> >> > +
> >> >      /* Hypervisor CSRs */
> >> >      target_ulong hstatus;
> >> >      target_ulong hedeleg;
> >> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >> > index b00f66824a..9684da7f7d 100644
> >> > --- a/target/riscv/cpu_helper.c
> >> > +++ b/target/riscv/cpu_helper.c
> >> > @@ -37,8 +37,8 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
> >> >  #ifndef CONFIG_USER_ONLY
> >> >  static int riscv_cpu_local_irq_pending(CPURISCVState *env)
> >> >  {
> >> > -    target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
> >> > -    target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
> >> > +    target_ulong mstatus_mie = get_field(*env->mstatus, MSTATUS_MIE);
> >> > +    target_ulong mstatus_sie = get_field(*env->mstatus, MSTATUS_SIE);
> >> >      target_ulong pending = env->mip & env->mie;
> >> >      target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
> >> >      target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
> >> > @@ -75,7 +75,7 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> >> >  /* Return true is floating point support is currently enabled */
> >> >  bool riscv_cpu_fp_enabled(CPURISCVState *env)
> >> >  {
> >> > -    if (env->mstatus & MSTATUS_FS) {
> >> > +    if (*env->mstatus & MSTATUS_FS) {
> >> >          return true;
> >> >      }
> >> >
> >> > @@ -198,8 +198,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
> >> >      int mode = mmu_idx;
> >> >
> >> >      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
> >> > -        if (get_field(env->mstatus, MSTATUS_MPRV)) {
> >> > -            mode = get_field(env->mstatus, MSTATUS_MPP);
> >> > +        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
> >> > +            mode = get_field(*env->mstatus, MSTATUS_MPP);
> >> >          }
> >> >      }
> >> >
> >> > @@ -213,11 +213,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
> >> >
> >> >      hwaddr base;
> >> >      int levels, ptidxbits, ptesize, vm, sum;
> >> > -    int mxr = get_field(env->mstatus, MSTATUS_MXR);
> >> > +    int mxr = get_field(*env->mstatus, MSTATUS_MXR);
> >> >
> >> >      if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> >> >          base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
> >> > -        sum = get_field(env->mstatus, MSTATUS_SUM);
> >> > +        sum = get_field(*env->mstatus, MSTATUS_SUM);
> >> >          vm = get_field(env->satp, SATP_MODE);
> >> >          switch (vm) {
> >> >          case VM_1_10_SV32:
> >> > @@ -237,8 +237,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
> >> >          }
> >> >      } else {
> >> >          base = (hwaddr)(env->sptbr) << PGSHIFT;
> >> > -        sum = !get_field(env->mstatus, MSTATUS_PUM);
> >> > -        vm = get_field(env->mstatus, MSTATUS_VM);
> >> > +        sum = !get_field(*env->mstatus, MSTATUS_PUM);
> >> > +        vm = get_field(*env->mstatus, MSTATUS_VM);
> >> >          switch (vm) {
> >> >          case VM_1_09_SV32:
> >> >            levels = 2; ptidxbits = 10; ptesize = 4; break;
> >> > @@ -492,8 +492,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >> >      ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
> >> >
> >> >      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
> >> > -        if (get_field(env->mstatus, MSTATUS_MPRV)) {
> >> > -            mode = get_field(env->mstatus, MSTATUS_MPP);
> >> > +        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
> >> > +            mode = get_field(*env->mstatus, MSTATUS_MPP);
> >> >          }
> >> >      }
> >> >
> >> > @@ -599,12 +599,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >> >      if (env->priv <= PRV_S &&
> >> >              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
> >> >          /* handle the trap in S-mode */
> >> > -        target_ulong s = env->mstatus;
> >> > +        target_ulong s = *env->mstatus;
> >> >          s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
> >> >              get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
> >> >          s = set_field(s, MSTATUS_SPP, env->priv);
> >> >          s = set_field(s, MSTATUS_SIE, 0);
> >> > -        env->mstatus = s;
> >> > +        *env->mstatus = s;
> >> >          env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
> >> >          env->sepc = env->pc;
> >> >          env->sbadaddr = tval;
> >> > @@ -613,12 +613,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
> >> >          riscv_cpu_set_mode(env, PRV_S);
> >> >      } else {
> >> >          /* handle the trap in M-mode */
> >> > -        target_ulong s = env->mstatus;
> >> > +        target_ulong s = *env->mstatus;
> >> >          s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
> >> >              get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
> >> >          s = set_field(s, MSTATUS_MPP, env->priv);
> >> >          s = set_field(s, MSTATUS_MIE, 0);
> >> > -        env->mstatus = s;
> >> > +        *env->mstatus = s;
> >> >          env->mcause = cause | ~(((target_ulong)-1) >> async);
> >> >          env->mepc = env->pc;
> >> >          env->mbadaddr = tval;
> >> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >> > index 74e911af08..a4b598d49a 100644
> >> > --- a/target/riscv/csr.c
> >> > +++ b/target/riscv/csr.c
> >> > @@ -136,7 +136,7 @@ static int write_fflags(CPURISCVState *env, int csrno, target_ulong val)
> >> >      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
> >> >          return -1;
> >> >      }
> >> > -    env->mstatus |= MSTATUS_FS;
> >> > +    *env->mstatus |= MSTATUS_FS;
> >> >  #endif
> >> >      riscv_cpu_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
> >> >      return 0;
> >> > @@ -159,7 +159,7 @@ static int write_frm(CPURISCVState *env, int csrno, target_ulong val)
> >> >      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
> >> >          return -1;
> >> >      }
> >> > -    env->mstatus |= MSTATUS_FS;
> >> > +    *env->mstatus |= MSTATUS_FS;
> >> >  #endif
> >> >      env->frm = val & (FSR_RD >> FSR_RD_SHIFT);
> >> >      return 0;
> >> > @@ -183,7 +183,7 @@ static int write_fcsr(CPURISCVState *env, int csrno, target_ulong val)
> >> >      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
> >> >          return -1;
> >> >      }
> >> > -    env->mstatus |= MSTATUS_FS;
> >> > +    *env->mstatus |= MSTATUS_FS;
> >> >  #endif
> >> >      env->frm = (val & FSR_RD) >> FSR_RD_SHIFT;
> >> >      riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
> >> > @@ -313,7 +313,7 @@ static int read_mhartid(CPURISCVState *env, int csrno, target_ulong *val)
> >> >  /* Machine Trap Setup */
> >> >  static int read_mstatus(CPURISCVState *env, int csrno, target_ulong *val)
> >> >  {
> >> > -    *val = env->mstatus;
> >> > +    *val = *env->mstatus;
> >> >      return 0;
> >> >  }
> >> >
> >> > @@ -325,7 +325,7 @@ static int validate_vm(CPURISCVState *env, target_ulong vm)
> >> >
> >> >  static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
> >> >  {
> >> > -    target_ulong mstatus = env->mstatus;
> >> > +    target_ulong mstatus = *env->mstatus;
> >> >      target_ulong mask = 0;
> >> >      int dirty;
> >> >
> >> > @@ -365,7 +365,7 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
> >> >               ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
> >> >              ((mstatus & MSTATUS_XS) == MSTATUS_XS);
> >> >      mstatus = set_field(mstatus, MSTATUS_SD, dirty);
> >> > -    env->mstatus = mstatus;
> >> > +    *env->mstatus = mstatus;
> >> >
> >> >      return 0;
> >> >  }
> >> > @@ -614,7 +614,7 @@ static int read_sstatus(CPURISCVState *env, int csrno, target_ulong *val)
> >> >  {
> >> >      target_ulong mask = ((env->priv_ver >= PRIV_VERSION_1_10_0) ?
> >> >                           sstatus_v1_10_mask : sstatus_v1_9_mask);
> >> > -    *val = env->mstatus & mask;
> >> > +    *val = *env->mstatus & mask;
> >> >      return 0;
> >> >  }
> >> >
> >> > @@ -622,7 +622,7 @@ static int write_sstatus(CPURISCVState *env, int csrno, target_ulong val)
> >> >  {
> >> >      target_ulong mask = ((env->priv_ver >= PRIV_VERSION_1_10_0) ?
> >> >                           sstatus_v1_10_mask : sstatus_v1_9_mask);
> >> > -    target_ulong newval = (env->mstatus & ~mask) | (val & mask);
> >> > +    target_ulong newval = (*env->mstatus & ~mask) | (val & mask);
> >> >      return write_mstatus(env, CSR_MSTATUS, newval);
> >> >  }
> >> >
> >> > @@ -737,7 +737,7 @@ static int read_satp(CPURISCVState *env, int csrno, target_ulong *val)
> >> >      if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
> >> >          *val = 0;
> >> >      } else if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> >> > -        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
> >> > +        if (env->priv == PRV_S && get_field(*env->mstatus, MSTATUS_TVM)) {
> >> >              return -1;
> >> >          } else {
> >> >              *val = env->satp;
> >> > @@ -762,7 +762,7 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
> >> >          validate_vm(env, get_field(val, SATP_MODE)) &&
> >> >          ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
> >> >      {
> >> > -        if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
> >> > +        if (env->priv == PRV_S && get_field(*env->mstatus, MSTATUS_TVM)) {
> >> >              return -1;
> >> >          } else {
> >> >              if((val ^ env->satp) & SATP_ASID) {
> >> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> >> > index 331cc36232..d150551bc9 100644
> >> > --- a/target/riscv/op_helper.c
> >> > +++ b/target/riscv/op_helper.c
> >> > @@ -83,11 +83,11 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
> >> >      }
> >> >
> >> >      if (env->priv_ver >= PRIV_VERSION_1_10_0 &&
> >> > -        get_field(env->mstatus, MSTATUS_TSR)) {
> >> > +        get_field(*env->mstatus, MSTATUS_TSR)) {
> >> >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> >> >      }
> >> >
> >> > -    target_ulong mstatus = env->mstatus;
> >> > +    target_ulong mstatus = *env->mstatus;
> >> >      target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
> >> >      mstatus = set_field(mstatus,
> >> >          env->priv_ver >= PRIV_VERSION_1_10_0 ?
> >> > @@ -96,7 +96,7 @@ target_ulong helper_sret(CPURISCVState *env, target_ulong cpu_pc_deb)
> >> >      mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
> >> >      mstatus = set_field(mstatus, MSTATUS_SPP, PRV_U);
> >> >      riscv_cpu_set_mode(env, prev_priv);
> >> > -    env->mstatus = mstatus;
> >> > +    *env->mstatus = mstatus;
> >> >
> >> >      return retpc;
> >> >  }
> >> > @@ -112,7 +112,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
> >> >          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> >> >      }
> >> >
> >> > -    target_ulong mstatus = env->mstatus;
> >> > +    target_ulong mstatus = *env->mstatus;
> >> >      target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
> >> >      mstatus = set_field(mstatus,
> >> >          env->priv_ver >= PRIV_VERSION_1_10_0 ?
> >> > @@ -121,7 +121,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
> >> >      mstatus = set_field(mstatus, MSTATUS_MPIE, 0);
> >> >      mstatus = set_field(mstatus, MSTATUS_MPP, PRV_U);
> >> >      riscv_cpu_set_mode(env, prev_priv);
> >> > -    env->mstatus = mstatus;
> >> > +    *env->mstatus = mstatus;
> >> >
> >> >      return retpc;
> >> >  }
> >> > @@ -132,7 +132,7 @@ void helper_wfi(CPURISCVState *env)
> >> >
> >> >      if (env->priv == PRV_S &&
> >> >          env->priv_ver >= PRIV_VERSION_1_10_0 &&
> >> > -        get_field(env->mstatus, MSTATUS_TW)) {
> >> > +        get_field(*env->mstatus, MSTATUS_TW)) {
> >> >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> >> >      } else {
> >> >          cs->halted = 1;
> >> > @@ -147,7 +147,7 @@ void helper_tlb_flush(CPURISCVState *env)
> >> >      if (!(env->priv >= PRV_S) ||
> >> >          (env->priv == PRV_S &&
> >> >           env->priv_ver >= PRIV_VERSION_1_10_0 &&
> >> > -         get_field(env->mstatus, MSTATUS_TVM))) {
> >> > +         get_field(*env->mstatus, MSTATUS_TVM))) {
> >> >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> >> >      } else {
> >> >          tlb_flush(cs);

