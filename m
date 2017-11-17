Received: from eggs.gnu.org ([2001:4830:134:3::10]:53811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFkNH-000279-Cr
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:24:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFkNG-0007Ib-CV
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:24:19 -0500
Date: Fri, 17 Nov 2017 18:24:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171117172404.GJ4795@localhost.localdomain>
References: <20171117164747.11525-1-eblake@redhat.com>
	<600d87a3-93a9-5d5d-7a9f-a31ba213348b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <600d87a3-93a9-5d5d-7a9f-a31ba213348b@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] qcow2: fix image corruption on
 commit with persistent snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 17.11.2017 um 18:07 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 17.11.2017 19:47, Eric Blake wrote:
> > If an image contains persistent snapshots, we cannot use the
> 
> bitmaps
> 
> > fast path of bdrv_make_empty() to clear the image during
> > qemu-img commit, because that will lose the clusters related
> > to the bitmaps.
> > 
> > Also leave a comment in qcow2_read_extensions to remind future
> > feature additions to think about fast-path removal, since we
> > just barely fixed the same bug for LUKS encryption.
> > 
> > It's a pain that qemu-img has not yet been taught to manipulate,
> > or even at a very minimum display, information about persistent
> > bitmaps; instead, we have to use QMP commands.  It's also a
> > pain that only qeury-block and x-debug-block-dirty-bitmap-sha256
> > will allow bitmap introspection; but the former requires the
> > node to be hooked to a block device, and the latter is experimental.
> 
> sorry for that pain =(.
> 
> Honestly, I don't understand why such a simple and obvious fix needs an
> additional test.

Because we could otherwise accidentally break it again in the future.

If there is a feature that you care about, make sure to have a test for
everything in it, and that you add a regression test for every bug that
you fix.

Kevin
