Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520A2C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3F320673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 09:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh2PsT7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3F320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD3M6-0003TT-RR
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 05:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iD3Kq-0002ZI-GD
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iD3Kp-0003nH-7V
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 05:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60118)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iD3Ko-0003me-VO; Wed, 25 Sep 2019 05:11:43 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF85220673;
 Wed, 25 Sep 2019 09:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569402701;
 bh=1fBfR4XDrl6VjHYFULK8TPjcSSpvzjSfMe4vTT4fa9g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=jh2PsT7QR3+SCskeUJRBg+XUINSBZ7RQnmd0ZxaAW7RQs/VfSEgfZLYDNbBZyJdDN
 4Nfmee3cteAetoEVAiuOB8bXkEjhnHxbgfhqjdvqo1STWHBt+r75Ohp71tTyB/lLYv
 TPmCpme1gV655WfRXrNdN5HGfIqJsA7hHw6WZ89c=
Received: by mail-wm1-f54.google.com with SMTP id p7so4251469wmp.4;
 Wed, 25 Sep 2019 02:11:40 -0700 (PDT)
X-Gm-Message-State: APjAAAUIYzVrf6baUZiKdw6HC+sUKlaWoQTPLp4TkfZlnYG1P6vXOb8i
 BphA8DrtGWuwVLsmbO9zvfv8Q9URZeU5KNWLm+U=
X-Google-Smtp-Source: APXvYqzGcs4wa/UcGxZJNgAp2utqncHyip3Zd8Lh28lURp/zUFwk7TzW5ny3Ly75SiPZroXa6FdwXjnxR6j4OoNH5UM=
X-Received: by 2002:a05:600c:1103:: with SMTP id
 b3mr6570969wma.3.1569402699205; 
 Wed, 25 Sep 2019 02:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <1569386895-8726-1-git-send-email-guoren@kernel.org>
 <CAEUhbmW2SB9xak88XQ2LdKL6jtHoLWTQY+j-WFGvgO2tExh4pg@mail.gmail.com>
In-Reply-To: <CAEUhbmW2SB9xak88XQ2LdKL6jtHoLWTQY+j-WFGvgO2tExh4pg@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 25 Sep 2019 17:11:27 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRve8qdWpjs1pWdqAtGigCb5V3wkQa4Dk4=k+8tnxKkSg@mail.gmail.com>
Message-ID: <CAJF2gTRve8qdWpjs1pWdqAtGigCb5V3wkQa4Dk4=k+8tnxKkSg@mail.gmail.com>
Subject: Re: [PATCH V3] target/riscv: Bugfix reserved bits in PTE for RV64
To: Bin Meng <bmeng.cn@gmail.com>
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
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 1:35 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, Sep 25, 2019 at 12:49 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <ren_guo@c-sky.com>
> >
>
> nits: the title is probably better to be rephrased to: Ignore reserved
> bits when calculating PPN for RV64
Yes, I forgot change the title.

>
> > Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> > need to ignore them. They can not be a part of ppn.
>
> nits: cannot
Thx

>
> >
> > 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
> >    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
> >    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> > ---
> >  target/riscv/cpu_bits.h   | 3 +++
> >  target/riscv/cpu_helper.c | 4 +++-
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > ---
> > Changelog V3:
>
> nits: normally we put changelog before the changed file summary above,
> and there is no need to put another ---
OK, just remove ---

>
> >  - Use UUL define for PTE_RESERVED.
> >  - Keep ppn >> PTE_PPN_SHIFT
> >
> > Changelog V2:
> >  - Bugfix pte destroyed cause boot fail
> >  - Change to AND with a mask instead of shifting both directions
> >
> > diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> > index e998348..cdc62a8 100644
> > --- a/target/riscv/cpu_bits.h
> > +++ b/target/riscv/cpu_bits.h
> > @@ -470,6 +470,9 @@
> >  #define PTE_D               0x080 /* Dirty */
> >  #define PTE_SOFT            0x300 /* Reserved for Software */
> >
> > +/* Reserved highest 10 bits in PTE */
> > +#define PTE_RESERVED        0xFFC0000000000000ULL
>
> Can we define the macro for RV32 too, so that (see below)
OK

>
> > +
> >  /* Page table PPN shift amount */
> >  #define PTE_PPN_SHIFT       10
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 87dd6a6..7e04ff5 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -258,10 +258,12 @@ restart:
> >          }
> >  #if defined(TARGET_RISCV32)
> >          target_ulong pte = ldl_phys(cs->as, pte_addr);
> > +        hwaddr ppn = pte;
> >  #elif defined(TARGET_RISCV64)
> >          target_ulong pte = ldq_phys(cs->as, pte_addr);
> > +        hwaddr ppn = pte & ~PTE_RESERVED;
> >  #endif
> > -        hwaddr ppn = pte >> PTE_PPN_SHIFT;
> > +        ppn = ppn >> PTE_PPN_SHIFT;
>
> we can just do this in this single line?
Yes

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

