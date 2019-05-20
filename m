Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820DDC04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 01:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CE22081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 01:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrjGWVE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CE22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56047 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSX8e-0001gA-I9
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 21:30:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hSX7o-0001DJ-7D
	for qemu-devel@nongnu.org; Sun, 19 May 2019 21:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hSX7m-0004LE-O1
	for qemu-devel@nongnu.org; Sun, 19 May 2019 21:30:00 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>)
	id 1hSX7m-0004Kr-Hn; Sun, 19 May 2019 21:29:58 -0400
Received: by mail-oi1-x241.google.com with SMTP id u199so8800459oie.5;
	Sun, 19 May 2019 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=S9RNOcgssDqjMUxMAN7FCHPIqt7bbrCMTaGyjBJsw5I=;
	b=DrjGWVE8CJrcWokPgSI35UqKojYyTngbigv0dX3IUMUrlOg17GUZ5O9EPFVRr6zJ2I
	yZ/WExlb/FnHQ/afbh8YLrOorgZ4mTGJw2i2kFOAB4BaPVB8HJmNXhtSYQtpUQavnOG7
	LllCoaC89NzRTmSJRktipd6IVjbt5/bNHFdK6yDqduPd72FnN6tCoL7G7uHXyXZUa7aR
	qg6wQgi/stwtZahi4cXX24hpkmG1zuUo6D/7bGGjXl2BlFh2bDZsz71mFfRUdWT3Aol+
	+iyAkwlEjbvc2K7U+LKXAXF8l7KHOOgqRtw8o2B3RhUrVS8L44E4LmOkVtDNBM0KjR/b
	fQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=S9RNOcgssDqjMUxMAN7FCHPIqt7bbrCMTaGyjBJsw5I=;
	b=GB2be2hmMGs4xr2j0TzGJKN33pwtijCISTyCT0C++3vIsAdVvIbE5skAVFwwuQe34g
	AkYsi+K9BF5BDMbViWoQ6gHd+F1DUj1cARgnjaSx+tohD8/U9SPtcQymw1JvBfDVosmw
	ag1NwblUKaQe+T6mY6WiAn4yHYfJL/bSeWlenMfyn7KHGD2ATbkrVrtKma597Klp/QeD
	cVunc17IdbFH6WCparZlWOaQwbl/c4raARbjPmZAlosjGV4rAO1Px8/C+H0Ne+agkNBy
	NRL1kZOf3hHBtgPsmaJbh8lf3YgO4qZKdVBoBsoGmif8whWG9zVR7I6r+dxaudv9ZMQc
	eplQ==
X-Gm-Message-State: APjAAAVKtegnklg0R5Te7OfZPbWo/34QOPeqYFZMXlVAM5LUj01ic3m0
	cYDgrk9QZ1txY9uU0XDCAoZJZpTNo8YsEIKyaGs=
X-Google-Smtp-Source: APXvYqyk7qwpkGaaebF00xshUHpdSJEkEJ2WNcLhAQQSXVCtNPOB/f2YGDXlvxYcLwdJ3eYelrL7uEGVmWpGCYOvWJo=
X-Received: by 2002:aca:fd45:: with SMTP id b66mr22383587oii.157.1558315797622;
	Sun, 19 May 2019 18:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190518032811.60341-1-liq3ea@163.com>
	<20190518032811.60341-2-liq3ea@163.com>
	<20190518082020.6b223ab0@x1.home>
In-Reply-To: <20190518082020.6b223ab0@x1.home>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 20 May 2019 09:29:21 +0800
Message-ID: <CAKXe6SLsoyCh=O1yyOFOukYdFoeySpSS1H8QG7fhp1ZQ35vD+g@mail.gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 2/4] hw: vfio: drop TYPE_FOO MACRO in
 VMStateDescription
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
Cc: lvivier@redhat.com, qemu-trivial@nongnu.org, Li Qiang <liq3ea@163.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Alex Williamson <alex.williamson@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=9C=
=8818=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8810:20=E5=86=99=E9=81=93=
=EF=BC=9A

> On Fri, 17 May 2019 20:28:09 -0700
> Li Qiang <liq3ea@163.com> wrote:
>
> > As the vmstate structure names aren't related with
> > the QOM type names.
>
> Seems contrary to the first patch in the series.
>
>
No, once there is a discussion of this:
-->https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02175.html

Thanks,
Li Qiang



> > CC: qemu-trivial@nongnu.org
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  hw/vfio/amd-xgbe.c      | 2 +-
> >  hw/vfio/ap.c            | 2 +-
> >  hw/vfio/calxeda-xgmac.c | 2 +-
> >  hw/vfio/ccw.c           | 2 +-
> >  hw/vfio/platform.c      | 2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
> > index ee64a3b4a2..1b06c0f3ea 100644
> > --- a/hw/vfio/amd-xgbe.c
> > +++ b/hw/vfio/amd-xgbe.c
> > @@ -26,7 +26,7 @@ static void amd_xgbe_realize(DeviceState *dev, Error
> **errp)
> >  }
> >
> >  static const VMStateDescription vfio_platform_amd_xgbe_vmstate =3D {
> > -    .name =3D TYPE_VFIO_AMD_XGBE,
> > +    .name =3D "vfio-amd-xgbe",
> >      .unmigratable =3D 1,
> >  };
> >
> > diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> > index d8b79ebe53..564751650f 100644
> > --- a/hw/vfio/ap.c
> > +++ b/hw/vfio/ap.c
> > @@ -155,7 +155,7 @@ static void vfio_ap_reset(DeviceState *dev)
> >  }
> >
> >  static const VMStateDescription vfio_ap_vmstate =3D {
> > -    .name =3D VFIO_AP_DEVICE_TYPE,
> > +    .name =3D "vfio-ap",
> >      .unmigratable =3D 1,
> >  };
> >
> > diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
> > index e7767c4b02..6cc608b6ca 100644
> > --- a/hw/vfio/calxeda-xgmac.c
> > +++ b/hw/vfio/calxeda-xgmac.c
> > @@ -26,7 +26,7 @@ static void calxeda_xgmac_realize(DeviceState *dev,
> Error **errp)
> >  }
> >
> >  static const VMStateDescription vfio_platform_calxeda_xgmac_vmstate =
=3D {
> > -    .name =3D TYPE_VFIO_CALXEDA_XGMAC,
> > +    .name =3D "vfio-calxeda-xgmac",
> >      .unmigratable =3D 1,
> >  };
> >
> > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > index 31dd3a2a87..d9e39552e2 100644
> > --- a/hw/vfio/ccw.c
> > +++ b/hw/vfio/ccw.c
> > @@ -468,7 +468,7 @@ static Property vfio_ccw_properties[] =3D {
> >  };
> >
> >  static const VMStateDescription vfio_ccw_vmstate =3D {
> > -    .name =3D TYPE_VFIO_CCW,
> > +    .name =3D "vfio-ccw",
> >      .unmigratable =3D 1,
> >  };
> >
> > diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> > index 398db38f14..e59a0234dd 100644
> > --- a/hw/vfio/platform.c
> > +++ b/hw/vfio/platform.c
> > @@ -697,7 +697,7 @@ out:
> >  }
> >
> >  static const VMStateDescription vfio_platform_vmstate =3D {
> > -    .name =3D TYPE_VFIO_PLATFORM,
> > +    .name =3D "vfio-platform",
> >      .unmigratable =3D 1,
> >  };
> >
>
>
