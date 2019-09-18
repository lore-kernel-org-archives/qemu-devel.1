Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772F7C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F862206C1
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 23:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOU7uKjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F862206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAjlT-0004Jj-4p
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 19:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iAjkW-0003b1-BA
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iAjkT-0006oo-H9
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 19:52:40 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iAjkN-0006md-Lf; Wed, 18 Sep 2019 19:52:32 -0400
Received: by mail-lf1-x142.google.com with SMTP id d17so931309lfa.7;
 Wed, 18 Sep 2019 16:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JGFrOa7U+QFQwm76uAo8EaCN3xHRL0MoJFkeI0Az5iw=;
 b=jOU7uKjODwk2yvivREk7Ko9SMLB7i/9aefD+EKqs6Kn30dpXRfyXua7U1Yd8VZqjgJ
 3qbRRXY0vDNKhvQPjgb0zlpZwaEt6+8JNBab0jz2mPPhOjG6QezfCYTkPU9gcN21RN/W
 WGmxBIo9NgJXMbW5L4cxoMfDUroHyRuq6rwVbiDXp6YRGrcyx6QjOrUdRw7578+PypTL
 G+pAcuxn/y/TpXCotGhh/sZTOjEb7DTDljX/g5gNBsFzHFGk8h38Z0AXRlxzFM4EZnKU
 Lu0+O3VGeARnz1bbWYs9yvf1U4S9oYrgK4a8lM5T+1r75ZssgUC8SAyEEIf0IgieD+I6
 aCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JGFrOa7U+QFQwm76uAo8EaCN3xHRL0MoJFkeI0Az5iw=;
 b=ENXck8GINbRJ0I9n+y7G29SiCReCSsNWo1vaRTEPLRroSO0JDC99ZztIoK6zFZsRmM
 7OX+O3cC/HSMr38jkTT46tHhXLWe7RDpqWPLp+6YIE4hupYBe0Ar5huV5oJ2bQ9FSd/1
 46sKD58IgnAEszZDhxOxHqdJUeIIMu5L7kDWw2U0jJl8MKFwJswl0d0lVMHPBksuFtD8
 EgK8MwHPsmx1D3AB15DJA39KBrZIKrh0aE6hu9+sFDVVYpidvMKW6h3ozMy0Jmjd4Zij
 jXWgSYkCzbOUKU83neUf9h6U3YI2spwwHpKprsvAT2INesa6+SFQYyecfAGMBTVxLeF0
 qYWw==
X-Gm-Message-State: APjAAAX5Dz8xrWBNeTh0rEo2mjnzrtT66nVn3K49JoMWTQW3lndDGHmZ
 CvCQ/ugHR19hhdyAPGKTjf0eRzncsgxNMLGR8QM=
X-Google-Smtp-Source: APXvYqy9gamO8tHsfrX3Q72mcvyIHMRBN/plZzVwCZYsYKiauvQQVm0nae8FKO+nkD3XPg6UGJQcPS1p+MbT+fod2LE=
X-Received: by 2002:ac2:4a69:: with SMTP id q9mr3222784lfp.86.1568850749508;
 Wed, 18 Sep 2019 16:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <850360df8fc15a3671bf2237f972ebaf09110015.1566603412.git.alistair.francis@wdc.com>
 <mhng-b813f03d-c23e-405a-8213-c4c9b22a6831@palmer-si-x1e>
 <CANnJOVFNqXEg9KkJC4CHkt0KTt2_6HjyhU2CvMROW+e79mDncA@mail.gmail.com>
 <CAKmqyKMfODSjbBm5ZgmHYYzzrf3B_4WEbANeKXo6rSO6V5Pzeg@mail.gmail.com>
 <CANnJOVGPW1ppNdx+=KAvgNhgGQPvJxjyGY=rxunicu=f++xhiQ@mail.gmail.com>
