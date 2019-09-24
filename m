Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E7BC432C2
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:45:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7D8920872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1neH1Ma0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D8920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCfVR-0003BZ-GZ
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 03:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iCfU1-0002bD-Q9
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iCfU0-0004UE-Eo
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iCfU0-0004Pk-6Z; Tue, 24 Sep 2019 03:43:36 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B0E3A214DA;
 Tue, 24 Sep 2019 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569311015;
 bh=izqiCldVI+IqJ9y6fkccFKPCDpgGmGqFvGvV7pRg3S0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=1neH1Ma0yU7b5TfugpLSmNKyi1s2Y7TW/sXCt+UGk55YVvkQ/nrZRjbBQ5bt3aPQd
 bccCVr8RhMP8f3HY3FyIzQIAnczeXT6G3VOrFFDSg73KwT/nl+r2VRRYv9+KHxC9qE
 C6rQ5fp8nVKcbqppQSCP28gu/XddiVcZiF4VMGV4=
Received: by mail-wr1-f50.google.com with SMTP id r5so715945wrm.12;
 Tue, 24 Sep 2019 00:43:34 -0700 (PDT)
X-Gm-Message-State: APjAAAXQi7/1EUM2MrzReu1eCcFuztuCVyoVT5lcOgowo4qsXCg9RReh
 3gMphbLt/b7W3NTW394axnUcCwt75sKgSSakMGM=
X-Google-Smtp-Source: APXvYqymHnDiJx8TNMhVrYiza/m4Fx8YcJgf6l+Z6jHQiFoj97uqHh+ujVlQrhLPekB6EaAR0CXMpzk75Or+4YXyry8=
X-Received: by 2002:adf:fac3:: with SMTP id a3mr1094534wrs.24.1569311013240;
 Tue, 24 Sep 2019 00:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <1569301232-7128-1-git-send-email-guoren@kernel.org>
 <CAKmqyKO9=FuqsEDbuA_iw3+W8fpcGxudxV76vu2ZucRLeExQUA@mail.gmail.com>
In-Reply-To: <CAKmqyKO9=FuqsEDbuA_iw3+W8fpcGxudxV76vu2ZucRLeExQUA@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 24 Sep 2019 15:43:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSTyKMNYbG_hF9EwdsyBeHjqbzAxG41uZrQPmxUaD9hCA@mail.gmail.com>
Message-ID: <CAJF2gTSTyKMNYbG_hF9EwdsyBeHjqbzAxG41uZrQPmxUaD9hCA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Bugfix reserved bits in PTE for RV64
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Guo Ren <ren_guo@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ok, In fact it's wrong patch, don't try it. pte is destroyed.

Sorry for that, I'll send V2.

On Tue, Sep 24, 2019 at 1:03 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Mon, Sep 23, 2019 at 10:01 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> > need to ignore them. They can not be a part of ppn.
> >
> > 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
> >    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
> >    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> > ---
> >  target/riscv/cpu_helper.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 87dd6a6..3c5e8f6 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -260,6 +260,7 @@ restart:
> >          target_ulong pte = ldl_phys(cs->as, pte_addr);
> >  #elif defined(TARGET_RISCV64)
> >          target_ulong pte = ldq_phys(cs->as, pte_addr);
> > +        pte = pte << 10 >> 10;
>
> You can just AND with a mask instead of shifting both directions.
>
> Alistair
>
> >  #endif
> >          hwaddr ppn = pte >> PTE_PPN_SHIFT;
> >
> > --
> > 2.7.4
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

