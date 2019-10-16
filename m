Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2650FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 21:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D314218DE
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 21:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukq+ByRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D314218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKqil-0004r8-JJ
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 17:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iKqht-0004O0-Pf
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 17:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iKqhs-0006bE-Fo
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 17:19:45 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43936)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iKqhr-0006ZP-RM; Wed, 16 Oct 2019 17:19:44 -0400
Received: by mail-lj1-x244.google.com with SMTP id n14so206281ljj.10;
 Wed, 16 Oct 2019 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oNjGOQAvWAKg0trjbGFZDhSHld62QxIYG23BesVY4Pk=;
 b=Ukq+ByRQqsDhOyvuXmHK7QWNmbOenZLSk2u92eOQ5pw5JsWkhqxxZF8M1bbwQekLHV
 dGYi+m3YA6hDjHDae6V008HSJ4ZF6wyfbAgXp8ssUi0AOjTfUpWi7tNUOJBe5zewCALu
 YehGj4SBIzcQiKYQbhOi1zfrVFJU0kjsDEq0PiTZ0/N4Xr4FC2eA1lcClEemoMkpPy3p
 6ExlL1l9Jsbl+9B4wh5axptNGsgeTK86JNToPLj5rEA86DyCbFgZLs8UyMQWybEzkbs2
 zm6rQ9Kz0ykziUODeekdHGOOXl7lh3wbBSH5rUF8rUESTQkXRAfW0I5jkhb1ptGFBKoG
 fWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oNjGOQAvWAKg0trjbGFZDhSHld62QxIYG23BesVY4Pk=;
 b=TnZUu1FiVsl1Gu4pCxptn1a2VOBDzZ0X0yGMLCoZdnvUM3oFsyrOvqBGhDi9DYR9i3
 yn2H8yq71qv7ZtQQUCkV5zNIeZPbprTTE6mbG/YBE2MSSAJv6I/BQl3ZYvT0vfuxpSDN
 bfHiLpAeM2hUIl7wMu6e5jmWfZRwt9rc0VaLO88OfULdCFlgYn/Abr0l8vC9q3Cw42eg
 tdO/xP7O5Mcq83d0zR19TFThhGPo8K73I9Q0+brTHXSMepgIp/vVuW3vY9Ml7/sE96d/
 oua6onm624IaeIJalHN//4Gw+yzCEuHMPuEE1Y5UjWBHTjPhs3SZSntf9wWcXvV4zC9M
 rI5A==
X-Gm-Message-State: APjAAAWMmKf6LM+DHrucGBGZeGisr9v6ilVEwslTjOZeA9IahtSYqYbe
 drjQ76Yq9In+TELj/zsJ9BlWXGKO9LCz6EQ8LAM=
X-Google-Smtp-Source: APXvYqzAu7Dw0lFtFelHlfe90Af4FEjTJVYFQbHFyhkXCDER/6BHJPcaI4wqz2ZaBKp77fbhV3IfqawMUJonMdNO0/k=
X-Received: by 2002:a2e:b010:: with SMTP id y16mr123390ljk.147.1571260781290; 
 Wed, 16 Oct 2019 14:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <c7961e38284feb8de1180173bf92c78153fd6970.1566603412.git.alistair.francis@wdc.com>
 <mhng-bbcac2a5-ee88-404e-a755-420242ec0153@palmer-si-x1e>
In-Reply-To: <mhng-bbcac2a5-ee88-404e-a755-420242ec0153@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 Oct 2019 14:14:31 -0700
Message-ID: <CAKmqyKO3dUT42SeQGJ0b-D0Jxp_KuecoyQgj+LoVYPxQ-sGrAQ@mail.gmail.com>
Subject: Re: [PATCH v1 27/28] target/riscv: Add the MSTATUS_MPV_ISSET helper
 macro
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