In-Reply-To: <CANnJOVGPW1ppNdx+=KAvgNhgGQPvJxjyGY=rxunicu=f++xhiQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 18 Sep 2019 16:47:55 -0700
Message-ID: <CAKmqyKPQPrPKdkaRjZ7P75jamuqEq6BABir56VrYGm=ZSFpAww@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCH v1 10/28] target/riscv:
 Convert mie and mstatus to pointers
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 7:00 PM Jonathan Behrens <fintelia@gmail.com> wrote=
:
>
> I went through the uses of mie in the entire hypervisor patch series and =
it seems like it would be much simpler to just have two non-pointer fields =
in the CPU struct: mie and vsie. To if an interrupt is pending, you are eit=
her running with V=3D0 in which case the contents of vsie can be ignored, o=
r you are running with V=3D1 and have to check both anyway. And the read_si=
e/write_sie would just need a single extra branch return proper results. Th=
e read_mie and write_mie function wouldn't need to be changed at all: if M-=
mode is running to access them, then V=3D0. (When queried from a debugger w=
hile V=3D1, I think the result would actually be more correct this way: the=
 bits of mie are supposed to always reflect sie rather than vsie).

Hello Jonathan,

Pleas make sure you reply inline, otherwise it is difficult to track
the order of messages. Can you also please wrap your lines at 80
characters.

What about in the future when some other extension does something with
mie? I would rather not have conditionals around accessing core CSRs
(hence the pointer way).

The other problem is mstatus, which is more confusing. I am trying to
keep mie and mstatus (and eventually mip) all the same. Having
different styles for different CSRs also seems confusing. Granted it
is now different between the m/s and s only CSRs, but that seems
unavoidable.

I'm not a fan of the pointer method that I'm using, but to me it seems
the least worst in terms of handling future code, keeping everythign
consistnent and avoiding complex access rules.

Alistair

>
> Jonathan
>
> On Tue, Sep 17, 2019 at 7:37 PM Alistair Francis <alistair23@gmail.com> w=
rote:
>>
>> On Wed, Sep 11, 2019 at 7:55 AM Jonathan Behrens <fintelia@gmail.com> wr=
ote:
>> >
>> > Version 0.4 of the hypervisor spec no longer talks about swapping regi=
sters. Instead when running in VS-mode some of the supervisor registers are=
 "aliased" and actually refer to alternate versions. Implementations are of=
 course still allowed to do swapping internally if desired, but it adds com=
plexity compared to a more straightforward implementation and isn't obvious=
 to me whether QEMU would get any benefit from it. At least, it is probably=
 worth fleshing out the rest of the v0.4 implementation before deciding on =
