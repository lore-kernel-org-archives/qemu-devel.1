Received: from eggs.gnu.org ([209.51.188.92]:45024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gm1nB-0007fN-Ng
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gm1lu-0005k5-2q
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:31:44 -0500
Date: Tue, 22 Jan 2019 15:46:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190122144617.GA5220@localhost.localdomain>
References: <1545149484-4929-1-git-send-email-thuth@redhat.com>
	<25d1e73d-ca73-9cb4-d959-8353f49f36b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25d1e73d-ca73-9cb4-d959-8353f49f36b7@redhat.com>
Subject: Re: [Qemu-devel] [QEMU PATCH] block: Remove blk_attach_dev_legacy()
 / legacy_dev code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, paul.durrant@citrix.com

Am 22.01.2019 um 15:19 hat Thomas Huth geschrieben:
> On 2018-12-18 17:11, Thomas Huth wrote:
> > The last user of blk_attach_dev_legacy() is the code in xen_disk.c.
> > It passes a pointer to a XenBlkDev as second parameter. XenBlkDev
> > is derived from XenDevice which in turn is derived from DeviceState
> > since commit 3a6c9172ac5951e ("xen: create qdev for each backend device").
> > Thus the code can also simply use blk_attach_dev() with a pointer
> > to the DeviceState instead.
> > So we can finally remove all code related to the "legacy_dev" flag, too,
> > and turn the related "void *" in block-backend.c into "DeviceState *"
> > to fix some of the remaining TODOs there.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  Note: I haven't tested the Xen code since I don't have a working Xen
> >  installation at hand. I'd appreciate if someone could check it...
> 
> Ping?

This needs a rebase. xen_disk.c doesn't even exist any more and
blk_attach_dev_legacy() is really dead code now.

The work on the Xen block device is the reason why I didn't merge this
patch yet. I thought I had sent a reply to that effect, but it seems I
hadn't. Sorry for that!

Kevin
