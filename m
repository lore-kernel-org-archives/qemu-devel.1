Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A69FECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BB4206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 18:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Js4AJEje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BB4206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHXTp-0001vy-5r
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 14:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iHXSs-0001Ul-Rr
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iHXSr-00053B-D5
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 14:10:34 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iHXSq-00052U-Qb; Mon, 07 Oct 2019 14:10:33 -0400
Received: by mail-lj1-x244.google.com with SMTP id n14so14670057ljj.10;
 Mon, 07 Oct 2019 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OzbvGigIYTDinndI7OgOMeW5d4ZDX0kILT/nZ6Ckwmc=;
 b=Js4AJEjeIk/3ncDbFTUzoFBeDpYo1woEVW5H1PPIVJra19G/zZh8w1mNneSbTFlYPs
 5zmOZQMfgf8O4PLqWl0hIVYLzewLuwsCB2W+h0h7uWNyk56DMXJ/mNP9SwwriXlGk+yU
 l0WEOFXAPUuLtFC4mnOBphAG9Wwal8nWlac7HjTlNsoTISe/LG4yFp2bQCMXEKuVtMIZ
 pvNIpEnJeJq4MXylybpehoHEIxjhlOXz6Av03kSdoBWD5VnbKr/CREPbUd+f4RN1XzMw
 U0vGUbplA6OAMZ4L/OsD6SKjs+JL1BVGMBr5RVlyZlTHxq0JL7mf7HC3+MHlLxzGVkHE
 Chwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OzbvGigIYTDinndI7OgOMeW5d4ZDX0kILT/nZ6Ckwmc=;
 b=d80IsKNFSumyIk3s6SpbrHgOw2PC6/1EjMkZ+0tTZnsd9+kQTL0La6xszBVsl9HGbq
 P9MjSRiCJhtTmcHzvLf6hzOPnuHefKkFNXsDI/4T3/Y4sc/lfX2yQaYR/RJ4g4o/jB4W
 Osq0DtnYntsE9QB1zh+ooIpOyTKmeU18gp5Rrl6YOpYohp5rs7fUTqRAsRYeQg37vcRa
 pD0961O9EwF1Lon0xcChdYYjUAusiA7IoWkBkpgH4eP72EaPdBrTEcrbJt1YXlCFCD9R
 NW/MJSsEbdYO40Y3l/OVY5pRI5z30tPS83dp9u2pHIt5cmmxITu04gomXPGnQGA+DFOJ
 +q3A==
X-Gm-Message-State: APjAAAWgWAQjZwcsmSRvEfPpyg/1u/h647qZPe8tAeY+JfBhxqf1ivip
 Q4tXR54+EQv7735hbmLnyxq8TjuTuuicp0N3iAk=
X-Google-Smtp-Source: APXvYqxQTadnculSdSqOymk/sfHOVIfWQfxX648K3wVxHBpXZO6Cu8imwOezZOThU7R/hcuKwxW8nja0iZ9ZKq8P338=
X-Received: by 2002:a2e:2c02:: with SMTP id s2mr19815668ljs.156.1570471830861; 
 Mon, 07 Oct 2019 11:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <4d84c887def558fc178c31e3adc52f1c4b2fb075.1566603412.git.alistair.francis@wdc.com>
 <mhng-87129cf6-394a-4b08-bf67-a6bb60f86245@palmer-si-x1e>
In-Reply-To: <mhng-87129cf6-394a-4b08-bf67-a6bb60f86245@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 7 Oct 2019 11:05:33 -0700
Message-ID: <CAKmqyKOV0J3w3fPUF3CGAip=j_+D_M+7X9r+2TwEZwkapsQZMQ@mail.gmail.com>
Subject: Re: [PATCH v1 22/28] target/riscv: Allow specifying MMU stage
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>, Anup Patel <Anup.Patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 3, 2019 at 8:53 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 23 Aug 2019 16:38:47 PDT (-0700), Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu_helper.c | 39 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 30 insertions(+), 9 deletions(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 098873c83e..9aa6906acd 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -318,10 +318,19 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
> >   *
> >   * Adapted from Spike's mmu_t::translate and mmu_t::walk
> >   *
> > + * @env: CPURISCVState
> > + * @physical: This will be set to the calculated physical address
> > + * @prot: The returned protection attributes
> > + * @addr: The virtual address to be translated
> > + * @access_type: The type of MMU access
> > + * @mmu_idx: Indicates current privilege level
> > + * @first_stage: Are we in first stage translation?
> > + *               Second stage is used for hypervisor guest translation
> >   */
> >  static int get_physical_address(CPURISCVState *env, hwaddr *physical,
> >                                  int *prot, target_ulong addr,
> > -                                int access_type, int mmu_idx)
> > +                                int access_type, int mmu_idx,
> > +                                bool first_stage)
> >  {
> >      /* NOTE: the env->pc value visible here will not be
> >       * correct, but the value visible to the exception handler
> > @@ -518,13 +527,23 @@ restart:
> >  }
> >
> >  static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
> > -                                MMUAccessType access_type, bool pmp_violation)
> > +                                MMUAccessType access_type, bool pmp_violation,
> > +                                bool first_stage)
> >  {
> >      CPUState *cs = env_cpu(env);
> > -    int page_fault_exceptions =
> > -        (env->priv_ver >= PRIV_VERSION_1_10_0) &&
> > -        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
> > -        !pmp_violation;
> > +    int page_fault_exceptions;
> > +    if (first_stage) {
> > +        page_fault_exceptions =
> > +            (env->priv_ver >= PRIV_VERSION_1_10_0) &&
> > +            get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
> > +            !pmp_violation;
> > +            riscv_cpu_set_force_hs_excep(env, CLEAR_HS_EXCEP);
>
> It might just be email, but the indentation looks wrong here.

Yep, fixed.

>
> > +    } else {
> > +        page_fault_exceptions =
> > +            get_field(env->hgatp, HGATP_MODE) != VM_1_10_MBARE &&
> > +            !pmp_violation;
> > +            riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
> > +    }
> >      switch (access_type) {
> >      case MMU_INST_FETCH:
> >          cs->exception_index = page_fault_exceptions ?
> > @@ -551,7 +570,8 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
> >      int prot;
> >      int mmu_idx = cpu_mmu_index(&cpu->env, false);
> >
> > -    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx)) {
> > +    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
> > +                             true)) {
> >          return -1;
> >      }
> >      return phys_addr;
> > @@ -613,7 +633,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
> >                    __func__, address, access_type, mmu_idx);
> >
> > -    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
> > +    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
> > +                               true);
> >
> >      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
> >          if (get_field(*env->mstatus, MSTATUS_MPRV)) {
> > @@ -640,7 +661,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >      } else if (probe) {
> >          return false;
> >      } else {
> > -        raise_mmu_exception(env, address, access_type, pmp_violation);
> > +        raise_mmu_exception(env, address, access_type, pmp_violation, true);
> >          riscv_raise_exception(env, cs->exception_index, retaddr);
> >      }
> >  #else
>
> I don't think it makes sense to split off these two (23 and 24, that add the
> argument) out from the implementation.

The goal was just to make it easier to review. If you want them
combined I can easily combine them.

Alistair

