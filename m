Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7985C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922C820665
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Y+F2BRM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922C820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwIT-00083c-Tp
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40146)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <anup@brainfault.org>) id 1hhwH6-0006db-KK
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1hhwH5-0007h0-CP
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:23:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33149)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1hhwH4-0007fP-V2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:23:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so13896729wru.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ziosd74qZsVijVIqdc9xtnOkOcze7h+1KOaH7g6GIG0=;
 b=Y+F2BRM4kBpCaIFGW4xLqlUm4jFNbaI4J6L5cR15HB4k11/SuUSyTNaEa5Im7x4P5K
 8MA+Sg1Z12758vCCasdeHMnXnkpp1qzbQOakWuGWcvCQfMo47ZQvsTGyTK59rN0X1SLb
 sTDdgLergbCRsKS0VQNoXiIRaUqd3lxRkuJRq01nrXd5b9itsoEfIzsDUw1MQ8m4Nky1
 QqkMKvfk1HCWnbSKk+8fdtR0Uw5D3zds3pZVumJrZu1Wh1p/Nz9z+ISn9szaHGbN332R
 j55fKCc5rm4wAfPC42x8mp0tE0jVB5oDejqGCjHIWb1TXzNGoBQAzJEMzkMiRtvO8Rto
 KXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ziosd74qZsVijVIqdc9xtnOkOcze7h+1KOaH7g6GIG0=;
 b=B5Bc1FeR0/VfkLWDn/dgLbOEag3OBj0q4BySRr3tsDDZ+yzvErTSuFrwA6jCiCOAGS
 f/zsYMrhhxZSB6p13Jt/0Evg536W9qzyvUif57eM5SJYaQyoikEQLp3mCWUHQur8OA3E
 9RMFrgnCliSOynRX1QDWkKJA5cJg7HZ8pdkwcFWEn8JT9ptwLb7JPwTZgZSFwjKGVkOE
 bda0fAvtFEQtL6EpTKzLmvE3dEzOwAPBBVULeLbPHWBdI1xzlcO5p6SjTbfZ3pAuzhWz
 A2WxiY6HAAo0Roep/Zjjs3sNpLaAaYwm4SRqyIErlqFTBmW+oXie19KI8ra8VV/FSmKM
 D5sA==
X-Gm-Message-State: APjAAAXKqSKT0CgBEdc6LzhMw/ZalUNHbYliFuGGxrRAbss7RpEFJXLn
 mhY8DQekDU7lFYDbdBrLif5pFdYSfeO/DWzCjeramA==
X-Google-Smtp-Source: APXvYqwmY9ADqvCBaSD7YNoyOl5M0zME1fQpbWFLmUA1ZfRLr0fBpjDi1FmpRxRSXoUwbAXopgfYcArCnJS3dVJhK2I=
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr19580039wrt.227.1561987392759; 
 Mon, 01 Jul 2019 06:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <20190628104605.000062c4@huawei.com>
 <CAKmqyKP1c5GHKaDuOvu11UtCwnrUosxTtoDAeW7GOS=s+h27aw@mail.gmail.com>
 <20190701134029.00004b97@huawei.com>
In-Reply-To: <20190701134029.00004b97@huawei.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 1 Jul 2019 18:53:02 +0530
Message-ID: <CAAhSdy1c47+MaD4GixWB+u-+1Rb9ULAj0NweSzyzy+VdCXns0Q@mail.gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [Qemu-riscv] [PULL 33/34] roms: Add OpenSBI
 version 0.3
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair23@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 1, 2019 at 6:12 PM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Fri, 28 Jun 2019 09:12:45 -0700
> Alistair Francis <alistair23@gmail.com> wrote:
>
> > On Fri, Jun 28, 2019 at 2:47 AM Jonathan Cameron
> > <jonathan.cameron@huawei.com> wrote:
> > >
> > > On Thu, 27 Jun 2019 08:20:10 -0700
> > > Palmer Dabbelt <palmer@sifive.com> wrote:
> > >
> > > > From: Alistair Francis <alistair.francis@wdc.com>
> > > >
> > > > Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
> > > >
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > > Tested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > >
> > > I sent a late bug report on this one.. Hence posting here as well
> > > to make sure it doesn't fall through the cracks!
> > >
> > > Right now you can't actually build the opensbi64-virt firmware
> > > due to cut and paste error in the Makefile.
> >
> > Ah, thanks for the bug report.
> >
> > @Palmer Dabbelt I'm just going to send you a fixup commit. Can you
> > apply it to your tree and send a PRv2?
> >
> > >
> > > As a side note, I hit this because OpenSBI 0.3 is resulting in a login
> > > loop on a debian test image and the current upstream isn't.  I haven't
> > > debugged yet, but someone else may hit that problem.
> >
> > Unfortunately OpenSBI 0.3 is a little old now, in saying that I didn't
> > know there are bugs in it? Which kernel are you using?
>
> Mainline 5.2.0-rc5.
>
> Just in case I also checked 5.2.0-rc7
>
> I tried doing an odd git bisect with good and bad reversed to figure out
> what fixed the problem, but boot wedged at "Run /sbin/init as init process."
>
> The wedge was bisected to:
>
> 4e2cd47820 ("lib: Flush everything when remote TLB flush range is too large")
>
> Which the patch correctly identifies as a problem introduced this kernel cycle.
> 5.2-rc1.
>
> So on that basis alone I'd suggest we want to move to a more recent openSBI
> asap, after all the 5.2 kernel will be out in a week or so.
>
> I'm a bit short on time (flight to catch), so haven't pushed that fix that
> far back in the tree yet in order to figure what is causing the login loop.
> Won't have access to relevant build machines until Wednesday.
>
> That patch cherry-picked on lib: Optimize TLB flush IPIs
> seems fine, so it is before that point...
>
> Passing that point would require real effort though as the two patches
> are changing the same code.
>
> So I had a go from the other end (0.3) to see if it was fixed quickly.
> Ran out of time, but at
> "firmware: Reset all registers and flush the icache" it superficially all
> seems to be working with no TLB related hang, or login loop.

We plan to release OpenSBI 0.4 in couple of days. It would be best
to pick-up OpenSBI 0.4 FW_JUMP binaries.

Regards,
Anup

