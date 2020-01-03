Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C654BC3276C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 02:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96496222C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 02:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdqp48cP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96496222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inCPM-0008CU-LA
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 21:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1inCOk-0007kz-7W
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 21:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1inCOj-0006nd-5I
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 21:09:10 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1inCOi-0006m9-SN; Thu, 02 Jan 2020 21:09:09 -0500
Received: by mail-lf1-x144.google.com with SMTP id y1so31000429lfb.6;
 Thu, 02 Jan 2020 18:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l8QDKYxk0sJNh5vSS9NGjFYqiMTqN7rFRbE8+T4VhPw=;
 b=Vdqp48cPEId9OmcQKc2Juvl+pFgxTvZQhTEpTzeAixJP42Bd17fwI0bijSJkVzObHx
 3fEC0048mmwS7dvE+YCT1Jx8Q25KkbrLayuJA9pf/7J3N2d60pPi9+T8vjN7wWtYuKYs
 WUi5Yew1a54G+bUDnBtpkIw7ZBNaliH0MIE9dr+mV5QXw/wBsSmSo6aruFzAIUv60IlM
 pnJSPThcd/OlrhuhlqBxKgyI1Pz2LpfNOhyJoX02olhgCde5UR5XRHnFYScxM+aSish7
 OEjYw4fnA1bQZWgsxTVDGVy4ANvbrUQK8XIQ5+6WiQM+q/QBqZkXxxFW+TOyjsiN9xEt
 qADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l8QDKYxk0sJNh5vSS9NGjFYqiMTqN7rFRbE8+T4VhPw=;
 b=Ymcn+fqGinsEoWr7aFSWSAK4vnuCrEYkQpE+5YlVfA8dDKNILwlps2GyO1yNYwzFmJ
 SWnKBZ7XOjjEY8Q05wgi5pig6ZbDrRLNDv0l9f64B0Ni7yzO7AijNZOh+ux7kVSQLDzE
 E346PLjBz0uppdZEP/7ixBXxp4deKmYfm2OcMgFY4uTVwxV+Y3mB9OR48BCRKYTurpn/
 mgXEAgKuuMgl0tyIrubiE8a1J4qh9NdTn2wJexSO1LtT/yPgWCUbpRWJJWMG249HfzCA
 589+QEIT3IbpdeAmCdHoKL1gZrtqx2Zib+7tuXgQcsRm8Ol+OlfaWSkc8PaBQ62NMpn3
 /i9Q==
X-Gm-Message-State: APjAAAVFBFVxLlfry8Ww0Wd4giy/YHJ0R8ATpxn8S93zJhygKcpDjoDE
 uh0nhtOxPcglNdp9oOq3JvZ2kChATHG3fTISIT0=
X-Google-Smtp-Source: APXvYqzEVgFN2vcIftNKj/jDoZCix10wCo8BufTrfV7MTmk8M9qktKu4oQBkRDmEhq6icf8DGQ9gbLwxCoYi7iBximg=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr48223003lfd.5.1578017346414; 
 Thu, 02 Jan 2020 18:09:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575914822.git.alistair.francis@wdc.com>
 <aa8557d53c1f6d3265e2b2c9bc4e127eddb995ea.1575914822.git.alistair.francis@wdc.com>
 <mhng-7890ef29-2f3d-4600-8bd5-5ad839f404a0@palmerdabbelt-glaptop>
In-Reply-To: <mhng-7890ef29-2f3d-4600-8bd5-5ad839f404a0@palmerdabbelt-glaptop>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Jan 2020 18:08:40 -0800
Message-ID: <CAKmqyKNwE77qjEGHVewWhZcx3DKESvAArjqixmFR-72g=+DgLA@mail.gmail.com>
Subject: Re: [PATCH v1 01/36] target/riscv: Convert MIP CSR to target_ulong
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 2, 2020 at 10:18 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Mon, 09 Dec 2019 10:10:43 PST (-0800), Alistair Francis wrote:
> > The MIP CSR is a xlen CSR, it was only 32-bits to allow atomic access.
> > Now that we don't use atomics for MIP we can change this back to a xlen
> > CSR.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu.c | 2 +-
> >  target/riscv/cpu.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index d37861a430..e521ebe2e1 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -224,7 +224,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> >  #ifndef CONFIG_USER_ONLY
> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
> > -    qemu_fprintf(f, " %s 0x%x\n", "mip     ", env->mip);
> > +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mip     ", env->mip);
> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mie     ", env->mie);
> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mideleg ", env->mideleg);
> >      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "medeleg ", env->medeleg);
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index e59343e13c..f889427869 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -121,7 +121,7 @@ struct CPURISCVState {
> >      target_ulong mhartid;
> >      target_ulong mstatus;
> >
> > -    uint32_t mip;
> > +    target_ulong mip;
> >      uint32_t miclaim;
> >
> >      target_ulong mie;
>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!

Can you just apply the patches from this series as they are reviewed?

Also, can you review this series :)

Alistair