On Tue, Oct 8, 2019 at 11:36 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 23 Aug 2019 16:39:00 PDT (-0700), Alistair Francis wrote:
> > Add a helper macro MSTATUS_MPV_ISSET() which will determine if the
> > MSTATUS_MPV bit is set for both 32-bit and 64-bit RISC-V.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu_bits.h   | 11 +++++++++++
> >  target/riscv/cpu_helper.c |  4 ++--
> >  target/riscv/op_helper.c  |  2 +-
> >  target/riscv/translate.c  |  2 +-
> >  4 files changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index 55e20af6d9..7056d9218b 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -365,8 +365,19 @@
> >  #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
> >  #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
> >  #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
> > +#if defined(TARGET_RISCV64)
> >  #define MSTATUS_MTL         0x4000000000ULL
> >  #define MSTATUS_MPV         0x8000000000ULL
> > +#elif defined(TARGET_RISCV32)
> > +#define MSTATUS_MTL         0x00000040
> > +#define MSTATUS_MPV         0x00000080
> > +#endif
> > +
> > +#ifdef TARGET_RISCV32
> > +# define MSTATUS_MPV_ISSET(env)  get_field(*env->mstatush, MSTATUS_MPV)
> > +#else
> > +# define MSTATUS_MPV_ISSET(env)  get_field(*env->mstatus, MSTATUS_MPV)
> > +#endif
> >
> >  #define MSTATUS64_UXL       0x0000000300000000ULL
> >  #define MSTATUS64_SXL       0x0000000C00000000ULL
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 8c80486dd0..2b88f756bb 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -351,7 +351,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
> >              mode = get_field(*env->mstatus, MSTATUS_MPP);
> >
> >              if (riscv_has_ext(env, RVH) &&
> > -                get_field(*env->mstatus, MSTATUS_MPV)) {
> > +                MSTATUS_MPV_ISSET(env)) {
> >                  use_background = true;
> >              }
> >          }
> > @@ -730,7 +730,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> >          m_mode_two_stage = env->priv == PRV_M &&
> >                             access_type != MMU_INST_FETCH &&
> >                             get_field(*env->mstatus, MSTATUS_MPRV) &&
> > -                           get_field(*env->mstatus, MSTATUS_MPV);
> > +                           MSTATUS_MPV_ISSET(env);
> >
> >          hs_mode_two_stage = env->priv == PRV_S &&
> >                              !riscv_cpu_virt_enabled(env) &&
> > diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> > index 8dec1aee99..6149cd9c15 100644
> > --- a/target/riscv/op_helper.c
> > +++ b/target/riscv/op_helper.c
> > @@ -146,7 +146,7 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
> >
> >      target_ulong mstatus = *env->mstatus;
> >      target_ulong prev_priv = get_field(mstatus, MSTATUS_MPP);
> > -    target_ulong prev_virt = get_field(mstatus, MSTATUS_MPV);
> > +    target_ulong prev_virt = MSTATUS_MPV_ISSET(env);
> >      mstatus = set_field(mstatus,
> >          env->priv_ver >= PRIV_VERSION_1_10_0 ?
> >          MSTATUS_MIE : MSTATUS_UIE << prev_priv,
> > diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> > index ea19ba9c5d..f0d9860429 100644
> > --- a/target/riscv/translate.c
> > +++ b/target/riscv/translate.c
> > @@ -754,7 +754,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
> >          ctx->virt_enabled = riscv_cpu_virt_enabled(env);
> >          if (env->priv_ver == PRV_M &&
> >              get_field(*env->mstatus, MSTATUS_MPRV) &&
> > -            get_field(*env->mstatus, MSTATUS_MPV)) {
> > +            MSTATUS_MPV_ISSET(env)) {
> >              ctx->virt_enabled = true;
> >          } else if (env->priv == PRV_S &&
> >                     !riscv_cpu_virt_enabled(env) &&
>
> This should be either ordered before or atomic with the patch that allows
> mstatush.mpv to be set, as otherwise there's point at which QEMU doesn't match
> the ISA.

I can't change the order due to dependencies, I can squash them but as
the Hypervisor extension can't be turned on there isn't really a
conflict with the ISA.

Do you still want me to squash them?

Alistair

