Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC5CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 06:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 847C320874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 06:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ8fMzUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847C320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPhtW-0006DI-Ml
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 02:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iPhsm-0005Bt-DE
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 02:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iPhsk-0004ja-MO
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 02:55:04 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:39559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iPhsg-0004bW-No; Wed, 30 Oct 2019 02:54:59 -0400
Received: by mail-lf1-x142.google.com with SMTP id 195so670356lfj.6;
 Tue, 29 Oct 2019 23:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CL02M2rNV8g68cXBbtRSn01S2C+370pg/0iHLJ2Z1VY=;
 b=UQ8fMzUC8lu2qE1L2EkDX2ulzev+y5K2eDQ1zzi9O1tKIZjKOMQT92JVN9KOQvYPZW
 lZAEoA6+LL4kLe0uBesqv8GCXRcj2/C1RQR+P2yuLl2RpIoZlg+xfpOPpmB8G7C0aCE4
 eb/IChj75sykqZEZpMu/7eNs7qJlaVLpslWi4bs2A6QjSe+dRLhuU2NwlXtsBm3Y0/JE
 0dHq1lQJaD33TE0n3JqhF44e7NakkpObj5JemlgamtCYPNOTJoNFVkEk+r9qR4GipRUb
 s/qToxfXMvjqaV1UYQFqeJCIq+UpS4F/egHAzedIqxMKNf809zboyrFtLW8hfQIJFxav
 gxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CL02M2rNV8g68cXBbtRSn01S2C+370pg/0iHLJ2Z1VY=;
 b=IMPfVzkoPu+PKlEsmB68JgvI6kZAE6vOVvMpJ/bJt/3Kdg5Lz5gIRZhQIbwCGVRv2n
 MhDVcRu4UHqrmf3veOyuwIwdfY8KU+7kBIdsy1S5VBgk7N6OYN5QSqnMDZ1hPN15pS71
 lagYRezswsV3M+GzwEqWaTripRxxBB+VCUPnat3EWD23YvICxZaGP9mWmhZ8JycNcwor
 LZe4bjLzMtzegHpwLUuAvqF3F9QgipJ0X1llPeI+h+ropPb9ykahObiBntlaBJsCax2g
 6wQ5eqGFQuUJlZkEgAW+l7h6tkVMTvV8fbxkJadC3O7rl2Pe7Cc8VRC5GLA93TRZheDk
 ao4Q==
X-Gm-Message-State: APjAAAW7WvkAIHA90vYlJs9E4WFLcznqByjjPGl8A/pHy71+QZG12EsJ
 5ViQ9DF6qn2gDUiMl63Lik48pTN824Mp3tH1g16IZN27EfE=
X-Google-Smtp-Source: APXvYqxUck24Ec7uKZcm+Ow0rGi2gTxzHFjy4B3RkF4p/8qLm7FcPNzxLKDClv1c48laP14h190PHDWWUS5dhk6ogCw=
X-Received: by 2002:a19:855:: with SMTP id 82mr4942879lfi.44.1572418496728;
 Tue, 29 Oct 2019 23:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKM9kKQxc7ZcSOMciqxBLUf=sWYzGJc98WkiOp3sozgq9g@mail.gmail.com>
 <mhng-7255cd2c-3899-4142-b41e-0a1c83f9cb78@palmer-si-x1c4>
In-Reply-To: <mhng-7255cd2c-3899-4142-b41e-0a1c83f9cb78@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Oct 2019 07:54:30 +0100
Message-ID: <CAKmqyKP_tv5RTZ00ZEr4jDMy+3+6heWK5LyoTLmnmsbbpCLrqg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] target/riscv: Remove atomic accesses to MIP CSR
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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

