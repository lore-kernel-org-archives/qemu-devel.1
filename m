Received: from eggs.gnu.org ([2001:4830:134:3::10]:40771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNfrq-0001H4-G6
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNfrp-0004Xs-H5
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:44:54 -0400
Date: Tue, 29 May 2018 10:44:46 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180529144446.GA31815@localhost.localdomain>
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-3-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525163327.23097-3-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/14] vhdx: Fix
 vhdx_co_create() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

On Fri, May 25, 2018 at 06:33:15PM +0200, Kevin Wolf wrote:
> .bdrv_co_create() is supposed to return 0 on success, but vhdx could
> return a positive value instead. Fix this.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vhdx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 0b1e21c750..b1ba121bb6 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1951,7 +1951,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
>          goto delete_and_exit;
>      }
>  
> -
> +    ret = 0;
>  delete_and_exit:
>      blk_unref(blk);
>      bdrv_unref(bs);
> -- 
> 2.13.6
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
