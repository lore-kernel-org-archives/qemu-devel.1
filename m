Received: from eggs.gnu.org ([2001:4830:134:3::10]:40919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNfsJ-0001iy-Gb
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fNfsF-0004t8-Hw
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:45:23 -0400
Date: Tue, 29 May 2018 10:45:07 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180529144507.GB31815@localhost.localdomain>
References: <20180525163327.23097-1-kwolf@redhat.com>
	<20180525163327.23097-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525163327.23097-2-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/14] vdi: Fix
 vdi_co_do_create() return value
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

On Fri, May 25, 2018 at 06:33:14PM +0200, Kevin Wolf wrote:
> .bdrv_co_create() is supposed to return 0 on success, but vdi could
> return a positive value instead. Fix this.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vdi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/vdi.c b/block/vdi.c
> index 96a22b8e83..668af0a828 100644
> --- a/block/vdi.c
> +++ b/block/vdi.c
> @@ -865,6 +865,7 @@ static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
>          }
>      }
>  
> +    ret = 0;
>  exit:
>      blk_unref(blk);
>      bdrv_unref(bs_file);
> -- 
> 2.13.6
> 
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
