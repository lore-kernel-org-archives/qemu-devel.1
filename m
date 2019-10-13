Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D41DC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 00:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EBA20679
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 00:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOEXnbZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EBA20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJRqZ-0002HN-Fs
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 20:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fintelia@gmail.com>) id 1iJRpr-0001kU-Ux
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 20:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fintelia@gmail.com>) id 1iJRpq-000529-G1
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 20:34:11 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fintelia@gmail.com>)
 id 1iJRpn-00050g-BE; Sat, 12 Oct 2019 20:34:07 -0400
Received: by mail-lf1-x142.google.com with SMTP id q12so9414732lfc.11;
 Sat, 12 Oct 2019 17:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nOKDNalhYB5f7D2qAfxWaYaAViL2od6h8EtYhXFIKjY=;
 b=BOEXnbZDitThFslOPXY10uz8WC4x3bC1hi04y8Sc7gm4RKA+aVRWADF5aKIzgKt1fp
 zlsBpeVhSzHaqEAIhbq3p2fYPOjqeqG70ZuZirVrYMF8XnPdeUzJ7jKmkylkWKphf6pl
 M0f+RkJ9WFMgFkgqOX5JjwUZIHvuD0aPdAbvYrzymgK5cgf4HRozG+XfVEjuZz5B7f3q
 9ngkalTANekr0zJNDJ34ZSm/iRiSzGVlNgbdbCxiaaEboKMLnD4FYb1aEPICAn2a7VTC
 Mf3rlN9QVRSwLL8VPRxEq34lZPTYlglPSkAxx6J4HQ2hW5tTaqClpW5vnSsDxH5Z+dTL
 Cc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nOKDNalhYB5f7D2qAfxWaYaAViL2od6h8EtYhXFIKjY=;
 b=qThuhgaVvJBSPgXEHCVvmI3WGvkDFiYn43H0ZCLyfiEmCYpIfhLBq/Yn6iG1qLwUnZ
 CcJb+Ptoe0ct4P94R8bJNCjHdvQjussn6T2RkF36kyLQ+kTRKOz5EtYy3/MFrG9riYri
 w7vh3J1ht8wBdek8KHfHCZsieHg5EIQJxWtG/ZEnGroec5OMHpi9FjsqJxSjSj5/iuj2
 Fxdb9DGpOsKN5toUptptMpYzquLV+/Tt244D2J9P997gO7ofASvhkjf2KXChix9Pmi0b
 2dq5zsRYSx1FfkrnRAphFQNQuOyETu2Nn/NUEsp7ZE7ohsazcLjqzyzxM+Laxw1IV5Rh
 9d+w==
X-Gm-Message-State: APjAAAXvkAyK1z7dluyjFL7Q4v58u9t4sbpHedhVeBQLPoMTiQpPg1Uk
 Uu4RE1FfNlfM13kbgABO2DSmPATKX4HuAoDtzHc=
X-Google-Smtp-Source: APXvYqwyfwrMG1Awh8Jn6PDarHaHsqV3KOA8Vp2Y5RTI+BUyfFHKE2j4CzmMfpQa9XOC1RY+eRocHtHBLplGzXxcuVY=
X-Received: by 2002:ac2:5bc1:: with SMTP id u1mr12951572lfn.182.1570926845054; 
 Sat, 12 Oct 2019 17:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <1569456861-8502-1-git-send-email-guoren@kernel.org>
 <mhng-32483094-26fb-4f1d-9d82-facd447bc7df@palmer-si-x1c4>
 <CAJF2gTRZ-WXTcUh3z8qmbNxb-i8x1vAyuOiSF5NA75WxyRaDcA@mail.gmail.com>
