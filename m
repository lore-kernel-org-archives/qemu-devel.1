Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0758BC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 00:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D6C20679
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 00:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU2PW/2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D6C20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJRZn-0006Cw-TB
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 20:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iJRYz-0005RL-OV
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 20:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iJRYy-0004hF-CU
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 20:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39766)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iJRYy-0004g0-4L; Sat, 12 Oct 2019 20:16:44 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 08E5B21655;
 Sun, 13 Oct 2019 00:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570925802;
 bh=KV65rNX0T3AXR371hAkF9poTyIHYvyckUjDwnY09yEA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=SU2PW/2yAQAD9fU8/fnUeFOJYxizNgteq5ydMINt/cdSIiit6tU3NhPW9MVbxtW6a
 vBQ3xI+LvczaqgESnS8SXLvzxI20mrkVz6Qb7s964OMNW+0mJdZBhvovZsdS6wY6wn
 vkwFzUA3DhWqodepWeCID4+CUydItUXtRemI1t2c=
Received: by mail-wm1-f47.google.com with SMTP id m18so13359536wmc.1;
 Sat, 12 Oct 2019 17:16:41 -0700 (PDT)
X-Gm-Message-State: APjAAAV7hIoFsZ4su4ZafqPb5jFBYLpV2el0CYxS8gFhtSzK4yBXCFsE
 OrL8OM9pFyGoYhAcE4kxFUceyXJ1Qr8zboG5460=
X-Google-Smtp-Source: APXvYqy0DUkDGjjyebLpBBYaoigEQsXv5QZPY8spZeYg/mKIT8JX9jsOIRC6P+f573sH7/6fiHgNMcP/1Co8g6v0Deg=
X-Received: by 2002:a1c:b654:: with SMTP id g81mr8686013wmf.172.1570925800495; 
 Sat, 12 Oct 2019 17:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <1569456861-8502-1-git-send-email-guoren@kernel.org>
 <mhng-32483094-26fb-4f1d-9d82-facd447bc7df@palmer-si-x1c4>
In-Reply-To: <mhng-32483094-26fb-4f1d-9d82-facd447bc7df@palmer-si-x1c4>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 13 Oct 2019 08:16:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRZ-WXTcUh3z8qmbNxb-i8x1vAyuOiSF5NA75WxyRaDcA@mail.gmail.com>
Message-ID: <CAJF2gTRZ-WXTcUh3z8qmbNxb-i8x1vAyuOiSF5NA75WxyRaDcA@mail.gmail.com>
Subject: Re: [PATCH V6] target/riscv: Ignore reserved bits in PTE for RV64
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Ren Guo <ren_guo@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch didn't wrap the physical address space directly, just follow the spec.
I admit that I am trying to use the compliance specification to allow
qemu to support some non-standard software.
But compliance specification and wrapping the physical address space
are different things.
I'm preparing c910 pachset for linux riscv and you can question me there.

On Sun, Oct 13, 2019 at 1:33 AM Palmer Dabbelt <palmer@sifive.com> wrote:
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



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

