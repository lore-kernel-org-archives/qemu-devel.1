Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2ABC2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 00:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0381E21734
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 00:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eecYHtRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0381E21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu3TM-0003HQ-4N
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 19:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iu3SH-0002ne-R0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 19:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iu3SF-00017U-Ao
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 19:01:09 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iu3S9-0007pO-79; Tue, 21 Jan 2020 19:01:01 -0500
Received: by mail-lj1-x244.google.com with SMTP id m26so4700484ljc.13;
 Tue, 21 Jan 2020 16:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lvM5HzMe7OasHN/yh90GhXvYnA4IAahosCCAQmxsXyc=;
 b=eecYHtRKs/y1xwwKAT23UIJSAec1IyA2sPPcfGGkBXP5VgeneLl+jCHq3Bis9KAiY/
 Vtk8BT7df4Iicu9t9i+IRnXzNTKeTJZ/bWzjV0Op6SB2mSDYsszCnM/D+Mw1cw+wTz5D
 6wEjL10REF2rvua5HWVQOYjx3dWp6qSfRv//PBOMvL0rSuRWHQQ+V+jSFER4OxsRRSSr
 7WBhV/BkyWQyUcn9vQ+jU+yMk7wFV6Ink5rAJ+kV6Dt8bwJsoHkW98bMkVzOiOx+3bKI
 bYcAu6z+wVUXsh6xUbZy9SCt65KgdVfk+VWBgv37aZDGd9JHVOiJRJlxCcoL6dSjVNdT
 6Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lvM5HzMe7OasHN/yh90GhXvYnA4IAahosCCAQmxsXyc=;
 b=s+QfGZ9lz/DLgBn/MhHbLdYpjgE5v6BauiQT//t36zH4Gdcb0y1vSyTwe4SXKJxaqv
 FwYRUhZCw3wPlRRcGO1zxsDdYaj9wBmLxb4WNjMyLgOF2tV4H6l5hDNMJmnJEiGhJqH+
 PdN1+kr622CTUmokZuZFTPOopUudCF/Uy4j5bEcEh4YIthq0IDVkSTCvcxf4cnVe405k
 V4i2weB+TaLIyo/Km4WuLfWMLsZs6X54D+DzrPilepHGIJlo10Sj+jnNc6QcwGE8iMKh
 6xQnkw62axAV4xIgPl9GE8/2B50qPevlzsOADTa5ezXxLaZ7tHL8Tlw4VOWprRXEFEvj
 bO3Q==
X-Gm-Message-State: APjAAAUHlwKB6YUI3jo5oXEcG6gDJCAKJX3io0rB+p45nAUdrmk6ByYc
 QmqL+4yoyYtrS4iGSqyQiRcx8Ejbh5I7ttfBEQM=
X-Google-Smtp-Source: APXvYqxWhRWJKx7lnwWnFwdbTX7T4cR2vXbdvdY+KbI9TB86eBEuNM39NCbfqh4K2XsNRvBsA6tjOUdB+1EurAE2Sx4=
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr17785267ljj.206.1579651259698; 
 Tue, 21 Jan 2020 16:00:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575914822.git.alistair.francis@wdc.com>
 <8c0eebc3868757e9ed312ac35e1f5325d5a18e76.1575914822.git.alistair.francis@wdc.com>
 <mhng-b22b75ac-a0c4-4d53-909c-2a8fd9506cd3@palmerdabbelt-glaptop>
 <CAKmqyKPOn_ULNu6i+s-0k-GGkZ0Gz9adNQcD1UU77u9t77ZXXQ@mail.gmail.com>
 <CANnJOVHAYA4uij86C0aBMp6FnZW=+i-v_K7iAcbTiEuUfkT8dQ@mail.gmail.com>
In-Reply-To: <CANnJOVHAYA4uij86C0aBMp6FnZW=+i-v_K7iAcbTiEuUfkT8dQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Jan 2020 10:00:29 +1000
Message-ID: <CAKmqyKNrM6WnPRbcsLw-7xgW4Wo5=BJ1JRknYnXcnWZ6t4mMJg@mail.gmail.com>
Subject: Re: [PATCH v1 15/36] target/riscv: Convert mstatus to pointers
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 10:56 PM Jonathan Behrens <fintelia@gmail.com> wrot=
e:
>
> When I looked through the relevant code a few months ago, I couldn't find=
 anywhere that could actually be agnostic to whether the real or virtual re=
