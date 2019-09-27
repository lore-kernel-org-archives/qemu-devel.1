Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC25C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:39:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB02217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 14:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbeMf565"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB02217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDrP8-0006vd-UR
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 10:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqQ5-0000DA-Sd
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:36:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iDqQ4-0002WJ-Ma
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:36:25 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:32770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iDqQ4-0002Vl-HE
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:36:24 -0400
Received: by mail-oi1-x241.google.com with SMTP id e18so5231506oii.0
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=de4z7S5G5ywrflGEuHK1OtY+IITfylTTQb5PJNGEdBU=;
 b=lbeMf565pLoufeNuekBKI9IMx2xyAR/3x6uARDrd7eVvc1NwmOsWqWHZorEpGiVwe5
 AcJXpmvG4ZjaDOEYfqAOE7oq2eWnJrfKnwjQ9xI7k+3mqJA+9aoWDvrriwcCgUlTw/XK
 Lpzz2mttxF9RtdeDgpKIBqeLknSoy85uzuD+R2y5Hg513AKnNPoHPFP43aKSnYIPm1mB
 hOVV+Fo3vPA5seKsJ3yXFmxKIItwZygumQqTY2MlhvIodTdJxpjJrZasNNeobAQ/X3B3
 J3Hd6RqzFT2UceRnYCFQvfgNt//8hrRkT6/yd4+htc4u5cNPQsGZvF9C4UQQc+C8NH+k
 vbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=de4z7S5G5ywrflGEuHK1OtY+IITfylTTQb5PJNGEdBU=;
 b=R1X121jZDb8c5AVCIZEmgAJL36+bc2mdIbBrqjVJWxXIjzrt6sttWWYtdhy6mhW4Ee
 +F/s9gInAUxC8IpP1Sy5+Q7Xr8oVOfMkf/EEqNPQmu1e37Z/DtW/m3UpM0LL6pE3+g2O
 XK/q4VkSpeAlpE4etCRvSIxqbVsQaHJ8M1XdNBVW6ygpmI1ZQ7ilGGujCwho5X+39dtm
 4Vi9goPvP9RoLh8cktzahO+yrJXv76jGhGfLpBddkGIah35jiDs4pH7Q3b39Cx4TQFVs
 zfDliH4C8Dfwz3jTc6jFPiroZOXY7yttWUgpuBlND9Q+oWnMid0PC65XCu6wfvTLqBfA
 UW7A==
X-Gm-Message-State: APjAAAWZIMiAW4RBes4NKGPwNkus0EBUZKF1xNGQUO5Wqrl+fVXrxqKS
 9ZNfBI6FRByOPckGyGexuwE2pdVkwX64/O39tY7kIw==
X-Google-Smtp-Source: APXvYqy4ky17opgRO5mHCiPr8wMqlG0dt2fv++y6B2toW7+Cw9tsh8crJSKsa55GPm1AGRvMB8MArrxafY/EeiUoTWU=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr6686737oib.48.1569591383575; 
 Fri, 27 Sep 2019 06:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-15-f4bug@amsat.org>
 <CADYoBw11iiK=+O-mGYS5Xp85zVhezOXXXr-wKV_xCg07ZYuzVw@mail.gmail.com>
 <20190927132602.GA19931@roeck-us.net>
In-Reply-To: <20190927132602.GA19931@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2019 14:36:12 +0100
Message-ID: <CAFEAcA8KcJzCNU1iLjiteEKhLsw9jeDyyqXurv0fuvSmLAEF0A@mail.gmail.com>
Subject: Re: [PATCH 14/19] python/qemu/machine: Allow to use other serial
 consoles than default
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Cheng Xiang <ext-cheng.xiang@here.com>, bzt <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Sep 2019 at 14:26, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Sep 27, 2019 at 02:54:10PM +0200, bzt wrote:
> > Hi,
> >
> > On 9/26/19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> > > Currently we are limited to use the first serial console available.
> >
> > I'm not so sure. Right now it works like this:
> >
> > qemu -serial stdio
> > Connects the VM's UART0 (PL011) serial console to the host terminal
> >
> > qemu -serial null -serial stdio
> > Connects the VM's UART1 (AUX) serial console to the host terminal
> >
> > I think this is simple and good, please don't remove this option. If
> > your commit does not influence these cli args, I'm not against it.
> >
> Agreed. I am using that mechanism (raspi3 uses the second console,
> not pl011) in my scripts. Please don't take it away.

This patch is changing our python infrastructure that invokes
QEMU, not QEMU itself. What Philippe's message means is
"currently our code for running QEMU as part of tests like
this is limited to using the first serial console; this doesn't
work for raspi because we want to use the second (aux) console;
so make the test infrastructure able to handle machines like this."

thanks
-- PMM