On Tue, Oct 29, 2019 at 4:14 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 29 Oct 2019 03:49:23 PDT (-0700), alistair23@gmail.com wrote:
> > On Fri, Oct 18, 2019 at 7:44 PM Alistair Francis <alistair23@gmail.com> wrote:
> >>
> >> On Fri, Oct 18, 2019 at 9:51 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >> >
> >> > On Tue, 08 Oct 2019 15:04:18 PDT (-0700), Alistair Francis wrote:
> >> > > Instead of relying on atomics to access the MIP register let's update
> >> > > our helper function to instead just lock the IO mutex thread before
> >> > > writing. This follows the same concept as used in PPC for handling
> >> > > interrupts
> >> > >
> >> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> > > ---
> >> > >  target/riscv/cpu.c        |  5 ++--
> >> > >  target/riscv/cpu.h        |  9 --------
> >> > >  target/riscv/cpu_helper.c | 48 +++++++++++++++------------------------
> >> > >  target/riscv/csr.c        |  2 +-
> >> > >  4 files changed, 21 insertions(+), 43 deletions(-)
> >> > >
> >> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >> > > index f13e298a36..e09dd7aa23 100644
> >> > > --- a/target/riscv/cpu.c
> >> > > +++ b/target/riscv/cpu.c
> >> > > @@ -224,8 +224,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> >> > >  #ifndef CONFIG_USER_ONLY
> >> > >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
> >> > >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> >> > > -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ",
> >> > > -                 (target_ulong)atomic_read(&env->mip));
> >> > > +    qemu_fprintf(f, " %s 0x%x\n", "mip     ", env->mip);
> >> > >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
> >> > >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
> >> > >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
> >> > > @@ -275,7 +274,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
> >> > >       * Definition of the WFI instruction requires it to ignore the privilege
> >> > >       * mode and delegation registers, but respect individual enables
> >> > >       */
> >> > > -    return (atomic_read(&env->mip) & env->mie) != 0;
> >> > > +    return (env->mip & env->mie) != 0;
> >> > >  #else
> >> > >      return true;
> >> > >  #endif
> >> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> >> > > index 124ed33ee4..a71473b243 100644
> >> > > --- a/target/riscv/cpu.h
> >> > > +++ b/target/riscv/cpu.h
> >> > > @@ -121,15 +121,6 @@ struct CPURISCVState {
> >> > >      target_ulong mhartid;
> >> > >      target_ulong mstatus;
> >> > >
> >> > > -    /*
> >> > > -     * CAUTION! Unlike the rest of this struct, mip is accessed asynchonously
> >> > > -     * by I/O threads. It should be read with atomic_read. It should be updated
> >> > > -     * using riscv_cpu_update_mip with the iothread mutex held. The iothread
> >> > > -     * mutex must be held because mip must be consistent with the CPU inturrept
> >> > > -     * state. riscv_cpu_update_mip calls cpu_interrupt or cpu_reset_interrupt
> >> > > -     * wuth the invariant that CPU_INTERRUPT_HARD is set iff mip is non-zero.
> >> > > -     * mip is 32-bits to allow atomic_read on 32-bit hosts.
> >> > > -     */
> >> > >      uint32_t mip;
> >> > >      uint32_t miclaim;
> >> > >
> >> > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >> > > index 87dd6a6ece..4334978c2e 100644
> >> > > --- a/target/riscv/cpu_helper.c
> >> > > +++ b/target/riscv/cpu_helper.c
> >> > > @@ -19,6 +19,7 @@
> >> > >
> >> > >  #include "qemu/osdep.h"
> >> > >  #include "qemu/log.h"
> >> > > +#include "qemu/main-loop.h"
> >> > >  #include "cpu.h"
> >> > >  #include "exec/exec-all.h"
> >> > >  #include "tcg-op.h"
> >> > > @@ -38,7 +39,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
> >> > >  {
> >> > >      target_ulong mstatus_mie = get_field(env->mstatus, MSTATUS_MIE);
> >> > >      target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
> >> > > -    target_ulong pending = atomic_read(&env->mip) & env->mie;
> >> > > +    target_ulong pending = env->mip & env->mie;
> >> > >      target_ulong mie = env->priv < PRV_M || (env->priv == PRV_M && mstatus_mie);
> >> > >      target_ulong sie = env->priv < PRV_S || (env->priv == PRV_S && mstatus_sie);
> >> > >      target_ulong irqs = (pending & ~env->mideleg & -mie) |
> >> > > @@ -92,42 +93,29 @@ int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
> >> > >      }
> >> > >  }
> >> > >
> >> > > -struct CpuAsyncInfo {
> >> > > -    uint32_t new_mip;
> >> > > -};
> >> > > -
> >> > > -static void riscv_cpu_update_mip_irqs_async(CPUState *target_cpu_state,
> >> > > -                                            run_on_cpu_data data)
> >> > > -{
> >> > > -    struct CpuAsyncInfo *info = (struct CpuAsyncInfo *) data.host_ptr;
> >> > > -
> >> > > -    if (info->new_mip) {
> >> > > -        cpu_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
> >> > > -    } else {
> >> > > -        cpu_reset_interrupt(target_cpu_state, CPU_INTERRUPT_HARD);
> >> > > -    }
> >> > > -
> >> > > -    g_free(info);
> >> > > -}
> >> > > -
> >> > >  uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value)
> >> > >  {
> >> > >      CPURISCVState *env = &cpu->env;
> >> > >      CPUState *cs = CPU(cpu);
> >> > > -    struct CpuAsyncInfo *info;
> >> > > -    uint32_t old, new, cmp = atomic_read(&env->mip);
> >> > > +    uint32_t old = env->mip;
> >> > > +    bool locked = false;
> >> > > +
> >> > > +    if (!qemu_mutex_iothread_locked()) {
> >> > > +        locked = true;
> >> > > +        qemu_mutex_lock_iothread();
> >> > > +    }
> >> >
> >> > I must be lost here, because I have no idea what this is trying to do.
> >>
> >> We lock the QEMU IO Thread before we trigger an interrupt. This way we
> >> can call it from the PLIC.
> >
> > Ping! This missed the latest PR.
>
> Sorry, I missed your reply.
>
> I really don't think this does that.  For example: if two threads enter this
> function at the same time, both will see that the lock is not taken and try to
> take it.  One will succeed and the other will fail, but both will have

That's not what this is doing. This is ensuring that if we enter this
function with the IO thread lock we won't try to lock it again, if it
isn't locked we will take the lock. We then also only unlock it if we
took the lock. This way when we return from the function we didn't
change the lock state.

QEMU will assert() if you try to lock the locked IO thread, this makes
sure that we don't do that.

Alistair

> 'locked=true' so both will try to unlock.  The first will win, causing the
> second function to execute for some period without the lock.  Then the second
> will unlock, possibly defeating another lock somewhere else.
>
> It smells kind of like this is trying to be a recursive lock, but those are a
> whole lot more complicated than this.
>
> >
> > Alistair
> >
> >>
> >> Alistair
> >>
> >> >
> >> > > -    do {
> >> > > -        old = cmp;
> >> > > -        new = (old & ~mask) | (value & mask);
> >> > > -        cmp = atomic_cmpxchg(&env->mip, old, new);
> >> > > -    } while (old != cmp);
> >> > > +    env->mip = (env->mip & ~mask) | (value & mask);
> >> > >
> >> > > -    info = g_new(struct CpuAsyncInfo, 1);
> >> > > -    info->new_mip = new;
> >> > > +    if (env->mip) {
> >> > > +        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> >> > > +    } else {
> >> > > +        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> >> > > +    }
> >> > >
> >> > > -    async_run_on_cpu(cs, riscv_cpu_update_mip_irqs_async,
> >> > > -                     RUN_ON_CPU_HOST_PTR(info));
> >> > > +    if (locked) {
> >> > > +        qemu_mutex_unlock_iothread();
> >> > > +    }
> >> > >
> >> > >      return old;
> >> > >  }
> >> > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >> > > index f767ad24be..db0cc6ef55 100644
> >> > > --- a/target/riscv/csr.c
> >> > > +++ b/target/riscv/csr.c
> >> > > @@ -579,7 +579,7 @@ static int rmw_mip(CPURISCVState *env, int csrno, target_ulong *ret_value,
> >> > >      if (mask) {
> >> > >          old_mip = riscv_cpu_update_mip(cpu, mask, (new_value & mask));
> >> > >      } else {
> >> > > -        old_mip = atomic_read(&env->mip);
> >> > > +        old_mip = env->mip;
> >> > >      }
> >> > >
> >> > >      if (ret_value) {

