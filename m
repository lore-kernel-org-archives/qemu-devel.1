Received: from eggs.gnu.org ([2001:4830:134:3::10]:56464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceKBX-0003fz-BX
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceKBW-0005wZ-MM
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:25:15 -0500
Date: Thu, 16 Feb 2017 12:25:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170216112506.GB4869@noname.redhat.com>
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-9-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487153430-17260-9-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v15 08/25] block: introduce auto-loading
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Auto loading bitmaps are bitmaps stored in the disk image, which should
> be loaded when the image is opened and become BdrvDirtyBitmaps for the
> corresponding drive.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Why do we need a new BlockDriver callback and special code for it in
bdrv_open_common()? The callback is only ever called immediately after
.bdrv_open/.bdrv_file_open, so can't the drivers just do this internally
in their .bdrv_open implementation? Even more so because qcow2 is the
only driver that supports this callback.

Kevin
