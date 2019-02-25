Received: from eggs.gnu.org ([209.51.188.92]:37604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyDg9-0008GH-FE
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyDg8-0007sV-IS
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 05:40:09 -0500
Date: Mon, 25 Feb 2019 11:31:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190225103105.GA6320@linux.fritz.box>
References: <20190220174843.8847-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220174843.8847-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/13] block: bdrv_set_aio_context()
 related fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Am 20.02.2019 um 18:48 hat Kevin Wolf geschrieben:
> Background for this series is the following bug report, which is about a
> crash with virtio-blk + iothread and request resubmission for werror/rerror:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1671173
> 
> The reason is that bdrv_set_aio_context() didn't correctly quiesce
> everything. Instead, it had a local hack to call aio_poll() for the
> source AioContext, which covered some, but not all cases, and is wrong
> because you can only call aio_poll() from the home thread.
> 
> So this series tries to make bdrv_drain() actually drain the known cases
> (fixes virtio-blk and the NBD client) and use the regular drain
> functions in bdrv_set_aio_context() instead of open-coding something
> similar.

Applied to the block branch.

Kevin
