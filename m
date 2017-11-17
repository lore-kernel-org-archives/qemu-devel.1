Received: from eggs.gnu.org ([2001:4830:134:3::10]:52264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFkIb-0000Rx-3U
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eFkIa-0002ze-Bd
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:19:29 -0500
Date: Fri, 17 Nov 2017 18:19:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171117171920.GI4795@localhost.localdomain>
References: <20171117164747.11525-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117164747.11525-1-eblake@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>

Am 17.11.2017 um 17:47 hat Eric Blake geschrieben:
> If an image contains persistent snapshots, we cannot use the
> fast path of bdrv_make_empty() to clear the image during
> qemu-img commit, because that will lose the clusters related
> to the bitmaps.
> 
> Also leave a comment in qcow2_read_extensions to remind future
> feature additions to think about fast-path removal, since we
> just barely fixed the same bug for LUKS encryption.
> 
> It's a pain that qemu-img has not yet been taught to manipulate,
> or even at a very minimum display, information about persistent
> bitmaps; instead, we have to use QMP commands.  It's also a
> pain that only qeury-block and x-debug-block-dirty-bitmap-sha256

s/qeury/query/

> will allow bitmap introspection; but the former requires the
> node to be hooked to a block device, and the latter is experimental.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Thanks, fixed the typo above and applied to the block branch.

Kevin
