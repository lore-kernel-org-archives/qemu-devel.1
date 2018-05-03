Received: from eggs.gnu.org ([2001:4830:134:3::10]:40066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=654c6ac3d=anthony.perard@citrix.com>)
	id 1fEAxR-00066X-S5
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=654c6ac3d=anthony.perard@citrix.com>)
	id 1fEAxN-0002IN-SZ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:55:25 -0400
Date: Thu, 3 May 2018 10:55:17 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180503095517.GE14376@perard>
References: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
	<20180502155816.GD14376@perard>
	<683868567d3f4ed5a0f5eae7c0d2d4a3@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <683868567d3f4ed5a0f5eae7c0d2d4a3@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH 0/4] block/xen_disk: legacy code removal
 and cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed, May 02, 2018 at 05:03:09PM +0100, Paul Durrant wrote:
> > -----Original Message-----
> > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > Sent: 02 May 2018 16:58
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: xen-devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-
> > devel@nongnu.org; Stefano Stabellini <sstabellini@kernel.org>; Kevin Wolf
> > <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>
> > Subject: Re: [PATCH 0/4] block/xen_disk: legacy code removal and cleanup
> > 
> > On Mon, Apr 30, 2018 at 01:01:35PM +0100, Paul Durrant wrote:
> > > The grant copy operation was added to libxengnttab in Xen 4.8.0 (released
> > > nearly 18 months ago) but the xen_disk PV backend QEMU is still carrying
> > > a significant amount of code purely to remain compatible with older
> > > versions of Xen.
> > >
> > > As can be inferred from the diff stats below, removing this support for
> > > older versions of Xen from QEMU reduces the size of the xen_disk source
> > by
> > > more than 350 lines (~25%). The majority of this is done in patches #1
> > > and #2. Further simplifications are made in patch #3 and then some
> > cosmetic
> > > work is done in patch #4.
> > 
> > FIY, I don't like this patch series. We've been checking that QEMU
> > builds against older version. I've check that it builds against 4.5 and
> > newer.
> > 
> 
> Ok, I can grant copy emulation in QEMU then should it not exist for the particular Xen/OS combo.
> 
> > Also the fact that FreeBSD doesn't have support for grant copy probably
> > mean that it is too soon to remove the compatibility code from qemu.
> > 
> 
> On another thread I'd already agreed to emulate grant copy in libxengnttab for those OS where it is not supported, but if you prefer it to be in QEMU I'll put it there.

Yes, I think it will be better from QEMU point of view.

Thanks,

-- 
Anthony PERARD
