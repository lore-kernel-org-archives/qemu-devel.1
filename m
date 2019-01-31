Received: from eggs.gnu.org ([209.51.188.92]:52532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=927b0d5b4=Paul.Durrant@citrix.com>)
	id 1gpEWB-0007nj-Vv
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=927b0d5b4=Paul.Durrant@citrix.com>)
	id 1gpEW6-0001RH-E3
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:44:43 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 31 Jan 2019 15:22:18 +0000
Message-ID: <b94b7583a3e14fec9b86a9cec13a1385@AMSPEX02CL03.citrite.net>
References: <20190130161948.15888-1-paul.durrant@citrix.com>
	<20190131152042.GF2306@perard.uk.xensource.com>
In-Reply-To: <20190131152042.GF2306@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] xen-block: handle resize callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 31 January 2019 15:21
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Stefan Hajnoczi <stefanha@redhat.com>; Stefan=
o
> Stabellini <sstabellini@kernel.org>; Kevin Wolf <kwolf@redhat.com>; Max
> Reitz <mreitz@redhat.com>
> Subject: Re: [PATCH v2] xen-block: handle resize callback
>=20
> On Wed, Jan 30, 2019 at 04:19:48PM +0000, Paul Durrant wrote:
> > Some frontend drivers will handle dynamic resizing of PV disks, so set
> up
> > the BlockDevOps resize_cb() method during xen_block_realize() to allow
> > this to be done.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
>=20
>=20
> > +    /*
> > +     * Mimic the behaviour of Linux xen-blkback and re-write the state
> > +     * to trigger the frontend watch.
> > +     */
> > +    xen_device_backend_set_state(xendev, backend_state);
>=20
> :(, that function doesn't write the state again if it hasn't changed.
> So in my testing, Linux never did anything.

Gah! I forgot about that. Alright, it's going to have to be a bit more crud=
e.

  Paul

>=20
> --
> Anthony PERARD
