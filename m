Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3631C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10082192B
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9KQjsuh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10082192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWkmn-0004Xd-Np
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWklr-0003rc-1z
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWklp-0005HX-15
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:25:02 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWklo-0005Fg-QW
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:25:00 -0500
Received: by mail-oi1-x243.google.com with SMTP id l20so16012173oie.10
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1vCWTm2yapJPkNp3Lj3hkHA50EH1mQuwW9MQi0cUu1g=;
 b=S9KQjsuhAaQd4KLmz3NEytTsx8ibMj2MO/0k1tRLjDPRt58elrsUAVvQFWvtWSGD9C
 jEN6A8EyS/lBhAR887fU06botpPAwqhg09QXBsdHlXVpiLhlPMiKlYITRTYiVgn+F9c8
 BfSB7Pl2qOd+46c74AP/ry6jwmmgH9lskbNRFewa2daXHU9hdpfHJT1X6SbmoPxFne+x
 QckO3+SarO6Ehew6J7W/UmLIh1b4ZEaPEgNftHuKBnLFgiDhLb9LT9rxFFSmzDNE6hKK
 HX/9obiA8092J9X8D6Jzunhw1ALWtg4MuK7JOTKcFD+4IW13vL8Xr3RoUfo4qkpzPUYl
 ev6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1vCWTm2yapJPkNp3Lj3hkHA50EH1mQuwW9MQi0cUu1g=;
 b=FZzergyY5zNCor2gUvaBU+SjD0jRRiExGzMebmOfMGpIkR41Qxdg+dZYUoQHoCf7iW
 W9pFuHOUvawmZcR4rzyQxeO+DChTNEJ8mtxgsviy/liWcGUQGz7b3tRHaQZEABYeRaQL
 lEBNnpz6KLiZouFdtIwyL4UiLAHDyDUs6I7FpcXC15gdEST7AccP3u1cB4Wg/qU2BMMi
 +o2OSVQrBEGJkeUx9qgPzYrPM4gIgBBHcD49sg+Q8+6HPaPTviUOf5PVAUkkNdwF1qB2
 WWpNO5Jp86t7QyO2xO1j8pe6TQiNH8aVp/t2yPRxndI9ARJuY/Skg63RDz3LIc5FyAYu
 Fa8Q==
X-Gm-Message-State: APjAAAVMeKP1vcNxdcUkoX6JB5ojLBWq/DmNaIAQxnOWn/B/Mv0IRGcs
 H+r1+N0xzxJ0yIxDregt5CYwIWOZAAp9yxY32Q/3tw==
X-Google-Smtp-Source: APXvYqxuGJ8cMPtfFwDfP4W+bnceC0MNsudtFShlMcHE6L91O91D4pQs0A1Vr88g6J6cc8BfsT3TIXfdB2Aazocx31k=
X-Received: by 2002:aca:a9d4:: with SMTP id s203mr52865oie.146.1574097899013; 
 Mon, 18 Nov 2019 09:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20191104181604.21943-1-linus.ziegert+qemu@holoplot.com>
 <CAKmqyKMWS18ssBUhDgYSnGiFRwCkSJPBRui4Op50Tq_Z-OUakA@mail.gmail.com>
 <CAPm2bJ_mfVepKP9hj-PQBnESsCi6t+9zj-m_KWQYx6m-S5ddAg@mail.gmail.com>
 <3c063300-b107-b17b-3647-8489b856a038@redhat.com>
In-Reply-To: <3c063300-b107-b17b-3647-8489b856a038@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 17:24:47 +0000
Message-ID: <CAFEAcA82V++Xd6SGbKqeinRXe=MxjFKbcx92Ux9umoG-QvOSjg@mail.gmail.com>
Subject: Re: [PATCH] net/cadence_gem: Set PHY autonegotiation restart status
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 Linus Ziegert <linus.ziegert+qemu@holoplot.com>,
 Alistair Francis <alistair23@gmail.com>,
 Linus Ziegert <linus.ziegert@holoplot.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 17:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 11/5/19 12:31 PM, Linus Ziegert wrote:
> > Am Mo., 4. Nov. 2019 um 23:50 Uhr schrieb Alistair Francis
> > <alistair23@gmail.com <mailto:alistair23@gmail.com>>:
> >  >
> >  > On Mon, Nov 4, 2019 at 2:02 PM <linus.ziegert@holoplot.com
> > <mailto:linus.ziegert@holoplot.com>> wrote:
> >  > >
> >  > > From: Linus Ziegert <linus.ziegert+qemu@holoplot.com
> > <mailto:linus.ziegert%2Bqemu@holoplot.com>>
> >  > >
> >  > > The Linux kernel PHY driver sets AN_RESTART in the BMCR of the
> >  > > PHY when autonegotiation is started.
> >  > > Recently the kernel started to read back the PHY's AN_RESTART
> >  > > bit and now checks whether the autonegotiation is complete and
> >  > > the bit was cleared [1]. Otherwise the link status is down.
> >  > >
> >  > > The emulated PHY needs to clear AN_RESTART immediately to inform
> >  > > the kernel driver about the completion of autonegotiation phase.
> >  > >
> >  > > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dc36757eb9dee
> >  > >
> >  > > Signed-off-by: Linus Ziegert <linus.ziegert+qemu@holoplot.com
> > <mailto:linus.ziegert%2Bqemu@holoplot.com>>
> >  >
> >  > Reviewed-by: Alistair Francis <alistair.francis@wdc.com
> > <mailto:alistair.francis@wdc.com>>
> >
> > I consider this stable material. Applies cleanly to all versions
> > starting from v1.5.0.
>
> Too bad this wasn't Cc'ed to qemu-stable@nongnu.org and missed 4.1.1
> stable release.

I can take it via target-arm since it only affects an arm board.

thanks
-- PMM

