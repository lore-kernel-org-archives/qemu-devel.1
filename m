Received: from eggs.gnu.org ([2001:4830:134:3::10]:40679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=863a5f629=Paul.Durrant@citrix.com>)
	id 1gS2zz-00034x-Hn
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=863a5f629=Paul.Durrant@citrix.com>)
	id 1gS2zx-0000Xx-Hn
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:47:39 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 28 Nov 2018 16:46:57 +0000
Message-ID: <a0104a7b4f874c31bda9d854bf254b0d@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-3-paul.durrant@citrix.com>
	<20181128161917.GE4222@dhcp-200-186.str.redhat.com>
	<48596f1fe100419c8b28ed54bda0117b@AMSPEX02CL03.citrite.net>
	<alpine.DEB.2.10.1811280827330.4577@sstabellini-ThinkPad-X260>
	<65af28818a724749839dcb6576e0413d@AMSPEX02CL03.citrite.net>
	<20181128163900.GG4222@dhcp-200-186.str.redhat.com>
	<5327ba765089439caf8119de49c3a399@AMSPEX02CL03.citrite.net>
In-Reply-To: <5327ba765089439caf8119de49c3a399@AMSPEX02CL03.citrite.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/18] xen: introduce new
 'XenBus' and 'XenDevice' object hierarchy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: 'Stefano Stabellini' <sstabellini@kernel.org>, "'qemu-block@nongnu.org'" <qemu-block@nongnu.org>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, "'xen-devel@lists.xenproject.org'" <xen-devel@lists.xenproject.org>, 'Eduardo Habkost' <ehabkost@redhat.com>, "'Michael S. Tsirkin'" <mst@redhat.com>, 'Marcel Apfelbaum' <marcel.apfelbaum@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Richard Henderson' <rth@twiddle.net>

