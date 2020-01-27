Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B67C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1210214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YeSYrhI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1210214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw40w-0004AQ-5Y
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iw3zg-00038m-Kz
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iw3zf-0004kk-Bo
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:59:56 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iw3zf-0004hm-2r
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 07:59:55 -0500
Received: by mail-lj1-x244.google.com with SMTP id r19so10574508ljg.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 04:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wVBAbf00d2tPuEnDfJH33UTFD9tw3xYmPmOvJjAUbUI=;
 b=YeSYrhI5y9uCZgQbKsndnmvXd2CkB/zvAcZ9s6CjU7Ly5c4VGgIaQbQj170QTdiMVo
 Us7mmgAAZvd5V8CSiVX4B6/zHQtMQkI9kg864pCmvLqdXyRbV9dhP8+W8HEsAFUWPj+s
 8IhDqN2wTZoQRNgWHLjWubmQ8RZGXHtHwuNloaJTlj7rWXTLry7Z89P3/m6Zg93Mvw1D
 bapWex7V+JtD+ZeOEiVFzGDRpHX3Wvd75w4tiLIqHXAuow8TfXCpuDyGtMNYGTFOaWah
 gvu4VXS3HpHHgfcw89S23xmCSy3P/m9z7s14AHp86Tx+bgzOBBLmESL2XRJoFdpNrRbU
 0qrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wVBAbf00d2tPuEnDfJH33UTFD9tw3xYmPmOvJjAUbUI=;
 b=JdseY4cCHZ2kkcTbBUd/xSZ/bgs91XRDwGAE8RdQC9SsWO27/aoWyaLR8BmdvXndHo
 PtTXZ3hLnazZVjO59nQdIOvs7Ml7E5XbG8lERR/+7QzxtS0qnpBdD7JqOZACdR5bWu2r
 M+e2Z308eD2z6JsVhrqH+0MSgGmNpZ84nWltS3AN1AsFLo0T//KVzA/0TcDM9/kOWDXx
 C2xijq76Lu3dZPVGInt7Hx+FX62k+k51nQiNsobmoE5UEI/688U1fKrG0XOu41k/1B3/
 NFLtUEs5YBQgtdst72MKdz3wfcYo+Ppe2mlfHEnFAMV9rbVmsn6uHoQETmTJI5H5L5be
 WG6w==
X-Gm-Message-State: APjAAAVBtqi62tFnLT9tgO/mu6FABnZulLKB0Ts6HCJfjCGePb1tEmWB
 XEG/AUcY2PE8kcFcBlJRipJgn7/RKdDz8cG1Z4jK1A==
X-Google-Smtp-Source: APXvYqyukMYgbhx5e10DN8rcAK3lFEiGOD52RmSIyVAPZapxi5OLs1K5m8IScyAk4ds6Ddiyq4DTAExZVJAlwJx1l68=
X-Received: by 2002:a2e:924d:: with SMTP id v13mr10446125ljg.267.1580129993318; 
 Mon, 27 Jan 2020 04:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20200124165335.422-1-robert.foley@linaro.org>
 <20200124165335.422-4-robert.foley@linaro.org>
 <87v9oxf9b7.fsf@linaro.org>
In-Reply-To: <87v9oxf9b7.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 27 Jan 2020 07:59:42 -0500
Message-ID: <CAEyhzFsnC8Tdns6MchMqSsZk1gwBbQupF3BmaDqmVKahgCxCqA@mail.gmail.com>
Subject: Re: [PATCH 3/8] tests/vm: change wait_ssh to optionally wait for root.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: fam@euphon.net, Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jan 2020 at 06:06, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> > Allow wait_ssh to wait for root user to be ready.
> > This solves the issue where we perform a wait_ssh()
> > successfully, but the root user is not yet ready
> > to be logged in.
>
> So in the case it's the root user we care about...
We care about both the root and guest users.  See below.
> >  tests/vm/basevm.py | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> > index 86908f58ec..3b4403ddcb 100755
> > --- a/tests/vm/basevm.py
> > +++ b/tests/vm/basevm.py
> > @@ -310,12 +310,17 @@ class BaseVM(object):
> >      def print_step(self, text):
> >          sys.stderr.write("### %s ...\n" % text)
> >
> > -    def wait_ssh(self, seconds=3D600):
> > +    def wait_ssh(self, wait_root=3DFalse, seconds=3D600):
> >          starttime =3D datetime.datetime.now()
> >          endtime =3D starttime + datetime.timedelta(seconds=3Dseconds)
> >          guest_up =3D False
> >          while datetime.datetime.now() < endtime:
> > -            if self.ssh("exit 0") =3D=3D 0:
> > +            if wait_root:
> > +                if self.ssh("exit 0") =3D=3D 0 and\
> > +                   self.ssh_root("exit 0") =3D=3D 0:
>
> ...why do we need to test both here?
We want to make sure the root user is up in
addition to the normal/guest user.  We're trying to add on the root user
since the issue we saw is that the guest user was up, (wait_ssh() completed=
),
but then when the root user tries to do something we get an error,
since root is not ready yet.

> > +                    guest_up =3D True
> > +                    break
> > +            elif self.ssh("exit 0") =3D=3D 0:
>
> Is this simpler?
Certainly simpler.  :)
And simpler seems like the right call here.  But we'll need to call
into wait_ssh() twice,
once with the wait_root option and once without.  But I think this is bette=
r
since it makes the code on the caller side more explicit and clear in
that we will
explicitly wait for the guest user and then wait for the root user.

Thanks,
-Rob Foley
>     def wait_ssh(self, wait_root=3DFalse, seconds=3D600):
>         starttime =3D datetime.datetime.now()
>         endtime =3D starttime + datetime.timedelta(seconds=3Dseconds)
>         guest_up =3D False
>         while datetime.datetime.now() < endtime:
>             if wait_root and self.ssh_root("exit 0") =3D=3D 0:
>                 guest_up =3D True
>                 break
>             elif self.ssh("exit 0") =3D=3D 0:
>                 guest_up =3D True
>                 break
>             seconds =3D (endtime - datetime.datetime.now()).total_seconds=
()
>             logging.debug("%ds before timeout", seconds)
>             time.sleep(1)
>         if not guest_up:
>             raise Exception("Timeout while waiting for guest ssh")
>
>
> >                  guest_up =3D True
> >                  break
> >              seconds =3D (endtime - datetime.datetime.now()).total_seco=
nds()
>
>
> --
> Alex Benn=C3=A9e

