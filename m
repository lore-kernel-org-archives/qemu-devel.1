Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F068C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4958F2086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 21:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="v16YwgVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4958F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgyK8-0002bO-3w
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 17:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56389)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hgyI5-0001hg-2S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hgyI3-0001Zj-Jj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:20:16 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:25587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71)
 (envelope-from <bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
 id 1hgyI2-0001Q8-M3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 17:20:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
 s=pic; 
 t=1561756802; h=Content-Type: Cc: To: Subject: Message-ID: Date: From:
 In-Reply-To: References: MIME-Version: Sender;
 bh=sOaaz9ehXVtLaJs7o+cAz5g128v97stLg2oZGhziyxw=;
 b=v16YwgVH6thG8wSjR0tRQEX3rJa2i537xeEmsSrI8jCNtAyvumPi+n/flLGknKRB4LDuYTFb
 //qRFP7qqUYKvOp8tILWox5/nCk4zctQbrE3TkPkBEg2tBrcedNQA70UdHCDxtFHwfNutaNe
 tT06Ji0QAGkZQCG4YmwnLT51MlKTTRQ8aJf31CWWQV2N9t/x0MBvrCUZPhv5oEcrSP+XgFET
 cvQTgJU18Nm82bDTKry6hrf6azKLgMPPUewrQmfl2Ym1JMNCMKlZlcGME1yQ12AX0PQc+q+C
 jKCC7So1/mGmJOSgrN5MZPB6mHNHWqStQfgvGnk6o6r8umDpp4Tbfg==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mxa.mailgun.org with ESMTP id 5d168481.7f95dc3620b0-smtp-out-n01;
 Fri, 28 Jun 2019 21:20:01 -0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id p17so7345169ljg.1;
 Fri, 28 Jun 2019 14:20:01 -0700 (PDT)
X-Gm-Message-State: APjAAAVxrFFI9+EqYSFuew/TYKOZfoWXizkJHODqwACxiA1ZBUtv8f7l
 CjJY41DKYdRgk3VuEg2hHDaonYbnOjIQ+e/CMzI=
X-Google-Smtp-Source: APXvYqxD80lJ4QuEeoV0thdjhtCjUt2OOK0Fr3cfQDnIK3JCXr6QdQB0wqD+16BdXnO3JVNIkRGpd1AQEfloa2t17cA=
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr7540697lji.64.1561756800146;
 Fri, 28 Jun 2019 14:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190628201133.14235-1-jonathan@fintelia.io>
 <CAKmqyKNKD4k-Z=-cbFwqnqRQV3e+EO0V0G-brYGeHW4ir0Z+yA@mail.gmail.com>
In-Reply-To: <CAKmqyKNKD4k-Z=-cbFwqnqRQV3e+EO0V0G-brYGeHW4ir0Z+yA@mail.gmail.com>
From: Jonathan Behrens <jonathan@fintelia.io>
Date: Fri, 28 Jun 2019 17:19:28 -0400
X-Gmail-Original-Message-ID: <CANnJOVHPR328jK0qEVpn5Tri5bUa4DvsTF8hZqJuac1nGicxRw@mail.gmail.com>
Message-ID: <CANnJOVHPR328jK0qEVpn5Tri5bUa4DvsTF8hZqJuac1nGicxRw@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Hardwire mcounter.TM and
 upper bits of [m|s]counteren
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Can you wrap your commit message at ~70 lines?

Sure.

> Isn't CSR_TIME & 31 just 0? Can this just be changed 1 << 1 or even
better add a macro?

Any of those options work. Unless anyone feels strongly otherwise, I'll add
macros for the bits associated with the three named counters but not the
remaining 29 unnamed "high performance counters".

On Fri, Jun 28, 2019 at 5:03 PM Alistair Francis <alistair23@gmail.com>
wrote:

> On Fri, Jun 28, 2019 at 1:12 PM <jonathan@fintelia.io> wrote:
> >
> > From: Jonathan Behrens <jonathan@fintelia.io>
> >
> > QEMU currently always triggers an illegal instruction exception when code
> > attempts to read the time CSR. This is valid behavor, but only if the TM
> bit in
> > mcounteren is hardwired to zero. This change also corrects mcounteren
> and scounteren CSRs to be 32-bits on both
> > 32-bit and 64-bit targets.
>
> Thanks for the patch.
>
> Can you wrap your commit message at ~70 lines?
>
> >
> > Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> > ---
> >  target/riscv/cpu.h | 4 ++--
> >  target/riscv/csr.c | 3 ++-
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 0adb307f32..2d0cbe9c78 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -151,8 +151,8 @@ struct CPURISCVState {
> >      target_ulong mcause;
> >      target_ulong mtval;  /* since: priv-1.10.0 */
> >
> > -    target_ulong scounteren;
> > -    target_ulong mcounteren;
> > +    uint32_t scounteren;
> > +    uint32_t mcounteren;
> >
> >      target_ulong sscratch;
> >      target_ulong mscratch;
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index e0d4586760..89cf9734c3 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
> > @@ -473,7 +473,8 @@ static int write_mcounteren(CPURISCVState *env, int
> csrno, target_ulong val)
> >      if (env->priv_ver < PRIV_VERSION_1_10_0) {
> >          return -1;
> >      }
> > -    env->mcounteren = val;
> > +    /* mcounteren.TM is hardwired to zero, all other bits are writable
> */
> > +    env->mcounteren = val & ~(1 << (CSR_TIME & 31));
>
> Isn't CSR_TIME & 31 just 0? Can this just be changed 1 << 1 or even
> better add a macro?
>
> Otherwise this patch looks good :)
>
> Alistair
>
> >      return 0;
> >  }
> >
> > --
> > 2.22.0
> >
>
