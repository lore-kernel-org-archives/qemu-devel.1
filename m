Received: from eggs.gnu.org ([2001:4830:134:3::10]:40016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6518dd5c5=roger.pau@citrix.com>)
	id 1fDAsq-0000GS-P1
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6518dd5c5=roger.pau@citrix.com>)
	id 1fDAsm-000117-M8
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:38:32 -0400
Date: Mon, 30 Apr 2018 16:28:26 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Message-ID: <20180430152826.puhl4lzvbdpdmomj@MacBook-Pro-de-Roger.local>
References: <1525089699-13411-1-git-send-email-paul.durrant@citrix.com>
	<1525089699-13411-3-git-send-email-paul.durrant@citrix.com>
	<20180430151145.iyou5pisaclvvn3v@MacBook-Pro-de-Roger.local>
	<dfeffd8d0d9f46fbbed1abb2bdaccd27@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dfeffd8d0d9f46fbbed1abb2bdaccd27@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 2/4] block/xen_disk: remove use
 of grant map/unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>

On Mon, Apr 30, 2018 at 04:16:52PM +0100, Paul Durrant wrote:
> > -----Original Message-----
> > From: Roger Pau Monne
> > Sent: 30 April 2018 16:12
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: xen-devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-
> > devel@nongnu.org; Anthony Perard <anthony.perard@citrix.com>; Kevin
> > Wolf <kwolf@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>; Max
> > Reitz <mreitz@redhat.com>
> > Subject: Re: [Xen-devel] [PATCH 2/4] block/xen_disk: remove use of grant
> > map/unmap
> > 
> > On Mon, Apr 30, 2018 at 01:01:37PM +0100, Paul Durrant wrote:
> > > The grant copy operation was added to libxengnttab in Xen 4.8.0. If grant
> > > copy is available then data from the guest will be copied rather than
> > > mapped.
> > > The xen_disk source can be significantly simplified by removing this now
> > > redundant code.
> > 
> > Hm, I know this is a PITA, but FreeBSD gntdev hasn't implemented the
> > grant-copy operation yet.
> > 
> > I could try to implement it, but I can't make any promises on the time
> > ATM, since I'm quite busy.
> > 
> 
> I guess we could carry a compat patch in QEMU that implements grant copy by doing a map/memcpy/unmap , but QEMU feels like the wrong place for that. I could try putting together a similar patch for the freebsd.c component of libxengnttab in the xen source rather than it simply failing with ENOSYS as it does now. Would either of those help?

Maybe this could be implemented in gnttab_core.c, so it can also be
used by MiniOS and Linux versions not supporting the copy ioctl as a
fallback?

Roger.
