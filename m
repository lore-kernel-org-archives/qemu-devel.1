Received: from eggs.gnu.org ([209.51.188.92]:38362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=904727a53=Paul.Durrant@citrix.com>)
	id 1ggr6t-0005EI-0v
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:08:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=904727a53=Paul.Durrant@citrix.com>)
	id 1ggr6r-00073E-VW
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 08:07:59 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 8 Jan 2019 13:07:49 +0000
Message-ID: <904d305f8c0f4aac8e60fb7ea14ebd41@AMSPEX02CL03.citrite.net>
References: <20181220171439.11159-1-paul.durrant@citrix.com>
	<20181220171439.11159-17-paul.durrant@citrix.com>
	<20190104163124.GE1508@perard.uk.xensource.com>
	<da727b0b8a9a4f9baa47a660298a9cba@AMSPEX02CL03.citrite.net>
	<20190108125321.GD11492@linux.fritz.box>
In-Reply-To: <20190108125321.GD11492@linux.fritz.box>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 16/18] xen: automatically create
 XenBlockDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Sent: 08 January 2019 12:53
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: Anthony Perard <anthony.perard@citrix.com>; qemu-devel@nongnu.org;
> qemu-block@nongnu.org; xen-devel@lists.xenproject.org; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v7 16/18] xen: automatically create XenBlockDevice-s
>=20
> Am 04.01.2019 um 17:40 hat Paul Durrant geschrieben:
> > > -----Original Message-----
> > > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > > Sent: 04 January 2019 16:31
> > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> > > devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> > > <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> > > Subject: Re: [PATCH v7 16/18] xen: automatically create
> XenBlockDevice-s
> > >
> > > Almost done, there is one thing left which I believe is an issue.
> > > Whenever I attach a raw file to QEMU, it print:
> > >     qemu-system-i386: warning: Opening a block device as a file using
> the
> > > 'file' driver is deprecated
> >
> > Oh, I'd not noticed that... but then I only use raw files occasionally.
>=20
> Strictly speaking, this is not about raw (regular) files, but raw block
> devices. 'file' is fine for actual regular files, but the protocol
> driver for block devices is 'host_device'.
>=20
> > > raw files should use the "raw" driver, so we aren't done yet.
> >
> > Ok. Having a strictly 2-layer stack actually makes things simpler anywa=
y
> :-)
>=20
> Using 'raw' there will make the block layer auto-detect the right
> protocol layer, so this works. If you want to avoid the second layer,
> you'd have to figure out manually whether to use 'file' or
> 'host_device'.

Thanks for the explanation. I'll give it a spin using a device... I've post=
ed v8 but, given what you say, I'm still not sure I have it right.

  Paul

>=20
> Kevin
