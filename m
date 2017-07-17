Received: from eggs.gnu.org ([2001:4830:134:3::10]:33125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX8WI-0001af-M9
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dX8WH-0004Kx-St
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:05:14 -0400
Date: Mon, 17 Jul 2017 18:05:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170717160503.GL5301@noname.redhat.com>
References: <20170717130130.29211-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717130130.29211-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v1] ide: check BlockBackend
 object in ide_cancel_dma_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org, Chensongnian <chensongnian@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

Am 17.07.2017 um 15:01 hat P J P geschrieben:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> When cancelling pending DMA requests in ide_cancel_dma_sync,
> the s->blk object could be null, leading to a null dereference.
> Add check to avoid it.
> 
>   blk_bs (blk=0x0) at block/block-backend.c:389
>   blk_drain (blk=0x0) at block/block-backend.c:1232
>   ide_cancel_dma_sync (s=0x7f203241c1a8) at hw/ide/core.c:684
>   bmdma_cmd_writeb (bm=0x7f203241cf20, val=104) at hw/ide/pci.c:237
>   bmdma_write (opaque=0x7f203241cf20, addr=0, val=104, size=1) at hw/ide/piix.c:77
> 
> Reported-by: Chensongnian <chensongnian@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ide/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Update: add call stack trace leading the null dereference.

I think Stefan didn't only mean a stack trace, but an actual instruction
how to reproduce this. VM configuration, what actions to take, etc.

In fact, I will add that we will probably want a qtest case as a
regression test anyway, and tests are always great for describing how to
reproduce a problem, too.

Kevin
