Received: from eggs.gnu.org ([2001:4830:134:3::10]:48327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5U13-0003FO-T8
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5U0z-0002Ut-UM
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:27:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1f5U0z-0002UV-OX
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 06:27:09 -0400
Date: Mon, 9 Apr 2018 12:27:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180409102701.GE5294@localhost.localdomain>
References: <20180327130846.21902-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327130846.21902-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block-backend: simplify
 blk_get_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com

Am 27.03.2018 um 15:08 hat Daniel Henrique Barboza geschrieben:
> blk_get_aio_context verifies if BlockDriverState bs is not NULL,
> return bdrv_get_aio_context(bs) if true or qemu_get_aio_context()
> otherwise. However, bdrv_get_aio_context from block.c already does
> this verification itself, also returning qemu_get_aio_context()
> if bs is NULL:
> 
> AioContext *bdrv_get_aio_context(BlockDriverState *bs)
> {
>     return bs ? bs->aio_context : qemu_get_aio_context();
> }
> 
> This patch simplifies blk_get_aio_context to simply call
> bdrv_get_aio_context instead of replicating the same logic.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Thanks, applied to the block-next branch.

Kevin
