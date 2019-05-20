Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674E1C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 20:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4115B20863
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 20:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4115B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSofc-00004r-Dl
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 16:14:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hSoek-0008BM-Ob
	for qemu-devel@nongnu.org; Mon, 20 May 2019 16:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hSoei-0001ic-Mx
	for qemu-devel@nongnu.org; Mon, 20 May 2019 16:13:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hSoeg-0001ex-Pl; Mon, 20 May 2019 16:13:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CFBB8830F;
	Mon, 20 May 2019 20:13:01 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A837518793;
	Mon, 20 May 2019 20:12:54 +0000 (UTC)
Date: Mon, 20 May 2019 14:12:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Li Qiang <liq3ea@gmail.com>
Message-ID: <20190520141254.1c97a9aa@x1.home>
In-Reply-To: <CAKXe6SLsoyCh=O1yyOFOukYdFoeySpSS1H8QG7fhp1ZQ35vD+g@mail.gmail.com>
References: <20190518032811.60341-1-liq3ea@163.com>
	<20190518032811.60341-2-liq3ea@163.com>
	<20190518082020.6b223ab0@x1.home>
	<CAKXe6SLsoyCh=O1yyOFOukYdFoeySpSS1H8QG7fhp1ZQ35vD+g@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 20 May 2019 20:13:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
	Philippe =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 May 2019 09:29:21 +0800
Li Qiang <liq3ea@gmail.com> wrote:

> Alex Williamson <alex.williamson@redhat.com> =E4=BA=8E2019=E5=B9=B45=E6=
=9C=8818=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8810:20=E5=86=99=E9=81=
=93=EF=BC=9A
>=20
> > On Fri, 17 May 2019 20:28:09 -0700
> > Li Qiang <liq3ea@163.com> wrote:
> > =20
> > > As the vmstate structure names aren't related with
> > > the QOM type names. =20
> >
> > Seems contrary to the first patch in the series.
> >
> > =20
> No, once there is a discussion of this:
> -->https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02175.html =20

Ok, then rather than the commit log above, it would be more useful (at
least to me) to state:

  It's recommended that VMStateDescription names are decoupled from QOM
  type names as the latter may freely change without consideration of
  migration compatibility.

  Link: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02175.html

Otherwise this appears as a rather arbitrary change.  Thanks,

Alex

> > > CC: qemu-trivial@nongnu.org
> > > Signed-off-by: Li Qiang <liq3ea@163.com>
> > > ---
> > >  hw/vfio/amd-xgbe.c      | 2 +-
> > >  hw/vfio/ap.c            | 2 +-
> > >  hw/vfio/calxeda-xgmac.c | 2 +-
> > >  hw/vfio/ccw.c           | 2 +-
> > >  hw/vfio/platform.c      | 2 +-
> > >  5 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
> > > index ee64a3b4a2..1b06c0f3ea 100644
> > > --- a/hw/vfio/amd-xgbe.c
> > > +++ b/hw/vfio/amd-xgbe.c
> > > @@ -26,7 +26,7 @@ static void amd_xgbe_realize(DeviceState *dev, Erro=
r =20
> > **errp) =20
> > >  }
> > >
> > >  static const VMStateDescription vfio_platform_amd_xgbe_vmstate =3D {
> > > -    .name =3D TYPE_VFIO_AMD_XGBE,
> > > +    .name =3D "vfio-amd-xgbe",
> > >      .unmigratable =3D 1,
> > >  };
> > >
> > > diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> > > index d8b79ebe53..564751650f 100644
> > > --- a/hw/vfio/ap.c
> > > +++ b/hw/vfio/ap.c
> > > @@ -155,7 +155,7 @@ static void vfio_ap_reset(DeviceState *dev)
> > >  }
> > >
> > >  static const VMStateDescription vfio_ap_vmstate =3D {
> > > -    .name =3D VFIO_AP_DEVICE_TYPE,
> > > +    .name =3D "vfio-ap",
> > >      .unmigratable =3D 1,
> > >  };
> > >
> > > diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
> > > index e7767c4b02..6cc608b6ca 100644
> > > --- a/hw/vfio/calxeda-xgmac.c
> > > +++ b/hw/vfio/calxeda-xgmac.c
> > > @@ -26,7 +26,7 @@ static void calxeda_xgmac_realize(DeviceState *dev,=
 =20
> > Error **errp) =20
> > >  }
> > >
> > >  static const VMStateDescription vfio_platform_calxeda_xgmac_vmstate =
=3D {
> > > -    .name =3D TYPE_VFIO_CALXEDA_XGMAC,
> > > +    .name =3D "vfio-calxeda-xgmac",
> > >      .unmigratable =3D 1,
> > >  };
> > >
> > > diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> > > index 31dd3a2a87..d9e39552e2 100644
> > > --- a/hw/vfio/ccw.c
> > > +++ b/hw/vfio/ccw.c
> > > @@ -468,7 +468,7 @@ static Property vfio_ccw_properties[] =3D {
> > >  };
> > >
> > >  static const VMStateDescription vfio_ccw_vmstate =3D {
> > > -    .name =3D TYPE_VFIO_CCW,
> > > +    .name =3D "vfio-ccw",
> > >      .unmigratable =3D 1,
> > >  };
> > >
> > > diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> > > index 398db38f14..e59a0234dd 100644
> > > --- a/hw/vfio/platform.c
> > > +++ b/hw/vfio/platform.c
> > > @@ -697,7 +697,7 @@ out:
> > >  }
> > >
> > >  static const VMStateDescription vfio_platform_vmstate =3D {
> > > -    .name =3D TYPE_VFIO_PLATFORM,
> > > +    .name =3D "vfio-platform",
> > >      .unmigratable =3D 1,
> > >  };
> > > =20
> >
> > =20


