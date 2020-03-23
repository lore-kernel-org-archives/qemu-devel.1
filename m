Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2764AC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C1A20753
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQ4qsQp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C1A20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGONX-00012q-3M
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 10:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGOM1-0007Q4-NV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGOM0-0001X8-9F
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:47:01 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGOM0-0001WX-0r
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:47:00 -0400
Received: by mail-ot1-x342.google.com with SMTP id x11so1513634otp.6
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9TUmqbKbO+Z1p85wdE0U6ljkhM1Fpg3g46pjbcSnIZI=;
 b=BQ4qsQp+BHO2wUjdlXo7pyBB0J2bMOg9d+9bjCu3hZmHob4hl/eTv5tLEAXOrdrWHS
 9KD/2/k6TJEIUBCrOxzsTrw5oOf3aMU2pN0JmFUSgYw2sunnoW5R5TPH7WvNVL85WicZ
 MiwMjDBKgmHAgWKFnzE/F+P6UTBk6GjxdYJTgBHBAIIc58pjLEvPQ1ZiM9iAsyiktyrU
 cRgz20UY5guaHqxhBaPPJP+l1yrpGoRGAfmA9hyQz8/VCul2YemIs9bqsfvvINtHP1Cd
 /XtZ4nTTgFywBE3x7RUsI8Rlf4eWzZrHiQyxJ8ERaUoUzYsx2xYb4vhRqAi7HPxW1D3l
 f/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9TUmqbKbO+Z1p85wdE0U6ljkhM1Fpg3g46pjbcSnIZI=;
 b=nZGCgBtKtNA9WxyVUoXbYEHh9jy2mxoeGoGAe49Xy9e7DbaqQEpiQcfCFm7dxN4dRF
 d72q07Qo8ZyOwuBy7BRCsb5Bu+P/vEvtRyxEBC3rRXNLeOCQKtSa/yRBQhPgWz8Yg/RK
 1XtSXfSSGynt0MVprDVMLziy27rEfzpNrslIAu9ZZsKVC736Bj/xaS3iroGnHALVmOLL
 pv+SuhTbOusQuhl3OB0I6c3XQg6QNgRt4CuXefHaG1+y/f6cV5JE7xOMfxsVriilbJuS
 VW4OU7D5xEezAVj296QdFewdI/rkI7Q+mhDqxn3Gb9z2tr3FrReJbl284U5xGYFiZFWY
 bDGg==
X-Gm-Message-State: ANhLgQ2XBvlnUmLnavUBQmX0ANdlwh5+BCSGNR2e4JGXPVBO39dqGK68
 p7I1XbKYvTdUghc2pr7Plep9p894MutlgkKp51KIKA==
X-Google-Smtp-Source: ADFU+vuCQxnu7j4My8UTFsG2gEr5wVMoV0l8rvGovMzTQmLofqYmaNDfARYhIHogaUUR54KMWveut4CFWnZwthkKTyo=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr18313168otm.91.1584974819174; 
 Mon, 23 Mar 2020 07:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
 <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
 <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
 <CAFEAcA9+WPxGYqk5_-v=oXPK=UcvngXGaOLY3njM5iNN2CFh2g@mail.gmail.com>
 <alpine.BSF.2.22.395.2003231459410.34482@zero.eik.bme.hu>
 <CAFEAcA9Ubue9Lk2jXJyZ+OUmk0j58ZKKnER1RxMi0b05FaN4QQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2003231539160.47226@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2003231539160.47226@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 14:46:47 +0000
Message-ID: <CAFEAcA_R1i2L5Vgmq1frGbQQxggLtEfMwHa8V=+K2Wje2mkVVA@mail.gmail.com>
Subject: Re: Coverity CID 1421984
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 14:43, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Mon, 23 Mar 2020, Peter Maydell wrote:
> > On Mon, 23 Mar 2020 at 14:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >> On Mon, 23 Mar 2020, Peter Maydell wrote:
> >>> Coverity has flagged up a lot of leaks involving qemu_allocate_irqs();
> >>> most of them I've for the moment just set as "insignificant, fix
> >>> required" because they're in called-once functions like board init.
> >>> If this device can't be hot-unplugged and so we will only ever call
> >>> realize once, it would fall in that category too. Otherwise I'd
> >>> suggest conversion to qdev_init_gpio_in(). (This allocates arrays
> >>> of IRQs under the hood too, but the device_finalize() function will
> >>> automatically free them for you, so it's easier to use non-leakily.)
> >>
> >> I think I can't do that in sii3112 becuase I need to pass irq to this func:
> >>
> >> void ide_init2(IDEBus *bus, qemu_irq irq);
> >
> > ide_init2(bus, qdev_get_gpio_in(DEVICE(dev), i);
> >
> > should do what you want, I think.
>
> I don't understand what you mean.

I mean that if you allocate the IRQs with qdev_init_gpio_in()
then the way to get a qemu_irq from within them to pass
to another function is to call qdev_get_gpio_in(). So you
just want to make your call to ide_init2() be the line I
suggest above.

> Sent a patch that I think might fix this
> warning for now. I'd leave qdevifying ide code to someone else.

There's no need to qdevify IDE for this.

thanks
-- PMM

