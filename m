Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078B8C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 23:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60E321971
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 23:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOJqOYEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60E321971
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDH29-0006wO-VK
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 19:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoren@kernel.org>) id 1iDGz6-0004uR-HK
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:46:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoren@kernel.org>) id 1iDGz2-00036J-Nq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 19:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoren@kernel.org>)
 id 1iDGz1-0002w0-K0; Wed, 25 Sep 2019 19:46:08 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3DA8C214DA;
 Wed, 25 Sep 2019 23:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569455161;
 bh=ksu3r/ccm9IRrLgnyuvZeW006N+sW3ZqteQCwP1C1oE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=VOJqOYEfih2Xcyx3SRW2SB9/5KtuuGib7vAq7gW844fZaHUg7XWFXj1R7SJrkiYx8
 i6sB+RaIt3jQ+k+Ycfj606hfeUdijfyhon7ctPLv51m4r0cESS0NN6gajsQ1mrYP02
 MN9qUKa4C1v5p7F9xzAf/eRFjhRFfi21/PD2kf0I=
Received: by mail-wr1-f52.google.com with SMTP id o18so248653wrv.13;
 Wed, 25 Sep 2019 16:46:01 -0700 (PDT)
X-Gm-Message-State: APjAAAX8ykVP/0cCaNbSJzkoCJj1t7MNhrXTc8fVUAEWCzrhyWPuseto
 TrjUtPs1hi5Vomoc5RqD0bDJj22r53z6Yq1jfIg=
X-Google-Smtp-Source: APXvYqwq/HEXqrqoz2O2JdnJa0TQMXOWYNlj0vXl3ISO2SIDl0c4CWJ+1zqhGeH4ZNU2pRgo5hnEfAyj5ICJ6fgOhCA=
X-Received: by 2002:adf:fac3:: with SMTP id a3mr545438wrs.24.1569455159696;
 Wed, 25 Sep 2019 16:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <1569413099-6859-1-git-send-email-guoren@kernel.org>
 <CAKmqyKNYZWRoWFPUofTw0JpVrAG8eZOT8QDWeOgj5GB4gCt7ZA@mail.gmail.com>
In-Reply-To: <CAKmqyKNYZWRoWFPUofTw0JpVrAG8eZOT8QDWeOgj5GB4gCt7ZA@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 26 Sep 2019 07:45:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ6T2zOxh_3=M-J=Jo951RygRbgNdT4E0-a_Qb_j5ANKg@mail.gmail.com>
Message-ID: <CAJF2gTQ6T2zOxh_3=M-J=Jo951RygRbgNdT4E0-a_Qb_j5ANKg@mail.gmail.com>
Subject: Re: [PATCH V5] target/riscv: Ignore reserved bits in PTE for RV64
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Guo Ren <ren_guo@c-sky.com>,
 Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thx, Sincerely

On Thu, Sep 26, 2019 at 6:52 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, Sep 25, 2019 at 5:05 AM <guoren@kernel.org> wrote:
> >
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
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > ---
> >  target/riscv/cpu_bits.h   | 7 +++++++
> >  target/riscv/cpu_helper.c | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> >  Changelog V5:
> >   - Update Reviewer and Tester.
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
> > --
> > 2.7.4
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