gisters were in effect (other than emulating the actual CSR modification in=
structions). For almost all state, the VS behavior is filtered by HS-mode c=
ode. For example, you can grab satp in either mode but to properly do addre=
ss translation you also have to factor in hgatp so you need to know the vir=
tualization state anyway. Similarly, floating point co-proccessor state is =
tracked in two places with V=3D1 so that both the host and the guest can in=
dependently track dirty bits, but of course only the one in the "real" msta=
tus applies in non-virtualized mode.

So the idea is that if you aren't interested in the Hypervisor
extension you can just access the CSRs as usual (inside QEMU's source
code). That is you don't need to know anything about the Hypervisor
extension to add support for other extensions or to work on the RISC-V
target in QEMU.

I was trying to avoid forcing everyone to understand the Hypervisor
extension to develop for RISC-V. For example we don't have to check
virtulasition status to dump the registers, we can just dump them and
know they are in the correct state (we do dump more is we have the
extension though). Image if someone adds a new way to dump registers,
I would like them not to care about if we are in V=3D1 or V=3D0 and they
can just dump them and know that the CSRs are correct.

>
> The idea of using an array to track the two versions of registers seemed =
really elegant to me. If you know you want the host version you access elem=
ent zero. If you know you want the guest version you access element one. An=
d if you want the version that the running code would see you index by the =
virtualization mode. In any case, the choice indicates that you thought tho=
ugh which was the right option to use in that instance.

mstatus really is the only one that has any complications. The others
have a vs* version, which could be converted to an array but it
doesn't really matter as we just swap them.

Alistair

>
> Jonathan
>
> On Tue, Jan 21, 2020 at 6:02 AM Alistair Francis <alistair23@gmail.com> w=
rote:
>>
>> On Wed, Jan 8, 2020 at 11:30 AM Palmer Dabbelt <palmerdabbelt@google.com=
> wrote:
>> >
>> > On Mon, 09 Dec 2019 10:11:19 PST (-0800), Alistair Francis wrote:
>> > > To handle the new Hypervisor CSR register aliasing let's use pointer=
s.
>> >
>> > For some reason I thought we were making this explicit?  In other word=
s,
>> > requiring that all callers provide which privilege mode they're using =
when
>> > accessing these CSRs, as opposed to swapping around pointers.  I don't=
 actually
>> > care that much, but IIRC when we were talking with the ARM guys at Plu=
mbers
>> > they were pretty adament that would end up being a much cleaner implem=
entation
>> > as they'd tried this way and later changed over.
>>
>> I think their implementation is different so it doesn't apply the same h=
ere.
>>
>> My main concern is that due to the modularity of RISC-V I don't expect
>> all future developers to keep track of the Hypervisor extensions. This
>> way we always have the correct state in the registers.
>>
>> There is only one pointer variable left, so we could drop the pointer
>> swapping part, but for now it's still here.
>>
>> Alistair
>>
>> >
>> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > > ---
>> > >  target/riscv/cpu.c        | 11 +++++++++--
>> > >  target/riscv/cpu.h        |  9 ++++++++-
>> > >  target/riscv/cpu_helper.c | 30 +++++++++++++++---------------
>> > >  target/riscv/csr.c        | 20 ++++++++++----------
>> > >  target/riscv/op_helper.c  | 14 +++++++-------
>> > >  5 files changed, 49 insertions(+), 35 deletions(-)
>> > >
>> > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> > > index a07c5689b3..e61cf46a73 100644
>> > > --- a/target/riscv/cpu.c
>> > > +++ b/target/riscv/cpu.c
>> > > @@ -236,7 +236,7 @@ static void riscv_cpu_dump_state(CPUState *cs, F=
ILE *f, int flags)
>> > >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc)=
;
>> > >  #ifndef CONFIG_USER_ONLY
>> > >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mha=
rtid);
>> > > -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mst=
atus);
>> > > +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", *env->ms=
tatus);
>> > >      if (riscv_has_ext(env, RVH)) {
>> > >          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env-=
>hstatus);
>> > >          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env=
->vsstatus);
>> > > @@ -336,7 +336,7 @@ static void riscv_cpu_reset(CPUState *cs)
>> > >      mcc->parent_reset(cs);
>> > >  #ifndef CONFIG_USER_ONLY
>> > >      env->priv =3D PRV_M;
>> > > -    env->mstatus &=3D ~(MSTATUS_MIE | MSTATUS_MPRV);
>> > > +    *env->mstatus &=3D ~(MSTATUS_MIE | MSTATUS_MPRV);
>> > >      env->mcause =3D 0;
>> > >      env->pc =3D env->resetvec;
>> > >  #endif
>> > > @@ -465,8 +465,15 @@ static void riscv_cpu_realize(DeviceState *dev,=
 Error **errp)