this patch.
>>
>> This patch is to handle the aliasing. The commit message isn't clear
>> (I'll fix that up) but this patch is required to handle the new alias
>> method instead of the previous swapping.
>>
>> Alistair
>>
>> > Jonathan
>> >
>> > On Wed, Sep 11, 2019 at 4:24 AM Palmer Dabbelt <palmer@sifive.com> wro=
te:
>> >>
>> >> On Fri, 23 Aug 2019 16:38:15 PDT (-0700), Alistair Francis wrote:
>> >> > To handle the new Hypervisor CSR register swapping let's use pointe=
rs.
>> >> >
>> >> > We only need to convert the MIE and MSTATUS CSRs. With the exceptio=
n of
>> >> > MIP all of the other CSRs that swap with virtulsation changes are S=
-Mode
>> >> > only, so we can just do a lazy switch. This because more challengin=
g for
>> >> > the M-Mode registers so it ends up being easier to use pointers.
>> >> >
>> >> > As the MIP CSR is always accessed atomicly the pointer swap doesn't=
 work
>> >> > so we leave that as is.
>> >> >
>> >> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> >> > ---
>> >> >  target/riscv/cpu.c        | 16 ++++++++++++----
>> >> >  target/riscv/cpu.h        | 12 ++++++++++--
>> >> >  target/riscv/cpu_helper.c | 32 ++++++++++++++++----------------
>> >> >  target/riscv/csr.c        | 28 ++++++++++++++--------------
>> >> >  target/riscv/op_helper.c  | 14 +++++++-------
>> >> >  5 files changed, 59 insertions(+), 43 deletions(-)
>> >> >
>> >> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> >> > index be8f643fc2..371d5845af 100644
>> >> > --- a/target/riscv/cpu.c
>> >> > +++ b/target/riscv/cpu.c
>> >> > @@ -228,7 +228,7 @@ static void riscv_cpu_dump_state(CPUState *cs, =
FILE *f, int flags)
>> >> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc=
);
>> >> >  #ifndef CONFIG_USER_ONLY
>> >> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mh=
artid);
>> >> > -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->ms=
tatus);
>> >> > +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", *env->m=
status);
>> >> >      if (riscv_has_ext(env, RVH)) {
>> >> >          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env=
->hstatus);
>> >> >          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bstatus ", env=
->vsstatus);
>> >> > @@ -239,7 +239,7 @@ static void riscv_cpu_dump_state(CPUState *cs, =
FILE *f, int flags)
>> >> >          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsip    ",
>> >> >                       (target_ulong)atomic_read(&env->vsip));
>> >> >      }
>> >> > -    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mi=
e);
>> >> > +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", *env->m=
ie);
>> >> >      if (riscv_has_ext(env, RVH)) {
>> >> >          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsie    ", env=
->vsie);
>> >> >      }
>> >> > @@ -309,7 +309,7 @@ static bool riscv_cpu_has_work(CPUState *cs)
>> >> >       * Definition of the WFI instruction requires it to ignore the=
 privilege
