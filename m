Received: from eggs.gnu.org ([2001:4830:134:3::10]:55982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr6og-0002x2-9z
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:46:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cr6of-0005y8-J3
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:46:30 -0400
Date: Thu, 23 Mar 2017 18:46:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170323174620.GC5344@noname.redhat.com>
References: <20170308191434.2413-1-mreitz@redhat.com>
	<20170308191434.2413-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170308191434.2413-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.10 2/4] block: Add errp to b{lk,
 drv}_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Am 08.03.2017 um 20:14 hat Max Reitz geschrieben:
> For one thing, this allows us to drop the error message generation from
> qemu-img.c and blockdev.c and instead have it unified in
> bdrv_truncate().
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6a92d2ef3f..43b8a986f0 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2294,9 +2294,8 @@ static int qcow2_create2(const char *filename, int64_t total_size,
>      }
>  
>      /* Okay, now that we have a valid image, let's give it the right size */
> -    ret = blk_truncate(blk, total_size);
> +    ret = blk_truncate(blk, total_size, errp);
>      if (ret < 0) {
> -        error_setg_errno(errp, -ret, "Could not resize image");

Maybe error_prepend(errp, "Could not resize image: ") could make sense?

>          goto out;
>      }

Kevin
