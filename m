Received: from eggs.gnu.org ([2001:4830:134:3::10]:43771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erPq2-00070z-HU
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erPpy-0005dl-JS
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:09:42 -0500
Date: Thu, 1 Mar 2018 16:09:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180301150921.GE4862@localhost.localdomain>
References: <20180216165015.30715-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216165015.30715-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/5] block: fix blk_aio_*() segfault
 when blk->root == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, mark.kanda@oracle.com, qemu-block@nongnu.org

Am 16.02.2018 um 17:50 hat Stefan Hajnoczi geschrieben:
> v3:
>  * Add Patch 1 to rename aio_context_in_iothread() to
>    in_aio_context_home_thread() [Eric]
> v2:
>  * Introduce AIO_WAIT_WHILE() since aio_poll(ctx, true) is not allowed [Paolo]
> 
> Using bdrv_inc_in_flight(blk_bs(blk)) doesn't work since BlockBackend->root may
> be NULL.
> 
> This patch series solves the issue by adding an BlockBackend->in_flight counter
> so requests can be tracked even when there is no BlockDriverState.
> 
> This should fix the IDE and virtio-blk segfaults that have been encountered
> when there is no BlockDriverState.
> 
> The patch is based on work by Kevin Wolf.

Thanks, applied to the block branch.

Kevin
