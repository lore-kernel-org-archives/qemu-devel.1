Received: from eggs.gnu.org ([2001:4830:134:3::10]:45444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dk6Z0-0005VC-C9
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dk6Yx-0003X7-3D
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:37:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dk6Yw-0003Wl-Sg
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:37:35 -0400
Date: Tue, 22 Aug 2017 11:37:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170822103731.GD16799@stefanha-x1.localdomain>
References: <20170528130649.28168-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170528130649.28168-1-dan@kernelim.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Fix get/set number of queues feature, again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Aloni <dan@kernelim.com>
Cc: qemu-devel@nongnu.org, Alex Friedman <alex@e8storage.com>, Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>

On Sun, May 28, 2017 at 04:06:49PM +0300, Dan Aloni wrote:
> The number of queues that should be return by the admin command should:
> 
>   1) Only mention the number of non-admin queues.
>   2) It is zero-based, meaning that '0 == one non-admin queue',
>      '1 == two non-admin queues', and so forth.
> 
> Because our `num_queues` means the number of queues _plus_ the admin
> queue, then the right calculation for the number returned from the admin
> command is `num_queues - 2`, combining the two requirements mentioned.
> 
> The issue was discovered by reducing num_queues from 64 to 8 and running
> a Linux VM with an SMP parameter larger than that (e.g. 22). It tries to
> utilize all queues, and therefore fails with an invalid queue number
> when trying to queue I/Os on the last queue.
> 
> Signed-off-by: Dan Aloni <dan@kernelim.com>
> CC: Alex Friedman <alex@e8storage.com>
> CC: Keith Busch <keith.busch@intel.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/nvme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Sorry for the delay.  Please send future nvme.c patches through Kevin
Wolf:

$ scripts/get_maintainer.pl -f hw/block/nvme.c
Keith Busch <keith.busch@intel.com> (supporter:nvme)
Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
Max Reitz <mreitz@redhat.com> (supporter:Block layer core)
qemu-block@nongnu.org (open list:nvme)
qemu-devel@nongnu.org (open list:All patches CC here)

This patch will be in QEMU 2.11.

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan
