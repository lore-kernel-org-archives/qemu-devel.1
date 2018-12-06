Received: from eggs.gnu.org ([2001:4830:134:3::10]:56719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUvuC-0002P7-Q3
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=8715dceb6=Paul.Durrant@citrix.com>)
	id 1gUvu9-0008TB-5t
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 10:49:36 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 6 Dec 2018 15:36:08 +0000
Message-ID: <39236fddad8d4fc0a9bf58550d0aaca2@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-16-paul.durrant@citrix.com>
	<20181204153510.GW14786@perard.uk.xensource.com>
	<66fe7ee71e9642d3bbbda0f4f900c799@AMSPEX02CL03.citrite.net>
	<20181206152406.GC18875@perard.uk.xensource.com>
In-Reply-To: <20181206152406.GC18875@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 15/18] xen: add a mechanism to
 automatically create XenDevice-s...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 06 December 2018 15:24
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH 15/18] xen: add a mechanism to automatically create
> XenDevice-s...
>=20
> On Thu, Dec 06, 2018 at 12:36:52PM +0000, Paul Durrant wrote:
> > > -----Original Message-----
> > > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > > Sent: 04 December 2018 15:35
> > >
> > > On Wed, Nov 21, 2018 at 03:12:08PM +0000, Paul Durrant wrote:
> > > > +    xenbus->backend_watch =3D
> > > > +        xen_bus_add_watch(xenbus, "", /* domain root node */
> > > > +                          "backend", xen_bus_enumerate, xenbus,
> > > &local_err);
> > > > +    if (local_err) {
> > > > +        error_propagate(errp, local_err);
> > > > +        error_prepend(errp, "failed to set up enumeration watch:
> ");
> > >
> > > You should use error_propagate_prepend instead
> > > error_propagate;error_prepend. And it looks like there is the same
> > > mistake in other patches that I haven't notice.
> > >
> >
> > Oh, I didn't know about that one either... I've only seen the separate
> calls used elsewhere.
>=20
> That information is all in "include/qapi/error.h", if you which to know
> more on how to use Error.
>=20

Thanks.

> > > Also you probably want goto fail here.
> > >
> >
> > Not sure about that. Whilst the bus scan won't happen, it doesn't mean
> devices can't be added via QMP.
>=20
> In that case, don't modify errp, and use error_reportf_err instead, or
> warn_reportf_err (then local_err =3D NULL, in case it is reused in a
> future modification of the function).
>=20
> Setting errp (with error_propagate) means that the function failed, and
> QEMU is going to exit(1), because of qdev_init_nofail call in
> xen_bus_init.

Ah, good point. I'll wait for more feedback on v2 and then fix in v3.

  Paul
