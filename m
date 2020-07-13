Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1804C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:15:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF882067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 01:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP67xxjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF882067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jun46-0007z2-Lk
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 21:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jun3R-0007VT-Jr; Sun, 12 Jul 2020 21:14:49 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:42942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jun3P-00014g-Tq; Sun, 12 Jul 2020 21:14:49 -0400
Received: by mail-yb1-xb41.google.com with SMTP id x138so4062492ybg.9;
 Sun, 12 Jul 2020 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gdqH0XhQFa0VRGbuLsFrAvUgcSV5sgjjAGNz2Xc8CO0=;
 b=XP67xxjEjWdaVFLsYQQXJuB0xBC7bp3E5P4c9/t7m1TJ6ISxgWQfKX1zL4wPeDK1r/
 OJwh6euvrguIXzbR+FMuX+f6qz3u9/EvygaSdqTy4HNRWtV1U3+3dPJHggJCYZu2H0Ve
 ZbwMyFWwWJLQQiZHbP12uBcPGz5M1v9enhO5YClH0yB3xkelrbbBG1l4etKoEi6v9O+Y
 D00uSwnLJ+SRer3dPQJWttVuCQAaq69hOa/xb/A6vTpLpF+jkJEinEPLbi+Wvoi3GlkL
 PfiU85BgFYa0yl3aEdtziT1XWIcBW9AAGY3X47iT1RidK0NZxyHylQczjQYf0Joyahr+
 r8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gdqH0XhQFa0VRGbuLsFrAvUgcSV5sgjjAGNz2Xc8CO0=;
 b=D7lETHr0Gp2+hicwMU6MFQOosXYp7boEDvgjRIVBTl3SkLs0MJ0BXYorlwMRZBupfN
 lN3Go45w7iSYN4Py6zcFnsm5cZghkhI2mGxw0vtnTx2UwJbzfYwzoU++gGWFBuC5B5xA
 uFCgqJgWWdQAhFIKDcoTDZ6RyTsVdmcb04yHm9O6AXRk4bqTIboZJqLqRyRdJ86CNj0l
 uKv5NmkYk99B0ppOEb72GjTZzfvMPxHj44PZ7xrMKURrIym749+FISoXuTp9aSjUuHyT
 vuVtbBfygM40as49If8TcdtmSyQZ+w7xhDmy7eWz2i5zNVda4SQkLwlRLoEOvNOdELvI
 0hZQ==
X-Gm-Message-State: AOAM532tiSeCrbS6wpPSRTkKSai3OTjJ33LNKn8O1SNfV7fDU50pzrqn
 cu5/BTieqNn6/o+Eu6xMs7lsgSl52NLXvogelt0=
X-Google-Smtp-Source: ABdhPJw/y/4TBgh4IucQWF+uIGNN6+Mwi4FO0QzltfmwAVQrrP9mPGtbIID3upx1jkBh2HkzHNUmZydr4UIUvtlP3d0=
X-Received: by 2002:a25:e5c3:: with SMTP id c186mr9912548ybh.332.1594602886205; 
 Sun, 12 Jul 2020 18:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <1594289144-24723-1-git-send-email-bmeng.cn@gmail.com>
 <1594289144-24723-2-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKPvn7dALUHhK=na1svr==oZ2rvyFOnw8FvRJZP23uHN7Q@mail.gmail.com>
 <CAEUhbmX4-Js6J9eqRnBT5q9QqRY8R5-AQ4VRg1iVDJPzcurDUA@mail.gmail.com>
 <CAKmqyKM2ZQ4oNqLG3UQWVhnHi1q7h_HjW7hjTfAC-2-1gXjzNg@mail.gmail.com>
In-Reply-To: <CAKmqyKM2ZQ4oNqLG3UQWVhnHi1q7h_HjW7hjTfAC-2-1gXjzNg@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 13 Jul 2020 09:14:35 +0800
Message-ID: <CAEUhbmXTfjsGVE-i_8ty5W0ybOS+1mPjf0ECzs0j6T+ZqLt77A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/riscv: sifive_u: Provide a reliable way for
 bootloader to detect whether it is running in QEMU
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Kadam <sagar.kadam@sifive.com>,
 Pragnesh Patel <pragnesh.patel@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

On Sun, Jul 12, 2020 at 12:03 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jul 9, 2020 at 5:48 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Alistair,
> >
> > On Fri, Jul 10, 2020 at 6:19 AM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Thu, Jul 9, 2020 at 3:07 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > >
> > > > From: Bin Meng <bin.meng@windriver.com>
> > > >
> > > > The reset vector codes are subject to change, e.g.: with recent
> > > > fw_dynamic type image support, it breaks oreboot again.
> > >
> > > This is a recurring problem, I have another patch for Oreboot to fix
> > > the latest breakage.
> > >
> >
> > Can Oreboot be updated to remove the QEMU detection?
>
> In general I think it should be.
>
> Right now it's not critical to do. I think from a QEMU perspective we
> have finished changing the "ROM" code so after this release we can
> update Oreboot and then it should settle down again.
>
> >
> > > >
> > > > Add a subregion in the MROM, with the size of machine RAM stored,
> > > > so that we can provide a reliable way for bootloader to detect
> > > > whether it is running in QEMU.
> > >
> > > I don't really like this though. I would prefer that we don't
> > > encourage guest software to behave differently on QEMU. I don't think
> > > other upstream boards do this.
> > >
> > > Besides Oreboot setting up the clocks are there any other users of this?
> >
> > I don't really have any specific reason, except for testing U-Boot SPL
> > by relaxing the requirement of hardcoding the memory to 8G "-m 8G" as
> > I indicated in the commit message below:
>
> Yeah, I think that's just something we will have to deal with. If the
> guest expects 8GB and doesn't check the device tree passed to it then
> the user has to create 8GB of memory.
>

Note there are two reasons that why "-m 8G" is used to test U-Boot SPL:

1. U-Boot DDR driver is hardcoding memory to 8G, which I had a fix
locally and will send U-Boot upstream soon.
2. U-Boot SPL has to use its own device tree because we don't want to
update QEMU to include all the DDR register settings in the device
tree which is very big.

Why I wanted to add this patch here is that I wanted to dynamically
patch U-Boot SPL DT to use the actual ram size that QEMU instantiates.
This way we can avoid editing U-Boot SPL DT to set the actual memory
size.

Regards,
Bin