>> > >  static void riscv_cpu_init(Object *obj)
>> > >  {
>> > >      RISCVCPU *cpu =3D RISCV_CPU(obj);
>> > > +#ifndef CONFIG_USER_ONLY
>> > > +    CPURISCVState *env =3D &cpu->env;
>> > > +#endif
>> > >
>> > >      cpu_set_cpustate_pointers(cpu);
>> > > +
>> > > +#ifndef CONFIG_USER_ONLY
>> > > +    env->mstatus =3D &env->mstatus_novirt;
>> > > +#endif
>> > >  }
>> > >
>> > >  static const VMStateDescription vmstate_riscv_cpu =3D {
>> > > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> > > index 21ae5a8b19..9dc8303c62 100644
>> > > --- a/target/riscv/cpu.h
>> > > +++ b/target/riscv/cpu.h
>> > > @@ -122,7 +122,7 @@ struct CPURISCVState {
>> > >      target_ulong resetvec;
>> > >
>> > >      target_ulong mhartid;
>> > > -    target_ulong mstatus;
>> > > +    target_ulong *mstatus;
>> > >
>> > >      target_ulong mip;
>> > >      uint32_t miclaim;
>> > > @@ -145,6 +145,13 @@ struct CPURISCVState {
>> > >      target_ulong mcause;
>> > >      target_ulong mtval;  /* since: priv-1.10.0 */
>> > >
>> > > +    /* The following registers are the "real" versions that the poi=
nter
>> > > +     * versions point to. These should never be used unless you kno=
w what you
>> > > +     * are doing. To access these use the pointer versions instead.=
 This is
>> > > +     * required to handle the Hypervisor register swapping.
>> > > +     */
>> > > +    target_ulong mstatus_novirt;
>> > > +
>> > >      /* Hypervisor CSRs */
>> > >      target_ulong hstatus;
>> > >      target_ulong hedeleg;
>> > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> > > index b00f66824a..9684da7f7d 100644
>> > > --- a/target/riscv/cpu_helper.c
>> > > +++ b/target/riscv/cpu_helper.c
>> > > @@ -37,8 +37,8 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool i=
fetch)
>> > >  #ifndef CONFIG_USER_ONLY
>> > >  static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>> > >  {
>> > > -    target_ulong mstatus_mie =3D get_field(env->mstatus, MSTATUS_MI=
E);
>> > > -    target_ulong mstatus_sie =3D get_field(env->mstatus, MSTATUS_SI=
E);
>> > > +    target_ulong mstatus_mie =3D get_field(*env->mstatus, MSTATUS_M=
IE);
>> > > +    target_ulong mstatus_sie =3D get_field(*env->mstatus, MSTATUS_S=
IE);
>> > >      target_ulong pending =3D env->mip & env->mie;
>> > >      target_ulong mie =3D env->priv < PRV_M || (env->priv =3D=3D PRV=
_M && mstatus_mie);
>> > >      target_ulong sie =3D env->priv < PRV_S || (env->priv =3D=3D PRV=
_S && mstatus_sie);
>> > > @@ -75,7 +75,7 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int in=
terrupt_request)
>> > >  /* Return true is floating point support is currently enabled */
>> > >  bool riscv_cpu_fp_enabled(CPURISCVState *env)
>> > >  {
>> > > -    if (env->mstatus & MSTATUS_FS) {
>> > > +    if (*env->mstatus & MSTATUS_FS) {
>> > >          return true;
>> > >      }
>> > >
>> > > @@ -198,8 +198,8 @@ static int get_physical_address(CPURISCVState *e=
nv, hwaddr *physical,
>> > >      int mode =3D mmu_idx;
>> > >
>> > >      if (mode =3D=3D PRV_M && access_type !=3D MMU_INST_FETCH) {
>> > > -        if (get_field(env->mstatus, MSTATUS_MPRV)) {
>> > > -            mode =3D get_field(env->mstatus, MSTATUS_MPP);
>> > > +        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
>> > > +            mode =3D get_field(*env->mstatus, MSTATUS_MPP);
>> > >          }
>> > >      }
>> > >
>> > > @@ -213,11 +213,11 @@ static int get_physical_address(CPURISCVState =
*env, hwaddr *physical,
>> > >
>> > >      hwaddr base;
>> > >      int levels, ptidxbits, ptesize, vm, sum;
>> > > -    int mxr =3D get_field(env->mstatus, MSTATUS_MXR);
>> > > +    int mxr =3D get_field(*env->mstatus, MSTATUS_MXR);
>> > >
>> > >      if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
>> > >          base =3D (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
>> > > -        sum =3D get_field(env->mstatus, MSTATUS_SUM);
>> > > +        sum =3D get_field(*env->mstatus, MSTATUS_SUM);
>> > >          vm =3D get_field(env->satp, SATP_MODE);
>> > >          switch (vm) {
>> > >          case VM_1_10_SV32:
>> > > @@ -237,8 +237,8 @@ static int get_physical_address(CPURISCVState *e=
nv, hwaddr *physical,
>> > >          }
>> > >      } else {
>> > >          base =3D (hwaddr)(env->sptbr) << PGSHIFT;
>> > > -        sum =3D !get_field(env->mstatus, MSTATUS_PUM);
>> > > -        vm =3D get_field(env->mstatus, MSTATUS_VM);
>> > > +        sum =3D !get_field(*env->mstatus, MSTATUS_PUM);
>> > > +        vm =3D get_field(*env->mstatus, MSTATUS_VM);
>> > >          switch (vm) {
>> > >          case VM_1_09_SV32:
>> > >            levels =3D 2; ptidxbits =3D 10; ptesize =3D 4; break;
>> > > @@ -492,8 +492,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr addr=
ess, int size,
>> > >      ret =3D get_physical_address(env, &pa, &prot, address, access_t=
ype, mmu_idx);
>> > >
>> > >      if (mode =3D=3D PRV_M && access_type !=3D MMU_INST_FETCH) {
>> > > -        if (get_field(env->mstatus, MSTATUS_MPRV)) {
>> > > -            mode =3D get_field(env->mstatus, MSTATUS_MPP);
>> > > +        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
>> > > +            mode =3D get_field(*env->mstatus, MSTATUS_MPP);
>> > >          }
>> > >      }
>> > >
>> > > @@ -599,12 +599,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>> > >      if (env->priv <=3D PRV_S &&
>> > >              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
>> > >          /* handle the trap in S-mode */
>> > > -        target_ulong s =3D env->mstatus;
>> > > +        target_ulong s =3D *env->mstatus;
>> > >          s =3D set_field(s, MSTATUS_SPIE, env->priv_ver >=3D PRIV_VE=
RSION_1_10_0 ?
>> > >              get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE <<=
 env->priv));
>> > >          s =3D set_field(s, MSTATUS_SPP, env->priv);
>> > >          s =3D set_field(s, MSTATUS_SIE, 0);
>> > > -        env->mstatus =3D s;
>> > > +        *env->mstatus =3D s;
>> > >          env->scause =3D cause | ((target_ulong)async << (TARGET_LON=
G_BITS - 1));
>> > >          env->sepc =3D env->pc;
>> > >          env->sbadaddr =3D tval;
>> > > @@ -613,12 +613,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>> > >          riscv_cpu_set_mode(env, PRV_S);
>> > >      } else {
>> > >          /* handle the trap in M-mode */
>> > > -        target_ulong s =3D env->mstatus;
>> > > +        target_ulong s =3D *env->mstatus;
>> > >          s =3D set_field(s, MSTATUS_MPIE, env->priv_ver >=3D PRIV_VE=
RSION_1_10_0 ?
>> > >              get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE <<=
 env->priv));
>> > >          s =3D set_field(s, MSTATUS_MPP, env->priv);
>> > >          s =3D set_field(s, MSTATUS_MIE, 0);
>> > > -        env->mstatus =3D s;
>> > > +        *env->mstatus =3D s;
>> > >          env->mcause =3D cause | ~(((target_ulong)-1) >> async);
>> > >          env->mepc =3D env->pc;
>> > >          env->mbadaddr =3D tval;
>> > > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> > > index 74e911af08..a4b598d49a 100644
>> > > --- a/target/riscv/csr.c
>> > > +++ b/target/riscv/csr.c
>> > > @@ -136,7 +136,7 @@ static int write_fflags(CPURISCVState *env, int =
csrno, target_ulong val)
>> > >      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>> > >          return -1;
>> > >      }
>> > > -    env->mstatus |=3D MSTATUS_FS;
>> > > +    *env->mstatus |=3D MSTATUS_FS;
>> > >  #endif
>> > >      riscv_cpu_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
>> > >      return 0;
>> > > @@ -159,7 +159,7 @@ static int write_frm(CPURISCVState *env, int csr=
no, target_ulong val)
>> > >      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>> > >          return -1;
>> > >      }
>> > > -    env->mstatus |=3D MSTATUS_FS;
>> > > +    *env->mstatus |=3D MSTATUS_FS;
>> > >  #endif
>> > >      env->frm =3D val & (FSR_RD >> FSR_RD_SHIFT);
>> > >      return 0;
>> > > @@ -183,7 +183,7 @@ static int write_fcsr(CPURISCVState *env, int cs=
rno, target_ulong val)
>> > >      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>> > >          return -1;
>> > >      }
>> > > -    env->mstatus |=3D MSTATUS_FS;
>> > > +    *env->mstatus |=3D MSTATUS_FS;
>> > >  #endif
>> > >      env->frm =3D (val & FSR_RD) >> FSR_RD_SHIFT;
>> > >      riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
>> > > @@ -313,7 +313,7 @@ static int read_mhartid(CPURISCVState *env, int =
csrno, target_ulong *val)
>> > >  /* Machine Trap Setup */
>> > >  static int read_mstatus(CPURISCVState *env, int csrno, target_ulong=
 *val)
>> > >  {
>> > > -    *val =3D env->mstatus;
>> > > +    *val =3D *env->mstatus;
>> > >      return 0;
>> > >  }
>> > >
>> > > @@ -325,7 +325,7 @@ static int validate_vm(CPURISCVState *env, targe=
t_ulong vm)
>> > >
>> > >  static int write_mstatus(CPURISCVState *env, int csrno, target_ulon=
g val)
>> > >  {
>> > > -    target_ulong mstatus =3D env->mstatus;
>> > > +    target_ulong mstatus =3D *env->mstatus;
>> > >      target_ulong mask =3D 0;
>> > >      int dirty;
>> > >
>> > > @@ -365,7 +365,7 @@ static int write_mstatus(CPURISCVState *env, int=
 csrno, target_ulong val)
>> > >               ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS)) |
>> > >              ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
>> > >      mstatus =3D set_field(mstatus, MSTATUS_SD, dirty);
>> > > -    env->mstatus =3D mstatus;
>> > > +    *env->mstatus =3D mstatus;
>> > >
>> > >      return 0;
>> > >  }
>> > > @@ -614,7 +614,7 @@ static int read_sstatus(CPURISCVState *env, int =
csrno, target_ulong *val)
>> > >  {
>> > >      target_ulong mask =3D ((env->priv_ver >=3D PRIV_VERSION_1_10_0)=
 ?
>> > >                           sstatus_v1_10_mask : sstatus_v1_9_mask);
>> > > -    *val =3D env->mstatus & mask;
>> > > +    *val =3D *env->mstatus & mask;
>> > >      return 0;
>> > >  }
>> > >
>> > > @@ -622,7 +622,7 @@ static int write_sstatus(CPURISCVState *env, int=
 csrno, target_ulong val)
>> > >  {
>> > >      target_ulong mask =3D ((env->priv_ver >=3D PRIV_VERSION_1_10_0)=
 ?
>> > >                           sstatus_v1_10_mask : sstatus_v1_9_mask);
>> > > -    target_ulong newval =3D (env->mstatus & ~mask) | (val & mask);
>> > > +    target_ulong newval =3D (*env->mstatus & ~mask) | (val & mask);
>> > >      return write_mstatus(env, CSR_MSTATUS, newval);
>> > >  }
>> > >
>> > > @@ -737,7 +737,7 @@ static int read_satp(CPURISCVState *env, int csr=
no, target_ulong *val)
>> > >      if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
>> > >          *val =3D 0;
>> > >      } else if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
>> > > -        if (env->priv =3D=3D PRV_S && get_field(env->mstatus, MSTAT=
US_TVM)) {
>> > > +        if (env->priv =3D=3D PRV_S && get_field(*env->mstatus, MSTA=
TUS_TVM)) {
>> > >              return -1;
>> > >          } else {
>> > >              *val =3D env->satp;
>> > > @@ -762,7 +762,7 @@ static int write_satp(CPURISCVState *env, int cs=
rno, target_ulong val)
>> > >          validate_vm(env, get_field(val, SATP_MODE)) &&
>> > >          ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
>> > >      {
>> > > -        if (env->priv =3D=3D PRV_S && get_field(env->mstatus, MSTAT=
US_TVM)) {
>> > > +        if (env->priv =3D=3D PRV_S && get_field(*env->mstatus, MSTA=
TUS_TVM)) {
>> > >              return -1;
>> > >          } else {
>> > >              if((val ^ env->satp) & SATP_ASID) {
>> > > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>> > > index 331cc36232..d150551bc9 100644
>> > > --- a/target/riscv/op_helper.c
>> > > +++ b/target/riscv/op_helper.c
>> > > @@ -83,11 +83,11 @@ target_ulong helper_sret(CPURISCVState *env, tar=
get_ulong cpu_pc_deb)
>> > >      }
>> > >
>> > >      if (env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
>> > > -        get_field(env->mstatus, MSTATUS_TSR)) {
>> > > +        get_field(*env->mstatus, MSTATUS_TSR)) {
>> > >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC()=
);
>> > >      }
>> > >
>> > > -    target_ulong mstatus =3D env->mstatus;
>> > > +    target_ulong mstatus =3D *env->mstatus;
>> > >      target_ulong prev_priv =3D get_field(mstatus, MSTATUS_SPP);
>> > >      mstatus =3D set_field(mstatus,
>> > >          env->priv_ver >=3D PRIV_VERSION_1_10_0 ?
>> > > @@ -96,7 +96,7 @@ target_ulong helper_sret(CPURISCVState *env, targe=
t_ulong cpu_pc_deb)
>> > >      mstatus =3D set_field(mstatus, MSTATUS_SPIE, 0);
>> > >      mstatus =3D set_field(mstatus, MSTATUS_SPP, PRV_U);
>> > >      riscv_cpu_set_mode(env, prev_priv);
>> > > -    env->mstatus =3D mstatus;
>> > > +    *env->mstatus =3D mstatus;
>> > >
>> > >      return retpc;
>> > >  }
>> > > @@ -112,7 +112,7 @@ target_ulong helper_mret(CPURISCVState *env, tar=
get_ulong cpu_pc_deb)
>> > >          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC(=
));
>> > >      }
>> > >
>> > > -    target_ulong mstatus =3D env->mstatus;
>> > > +    target_ulong mstatus =3D *env->mstatus;
>> > >      target_ulong prev_priv =3D get_field(mstatus, MSTATUS_MPP);
>> > >      mstatus =3D set_field(mstatus,
>> > >          env->priv_ver >=3D PRIV_VERSION_1_10_0 ?
>> > > @@ -121,7 +121,7 @@ target_ulong helper_mret(CPURISCVState *env, tar=
get_ulong cpu_pc_deb)
>> > >      mstatus =3D set_field(mstatus, MSTATUS_MPIE, 0);
>> > >      mstatus =3D set_field(mstatus, MSTATUS_MPP, PRV_U);
>> > >      riscv_cpu_set_mode(env, prev_priv);
>> > > -    env->mstatus =3D mstatus;
>> > > +    *env->mstatus =3D mstatus;
>> > >
>> > >      return retpc;
>> > >  }
>> > > @@ -132,7 +132,7 @@ void helper_wfi(CPURISCVState *env)
>> > >
>> > >      if (env->priv =3D=3D PRV_S &&
>> > >          env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
>> > > -        get_field(env->mstatus, MSTATUS_TW)) {
>> > > +        get_field(*env->mstatus, MSTATUS_TW)) {
>> > >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC()=
);
>> > >      } else {
>> > >          cs->halted =3D 1;
>> > > @@ -147,7 +147,7 @@ void helper_tlb_flush(CPURISCVState *env)
>> > >      if (!(env->priv >=3D PRV_S) ||
>> > >          (env->priv =3D=3D PRV_S &&
>> > >           env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
>> > > -         get_field(env->mstatus, MSTATUS_TVM))) {
>> > > +         get_field(*env->mstatus, MSTATUS_TVM))) {
>> > >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC()=
);
>> > >      } else {
>> > >          tlb_flush(cs);
>>

