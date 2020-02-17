Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA1DC3B1BF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 00:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939AE208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 00:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939AE208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3UMH-000430-QO
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 19:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3ULb-0003VU-Gd
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 19:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3ULa-0007lp-B5
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 19:33:15 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3ULa-0007kx-6P; Sun, 16 Feb 2020 19:33:14 -0500
Received: by mail-yw1-f65.google.com with SMTP id n184so7173721ywc.3;
 Sun, 16 Feb 2020 16:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ntFayrsnLzjGEZwpem/YIw/uLhNdWCxZdWKJQxDYT9w=;
 b=SExkCIxAwAtKHplaPAJE1mMGcgtn4TrCG9xYX3Eg6dLrJwwLUexvVCqWinW7zwcgT9
 n/L3Igl3nh1owplsYFvatMNoZ7zaPBvY/PYqoI6VlNXkA+Sj59AOEEEA09slGKtTAAK7
 fvtTScoUFE58WqHYODI7JYb8HJHvyDsFEyPqDAfxV1g6ICQZq9Aop2+1J3Y9B38Pap70
 o730xqbRMmfABKXMrJO6xRnFLkwJJXyDTZvri/dR2sXAaHUVc8LjOQhiC1UR2IpTMuuQ
 mwQEwhUeiVjr5PqNY88D13SLRCKCxzzde/UwNM1UFsbMk5e/NbF686H6uFEJQakhDkMI
 Uq/g==
X-Gm-Message-State: APjAAAXueaSaVBFAb3Q8Yf7himm0RUhNBKYO43tngkyjl3Wo1mkGiXzk
 YnSnkKKGM/asQqwn4VN86OudJnO0wSmanOv+y/0=
X-Google-Smtp-Source: APXvYqyM6FSvFDm3Ix3lL+Slmi8XTvz9m7dJdpjRviTdDtm8xQ+NL254ZPwdsc+8J59aB6SZpphOQumB0dAR7MxA85g=
X-Received: by 2002:a81:2313:: with SMTP id j19mr11471741ywj.201.1581899593418; 
 Sun, 16 Feb 2020 16:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20200215162337.5809-1-f4bug@amsat.org>
 <CAL1e-=ij-KpK-O2e44C8_No-H7eshV-tz3iJ9cx0Q74xCLtyAQ@mail.gmail.com>
In-Reply-To: <CAL1e-=ij-KpK-O2e44C8_No-H7eshV-tz3iJ9cx0Q74xCLtyAQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Feb 2020 01:33:02 +0100
Message-ID: <CAAdtpL62_kO9PA8fpzdFg7+vRK2ufcYmVOSH6qOFjQrs-cZkBw@mail.gmail.com>
Subject: Re: [PATCH] configure: Avoid compiling system tools on user build by
 default
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.65
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "open list:bochs" <qemu-block@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Feb 16, 2020 at 8:27 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> 5:23 PM Sub, 15.02.2020. Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
=D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > User-mode does not need the sytem tools. Do not build them by
> > default if user specified --disable-system.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  configure | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
>
> It would be nice if somebody comes up with more detailed analysis on what=
 is built for --disable-system, but in fact not needed at all.

This patch disable building the following binary on a user-only build:

- elf2dmp
- qemu-edid
- qemu-ga
- qemu-img
- qemu-io
- qemu-nbd
- ivshmem-client
- ivshmem-server

Maybe Laurent can amend that to the description, else I can respin.

> How does your change affect the size of the executable?

Their size depends of the build option used (i.e. -ggdb vs -Os -s).

The bigger difference is the build runs faster.

> > diff --git a/configure b/configure
> > index 16f94cd96b..557ca4bd04 100755
> > --- a/configure
> > +++ b/configure
> > @@ -455,7 +455,7 @@ guest_agent_ntddscsi=3D"no"
> >  guest_agent_msi=3D""
> >  vss_win32_sdk=3D""
> >  win_sdk=3D"no"
> > -want_tools=3D"yes"
> > +want_tools=3D""
> >  libiscsi=3D""
> >  libnfs=3D""
> >  coroutine=3D""
> > @@ -2199,6 +2199,15 @@ else
> >      echo big/little test failed
> >  fi
> >
> > +##########################################
> > +# system tools
> > +if test "$want_tools" !=3D "yes" && test "$softmmu" =3D "no"; then
> > +    want_tools=3Dno
> > +fi
> > +if test -z "$want_tools"; then
> > +    want_tools=3Dyes
> > +fi
> > +
> >  ##########################################
> >  # cocoa implies not SDL or GTK
> >  # (the cocoa UI code currently assumes it is always the active UI
> > --
> > 2.21.1
> >
> >