In-Reply-To: <CAJF2gTRZ-WXTcUh3z8qmbNxb-i8x1vAyuOiSF5NA75WxyRaDcA@mail.gmail.com>
From: Jonathan Behrens <fintelia@gmail.com>
Date: Sat, 12 Oct 2019 20:33:38 -0400
Message-ID: <CANnJOVEXmsVho7db1xq1-vDk7D4shxMRW-eh-PQuxtu1eKQsaQ@mail.gmail.com>
Subject: Re: [PATCH V6] target/riscv: Ignore reserved bits in PTE for RV64
To: Guo Ren <guoren@kernel.org>
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Ren Guo <ren_guo@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nowhere in the spec that ever says what hardware has to do if
any of those reserved bits are non-zero. Hardware is certainly not
required to ignore them and treat the PTE as being valid (which is
what this patch does). I'd argue that since only buggy code would ever
set these bits, QEMU should treat any PTE with them set as being
invalid so that programmers can realize they've made a mistake.

Jonathan


On Sat, Oct 12, 2019 at 8:16 PM Guo Ren <guoren@kernel.org> wrote:
>
> The patch didn't wrap the physical address space directly, just follow the spec.
> I admit that I am trying to use the compliance specification to allow
> qemu to support some non-standard software.
> But compliance specification and wrapping the physical address space
> are different things.
> I'm preparing c910 pachset for linux riscv and you can question me there.
>
> On Sun, Oct 13, 2019 at 1:33 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Wed, 25 Sep 2019 17:14:21 PDT (-0700), guoren@kernel.org wrote:
> > > From: Guo Ren <ren_guo@c-sky.com>
> > >
> > > Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> > > need to ignore them. They cannot be a part of ppn.
> > >
> > > 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
> > >    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
> > >    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
> > >
> > > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > > Tested-by: Bin Meng <bmeng.cn@gmail.com>
> > > Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > >  target/riscv/cpu_bits.h   | 7 +++++++
> > >  target/riscv/cpu_helper.c | 2 +-
> > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > >  Changelog V6:
> > >   - Add Reviewer: Alistair Francis
> > >
> > >  Changelog V5:
> > >   - Add Reviewer and Tester: Bin Meng
> > >
> > >  Changelog V4:
> > >   - Change title to Ignore not Bugfix
> > >   - Use PTE_PPN_MASK for RV32 and RV64
> > >
> > >  Changelog V3:
> > >   - Use UUL define for PTE_RESERVED
> > >   - Keep ppn >> PTE_PPN_SHIFT
> > >
> > >  Changelog V2:
> > >   - Bugfix pte destroyed cause boot fail
> > >   - Change to AND with a mask instead of shifting both directions
> > >
> > > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > > index e998348..399c2c6 100644
> > > --- a/target/riscv/cpu_bits.h
> > > +++ b/target/riscv/cpu_bits.h
> > > @@ -473,6 +473,13 @@
> > >  /* Page table PPN shift amount */
> > >  #define PTE_PPN_SHIFT       10
> > >
> > > +/* Page table PPN mask */
> > > +#if defined(TARGET_RISCV32)
> > > +#define PTE_PPN_MASK        0xffffffffUL
> > > +#elif defined(TARGET_RISCV64)
> > > +#define PTE_PPN_MASK        0x3fffffffffffffULL
> > > +#endif
> > > +
> > >  /* Leaf page shift amount */
> > >  #define PGSHIFT             12
> > >
> > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > > index 87dd6a6..9961b37 100644
> > > --- a/target/riscv/cpu_helper.c
> > > +++ b/target/riscv/cpu_helper.c
> > > @@ -261,7 +261,7 @@ restart:
> > >  #elif defined(TARGET_RISCV64)
> > >          target_ulong pte = ldq_phys(cs->as, pte_addr);
> > >  #endif
> > > -        hwaddr ppn = pte >> PTE_PPN_SHIFT;
> > > +        hwaddr ppn = (pte & PTE_PPN_MASK) >> PTE_PPN_SHIFT;
> > >
> > >          if (!(pte & PTE_V)) {
> > >              /* Invalid PTE */
> >
> > I know I'm a bit late to the party here, but I don't like this.  There's ample
> > evidence that wrapping the physical address space is a bad idea, and just
> > because the ISA allows implementations to do this doesn't mean we should.
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
>

