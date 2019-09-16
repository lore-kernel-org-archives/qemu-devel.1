Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E54C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF7520678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm6U+CvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF7520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tcP-0005vf-Oz
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9tSN-0004sX-1F
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9tSL-0006HX-PA
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 12:02:26 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9tSL-0006Gy-Hg; Mon, 16 Sep 2019 12:02:25 -0400
Received: by mail-lf1-x144.google.com with SMTP id u28so386177lfc.5;
 Mon, 16 Sep 2019 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AeDrdWoph1c/zo2OnhjnI4KMjDluFfv/o+PCV5TtfKU=;
 b=dm6U+CvMeiCZCTD9FamXpjiptV6kfGOvX11DBQeCVsTp0llMIbDXurn065xOYIfreq
 afLTTuPciJuhqa4cNzktka97Cd3lHUNLEMB/n3cfHZEnfGK9rdhrd1F7V9wjX0BBtaER
 eHq2yEYQZNeA+fBTMfVZPCYlJUxt2in3BQ2IGgCyU84WITbZNMWHQIqmP81uVuLUFoNF
 LqglEmMA+aa6jNvlSleDsTzqGB2ctA8JrHPxVRr7cGBxRdXEJqCbZb36Op5ZeQxiECdT
 2hKErS7lzUd7tKcoyqqTnOGNugM1KGp+w++LXbb5trtGvVkbcCcUOFTCmiZ1vspsDQrF
 uAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AeDrdWoph1c/zo2OnhjnI4KMjDluFfv/o+PCV5TtfKU=;
 b=T7z3rrHx6TRELM6H6s7lNAo7G6aj2iNs0a96V4hcJPAz/r4PvPkZvblU4UVEYQaxeu
 b4ZhC406k76IYFOo4cTtdnqywSgCzoukk1JmtvauVtEx7XgSl5IroY3EhP4f1D/XW2si
 LGqDGa5czHh4CJtzSDidbDq+U3YgEnip7PDRH/YVfzXhYgSCehfSh/SmK31TajwzLkkk
 JjqDqDOoovr1OetkPyhINRbhKEX1cQHBKFoZ9przK6OlBLD7f5k0TuD7m13tq64Q+oEE
 8XsWGz+LIPAdT/Z/GDqixYBuQK4cxcqM5jFNiQhNGV9QVcZkfg7CrSYdLtutSf63VEGS
 LcBg==
X-Gm-Message-State: APjAAAVIgLQuy43mNPwIVBvsBwn/tuIU9VhsLlKvPqoh6d7bdP3jRMjI
 7rR2XkIlxCYfXGOlnD+SgADNbB3KrrogdAGoLPI=
X-Google-Smtp-Source: APXvYqwxMlTZj0mkXSWjl5ZbZSuZON6zWCBxp1QeXrHm1dJpVTMMHTF/BSiR8ZyFMO02zSifaLNOdoezDg0x9xad9UM=
X-Received: by 2002:ac2:4a69:: with SMTP id q9mr90720lfp.86.1568649743426;
 Mon, 16 Sep 2019 09:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <1c1d359caa6633349158debc38e07156a10b63e8.1566603412.git.alistair.francis@wdc.com>
 <mhng-9017291b-1ed2-4cea-ab34-03825a8c8a8c@palmer-si-x1e>
In-Reply-To: <mhng-9017291b-1ed2-4cea-ab34-03825a8c8a8c@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 08:57:52 -0700
Message-ID: <CAKmqyKP5Ld5TQH+J2bArXOEChcB+0RFTdqNS-Sg-_G-UuOz_uQ@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v1 02/28] target/riscv: Add the
 virtulisation mode
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

On Tue, Sep 10, 2019 at 6:44 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 23 Aug 2019 16:37:54 PDT (-0700), Alistair Francis wrote:
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu.h        |  4 ++++
> >  target/riscv/cpu_bits.h   |  6 ++++++
> >  target/riscv/cpu_helper.c | 23 +++++++++++++++++++++++
> >  3 files changed, 33 insertions(+)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 7f54fb8c87..0ef1ecb0e0 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -117,6 +117,8 @@ struct CPURISCVState {
> >
> >  #ifndef CONFIG_USER_ONLY
> >      target_ulong priv;
> > +    /* This contains QEMU specific information about the virt state. */
> > +    target_ulong virt;
> >      target_ulong resetvec;
> >
> >      target_ulong mhartid;
> > @@ -257,6 +259,8 @@ int riscv_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> >  int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> >  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
> >  bool riscv_cpu_fp_enabled(CPURISCVState *env);
> > +bool riscv_cpu_virt_enabled(CPURISCVState *env);
> > +void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable);
> >  int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch);
> >  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> >  void  riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index e99834856c..1fbde516be 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -422,6 +422,12 @@
> >  #define PRV_H 2 /* Reserved */
> >  #define PRV_M 3
> >
> > +/* Virtulisation modes */
> > +#define VIRT_OFF            0
> > +#define VIRT_ON             1
> > +#define VIRT_MODE_SHIFT     0
> > +#define VIRT_MODE_MASK      (1 << VIRT_MODE_SHIFT)
> > +
> >  /* RV32 satp CSR field masks */
> >  #define SATP32_MODE         0x80000000
> >  #define SATP32_ASID         0x7fc00000
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 225e407cff..7b0bb14c01 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -81,6 +81,29 @@ bool riscv_cpu_fp_enabled(CPURISCVState *env)
> >      return false;
> >  }
> >
> > +bool riscv_cpu_virt_enabled(CPURISCVState *env)
> > +{
> > +    bool tmp;
> > +
> > +    if (!riscv_has_ext(env, RVH)) {
> > +        return false;
> > +    }
> > +
> > +    tmp = (env->virt & VIRT_MODE_MASK) >> VIRT_MODE_SHIFT;
> > +
> > +    return tmp == VIRT_ON;
> > +}
>
> extract64() is a bit cleaner.

I have already changed it to get_field() and set_field().

>
> > +
> > +void riscv_cpu_set_virt_enabled(CPURISCVState *env, bool enable)
> > +{
> > +    if (!riscv_has_ext(env, RVH)) {
> > +        return;
> > +    }
> > +
> > +    env->virt &= ~VIRT_MODE_MASK;
> > +    env->virt |= enable << VIRT_MODE_SHIFT;
> > +}
> > +
> >  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts)
> >  {
> >      CPURISCVState *env = &cpu->env;
>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

This patch is a little out of date, so I'll not include your RB line in the v2.

Alistair

