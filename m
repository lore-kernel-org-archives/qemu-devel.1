Received: from eggs.gnu.org ([2001:4830:134:3::10]:46589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fnPs0-000753-P8
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jthumshirn@suse.de>) id 1fnPrv-00063h-Lv
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:55:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37620 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jthumshirn@suse.de>) id 1fnPrv-00061s-EK
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:55:23 -0400
Date: Wed, 8 Aug 2018 16:55:21 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <20180808145521.c35hkdtn6fjs2inz@linux-x5ow.site>
References: <20180808141700.21333-1-jthumshirn@suse.de>
	<20180808141700.21333-2-jthumshirn@suse.de>
	<CAFEAcA80PvZzdeUALCWfRojSp6pT_s6ppnUC9TYLHgFCO-cNAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA80PvZzdeUALCWfRojSp6pT_s6ppnUC9TYLHgFCO-cNAg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] Add MEN Chameleon Bus emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, Aug 08, 2018 at 03:52:05PM +0100, Peter Maydell wrote:
> On 8 August 2018 at 15:16, Johannes Thumshirn <jthumshirn@suse.de> wrot=
e:
> > The MEN Chameleon Bus (MCB) is an on-chip bus system exposing IP Core=
s of an
> > FPGA to a outside bus system like PCIe.
> >
> > Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>=20
>=20
> > --- /dev/null
> > +++ b/hw/mcb/mcb.c
> > @@ -0,0 +1,180 @@
> > +/*
> > + * QEMU MEN Chameleon Bus emulation
> > + *
> > + * Copyright (C) 2016 Johannes Thumshirn <morbidrsa@gmail.com>
>=20
> Really 2016?

Yes originally. I'll bump it to 2016 - 2018.

>=20
> > + *
> > + * This code is licensed under the GNU GPL v2 or (at your opinion) a=
ny
>=20
> This should say "option" -- wording is important in license
> statements :-)  You might prefer to copy-and-paste an
> existing copyright header.

This should've been a copy&paste from somehwere. Anyways I'll fix
it.

Thanks.

--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=FCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
