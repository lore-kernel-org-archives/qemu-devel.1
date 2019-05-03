Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7176EC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 02:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECF8206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 02:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="LicIv+M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECF8206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMNZi-0007Q2-2G
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 22:05:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hMNYo-000758-So
	for qemu-devel@nongnu.org; Thu, 02 May 2019 22:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hMNYn-0002zM-M4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 22:04:26 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:42105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <joel.stan@gmail.com>)
	id 1hMNYm-0002y4-I2; Thu, 02 May 2019 22:04:25 -0400
Received: by mail-qt1-x842.google.com with SMTP id p20so5058108qtc.9;
	Thu, 02 May 2019 19:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=iLCJFceTJq9C8V46rQKva2rGkVweODOBqpcEY5lfNaU=;
	b=LicIv+M/WKUOYy0NB5TKYwFba2rAh9rsR6ops03H18mzjQSoOqyNn4eF3B0SY/KFOK
	fantdGGu62HyLnDk4/Elm2lVb2e1vZ5HzvV5P29TM/s3eOmrfTzSwnViGlV7beHhJMuS
	Aj2WQQw2Q3pEwbrOllwTLeT9gHCV8vefErTWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=iLCJFceTJq9C8V46rQKva2rGkVweODOBqpcEY5lfNaU=;
	b=AnU/e54H7n5iCXYIkv2K1MWxN0oWXuppxDGoEu2ESLiB7v+uIwP6yg4BI1p6sCCCgJ
	wIitRN4BlyPyGEfK3Bkh4QHGzJqbrUlAubFL8VDt/nHzc4PTlncK9fZ6LgWEL9OMgEdW
	xiUMZCrB8Tu+NMpDxzMYrO0RDKH0X9DmQiRr3eHMukvqgKJjn/aF8Msl87WgrpFak9yb
	VTHHyz2h93sBJRklKO+PVdR8Qv2IVH3A03DbrpJwOdZ+ZYO840H/Gl3lty7S74/NYRbQ
	taSm5zG0DNw+20Hv7qhkvo2GqLbQdsrbblUx0AnTkevUzNKm512PRWg+3oMhqIUQdjSi
	2pfQ==
X-Gm-Message-State: APjAAAU8eohuWzz6OCkGplloOGnvUU7QReI9XrnfptOLsrENBwYtetOt
	FfG8GI5XtOEDL+ef7UeXfoaKagHxeMwKpxfY7YE=
X-Google-Smtp-Source: APXvYqyZk/wKiSz8jm8RZKTb5dRyWnqYoFoVNOCaVSrd7cRXh+AVeTf28lijNBAoW2tcl7CSBgMeTXUT1Alc8fyJ+6U=
X-Received: by 2002:ac8:2565:: with SMTP id 34mr6370365qtn.37.1556849062957;
	Thu, 02 May 2019 19:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
	<CACPK8Xc5KgiaYCTs=8ceRu_hV=vC3M6pGV0=7jJNsbuz2a6LDA@mail.gmail.com>
	<20190501162316.GD21155@stefanha-x1.localdomain>
In-Reply-To: <20190501162316.GD21155@stefanha-x1.localdomain>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 3 May 2019 02:04:11 +0000
Message-ID:
 <CACPK8Xc-7MOCMDKi=by0DVZrUW2vPL0QVT_G2NTuhi_fvwU1Aw@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>,
	QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503020411.hb2eR_YjKi9ia1h0vdCrKlLBANsGeVkTri-O6fbgP-s@z>

On Wed, 1 May 2019 at 16:23, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Mon, Apr 29, 2019 at 12:53:48PM +0000, Joel Stanley wrote:
> > On Fri, 26 Apr 2019 at 09:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > A user-friendly error message is needed here.  The check for -kernel was
> > > too specific and is not desirable for microbit where we use -device
> > > loader.
> > >
> > > Old boards probably want to continue using -kernel.  New boards like
> > > microbit may use just -device loader.  Perhaps there is even a group
> > > that wants both options.
> >
> > FWIW, I used -kernel exclusively when working on the microbit model.
> > Other users may chose to use the device loader/hex file.
> >
> > I am all for usability, but getting rid of the ability to use -kernel
> > on some machine types would be a step in the wrong direction.
>
> -kernel doesn't support the .hex file format that is most commonly used
> for micro:bit programs.  Are you loading ELFs?

Yes, I am loading ELFs.

