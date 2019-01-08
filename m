Received: from eggs.gnu.org ([209.51.188.92]:33143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggqsw-0007PB-K0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ggqsv-0007PQ-S5
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 07:53:34 -0500
Date: Tue, 8 Jan 2019 13:53:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190108125321.GD11492@linux.fritz.box>
References: <20181220171439.11159-1-paul.durrant@citrix.com>
	<20181220171439.11159-17-paul.durrant@citrix.com>
	<20190104163124.GE1508@perard.uk.xensource.com>
	<da727b0b8a9a4f9baa47a660298a9cba@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da727b0b8a9a4f9baa47a660298a9cba@AMSPEX02CL03.citrite.net>
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
Cc: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

Am 04.01.2019 um 17:40 hat Paul Durrant geschrieben:
> > -----Original Message-----
> > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > Sent: 04 January 2019 16:31
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> > devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> > <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> > Subject: Re: [PATCH v7 16/18] xen: automatically create XenBlockDevice-s
> > 
> > Almost done, there is one thing left which I believe is an issue.
> > Whenever I attach a raw file to QEMU, it print:
> >     qemu-system-i386: warning: Opening a block device as a file using the
> > 'file' driver is deprecated
> 
> Oh, I'd not noticed that... but then I only use raw files occasionally.

Strictly speaking, this is not about raw (regular) files, but raw block
devices. 'file' is fine for actual regular files, but the protocol
driver for block devices is 'host_device'.

> > raw files should use the "raw" driver, so we aren't done yet.
> 
> Ok. Having a strictly 2-layer stack actually makes things simpler anyway :-)

Using 'raw' there will make the block layer auto-detect the right
protocol layer, so this works. If you want to avoid the second layer,
you'd have to figure out manually whether to use 'file' or
'host_device'.

Kevin
