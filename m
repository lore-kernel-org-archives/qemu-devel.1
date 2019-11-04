Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32143CA9EC9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:43:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3292084D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V43asXs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3292084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRl3w-0005KM-7C
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 17:43:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iRl2X-00047Y-2m
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iRl2U-00054V-US
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:41:36 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45799)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iRl2P-0004yO-W8; Mon, 04 Nov 2019 17:41:30 -0500
Received: by mail-lj1-x243.google.com with SMTP id n21so5870116ljg.12;
 Mon, 04 Nov 2019 14:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3MNZTTEaIRJDXi5ywkdU3tKFxrf0TECuTiOQ+AZ7jeE=;
 b=V43asXs138SpXh4EPIcT22ljCBsIMN1aCRNUjw5t9GezQ5i28wohTo2SzNdiV8ejNL
 XtLi8vvCVfOVn3Y7Vgqu4tzwh6y5z6ICs2rsC2ABOx9y6wqhNxKu9+kLiyWyJqJPgnQh
 b6tiyYEybYDOfnVs4Bao9u+M9wR4zQNBDFc5u6eSSBIoudg+cHSr6ReAWPAgxZoSgVCS
 EZ2RgOf95CCtjF/SOQGhzzkyJkVlzGmFuO5iaJ2UMBcURO3UZOJmeqFvtif9oH38m/6t
 cP8/UTj0iAaQK2i6sqsg7a+UpajoxKT5AH5AermCbYbphSLZEfoylXVeGwcyCJxi+0dc
 JYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3MNZTTEaIRJDXi5ywkdU3tKFxrf0TECuTiOQ+AZ7jeE=;
 b=ebfDwXi7NP6fByzr1wW3xxPFNGvVCdWyi+XhCrMgHY8VWgqSmkpiwVFu0QUK+NNZnj
 DFZ5dAsjWTiG7gPVjVb4wUAhhjbGmHQqO7eC8v3fZGOxfBxF9pT4/+TVsXXp3KAxmLmI
 6SjnlIQGb+fRKdqst7foDqyQ8lecO8ihA9YU+4pgsl58u9eQ6E9WAE38BjgPhTShp2Cy
 f0xOf1077wiuPdHGo7pbmX7HiAsziRP1rFh6WgB8r0uNm2PAS1UB7L+Ewqwm4rhcHoRD
 rzp4xKzYZ2iInZj+lXKxSqni1WAcIa0vTsm64Xi1XI2TUf3JQWXIaaMveM+R/R2I/7Sx
 nbww==
X-Gm-Message-State: APjAAAW/BRGQpLpivKYQ0kLYs4Mit+zTpjvGpMXSl7hjr+9pwtIPjvCw
 4luOaiBkXI5TmcjjUcgf5RpMXLrnlEJb0UxgYeQ=
X-Google-Smtp-Source: APXvYqxmOAhkxW0S4goBCmYmmW4PwGBsqWdP+QXj004r4+vNAv7cH2bWUD8znVmHd6X/D5anFaOR9IBm3mBcQ6MLZhc=
X-Received: by 2002:a2e:82cd:: with SMTP id n13mr20425472ljh.156.1572907288687; 
 Mon, 04 Nov 2019 14:41:28 -0800 (PST)
MIME-Version: 1.0
References: <CAAhSdy3sUb_r77NBvEQEAQ0EQB99=4jgAbH3ADOqvJ_iX+o8pg@mail.gmail.com>
 <mhng-111ec6b3-0e63-4f94-a1ed-8ddcd354b943@palmer-si-x1c4>
 <CAAhSdy1MZPaNhHxR345bu4HOtDndd5eZWJp2eTwJSym+9NjD+w@mail.gmail.com>
In-Reply-To: <CAAhSdy1MZPaNhHxR345bu4HOtDndd5eZWJp2eTwJSym+9NjD+w@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 Nov 2019 14:35:50 -0800
Message-ID: <CAKmqyKNE3oPQgkh1mu=WbDOsxSq=fmXgCu9rx_PdOcbAEZeuYA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] RTC support for QEMU RISC-V virt machine
To: Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <Anup.Patel@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 3, 2019 at 12:12 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Sat, Nov 2, 2019 at 4:44 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Fri, 01 Nov 2019 08:40:24 PDT (-0700), anup@brainfault.org wrote:
> > > On Tue, Oct 29, 2019 at 6:55 PM Alistair Francis <alistair23@gmail.com> wrote:
> > >>
> > >> On Fri, Oct 25, 2019 at 6:28 AM Anup Patel <Anup.Patel@wdc.com> wrote:
> > >> >
> > >> > This series adds RTC device to QEMU RISC-V virt machine. We have
> > >> > selected Goldfish RTC device model for this. It's a pretty simple
> > >> > synthetic device with few MMIO registers and no dependency external
> > >> > clock. The driver for Goldfish RTC is already available in Linux so
> > >> > we just need to enable it in Kconfig for RISCV and also update Linux
> > >> > defconfigs.
> > >> >
> > >> > We have tested this series with Linux-5.4-rc4 plus defconfig changes
> > >> > available in 'goldfish_rtc_v2' branch of:
> > >> > https://github.com/avpatel/linux.git
> > >>
> > >> @Peter Maydell this has been reviewed, do you mind taking this in you
> > >> next PR? I don't see a maintainer for hw/rtc.
> > >
> > > It would be great if this series can be taken for QEMU-4.2
> >
> > It doesn't look like there's anyone who maintains hw/rtc, so maybe that's why
> > this has been going slowly?  I'd happy to PR it, but I don't really have the
> > bandwidth to sign up to maintain more stuff right now.

The PR is reviewed so it should be ok to merge now (and it made it
into soft freeze).

>
> No problem, I will maintain Goldfish RTC emulation until someone else
> is willing to maintain it.

You can add me as a maintainer as well if you want.

Alistair

>
> Regards,
> Anup
>
> >
> > >
> > > Regards,
> > > Anup
> > >
> > >>
> > >> Alistair
> > >>
> > >> >
> > >> > Changes since v4:
> > >> >  - Fixed typo in trace event usage
> > >> >  - Moved goldfish_rtc.h to correct location
> > >> >
> > >> > Changes since v3:
> > >> >  - Address all nit comments from Alistair
> > >> >
> > >> > Changes since v2:
> > >> >  - Rebased on RTC code refactoring
> > >> >
> > >> > Changes since v1:
> > >> >  - Implemented VMState save/restore callbacks
> > >> >
> > >> > Anup Patel (2):
> > >> >   hw: rtc: Add Goldfish RTC device
> > >> >   riscv: virt: Use Goldfish RTC device
> > >> >
> > >> >  hw/riscv/Kconfig              |   1 +
> > >> >  hw/riscv/virt.c               |  15 ++
> > >> >  hw/rtc/Kconfig                |   3 +
> > >> >  hw/rtc/Makefile.objs          |   1 +
> > >> >  hw/rtc/goldfish_rtc.c         | 288 ++++++++++++++++++++++++++++++++++
> > >> >  hw/rtc/trace-events           |   4 +
> > >> >  include/hw/riscv/virt.h       |   2 +
> > >> >  include/hw/rtc/goldfish_rtc.h |  46 ++++++
> > >> >  8 files changed, 360 insertions(+)
> > >> >  create mode 100644 hw/rtc/goldfish_rtc.c
> > >> >  create mode 100644 include/hw/rtc/goldfish_rtc.h
> > >> >
> > >> > --
> > >> > 2.17.1
> > >> >

