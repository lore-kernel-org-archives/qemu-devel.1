Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87103C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8D620872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTVu+sVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8D620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCvlx-0005GZ-9E
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 21:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iCvlB-0004fC-Fl
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iCvl9-0004qS-QF
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:06:25 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iCvl6-0004oc-7p; Tue, 24 Sep 2019 21:06:20 -0400
Received: by mail-lj1-x242.google.com with SMTP id m13so3784994ljj.11;
 Tue, 24 Sep 2019 18:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yUUIa5Ov6YlwQGXP9ytN25tO/ntGka441s3AW41ZIbY=;
 b=kTVu+sViOawRNoye69G0ic+AAFlGT/9b8XHUdGaPqwLaCXbSz4n0sTMuo4w/4rEvJ0
 9qp0Xd62fZM4WCDsHN/WSPY+uX6meR0TE5xb+TAhW7jThELWoSJhvCB2Onc6YR19865X
 T1xXQLE0Zc2n/ZbYbTgDTZMgrapJHI8qzIL9qHoBZ4fPPiID9PZ95qGWyReynWcB/pI2
 tnj2mVfl4mG9XBWZOIEssifta+6daLXyBOwqEf6KTtfMLrEvSIY6B/8H1B5FHrZU23I8
 HYpLSwhQ5wbd0l7gXXueK0FoEWJh4rx1PpxDL0YAwLP47KV4vEYcwmOpR9Fw4UPnmZCO
 rA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yUUIa5Ov6YlwQGXP9ytN25tO/ntGka441s3AW41ZIbY=;
 b=LyvhazIGsThEGgzWzCBhMhD1r6mIbzXWZJapevtaD2gHftDSBJjkOffkLorGEalUjV
 KUAqyYNUuuyEdNcIa6uw2GiH9ln1BwqZNrorlFzgYUeGLW+7spqRvAb6qt3g4vYhn0Gt
 5k8xpl6xxtzRDTHGngDUqOUliV9mWh7wgZmTXlGZLzxLWHJkjs4k1oHcmDhAB+KN2XXD
 L0bArXOujFXWljMhg2IJCvn2I2tt8dNAB3gXfecrmn6XfS5oR2iEww0V6kwMRvU718Ol
 pAdeoM+iGUbAOtRX9UQLVMtBIHimLeOma4mlopwzRLzz+UgqX8y7VMryXhtpQgAwoNE4
 0W1w==
X-Gm-Message-State: APjAAAVVCEYVoAYug+nh+KMCmIEn23hjDkl+aE5cbustDHFT34pz7HlR
 wJjOOXnSS7QYZYsNzMeY4NVNijx1+1JB5H+yWAA=
X-Google-Smtp-Source: APXvYqxfLUwHnwUXw8Lz3jfTPWKPtqWa2qXXSl3h2+miavJhnqIQNAl3NALDwBJcz8/vpAD1dhQq4ZT3e/b/CW1jKd0=
X-Received: by 2002:a05:651c:1132:: with SMTP id
 e18mr3976249ljo.33.1569373578718; 
 Tue, 24 Sep 2019 18:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKP+HNfzh5kCKkGDtfr=pDRwcjL+dUQ79NZEk+jMZ3q=_Q@mail.gmail.com>
 <mhng-a172dfe8-dd34-427f-89dd-ca65da3145fb@palmer-si-x1e>
 <CAKmqyKON2=3mO-n3nXwyqN9i-RDOeyrpjxt9JJMSBwyyiEiuow@mail.gmail.com>
In-Reply-To: <CAKmqyKON2=3mO-n3nXwyqN9i-RDOeyrpjxt9JJMSBwyyiEiuow@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 24 Sep 2019 18:01:36 -0700
Message-ID: <CAKmqyKPVxkbKkZPg5u+nKiLtNgtf5Na6JgzF3ocrx8wy8+bxJw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] atomic failures on qemu-system-riscv64
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: me@carlosedp.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Joel Sing <joel@sing.id.au>, Alistair Francis <Alistair.Francis@wdc.com>,
 marco@decred.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 4:35 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Sep 24, 2019 at 1:04 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Tue, 24 Sep 2019 11:29:25 PDT (-0700), alistair23@gmail.com wrote:
> > > On Mon, Jun 24, 2019 at 11:21 AM Joel Sing <joel@sing.id.au> wrote:
> > >>
> > >> On 19-06-17 16:52:44, Richard Henderson wrote:
> > >> > On 6/16/19 12:19 PM, Joel Sing wrote:
> > >> > > +    /*
> > >> > > +     * Clear the load reservation, since an SC must fail if there is
> > >> > > +     * an SC to any address, in between an LR and SC pair.
> > >> > > +     */
> > >> > > +    tcg_gen_movi_tl(load_res, 0);
> > >> > > +
> > >> > >      gen_set_label(l2);
> > >> >
> > >> > This clear needs to be moved down below label l2.
> > >> > Otherwise, with lr / sc / sc, the second sc could succeed in error.
> > >>
> > >> Indeed, thanks.
> > >>
> > >> > FWIW, other targets have used -1 as the "invalid" load reservation, since the
> > >> > architecture does not require address 0 to be unmapped.  This should be quite
> > >> > visible in M-mode with paging disabled and ram at offset 0.  Often, other
> > >> > targets require alignment for the lr/sc address, though I don't see that for riscv.
> > >>
> > >> I've switched to -1 as suggested. Regarding the alignment for reservations, the
> > >> specification does require this, although I do not recall seeing any enforcement
> > >> of this by qemu itself.
> > >>
> > >> New diff follows.
> > >>
> > >> From 8ef31a2ce8ef1cbeee92995a0b2994f480e9bb6d Mon Sep 17 00:00:00 2001
> > >> From: Joel Sing <joel@sing.id.au>
> > >> Date: Tue, 25 Jun 2019 02:44:24 +1000
> > >> Subject: [PATCH] Clear load reservations on qemu riscv target
> > >>
> > >> This prevents a load reservation from being placed in one context/process,
> > >> then being used in another, resulting in an SC succeeding incorrectly and
> > >> breaking atomics.
> > >>
> > >> Signed-off-by: Joel Sing <joel@sing.id.au>
> > >> ---
> > >>  target/riscv/cpu.c                      | 1 +
> > >>  target/riscv/cpu_helper.c               | 9 +++++++++
> > >>  target/riscv/insn_trans/trans_rva.inc.c | 8 +++++++-
> > >>  3 files changed, 17 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > >> index d61bce6d55..e7c8bf48fc 100644
> > >> --- a/target/riscv/cpu.c
> > >> +++ b/target/riscv/cpu.c
> > >> @@ -281,6 +281,7 @@ static void riscv_cpu_reset(CPUState *cs)
> > >>      env->pc = env->resetvec;
> > >>  #endif
> > >>      cs->exception_index = EXCP_NONE;
> > >> +    env->load_res = -1;
> > >>      set_default_nan_mode(1, &env->fp_status);
> > >>  }
> > >>
> > >> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > >> index b17f169681..6a07b12e65 100644
> > >> --- a/target/riscv/cpu_helper.c
> > >> +++ b/target/riscv/cpu_helper.c
> > >> @@ -113,6 +113,15 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
> > >>      }
> > >>      /* tlb_flush is unnecessary as mode is contained in mmu_idx */
> > >>      env->priv = newpriv;
> > >> +
> > >> +    /* Clear the load reservation - otherwise a reservation placed in one
> > >> +     * context/process can be used by another, resulting in an SC succeeding
> > >> +     * incorrectly. Version 2.2 of the ISA specification explicitly requires
> > >> +     * this behaviour, while later revisions say that the kernel "should" use
> > >> +     * an SC instruction to force the yielding of a load reservation on a
> > >> +     * preemptive context switch. As a result, do both.
> > >> +     */
> > >> +    env->load_res = -1;
> > >>  }
> > >>
> > >>  /* get_physical_address - get the physical address for this virtual address
> > >> diff --git a/target/riscv/insn_trans/trans_rva.inc.c b/target/riscv/insn_trans/trans_rva.inc.c
> > >> index f6dbbc065e..fadd88849e 100644
> > >> --- a/target/riscv/insn_trans/trans_rva.inc.c
> > >> +++ b/target/riscv/insn_trans/trans_rva.inc.c
> > >> @@ -61,7 +61,7 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
> > >>
> > >>      gen_set_label(l1);
> > >>      /*
> > >> -     * Address comparion failure.  However, we still need to
> > >> +     * Address comparison failure.  However, we still need to
> > >>       * provide the memory barrier implied by AQ/RL.
> > >>       */
> > >>      tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + a->rl * TCG_BAR_STRL);
> > >> @@ -69,6 +69,12 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, TCGMemOp mop)
> > >>      gen_set_gpr(a->rd, dat);
> > >>
> > >>      gen_set_label(l2);
> > >> +    /*
> > >> +     * Clear the load reservation, since an SC must fail if there is
> > >> +     * an SC to any address, in between an LR and SC pair.
> > >> +     */
> > >> +    tcg_gen_movi_tl(load_res, -1);
> > >> +
> > >>      tcg_temp_free(dat);
> > >>      tcg_temp_free(src1);
> > >>      tcg_temp_free(src2);
> > >> --
> > >
> > > This patch causes boot failures when booting systemd built with musl on RV64.
> > >
> > > It could possibly be a musl bug, but I wanted to throw that out here
> > > first to see what people think.
> >
> > Looking at the musl port, I see at least one bug in their atomics jumping out
> > at me:
> >
> > diff --git a/arch/riscv64/atomic_arch.h b/arch/riscv64/atomic_arch.h
> > index c9765342..41ad4d04 100644
> > --- a/arch/riscv64/atomic_arch.h
> > +++ b/arch/riscv64/atomic_arch.h
> > @@ -14,7 +14,7 @@ static inline int a_cas(volatile int *p, int t, int s)
> >                 "       sc.w.aqrl %1, %4, (%2)\n"
> >                 "       bnez %1, 1b\n"
> >                 "1:"
> > -               : "=&r"(old), "=r"(tmp)
> > +               : "=&r"(old), "=&r"(tmp)
> >                 : "r"(p), "r"(t), "r"(s)
> >                 : "memory");
> >         return old;
> > @@ -31,7 +31,7 @@ static inline void *a_cas_p(volatile void *p, void *t, void *s)
> >                 "       sc.d.aqrl %1, %4, (%2)\n"
> >                 "       bnez %1, 1b\n"
> >                 "1:"
> > -               : "=&r"(old), "=r"(tmp)
> > +               : "=&r"(old), "=&r"(tmp)
> >                 : "r"(p), "r"(t), "r"(s)
> >                 : "memory");
> >         return old;
> >
> > It's a shot in the dark as to whether that'll fix your bug, but I could at
> > least see a mechanism for it: before we yielded load reservations on context
> > switches then that backwards branch would never be taken, so we wouldn't notice
> > if tmp was allocated into one of the same registers as the inputs.  Even if it
> > doesn't fix your issue it's still a bug so I'll send the patch out, just LMK so
> > I can indicate how important the issue is.
>
> I haven't had a chance to test this fix yet. The bug was reported by
> Khem (and other OE people) as it's break musl for RISC-V.

I did get a chance to test it. This seems to fix the issue :)

Please send the patch to musl and CC me when you do.

Good catch!

Alistair

>
> >
> > This should manifest on hardware, but it looks like we managed to drop that SC
> > patch.  I'll go send the patch out now...
>
> Thanks, do you mind CCing me?
>
> Alistair
>
> >
> > >
> > > Alistair
> > >
> > >> 2.21.0
> > >>
> > >>

