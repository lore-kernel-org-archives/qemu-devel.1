Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B512AC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F3A521479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 10:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEzibG5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3A521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOg7I-0006lA-Ov
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 06:17:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hOg6J-0006Ru-G8
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hOg6I-0005hK-F6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:16:31 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hOg6I-0005h4-8r
	for qemu-devel@nongnu.org; Thu, 09 May 2019 06:16:30 -0400
Received: by mail-wm1-x344.google.com with SMTP id o189so2555382wmb.1
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=+PxqZ01CaVWxu7DdnrTvpat4+zyIv2nt0ePxlB/zmIs=;
	b=iEzibG5tEFwc5ccYhtI0HDsGKhokbcXOjTJtamJ+z/QWVbYzzLCRTDo4eucnI8ZMeu
	YgceqWIs//DdKgpOikGgLBJt0/ikMI1+us+8YY1VnH7Qa0EsdVw7cvpzBwOKYhaGYSry
	ZFoJ9n66iQSzyAWd0gwYzE0MAT4/ir8Pf1LB1M031VRMVoHic3YsExd/+i0phXSYaBDy
	UcvkBPeIX3DM7Do0VsgtDcLQUfG4LYM50Mq8oS3e1BlqfdXCUh1Q+RzMpMkyS+UiK/mE
	5Qz+Rvief4GkNuNNjRpnkjBOol6vStDKzP4MU/att3mHgHhEkqJP4SjLBidAMZI6DyJ5
	lk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=+PxqZ01CaVWxu7DdnrTvpat4+zyIv2nt0ePxlB/zmIs=;
	b=eeh8UOcuBsU4jprMYjgLe95T9UMBI5JYMTU94b+Getyb26ThoF/+xfHkgBqsTQqUCa
	6BmQca45RofV6O+5kgHnYwGnTXk+IdAl09i7cKYGJNpw7vQ35IV2vMWCrzryYVOw3abW
	lzO5dYY4CaiimmAzQeNz8M9j4S1hfJOzon+NMDTaPp4LLpXVvUf0UWeczcdtXPCntg31
	Uhfbt6sAp3IoszaftbVqDHNGxGj8kaQL/YJ3bZcpPZ5Z7tvgBJIy6DD86O0bLt7NPH14
	DCzE+rQX6k1FSDwUYWNPqT8GkfarQgOgZAOdbKAdrwekvN8QsRGUwEP/nbOt9ohg4VIN
	Dc1w==
X-Gm-Message-State: APjAAAX+7cGw+CJAZtL4cmZhEwk3m0JZy3N3MJOfaAODawZcHhJquxmf
	y9MTSFbvkwsL6oOJ66SHMR/l9gbQ/EB23QPNtGQ=
X-Google-Smtp-Source: APXvYqxNilADOx83lyw7LUSW5aluGpNTb8XzksYQvdyu2V576ZyNBYq7PuBW7+VNRaAYjqO6FRs3KCa3t/KGXDVZqeI=
X-Received: by 2002:a05:600c:2412:: with SMTP id
	18mr2410858wmp.46.1557396989337; 
	Thu, 09 May 2019 03:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190503130034.24916-1-marcandre.lureau@redhat.com>
	<20190503130034.24916-5-marcandre.lureau@redhat.com>
	<20190509063220.cfahgzlujtcv5etr@sirius.home.kraxel.org>
	<CAMxuvaw9kOt3yoRk4sWPeRyUmRLWboCCyrO00W0Se+W-OOrGRw@mail.gmail.com>
	<20190509092418.65ftbkyy4qzki7jk@sirius.home.kraxel.org>
	<CAJ+F1C+CLuoHUNA-hhsEQhYDd1pjJ5EKN8WpBdO-RxS70gCLXw@mail.gmail.com>
	<CAJ+F1C+-xL4tBAC+5h0KoEeqNbN-7z64=DJy40YT29W++-W4eg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+-xL4tBAC+5h0KoEeqNbN-7z64=DJy40YT29W++-W4eg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 May 2019 12:16:18 +0200
Message-ID: <CAJ+F1CKk9Vsah3FELseRrf7s=Ku4L0bEW7HOX9v_-Db677BRfA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v2 4/6] Add vhost-user-input-pci
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
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, May 9, 2019 at 12:09 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, May 9, 2019 at 11:53 AM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Thu, May 9, 2019 at 11:25 AM Gerd Hoffmann <kraxel@redhat.com> wrote=
:
> > >
> > > On Thu, May 09, 2019 at 10:37:20AM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi
> > > >
> > > > On Thu, May 9, 2019 at 8:32 AM Gerd Hoffmann <kraxel@redhat.com> wr=
ote:
> > > > >
> > > > >   Hi,
> > > > >
> > > > > > +static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info=
 =3D {
> > > > > > +    .base_name =3D TYPE_VHOST_USER_INPUT_PCI,
> > > > > > +    .generic_name =3D "vhost-user-input-pci",
> > > > > > +    .transitional_name =3D "vhost-user-input-pci-transitional"=
,
> > > > > > +    .non_transitional_name =3D "vhost-user-input-pci-non-trans=
itional",
> > > > >
> > > > > virtio-input is virtio 1.0 only, so we don't need these variants.
> > > > > Incremental fix below, if you ack that I can squash it for the pu=
ll req.
> > > > > Or you send a v3 (in case you have other changes pending).
> > > > >
> > > > > cheers,
> > > > >   Gerd
> > > >
> > > > ack, thanks
> > >
> > > Spoke too soon, patch failed tests.
> > > New version (with some virtio-input-host fixes on top) pushed to:
> > >
> > >         https://git.kraxel.org/cgit/qemu/log/?h=3Dtesting/vhost-input
> > >
> > > Can you please verify?
> >
> > Looks good, tested successfully.
> > thanks
> >
>
> nack, I tested wrongly, investigating some issue

In your git tree, you removed:
-    .parent =3D TYPE_VIRTIO_INPUT_PCI,

from vhost_user_input_pci_info, please add it back


--=20
Marc-Andr=C3=A9 Lureau

