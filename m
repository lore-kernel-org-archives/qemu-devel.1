Received: from eggs.gnu.org ([2001:4830:134:3::10]:58307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=863a5f629=Paul.Durrant@citrix.com>)
	id 1gS3T4-0005ap-EU
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=863a5f629=Paul.Durrant@citrix.com>)
	id 1gS3T2-0001Wr-Ou
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:17:42 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 28 Nov 2018 17:17:10 +0000
Message-ID: <79c7ea5f1b8041d7828240ec18f881f4@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-3-paul.durrant@citrix.com>
	<20181128171001.GC14786@perard.uk.xensource.com>
In-Reply-To: <20181128171001.GC14786@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 02/18] xen: introduce new 'XenBus' and
 'XenDevice' object hierarchy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel
	Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 28 November 2018 17:10
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>;
> Michael S. Tsirkin <mst@redhat.com>; Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com>; Paolo Bonzini <pbonzini@redhat.com>; Richar=
d
> Henderson <rth@twiddle.net>; Eduardo Habkost <ehabkost@redhat.com>
> Subject: Re: [PATCH 02/18] xen: introduce new 'XenBus' and 'XenDevice'
> object hierarchy
>=20
> On Wed, Nov 21, 2018 at 03:11:55PM +0000, Paul Durrant wrote:
> > diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> > new file mode 100644
> > index 0000000000..dede2d914a
> > --- /dev/null
> > +++ b/hw/xen/xen-bus.c
> > @@ -0,0 +1,125 @@
> > +/*
> > + * Copyright (c) Citrix Systems Inc.
> > + * All rights reserved.
>=20
> You probably should include:
>   This work is licensed under the terms of the GNU GPL, version 2 or
> later.
>   See the COPYING file in the top-level directory.
>=20
> As this seems to be a boilerplate used in recent new files, there are
> other similair boilerplates.
>=20
> Also, I think the copyright line should include a year.

Ok.

>=20
> > +void xen_bus_init(void)
> > +{
> > +    DeviceState *dev =3D qdev_create(NULL, TYPE_XEN_BRIDGE);
> > +
> > +    qbus_create(TYPE_XEN_BUS, dev, NULL);
> > +    qdev_init_nofail(dev);
>=20
> Will we need a hotplug handler for this bus, like it is done with
> TYPE_XENSYSBUS?

I didn't seem to need one even doing 'xl block-attach' after the VM had boo=
ted. I'm really not sure what that does.

  Paul

>=20
>=20
> The rest looks good,
> Thanks,
>=20
> --
> Anthony PERARD
