Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6DEC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 10:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BF120652
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 10:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ay0iR7We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BF120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM8hX-0006Y3-Hs
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 06:12:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM8gb-0006Eb-AY
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:11:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hM8gZ-0004Up-9v
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:11:29 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hM8gY-0004Sg-M8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 06:11:27 -0400
Received: by mail-oi1-x244.google.com with SMTP id k9so1168163oig.9
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=xMYhaYEkdDSRjtWMuaokJ0R48E+isDAM3paGQ7J3Sv0=;
	b=Ay0iR7WesVtRYIOdXlv8ke59LIMTzGWz2agtuwfEoxU5M/pKtvFkcek7A6eELdqN14
	8AyBMzMLgrsXtRF50E+4LPBzhDu+1Bg44Y2dkKB0YgWQJiX2wqB7njDcpRtTNwP1NsXA
	s8aDIivf4nohOsViuk1Z066d1QYsNUpdPrVUHxlXIcFWi1T5b+kApDh2cLhxGm113iYL
	vS1jP2i3wrMH/8I7fxvkODoIhdzLp5ku0YuIKadOMdXaqXgO9BTddGxlDHqApW6klX4l
	QYuHGEJ/W+wqIxJ+lUH1iMDm/H77qO2aABwbwryHx+Em+p5q2D6GLN+j98bKyCntQ7ne
	AMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=xMYhaYEkdDSRjtWMuaokJ0R48E+isDAM3paGQ7J3Sv0=;
	b=jZaptSbAAgOaxQPP9A/fUxME2HiwsqQ8TK3qZEFn/CgCjJtYvqhfzqhbcfaru9raKF
	FkmWMMTxpyURoACmpr00L8UHN3fsyExbFbWuB6uj8OjJRYuRwHvP5Zcv5YOTcHyxHKo1
	XLr6fL2FJ2hMji8+Qk7c4a2dpKH+pxuEovhckW/88MGaDcTMVThesGr7/qSGzy7NmmJJ
	9SO630pNtfUhuK1IS2F28Q/QUTMszRETP6mGMjXpRh4FMTAgWce+TMyRXIZKKtdb1ivS
	i8p9+jqrI1nzcM5xNr387/4PF4GZ5MRwWzkytPMtHHGEkwFR0f1IX8H4LSsXvZME7ok2
	xKIg==
X-Gm-Message-State: APjAAAVZOnfzFfRyUX4k1MaBLFOCulxbf0HePHGIaIKktgGo73GlaaQ2
	S0aEaqNveOVDXYkReg8mH2Th8wjRFW90fHljMEbsZA==
X-Google-Smtp-Source: APXvYqym+BvCN3bHgbuAMGsOa3iQjQIlDXUm/JpaoxrMPeUY/pSTKkhK3t3scKfou21tgyH0ZmqW5TgTWwZNYkTk2gs=
X-Received: by 2002:aca:4b04:: with SMTP id y4mr1874906oia.170.1556791885011; 
	Thu, 02 May 2019 03:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190425145420.8888-1-stefanha@redhat.com>
	<20190501162055.GB21155@stefanha-x1.localdomain>
In-Reply-To: <20190501162055.GB21155@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2019 11:11:14 +0100
Message-ID:
 <CAFEAcA8Go-8Ux9AGzw5CGiU3wDyAQSrV1HOb0gbZP8+b06-EPQ@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v2] gitmodules: use qemu.org git mirrors
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502101114.PVfwSnEW70sW6WeTG5GofA01mzw-wULoX58uai1PcGc@z>

On Wed, 1 May 2019 at 17:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Thu, Apr 25, 2019 at 03:54:20PM +0100, Stefan Hajnoczi wrote:
> > qemu.org hosts git repository mirrors of all submodules.  Update
> > .gitmodules to use the mirrors and not the upstream repositories.
> >
> > Mirroring upstream repositories ensures that QEMU continues to build
> > even when upstream repositories are deleted or temporarily offline.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  .gitmodules | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
>
> Ping?
>
> > diff --git a/.gitmodules b/.gitmodules
> > index aa77ce6f50..2857eec763 100644
> > --- a/.gitmodules
> > +++ b/.gitmodules
> > @@ -39,19 +39,19 @@
> >       url =3D https://git.qemu.org/git/capstone.git
> >  [submodule "roms/seabios-hppa"]
> >       path =3D roms/seabios-hppa
> > -     url =3D https://github.com/hdeller/seabios-hppa.git
> > +     url =3D https://git.qemu.org/git/seabios-hppa.git
> >  [submodule "roms/u-boot-sam460ex"]
> >       path =3D roms/u-boot-sam460ex
> >       url =3D https://git.qemu.org/git/u-boot-sam460ex.git
> >  [submodule "tests/fp/berkeley-testfloat-3"]
> >       path =3D tests/fp/berkeley-testfloat-3
> > -     url =3D https://github.com/cota/berkeley-testfloat-3
> > +     url =3D https://git.qemu.org/git/berkeley-testfloat-3.git
> >  [submodule "tests/fp/berkeley-softfloat-3"]
> >       path =3D tests/fp/berkeley-softfloat-3
> > -     url =3D https://github.com/cota/berkeley-softfloat-3
> > +     url =3D https://git.qemu.org/git/berkeley-softfloat-3.git
> >  [submodule "roms/edk2"]
> >       path =3D roms/edk2
> > -     url =3D https://github.com/tianocore/edk2.git
> > +     url =3D https://git.qemu.org/git/edk2.git
> >  [submodule "slirp"]
> >       path =3D slirp
> > -     url =3D https://gitlab.freedesktop.org/slirp/libslirp.git
> > +     url =3D https://git.qemu.org/git/libslirp.git
> > --

This won't apply because currently master's .gitmodules
has no [submodule "slirp"] entry. I was assuming you'd
ping or repost once the slirp changes went in.

thanks
-- PMM

