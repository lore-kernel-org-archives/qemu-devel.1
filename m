Received: from eggs.gnu.org ([2001:4830:134:3::10]:60362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3kAU-0000Pg-ID
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d3kAQ-0007Io-Mi
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:13:14 -0400
Date: Thu, 27 Apr 2017 16:13:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170427141302.GG4805@noname.str.redhat.com>
References: <20170413154334.23708-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413154334.23708-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10?] block: Do not unref bs->file on
 error in BD's open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org

Am 13.04.2017 um 17:43 hat Max Reitz geschrieben:
> The block layer takes care of removing the bs->file child if the block
> driver's bdrv_open()/bdrv_file_open() implementation fails. The block
> driver therefore does not need to do so, and indeed should not unless it
> sets bs->file to NULL afterwards -- because if this is not done, the
> bdrv_unref_child() in bdrv_open_inherit() will dereference the freed
> memory block at bs->file afterwards, which is not good.
> 
> We can now decide whether to add a "bs->file = NULL;" after each of the
> offending bdrv_unref_child() invocations, or just drop them altogether.
> The latter is simpler, so let's do that.
> 
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to block-next.

Kevin
