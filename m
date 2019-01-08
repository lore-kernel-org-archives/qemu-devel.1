Received: from eggs.gnu.org ([209.51.188.92]:57407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggtGf-0007LQ-DJ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggtGd-00062j-H7
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:26:13 -0500
Date: Tue, 8 Jan 2019 16:25:51 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190108152551.GF11492@linux.fritz.box>
References: <20181220171439.11159-1-paul.durrant@citrix.com>
	<20181220171439.11159-17-paul.durrant@citrix.com>
	<20190104163124.GE1508@perard.uk.xensource.com>
	<da727b0b8a9a4f9baa47a660298a9cba@AMSPEX02CL03.citrite.net>
	<20190108125321.GD11492@linux.fritz.box>
	<904d305f8c0f4aac8e60fb7ea14ebd41@AMSPEX02CL03.citrite.net>
	<20190108132823.GF1508@perard.uk.xensource.com>
	<cc64da25a6a3418e8d36c6975fe2df45@AMSPEX02CL03.citrite.net>
	<3d36565f9e7646d08f9b02bf5b5474d7@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d36565f9e7646d08f9b02bf5b5474d7@AMSPEX02CL03.citrite.net>
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
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

Am 08.01.2019 um 15:20 hat Paul Durrant geschrieben:
> > -----Original Message-----
> > From: Xen-devel [mailto:xen-devel-bounces@lists.xenproject.org] On Behalf
> > Of Paul Durrant
> > Sent: 08 January 2019 14:11
> > To: Anthony Perard <anthony.perard@citrix.com>
> > Cc: 'Kevin Wolf' <kwolf@redhat.com>; Stefano Stabellini
> > <sstabellini@kernel.org>; qemu-block@nongnu.org; qemu-devel@nongnu.org;
> > Max Reitz <mreitz@redhat.com>; xen-devel@lists.xenproject.org
> > Subject: Re: [Xen-devel] [PATCH v7 16/18] xen: automatically create
> > XenBlockDevice-s
> > 
> > > -----Original Message-----
> > > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > > Sent: 08 January 2019 13:28
> > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > Cc: 'Kevin Wolf' <kwolf@redhat.com>; qemu-devel@nongnu.org; qemu-
> > > block@nongnu.org; xen-devel@lists.xenproject.org; Max Reitz
> > > <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> > > Subject: Re: [PATCH v7 16/18] xen: automatically create XenBlockDevice-s
> > >
> > > On Tue, Jan 08, 2019 at 01:07:49PM +0000, Paul Durrant wrote:
> > > > > -----Original Message-----
> > > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > > Sent: 08 January 2019 12:53
> > > > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > > Cc: Anthony Perard <anthony.perard@citrix.com>; qemu-
> > devel@nongnu.org;
> > > > > qemu-block@nongnu.org; xen-devel@lists.xenproject.org; Max Reitz
> > > > > <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> > > > > Subject: Re: [PATCH v7 16/18] xen: automatically create
> > > XenBlockDevice-s
> > > > >
> > > > > Am 04.01.2019 um 17:40 hat Paul Durrant geschrieben:
> > > > > > > -----Original Message-----
> > > > > > > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > > > > > > Sent: 04 January 2019 16:31
> > > > > > > To: Paul Durrant <Paul.Durrant@citrix.com>
> > > > > > > Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> > > > > > > devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max
> > > Reitz
> > > > > > > <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> > > > > > > Subject: Re: [PATCH v7 16/18] xen: automatically create
> > > > > XenBlockDevice-s
> > > > > > >
> > > > > > > Almost done, there is one thing left which I believe is an
> > issue.
> > > > > > > Whenever I attach a raw file to QEMU, it print:
> > > > > > >     qemu-system-i386: warning: Opening a block device as a file
> > > using
> > > > > the
> > > > > > > 'file' driver is deprecated
> > > > > >
> > > > > > Oh, I'd not noticed that... but then I only use raw files
> > > occasionally.
> > > > >
> > > > > Strictly speaking, this is not about raw (regular) files, but raw
> > > block
> > > > > devices. 'file' is fine for actual regular files, but the protocol
> > > > > driver for block devices is 'host_device'.
> > > > >
> > > > > > > raw files should use the "raw" driver, so we aren't done yet.
> > > > > >
> > > > > > Ok. Having a strictly 2-layer stack actually makes things simpler
> > > anyway
> > > > > :-)
> > > > >
> > > > > Using 'raw' there will make the block layer auto-detect the right
> > > > > protocol layer, so this works. If you want to avoid the second
> > layer,
> > > > > you'd have to figure out manually whether to use 'file' or
> > > > > 'host_device'.
> > > >
> > > > Thanks for the explanation. I'll give it a spin using a device... I've
> > > posted v8 but, given what you say, I'm still not sure I have it right.
> > >
> > > Indeed, in v8, even with the extra 'raw' layer, the warning is still
> > > there. I was trying to understand why, and I only found out today that
> > > we would need to use the 'host_device' driver as explain by Kevin.
> > >
> > >
> > > BTW Paul, we can simplify the code that manage layers, by not managing
> > > them.
> > > Instead of (in JSON / QMP term):
> > >     { 'driver': 'file', 'filename': '/file', 'node-name': 'node-file' }
> > >     { 'driver': 'qcow2', 'file': 'node-file', 'node-name': 'node-qcow2'
> > }
> > > we can have:
> > >     { 'driver': 'qcow2', 'node-name': 'node-qcow2',
> > >       'file': { 'driver': 'file', 'filename': '/file' } }
> > >
> > 
> > I kind of like the clean separation though... From what Kevin said, it
> > sounds like the lowest layer should use 'raw' instead of 'file' to DTRT,
> > and then we should be back to only needing the single layer in that case.
> > I'll revert back to v7 and give it a try.
> 
> No, that doesn't work as we can't deal with locking correctly unless
> we use driver=file so maybe I misunderstood.

The lowest layer should use 'host_device' there. 'raw' is the format
layer that is stacked on top.

I'm not sure what your locking requirements are, but 'host_device'
supports the same options as 'file'.

Kevin
