Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F83C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 22:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF3E206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 22:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGvR4K80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF3E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK9GI-00034P-LJ
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 18:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iK9FU-0002aj-IQ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 18:55:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iK9FT-0001rR-AA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 18:55:32 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:33168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iK9FT-0001qh-2O; Mon, 14 Oct 2019 18:55:31 -0400
Received: by mail-lj1-x244.google.com with SMTP id a22so18224689ljd.0;
 Mon, 14 Oct 2019 15:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DaahTCxl0gd6VO8eLTgXKhKcTiBd9QFV8L/VBsa9xr4=;
 b=iGvR4K80od15B2DgSLC+hDAsEsX+y8LZmjwxc6vUR6M1RfDYyYKKFQ0SFh1F77aoHL
 wf535wJE2HMmCGNr2zw8ZONRuW/SmU5LZc9XfKWnPLOVA4rnhqRMi7288dgH8NmDCwFq
 5zjk0Ax5rjEss8eS1/VNqR+TXWZnTd1JkXsn3wq/FRvlwYxgmrUtyNggArsY83aKZHeH
 9zT8Z9VGIvCMd8cVBDe++Aq+qKvFimSdtbwwxF/WVppCuSgLIMnP4JOvGdgHvM/G0nei
 qrqLqCIAgFDYP0Aqu/S5eUGZJlx5ibUfz5H970vEAlpn4OaTGdF2pHIcpuSmtNT9WIm5
 3i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DaahTCxl0gd6VO8eLTgXKhKcTiBd9QFV8L/VBsa9xr4=;
 b=iAYfI9/jz1yTtdnkXj3rCcJaB2mf+NG7HvzRYbjRE5xg1PmlrnTsLSpMnyYzpQDhSu
 7+Jkq32UiXCQiJ73Tc8qIxx9Vle05Pa0lFrJm/mTyvD+iAdjL4OLiV6FrRT1PM6ERAiK
 fS9OTQgrcdKAUJEEeoj9yORnpQw6/nrRy2K8ZLZRtZggaPiypr6/wlMeDXVJlUrvo/yH
 qtjM/Dgfil9jthH2BZJ+kYa2OHosHbF0ONY3WdxKkctHTc6cGRB1dgMjZRYJjzmIImH5
 hVYq2+nK9CXa5sDTlBiu8hfUxEz6N6Y30wI0V973Jw6cR7wejjdt6teWps9MMN0klThi
 6+EA==
X-Gm-Message-State: APjAAAVmpOA7lImTYGe/D/ufLzoYqZyUh1z4XJ7kKYJP/devpqk8FEVG
 NpZCORFmehfPDtxHXtWcd771IxXV+mGXQayRLbE=
X-Google-Smtp-Source: APXvYqwr/BBv720r6XEjYte+khgPkFiXYmBNIHLntPB3cNPA7P/L0te/P369xh4fCTceT+KY2FdU3j5Pxs6v86ki6L8=
X-Received: by 2002:a2e:9604:: with SMTP id v4mr1339993ljh.101.1571093729197; 
 Mon, 14 Oct 2019 15:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <1569456861-8502-1-git-send-email-guoren@kernel.org>
 <mhng-32483094-26fb-4f1d-9d82-facd447bc7df@palmer-si-x1c4>
In-Reply-To: <mhng-32483094-26fb-4f1d-9d82-facd447bc7df@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 14 Oct 2019 15:50:24 -0700
Message-ID: <CAKmqyKMQvxUG-ssGW4j3LYc9TRf1v4YtOPQcVytnEutjS5jO0g@mail.gmail.com>
Subject: Re: [PATCH V6] target/riscv: Ignore reserved bits in PTE for RV64
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Guo Ren <guoren@kernel.org>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 12, 2019 at 10:33 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 25 Sep 2019 17:14:21 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> > need to ignore them. They cannot be a part of ppn.
> >
> > 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
> >    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
> >    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Tested-by: Bin Meng <bmeng.cn@gmail.com>
> > Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  target/riscv/cpu_bits.h   | 7 +++++++
> >  target/riscv/cpu_helper.c | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> >  Changelog V6:
> >   - Add Reviewer: Alistair Francis
> >
> >  Changelog V5:
> >   - Add Reviewer and Tester: Bin Meng
> >
> >  Changelog V4:
> >   - Change title to Ignore not Bugfix
> >   - Use PTE_PPN_MASK for RV32 and RV64
> >
> >  Changelog V3:
> >   - Use UUL define for PTE_RESERVED
> >   - Keep ppn >> PTE_PPN_SHIFT
> >
> >  Changelog V2:
> >   - Bugfix pte destroyed cause boot fail
> >   - Change to AND with a mask instead of shifting both directions
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index e998348..399c2c6 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -473,6 +473,13 @@
> >  /* Page table PPN shift amount */
> >  #define PTE_PPN_SHIFT       10
> >
> > +/* Page table PPN mask */
> > +#if defined(TARGET_RISCV32)
> > +#define PTE_PPN_MASK        0xffffffffUL
> > +#elif defined(TARGET_RISCV64)
> > +#define PTE_PPN_MASK        0x3fffffffffffffULL
> > +#endif
> > +
> >  /* Leaf page shift amount */
> >  #define PGSHIFT             12
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 87dd6a6..9961b37 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -261,7 +261,7 @@ restart:
> >  #elif defined(TARGET_RISCV64)
> >          target_ulong pte = ldq_phys(cs->as, pte_addr);
> >  #endif
> > -        hwaddr ppn = pte >> PTE_PPN_SHIFT;
> > +        hwaddr ppn = (pte & PTE_PPN_MASK) >> PTE_PPN_SHIFT;
> >
> >          if (!(pte & PTE_V)) {
> >              /* Invalid PTE */
>
> I know I'm a bit late to the party here, but I don't like this.  There's ample
> evidence that wrapping the physical address space is a bad idea, and just
> because the ISA allows implementations to do this doesn't mean we should.

I think this is ok as the spec specifically states that "These
reserved bits may also be used to facilitate research
experimentation." and as QEMU is generally used for developing new
features it makes sense to allow guests to set these bit and we just
ignore them.

Software should always set these to zero, so the worst outcome of
doing this is that QEMU will hid software bugs if people set the bits,
but I don't see that as huge downside.

Alistair

