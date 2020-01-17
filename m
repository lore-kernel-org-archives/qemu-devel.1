Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B16C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DE52072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cs3PsVox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DE52072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWi4-0008L2-7j
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isWc4-00067D-Ce
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isWc3-0005GG-28
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:44:56 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isWc2-0005FQ-Qo
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:44:55 -0500
Received: by mail-oi1-x243.google.com with SMTP id c16so23089558oic.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 10:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/FVu51Op0a4Se1tMHsJ70/J8wXfsAdBp/IiqnssJyqc=;
 b=Cs3PsVoxYYQsENmDo9UOkMI/ZNgz6f5OcB9nmuXffFthNeaChMEd5Ek6ToISEtFav1
 Ynzet14+BMSjY+7t7z/mN//N09+TLFF6Wef+An5hP6JZBFvdGFxn5Yp+c6p2YkXhWf4f
 vqpZ68DVrmnYkczBs9j3Z7CY/DWUVYMkdwX6iAVG2/cxa/dXZrhQQ3pp6aD8Jk1ungW7
 BB5BL9Pk98umL7n3u1uAtXV/DDWAN54C811+nOVKvro9m6gf0h+gEG4hI6IIGMR6EL8G
 wwQG5sdq/3de0LrZkX6ebgkWohhKpBHOk4gvPwuEjhlxddI2/HVTVA4EBOeuTfwjoaAf
 D9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/FVu51Op0a4Se1tMHsJ70/J8wXfsAdBp/IiqnssJyqc=;
 b=R3r1NnX64guAjwGQCUHV0BKtt+fjnDY+GNbXlIwdOFQTN7gNbIdqdZ4l4pq8RxBki7
 ODv3QO/0vSA4qPb6bu7X0plEQ1EJWzLk3ZGkAZ/Re/L5a2p7ejR9YJegV+ig/K2C9/67
 ZnN4uSzE0Gyefpvxuu/M30eCB69N982wM16u0IDfHbk2ix2zwJMcrOj4JD9eQ0JlvMlN
 CtleAtCfo0Z2ZZDVUmf42EDShJlb3THJnVdAGthTUAso09HdS8k6XyaeDSFMLgtNIqT/
 9cthh/znlh2O8IzgejUg72dbb7UeOujYyVOeZAriVJIfBRf5+JlnOd9EsHywWMjhUiSI
 s9Mw==
X-Gm-Message-State: APjAAAWow3r8fh0SVZosgn51BOw8QUvgrGGxZBQX4m8rksKlUlIkQxcc
 V+qb23z2AGlw+FY+IQzevpBYwMtakGYHcklBewpamA==
X-Google-Smtp-Source: APXvYqzt0Ju/GTnZKkQZMVUoNyd3EFtHkaXMnL2DDev7+Lg33Mx+18lxx3cbqfn9qExzUTc9mt/fUukyxlBddqBTXKw=
X-Received: by 2002:aca:f484:: with SMTP id s126mr4301199oih.48.1579286693769; 
 Fri, 17 Jan 2020 10:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-7-linux@roeck-us.net>
 <CAFEAcA_v98GcR06PWfm+=VnteQN_Q7iKK4wobAg6NrVSP1AyDg@mail.gmail.com>
 <20200117182939.GC13396@roeck-us.net>
In-Reply-To: <20200117182939.GC13396@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 18:44:42 +0000
Message-ID: <CAFEAcA9zWeW1k-K7qVzCSOA70BmOCa9onT2z_QUQK-=0AJ+NjQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] hw/arm/exynos4210: Connect serial port DMA busy
 signals with pl330
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 at 18:29, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Jan 17, 2020 at 01:48:06PM +0000, Peter Maydell wrote:
> > On Fri, 10 Jan 2020 at 20:39, Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > The Exynos4210 serial driver uses an interrupt line to signal if receive
> > > data is available. Connect that interrupt with the DMA controller's
> > > 'peripheral busy' gpio pin.

> > Rather than having the uart and pl330 pointers be locals,
> > they should be fields in Exynos4210State. (Otherwise technically
> > we leak them, though this is unnoticeable in practice because there's
> > no way to destroy an Exynos4210State.)
> >
> Out of curiosity: Is that a new leak because they are now tied together,
> or is it an existing leak ? I don't find many DeviceState entries
> in xxxState structures, so find it difficult to determine if/when/why
> there is such a leak.

Yes, it's an existing leak, though it's more of a conceptual leak
than one that valgrind would actually complain about. (The object
isn't totally unreachable because there will be references to it
in the QOM tree. Keeping track of your child objects only becomes
really important if the device is hot-pluggable, because if you
can hot-unplug the device you get a real leak if it hasn't cleaned
up its child objects.)

Aside: I think this code is written this way because although it's
a container device it has been incorrectly written against
the pattern of a board model. Originally board models did not
have any "this is the board" struct that they could keep things
in, so the only way to write board model code that created,
configured and wired up devices was to have it do it in a
way that didn't keep track of the things it created once the
board init function returned. This code is part of an SoC
"container" device, so it does have a state struct that it
could use to hold either embedded device structs or simply
pointers to device objects, but the code is written like the old
board-model code. (These days even board models have a suitable
state struct they can use.)

include/hw/arm/armsse.h is an example of a device state struct
with a lot of embedded device state structs in it. (Not all device
state structs have names ending "State".)

thanks
-- PMM