>> >> >       * mode and delegation registers, but respect individual enabl=
es
>> >> >       */
>> >> > -    return (atomic_read(&env->mip) & env->mie) !=3D 0;
>> >> > +    return (atomic_read(&env->mip) & *env->mie) !=3D 0;
>> >> >  #else
>> >> >      return true;
>> >> >  #endif
>> >> > @@ -330,7 +330,7 @@ static void riscv_cpu_reset(CPUState *cs)
>> >> >      mcc->parent_reset(cs);
>> >> >  #ifndef CONFIG_USER_ONLY
>> >> >      env->priv =3D PRV_M;
>> >> > -    env->mstatus &=3D ~(MSTATUS_MIE | MSTATUS_MPRV);
>> >> > +    *env->mstatus &=3D ~(MSTATUS_MIE | MSTATUS_MPRV);
>> >> >      env->mcause =3D 0;
>> >> >      env->pc =3D env->resetvec;
>> >> >  #endif
>> >> > @@ -459,8 +459,16 @@ static void riscv_cpu_realize(DeviceState *dev=
, Error **errp)
>> >> >  static void riscv_cpu_init(Object *obj)
>> >> >  {
>> >> >      RISCVCPU *cpu =3D RISCV_CPU(obj);
>> >> > +#ifndef CONFIG_USER_ONLY
>> >> > +    CPURISCVState *env =3D &cpu->env;
>> >> > +#endif
>> >> >
>> >> >      cpu_set_cpustate_pointers(cpu);
>> >> > +
>> >> > +#ifndef CONFIG_USER_ONLY
>> >> > +    env->mie =3D &env->mie_novirt;
>> >> > +    env->mstatus =3D &env->mstatus_novirt;
>> >> > +#endif
>> >> >  }
>> >> >
>> >> >  static const VMStateDescription vmstate_riscv_cpu =3D {
>> >> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> >> > index 4c342e7a79..680592cb60 100644
>> >> > --- a/target/riscv/cpu.h
>> >> > +++ b/target/riscv/cpu.h
>> >> > @@ -122,7 +122,7 @@ struct CPURISCVState {
>> >> >      target_ulong resetvec;
>> >> >
>> >> >      target_ulong mhartid;
>> >> > -    target_ulong mstatus;
>> >> > +    target_ulong *mstatus;
>> >> >
>> >> >      /*
>> >> >       * CAUTION! Unlike the rest of this struct, mip is accessed as=
ynchonously
>> >> > @@ -136,7 +136,7 @@ struct CPURISCVState {
>> >> >      uint32_t mip;
>> >> >      uint32_t miclaim;
>> >> >
>> >> > -    target_ulong mie;
>> >> > +    target_ulong *mie;
>> >> >      target_ulong mideleg;
>> >> >
>> >> >      target_ulong sptbr;  /* until: priv-1.9.1 */
>> >> > @@ -154,6 +154,14 @@ struct CPURISCVState {
>> >> >      target_ulong mcause;
>> >> >      target_ulong mtval;  /* since: priv-1.10.0 */
>> >> >
>> >> > +    /* The following registers are the "real" versions that the po=
inter
>> >> > +     * versions point to. These should never be used unless you kn=
ow what you
>> >> > +     * are doing. To access these use the pointer versions instead=
. This is
>> >> > +     * required to handle the Hypervisor register swapping.
>> >> > +     */
>> >> > +    target_ulong mie_novirt;
>> >> > +    target_ulong mstatus_novirt;
>> >> > +
>> >> >      /* Hypervisor CSRs */
>> >> >      target_ulong hstatus;
>> >> >      target_ulong hedeleg;
>> >> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> >> > index 5bcfc2e090..c597523d74 100644
>> >> > --- a/target/riscv/cpu_helper.c
>> >> > +++ b/target/riscv/cpu_helper.c
>> >> > @@ -36,9 +36,9 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool =
ifetch)
>> >> >  #ifndef CONFIG_USER_ONLY
>> >> >  static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>> >> >  {
>> >> > -    target_ulong mstatus_mie =3D get_field(env->mstatus, MSTATUS_M=
IE);
>> >> > -    target_ulong mstatus_sie =3D get_field(env->mstatus, MSTATUS_S=
IE);
>> >> > -    target_ulong pending =3D atomic_read(&env->mip) & env->mie;
>> >> > +    target_ulong mstatus_mie =3D get_field(*env->mstatus, MSTATUS_=
MIE);
>> >> > +    target_ulong mstatus_sie =3D get_field(*env->mstatus, MSTATUS_=
SIE);
>> >> > +    target_ulong pending =3D atomic_read(env->mip) & *env->mie;
>> >> >      target_ulong mie =3D env->priv < PRV_M || (env->priv =3D=3D PR=
V_M && mstatus_mie);
>> >> >      target_ulong sie =3D env->priv < PRV_S || (env->priv =3D=3D PR=
V_S && mstatus_sie);
>> >> >      target_ulong irqs =3D (pending & ~env->mideleg & -mie) |
>> >> > @@ -74,7 +74,7 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int i=
nterrupt_request)
>> >> >  /* Return true is floating point support is currently enabled */
>> >> >  bool riscv_cpu_fp_enabled(CPURISCVState *env)
>> >> >  {
>> >> > -    if (env->mstatus & MSTATUS_FS) {
>> >> > +    if (*env->mstatus & MSTATUS_FS) {
>> >> >          return true;
>> >> >      }
>> >> >
>> >> > @@ -219,8 +219,8 @@ static int get_physical_address(CPURISCVState *=
env, hwaddr *physical,
>> >> >      int mode =3D mmu_idx;
>> >> >
>> >> >      if (mode =3D=3D PRV_M && access_type !=3D MMU_INST_FETCH) {
>> >> > -        if (get_field(env->mstatus, MSTATUS_MPRV)) {
>> >> > -            mode =3D get_field(env->mstatus, MSTATUS_MPP);
>> >> > +        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
>> >> > +            mode =3D get_field(*env->mstatus, MSTATUS_MPP);
>> >> >          }
>> >> >      }
>> >> >
>> >> > @@ -234,11 +234,11 @@ static int get_physical_address(CPURISCVState=
 *env, hwaddr *physical,
>> >> >
>> >> >      target_ulong base;
>> >> >      int levels, ptidxbits, ptesize, vm, sum;
>> >> > -    int mxr =3D get_field(env->mstatus, MSTATUS_MXR);
>> >> > +    int mxr =3D get_field(*env->mstatus, MSTATUS_MXR);
>> >> >
>> >> >      if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
>> >> >          base =3D get_field(env->satp, SATP_PPN) << PGSHIFT;
>> >> > -        sum =3D get_field(env->mstatus, MSTATUS_SUM);
>> >> > +        sum =3D get_field(*env->mstatus, MSTATUS_SUM);
>> >> >          vm =3D get_field(env->satp, SATP_MODE);
>> >> >          switch (vm) {
>> >> >          case VM_1_10_SV32:
>> >> > @@ -258,8 +258,8 @@ static int get_physical_address(CPURISCVState *=
env, hwaddr *physical,
>> >> >          }
>> >> >      } else {
>> >> >          base =3D env->sptbr << PGSHIFT;
>> >> > -        sum =3D !get_field(env->mstatus, MSTATUS_PUM);
>> >> > -        vm =3D get_field(env->mstatus, MSTATUS_VM);
>> >> > +        sum =3D !get_field(*env->mstatus, MSTATUS_PUM);
>> >> > +        vm =3D get_field(*env->mstatus, MSTATUS_VM);
>> >> >          switch (vm) {
>> >> >          case VM_1_09_SV32:
>> >> >            levels =3D 2; ptidxbits =3D 10; ptesize =3D 4; break;
>> >> > @@ -505,8 +505,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr add=
ress, int size,
>> >> >      ret =3D get_physical_address(env, &pa, &prot, address, access_=
type, mmu_idx);
>> >> >
>> >> >      if (mode =3D=3D PRV_M && access_type !=3D MMU_INST_FETCH) {
>> >> > -        if (get_field(env->mstatus, MSTATUS_MPRV)) {
>> >> > -            mode =3D get_field(env->mstatus, MSTATUS_MPP);
>> >> > +        if (get_field(*env->mstatus, MSTATUS_MPRV)) {
>> >> > +            mode =3D get_field(*env->mstatus, MSTATUS_MPP);
>> >> >          }
>> >> >      }
>> >> >
>> >> > @@ -606,12 +606,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>> >> >      if (env->priv <=3D PRV_S &&
>> >> >              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
>> >> >          /* handle the trap in S-mode */
>> >> > -        target_ulong s =3D env->mstatus;
>> >> > +        target_ulong s =3D *env->mstatus;
>> >> >          s =3D set_field(s, MSTATUS_SPIE, env->priv_ver >=3D PRIV_V=
ERSION_1_10_0 ?
>> >> >              get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE <=
< env->priv));
>> >> >          s =3D set_field(s, MSTATUS_SPP, env->priv);
>> >> >          s =3D set_field(s, MSTATUS_SIE, 0);
>> >> > -        env->mstatus =3D s;
>> >> > +        *env->mstatus =3D s;
>> >> >          env->scause =3D cause | ((target_ulong)async << (TARGET_LO=
NG_BITS - 1));
>> >> >          env->sepc =3D env->pc;
>> >> >          env->sbadaddr =3D tval;
>> >> > @@ -620,12 +620,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>> >> >          riscv_cpu_set_mode(env, PRV_S);
>> >> >      } else {
>> >> >          /* handle the trap in M-mode */
>> >> > -        target_ulong s =3D env->mstatus;
>> >> > +        target_ulong s =3D *env->mstatus;
>> >> >          s =3D set_field(s, MSTATUS_MPIE, env->priv_ver >=3D PRIV_V=
ERSION_1_10_0 ?
>> >> >              get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE <=
< env->priv));
>> >> >          s =3D set_field(s, MSTATUS_MPP, env->priv);
>> >> >          s =3D set_field(s, MSTATUS_MIE, 0);
>> >> > -        env->mstatus =3D s;
>> >> > +        *env->mstatus =3D s;
>> >> >          env->mcause =3D cause | ~(((target_ulong)-1) >> async);
>> >> >          env->mepc =3D env->pc;
>> >> >          env->mbadaddr =3D tval;
>> >> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> >> > index e2e908fbc0..30ec8c0a8e 100644
>> >> > --- a/target/riscv/csr.c
>> >> > +++ b/target/riscv/csr.c
>> >> > @@ -136,7 +136,7 @@ static int write_fflags(CPURISCVState *env, int=
 csrno, target_ulong val)
>> >> >      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>> >> >          return -1;
>> >> >      }
>> >> > -    env->mstatus |=3D MSTATUS_FS;
>> >> > +    *env->mstatus |=3D MSTATUS_FS;
>> >> >  #endif
>> >> >      riscv_cpu_set_fflags(env, val & (FSR_AEXC >> FSR_AEXC_SHIFT));
>> >> >      return 0;
>> >> > @@ -159,7 +159,7 @@ static int write_frm(CPURISCVState *env, int cs=
rno, target_ulong val)
>> >> >      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>> >> >          return -1;
>> >> >      }
>> >> > -    env->mstatus |=3D MSTATUS_FS;
>> >> > +    *env->mstatus |=3D MSTATUS_FS;
>> >> >  #endif
>> >> >      env->frm =3D val & (FSR_RD >> FSR_RD_SHIFT);
>> >> >      return 0;
>> >> > @@ -183,7 +183,7 @@ static int write_fcsr(CPURISCVState *env, int c=
srno, target_ulong val)
>> >> >      if (!env->debugger && !riscv_cpu_fp_enabled(env)) {
>> >> >          return -1;
>> >> >      }
>> >> > -    env->mstatus |=3D MSTATUS_FS;
>> >> > +    *env->mstatus |=3D MSTATUS_FS;
>> >> >  #endif
>> >> >      env->frm =3D (val & FSR_RD) >> FSR_RD_SHIFT;
>> >> >      riscv_cpu_set_fflags(env, (val & FSR_AEXC) >> FSR_AEXC_SHIFT);
>> >> > @@ -307,7 +307,7 @@ static int read_mhartid(CPURISCVState *env, int=
 csrno, target_ulong *val)
>> >> >  /* Machine Trap Setup */
>> >> >  static int read_mstatus(CPURISCVState *env, int csrno, target_ulon=
g *val)
>> >> >  {
>> >> > -    *val =3D env->mstatus;
>> >> > +    *val =3D *env->mstatus;
>> >> >      return 0;
>> >> >  }
>> >> >
>> >> > @@ -319,7 +319,7 @@ static int validate_vm(CPURISCVState *env, targ=
et_ulong vm)
>> >> >
>> >> >  static int write_mstatus(CPURISCVState *env, int csrno, target_ulo=
ng val)
>> >> >  {
>> >> > -    target_ulong mstatus =3D env->mstatus;
>> >> > +    target_ulong mstatus =3D *env->mstatus;
>> >> >      target_ulong mask =3D 0;
>> >> >      int dirty;
>> >> >
>> >> > @@ -359,7 +359,7 @@ static int write_mstatus(CPURISCVState *env, in=
t csrno, target_ulong val)
>> >> >               ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS)) |
>> >> >              ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
>> >> >      mstatus =3D set_field(mstatus, MSTATUS_SD, dirty);
>> >> > -    env->mstatus =3D mstatus;
>> >> > +    *env->mstatus =3D mstatus;
>> >> >
>> >> >      return 0;
>> >> >  }
>> >> > @@ -448,13 +448,13 @@ static int write_mideleg(CPURISCVState *env, =
int csrno, target_ulong val)
>> >> >
>> >> >  static int read_mie(CPURISCVState *env, int csrno, target_ulong *v=
al)
>> >> >  {
>> >> > -    *val =3D env->mie;
>> >> > +    *val =3D *env->mie;
>> >> >      return 0;
>> >> >  }
>> >> >
>> >> >  static int write_mie(CPURISCVState *env, int csrno, target_ulong v=
al)
>> >> >  {
>> >> > -    env->mie =3D (env->mie & ~all_ints) | (val & all_ints);
>> >> > +    *env->mie =3D (*env->mie & ~all_ints) | (val & all_ints);
>> >> >      return 0;
>> >> >  }
>> >> >
>> >> > @@ -608,7 +608,7 @@ static int read_sstatus(CPURISCVState *env, int=
 csrno, target_ulong *val)
>> >> >  {
>> >> >      target_ulong mask =3D ((env->priv_ver >=3D PRIV_VERSION_1_10_0=
) ?
>> >> >                           sstatus_v1_10_mask : sstatus_v1_9_mask);
>> >> > -    *val =3D env->mstatus & mask;
>> >> > +    *val =3D *env->mstatus & mask;
>> >> >      return 0;
>> >> >  }
>> >> >
>> >> > @@ -616,19 +616,19 @@ static int write_sstatus(CPURISCVState *env, =
int csrno, target_ulong val)
>> >> >  {
>> >> >      target_ulong mask =3D ((env->priv_ver >=3D PRIV_VERSION_1_10_0=
) ?
>> >> >                           sstatus_v1_10_mask : sstatus_v1_9_mask);
>> >> > -    target_ulong newval =3D (env->mstatus & ~mask) | (val & mask);
>> >> > +    target_ulong newval =3D (*env->mstatus & ~mask) | (val & mask)=
;
>> >> >      return write_mstatus(env, CSR_MSTATUS, newval);
>> >> >  }
>> >> >
>> >> >  static int read_sie(CPURISCVState *env, int csrno, target_ulong *v=
al)
>> >> >  {
>> >> > -    *val =3D env->mie & env->mideleg;
>> >> > +    *val =3D *env->mie & env->mideleg;
>> >> >      return 0;
>> >> >  }
>> >> >
>> >> >  static int write_sie(CPURISCVState *env, int csrno, target_ulong v=
al)
>> >> >  {
>> >> > -    target_ulong newval =3D (env->mie & ~env->mideleg) | (val & en=
v->mideleg);
>> >> > +    target_ulong newval =3D (*env->mie & ~env->mideleg) | (val & e=
nv->mideleg);
>> >> >      return write_mie(env, CSR_MIE, newval);
>> >> >  }
>> >> >
>> >> > @@ -731,7 +731,7 @@ static int read_satp(CPURISCVState *env, int cs=
rno, target_ulong *val)
>> >> >      if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
>> >> >          *val =3D 0;
>> >> >      } else if (env->priv_ver >=3D PRIV_VERSION_1_10_0) {
>> >> > -        if (env->priv =3D=3D PRV_S && get_field(env->mstatus, MSTA=
TUS_TVM)) {
>> >> > +        if (env->priv =3D=3D PRV_S && get_field(*env->mstatus, MST=
ATUS_TVM)) {
>> >> >              return -1;
>> >> >          } else {
>> >> >              *val =3D env->satp;
>> >> > @@ -756,7 +756,7 @@ static int write_satp(CPURISCVState *env, int c=
srno, target_ulong val)
>> >> >          validate_vm(env, get_field(val, SATP_MODE)) &&
>> >> >          ((val ^ env->satp) & (SATP_MODE | SATP_ASID | SATP_PPN)))
>> >> >      {
>> >> > -        if (env->priv =3D=3D PRV_S && get_field(env->mstatus, MSTA=
TUS_TVM)) {
>> >> > +        if (env->priv =3D=3D PRV_S && get_field(*env->mstatus, MST=
ATUS_TVM)) {
>> >> >              return -1;
>> >> >          } else {
>> >> >              if((val ^ env->satp) & SATP_ASID) {
>> >> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
>> >> > index 331cc36232..d150551bc9 100644
>> >> > --- a/target/riscv/op_helper.c
>> >> > +++ b/target/riscv/op_helper.c
>> >> > @@ -83,11 +83,11 @@ target_ulong helper_sret(CPURISCVState *env, ta=
rget_ulong cpu_pc_deb)
>> >> >      }
>> >> >
>> >> >      if (env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
>> >> > -        get_field(env->mstatus, MSTATUS_TSR)) {
>> >> > +        get_field(*env->mstatus, MSTATUS_TSR)) {
>> >> >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC(=
));
>> >> >      }
>> >> >
>> >> > -    target_ulong mstatus =3D env->mstatus;
>> >> > +    target_ulong mstatus =3D *env->mstatus;
>> >> >      target_ulong prev_priv =3D get_field(mstatus, MSTATUS_SPP);
>> >> >      mstatus =3D set_field(mstatus,
>> >> >          env->priv_ver >=3D PRIV_VERSION_1_10_0 ?
>> >> > @@ -96,7 +96,7 @@ target_ulong helper_sret(CPURISCVState *env, targ=
et_ulong cpu_pc_deb)
>> >> >      mstatus =3D set_field(mstatus, MSTATUS_SPIE, 0);
>> >> >      mstatus =3D set_field(mstatus, MSTATUS_SPP, PRV_U);
>> >> >      riscv_cpu_set_mode(env, prev_priv);
>> >> > -    env->mstatus =3D mstatus;
>> >> > +    *env->mstatus =3D mstatus;
>> >> >
>> >> >      return retpc;
>> >> >  }
>> >> > @@ -112,7 +112,7 @@ target_ulong helper_mret(CPURISCVState *env, ta=
rget_ulong cpu_pc_deb)
>> >> >          riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC=
());
>> >> >      }
>> >> >
>> >> > -    target_ulong mstatus =3D env->mstatus;
>> >> > +    target_ulong mstatus =3D *env->mstatus;
>> >> >      target_ulong prev_priv =3D get_field(mstatus, MSTATUS_MPP);
>> >> >      mstatus =3D set_field(mstatus,
>> >> >          env->priv_ver >=3D PRIV_VERSION_1_10_0 ?
>> >> > @@ -121,7 +121,7 @@ target_ulong helper_mret(CPURISCVState *env, ta=
rget_ulong cpu_pc_deb)
>> >> >      mstatus =3D set_field(mstatus, MSTATUS_MPIE, 0);
>> >> >      mstatus =3D set_field(mstatus, MSTATUS_MPP, PRV_U);
>> >> >      riscv_cpu_set_mode(env, prev_priv);
>> >> > -    env->mstatus =3D mstatus;
>> >> > +    *env->mstatus =3D mstatus;
>> >> >
>> >> >      return retpc;
>> >> >  }
>> >> > @@ -132,7 +132,7 @@ void helper_wfi(CPURISCVState *env)
>> >> >
>> >> >      if (env->priv =3D=3D PRV_S &&
>> >> >          env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
>> >> > -        get_field(env->mstatus, MSTATUS_TW)) {
>> >> > +        get_field(*env->mstatus, MSTATUS_TW)) {
>> >> >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC(=
));
>> >> >      } else {
>> >> >          cs->halted =3D 1;
>> >> > @@ -147,7 +147,7 @@ void helper_tlb_flush(CPURISCVState *env)
>> >> >      if (!(env->priv >=3D PRV_S) ||
>> >> >          (env->priv =3D=3D PRV_S &&
>> >> >           env->priv_ver >=3D PRIV_VERSION_1_10_0 &&
>> >> > -         get_field(env->mstatus, MSTATUS_TVM))) {
>> >> > +         get_field(*env->mstatus, MSTATUS_TVM))) {
>> >> >          riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC(=
));
>> >> >      } else {
>> >> >          tlb_flush(cs);
>> >>
>> >> I don't think this is that bad.
>> >>
>> >> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>> >>