> -----Original Message-----
> From: Paul Durrant
> Sent: 28 November 2018 16:46
> To: 'Kevin Wolf' <kwolf@redhat.com>
> Cc: 'Stefano Stabellini' <sstabellini@kernel.org>; qemu-block@nongnu.org;
> qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Eduardo Habkost
> <ehabkost@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; Marcel
> Apfelbaum <marcel.apfelbaum@gmail.com>; Anthony Perard
> <anthony.perard@citrix.com>; Paolo Bonzini <pbonzini@redhat.com>; Richard
> Henderson <rth@twiddle.net>
> Subject: RE: [Qemu-block] [PATCH 02/18] xen: introduce new 'XenBus' and
> 'XenDevice' object hierarchy
>=20
> > -----Original Message-----
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > Sent: 28 November 2018 16:39
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: 'Stefano Stabellini' <sstabellini@kernel.org>; qemu-
> block@nongnu.org;
> > qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Eduardo Habkost
> > <ehabkost@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; Marcel
> > Apfelbaum <marcel.apfelbaum@gmail.com>; Anthony Perard
> > <anthony.perard@citrix.com>; Paolo Bonzini <pbonzini@redhat.com>;
> Richard
> > Henderson <rth@twiddle.net>
> > Subject: Re: [Qemu-block] [PATCH 02/18] xen: introduce new 'XenBus' and
> > 'XenDevice' object hierarchy
> >
> > Am 28.11.2018 um 17:29 hat Paul Durrant geschrieben:
> > > > -----Original Message-----
> > > > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> > > > Sent: 28 November 2018 16:28
> > > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > Cc: 'Kevin Wolf' <kwolf@redhat.com>; qemu-block@nongnu.org; qemu-
> > > > devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano Stabellin=
i
> > > > <sstabellini@kernel.org>; Eduardo Habkost <ehabkost@redhat.com>;
> > Michael
> > > > S. Tsirkin <mst@redhat.com>; Marcel Apfelbaum
> > > > <marcel.apfelbaum@gmail.com>; Anthony Perard
> > <anthony.perard@citrix.com>;
> > > > Paolo Bonzini <pbonzini@redhat.com>; Richard Henderson
> > <rth@twiddle.net>
> > > > Subject: RE: [Qemu-block] [PATCH 02/18] xen: introduce new 'XenBus'
> > and
> > > > 'XenDevice' object hierarchy
> > > >
> > > > On Wed, 28 Nov 2018, Paul Durrant wrote:
> > > > > > -----Original Message-----
> > > > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > > > Sent: 28 November 2018 16:19
> > > > > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > > > Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> > > > > > devel@lists.xenproject.org; Stefano Stabellini
> > > > <sstabellini@kernel.org>;
> > > > > > Eduardo Habkost <ehabkost@redhat.com>; Michael S. Tsirkin
> > > > > > <mst@redhat.com>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>=
;
> > > > Anthony
> > > > > > Perard <anthony.perard@citrix.com>; Paolo Bonzini
> > > > <pbonzini@redhat.com>;
> > > > > > Richard Henderson <rth@twiddle.net>
> > > > > > Subject: Re: [Qemu-block] [PATCH 02/18] xen: introduce new
> > 'XenBus'
> > > > and
> > > > > > 'XenDevice' object hierarchy
> > > > > >
> > > > > > Am 21.11.2018 um 16:11 hat Paul Durrant geschrieben:
> > > > > > > This patch adds the basic boilerplate for a 'XenBus' object
> that
> > > > will
> > > > > > act
> > > > > > > as a parent to 'XenDevice' PV backends.
> > > > > > > A new 'XenBridge' object is also added to connect XenBus to
> the
> > > > system
> > > > > > bus.
> > > > > > >
> > > > > > > The XenBus object is instantiated by a new xen_bus_init()
> > function
> > > > > > called
> > > > > > > from the same sites as the legacy xen_be_init() function.
> > > > > > >
> > > > > > > Subsequent patches will flesh-out the functionality of these
> > > > objects.
> > > > > > >
> > > > > > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > > > >
> > > > > > > diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> > > > > > > new file mode 100644
> > > > > > > index 0000000000..dede2d914a
> > > > > > > --- /dev/null
> > > > > > > +++ b/hw/xen/xen-bus.c
> > > > > > > @@ -0,0 +1,125 @@
> > > > > > > +/*
> > > > > > > + * Copyright (c) Citrix Systems Inc.
> > > > > > > + * All rights reserved.
> > > > > > > + */
> > > > > >
> > > > > > This doesn't look very compatible with the GPL. In fact it migh=
t
> > even
> > > > > > make it illegal for the QEMU project to distribute this code. :=
-
> )
> > > > > >
> > > > > > Other files you add throughout the series seem to have the same
> > > > problem.
> > > > > >
> > > > >
> > > > > I was working on the assumption that a lack of explicit license
> > meant
> > > > that the overall project license as described in item 2 in LICENSE.
> > Did I
> > > > misinterpret that text?
> > > >
> > > > It's "All rights reserved." the problem
> > >
> > > Oh, I see. I'm happy to remove that.
> >
> > That would be better at least. I'm not sure about files that have a
> > copyright header, but no license statement. Do such files exist yet in
> > the source tree?
>=20
> Yes, there's quite a few... e.g. (first ones I tripped over)
> hw/rdma/rdma_backend.c, hw/virtio/vhost-backend.c, ...

Oh... I see they have a license statement but no boilerplate... is that sta=
tement enough?

  Paul

>=20
> > To be on the safe side, I'd just stick with the
> > established practice, which is having a license header in every file.
>=20
> Ok... if that is established practice. It really wasn't clear.
>=20
> >
> > By the way, in a later patch you remove the existing license header,
> > which is different from the default license (because parts of the sourc=
e
> > file are GPL 2 only). If you can't prove that all such parts (and parts
> > derived from them) have been removed, this is also a problem.
> >
>=20
> What should I do? I am duplicating xen_disk, and then heavily modifying
> it. Should I just leave the old boilerplate in place?
>=20
>   Paul
>=20
> > Kevin
