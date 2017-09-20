Received: from eggs.gnu.org ([2001:4830:134:3::10]:60278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufzL-0008Ti-Ah
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dufzK-0002Rp-GA
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:28:31 -0400
Date: Wed, 20 Sep 2017 15:28:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170920142816.GE9409@stefanha-x1.localdomain>
References: <20170920102311.25736-1-el13635@mail.ntua.gr>
	<20170920102311.25736-2-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920102311.25736-2-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 1/3] block: add bdrv_co_drain_end callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>

On Wed, Sep 20, 2017 at 01:23:09PM +0300, Manos Pitsidianakis wrote:
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index ba4c383393..ea1326e3c7 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -359,6 +359,8 @@ struct BlockDriver {
>       */
>      void coroutine_fn (*bdrv_co_drain)(BlockDriverState *bs);
>  
> +    void coroutine_fn (*bdrv_co_drain_end)(BlockDriverState *bs);

Please update the doc comment to describe the environment under which
begin() and end() are invoked.  It should be clear when to implement
begin() and/or end().
