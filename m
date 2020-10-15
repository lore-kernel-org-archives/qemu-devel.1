Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A09C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 02:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EE322255
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 02:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="V5ehwxfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EE322255
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSstS-00013K-8P
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 22:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kSssV-0000XF-8p
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 22:20:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:39556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <green.wan@sifive.com>)
 id 1kSssT-0003TX-02
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 22:20:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id c13so1448653oiy.6
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gxs/K06KqtsMvibfK+x1C8VCxxHWIvatYPCu2bPd3KI=;
 b=V5ehwxfvnjHgQxBUcGXF1WIeWXeQ0At/fPIdR+s1OlANK79xrbWZ6/LncF6Lx5NTyz
 z+PSrD67EUJz3KS+GuFrhXtGeX54MGIiZcGD2N/1a3Qw6JuCkeH61Uv8oQSslCTrgDHC
 vDaEQDmkhZdeaFMMhzWkIfMOLIusaBLtzp1OlBAC9ioWl+UfZsQb0Ax9FuLN0Kvlsd2W
 eQruwRKWXhpkyPaM9PhtIeOGhtyZ+ShdloQKpwcL56b8SFLebOrRTTntK6TIxBJ5274X
 ePYeTwIffg/9lYhc9jCDhnf/kSLu45BG+nGFVNZeCuQ7szCFGjQCVdVM19dnX15s9PiL
 ouIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gxs/K06KqtsMvibfK+x1C8VCxxHWIvatYPCu2bPd3KI=;
 b=Y5oXBnewylYONvSW/L/EjNg0+goIEOjbxo7p5mi+JBN3KE4BZxjRV6+hXd/mixSDxn
 HDSkpO88I4OyvllBw0lOsvGcgYQ4CnfII1uBzBiJ3QEKJuIDivNqDloXn4FF8HGEm7ed
 9xGt5SMWtSSWArsi0Zr6RrAB0CHy0BiF3TW9eutHM/F9/pEhoneGTrsiguZDKw6uNNPv
 jmr1SZlkvFaJr4FKJZTe6IJrcn880adj3HCX5G82PSi2S4yEheFgoVx3GJpomjjvLgzp
 k08qJ+MESgLIIAxhdHSldgucbv/cWo/fjj/jgq6wmys/4ndmYOHaSFEWLn4siE+R/i65
 ipbg==
X-Gm-Message-State: AOAM533tpfQj9/R9bOAbGcJPRlIyZrD/RR6rH/Scp32vgv317A1qy9b5
 t8053tENgQ/7l/j0BXTVT5fdyb77w6c8BBN0F6QWNQ==
X-Google-Smtp-Source: ABdhPJxhznTgU4/iTPEPlXcy1xEct+3L+pq0tbA97ZJ3aLI3pAS+lYujn6GLBq3UIuIrNviwwFtWZDPGvxU5uFN9yIs=
X-Received: by 2002:aca:5d07:: with SMTP id r7mr684037oib.87.1602728423424;
 Wed, 14 Oct 2020 19:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200901154711.18457-1-green.wan@sifive.com>
 <20200901154711.18457-3-green.wan@sifive.com>
 <CAKmqyKOqQgE0X3T100Zzi6_8X5d9XVEjam01bhCZSU=-FL-ecw@mail.gmail.com>
 <CAJivOr4xLP1n4eVFyWHi=ckg17C_j76f=+o+YPztsYuaPDwCCw@mail.gmail.com>
 <CAKmqyKPFbfbXSryWW40kW=RF-mx4V_nVqmdOveQ-fuLQgFbARQ@mail.gmail.com>
 <CAJivOr7PVXi430SzPgbyFtFPqAsufy_xs1O7gfWQAS1ktTwb1A@mail.gmail.com>
 <CAKmqyKNC5K5MEvVGaZPisTEyrePNV3jWrSYzuUcY3p62ws2VXg@mail.gmail.com>
 <CAEUhbmWJsrcvShaeb-q8Q5W25yhPKtsQaKEYRqgyGgCogrFaQg@mail.gmail.com>
 <CAKmqyKPnk7ZGH_XQvywb1zvC1UqQ8Yab3P37QMwNWtTS-OsD_A@mail.gmail.com>
In-Reply-To: <CAKmqyKPnk7ZGH_XQvywb1zvC1UqQ8Yab3P37QMwNWtTS-OsD_A@mail.gmail.com>
From: Green Wan <green.wan@sifive.com>
Date: Thu, 15 Oct 2020 10:19:48 +0800
Message-ID: <CAJivOr69aQmR+4P831f2RNOeP9AAmR8tvhqjqHcpspVLg3B3pg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] hw/riscv: sifive_u: Add backend drive support
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=green.wan@sifive.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alistair,

That's correct. Once you configure 'CONFIG_SIFIVE_OTP=y', the uboot
driver performs some read/write during booting.

And I'll also include the test steps by using the 'misc' testing patch
shared by Bin.

Regards,
-
Green

On Thu, Oct 15, 2020 at 2:51 AM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Wed, Oct 14, 2020 at 8:02 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Alistair,
> >
> > On Wed, Oct 14, 2020 at 10:46 PM Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 12:10 AM Green Wan <green.wan@sifive.com> wrote:
> > > >
> > > > On Wed, Sep 30, 2020 at 1:08 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > > >
> > > > > On Mon, Sep 28, 2020 at 2:18 AM Green Wan <green.wan@sifive.com> wrote:
> > > > > >
> > > > > > Hi Alistair,
> > > > > >
> > > > > > Thanks for the review. See the reply inline below.
> > > > > >
> > > > > >
> > > > > > On Sat, Sep 26, 2020 at 5:52 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 1, 2020 at 8:49 AM Green Wan <green.wan@sifive.com> wrote:
> > > > > > > >
> > > > > > > > Add '-drive' support to OTP device. Allow users to assign a raw file
> > > > > > > > as OTP image.
> > > > > > >
> > > > > > > Do you mind writing an example command line argument in the commit message?
> > > > > > >
> > > > > > > Also, do you have a test case for this? I would like to add it to my CI.
> > > > > > >
> > > > > >
> > > > > > Do you mean qtest? I run uboot and use uboot driver to test it and
> > > > > > didn't create a qemu test case.
> > > > >
> > > > > No, I just mean how are you running and testing this.
> > > > >
> > > > > So you are booting U-Boot, then how do you test it in U-Boot?
> > >
> > > Hey,
> > >
> > > Sorry, this email didn't send and I only just noticed.
> > >
> > > >
> > > > Correct, I just enabled the configuration for
> > > > ./drivers/misc/sifive-otp.c in uboot for normal booting access to OTP.
> > > > And manually modify some failures write case to test write-once
> > > > feature.
> > >
> > > Can you document this? I would like to include this in my tests.
> > >
> >
> > See `QEMU Specific Instructions` in
> > https://github.com/riscv/opensbi/blob/master/docs/platform/sifive_fu540.md
>
> Hmm... I am missing something. I don't see any details on how you
> access the OTP and verify that reads/writes have occured. That link
> just seems to document how to build OpenSBI with a U-boot payload.
>
> Does U-Boot run the tests automatically after boot?
>
> Alistair
>
> >
> > Regards,
> > Bin

