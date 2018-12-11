Received: from eggs.gnu.org ([2001:4830:134:3::10]:37415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWk87-0003MH-VC
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWk83-0002Bm-Sz
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:39:27 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 11 Dec 2018 15:38:52 +0000
Message-ID: <289322a222fa426faf953c88274d4b2f@AMSPEX02CL03.citrite.net>
References: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
	<1544525238-3527-10-git-send-email-paul.durrant@citrix.com>
	<20181211153021.GA16149@perard.uk.xensource.com>
In-Reply-To: <20181211153021.GA16149@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v3 09/18] xen: remove
 unnecessary code from dataplane/xen-block.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Stefano
	Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 11 December 2018 15:30
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Stefano
> Stabellini <sstabellini@kernel.org>; Stefan Hajnoczi
> <stefanha@redhat.com>; Max Reitz <mreitz@redhat.com>
> Subject: Re: [Xen-devel] [PATCH v3 09/18] xen: remove unnecessary code
> from dataplane/xen-block.c
>=20
> On Tue, Dec 11, 2018 at 10:47:09AM +0000, Paul Durrant wrote:
> > v2:
> >  - Leave existing boilerplate alone, other than removing the now-
> incorrect
> >    description
> > ---
> >  hw/block/dataplane/xen-block.c | 409 ++-------------------------------=
-
> -------
> >  1 file changed, 16 insertions(+), 393 deletions(-)
> >
> > diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-
> block.c
> > index 9fae505..98f987d 100644
> > --- a/hw/block/dataplane/xen-block.c
> > +++ b/hw/block/dataplane/xen-block.c
> > @@ -1,6 +1,4 @@
> >  /*
> > - *  xen paravirt block device backend
> > - *
> >   *  (c) Gerd Hoffmann <kraxel@redhat.com>
> >   *
> >   *  This program is free software; you can redistribute it and/or
> modify
> > @@ -19,26 +17,12 @@
> >   *  GNU GPL, version 2 or (at your option) any later version.
> >   */
> >
> > +/*
> > + * Copyright (c) 2018  Citrix Systems Inc.
>=20
> Can you move this copyright line to the existing license boilerplate as
> I've asked on v2?
>=20

Oops. I thought I'd done this.

> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
>=20
> And this isn't needed as it just duplicate the already existing one.
>=20

Sure. I'll send v4 with both these fixed.

  Paul

> > + */
> >
>=20
> Thanks,
>=20
> --
> Anthony PERARD
