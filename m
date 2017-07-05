Received: from eggs.gnu.org ([2001:4830:134:3::10]:38846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dShwu-0001U4-RJ
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dShwq-000641-1B
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:54:24 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dShwp-00063b-RE
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:54:19 -0400
Received: by mail-wm0-f41.google.com with SMTP id 70so31119546wmo.1
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 03:54:19 -0700 (PDT)
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-9-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ffefaff-3c04-9328-a27b-332d30153b0a@redhat.com>
Date: Wed, 5 Jul 2017 12:53:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170704220346.29244-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/35] block: all bdrv_aio callbacks are
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 05/07/2017 00:03, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/block/block_int.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 15fa602150..93eb2a9528 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -133,15 +133,15 @@ struct BlockDriver {
>      void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
>  
>      /* aio */
> -    BlockAIOCB *(*bdrv_aio_readv)(BlockDriverState *bs,
> +    BlockAIOCB * coroutine_fn (*bdrv_aio_readv)(BlockDriverState *bs,
>          int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
>          BlockCompletionFunc *cb, void *opaque);
> -    BlockAIOCB *(*bdrv_aio_writev)(BlockDriverState *bs,
> +    BlockAIOCB * coroutine_fn (*bdrv_aio_writev)(BlockDriverState *bs,
>          int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
>          BlockCompletionFunc *cb, void *opaque);
> -    BlockAIOCB *(*bdrv_aio_flush)(BlockDriverState *bs,
> +    BlockAIOCB * coroutine_fn (*bdrv_aio_flush)(BlockDriverState *bs,
>          BlockCompletionFunc *cb, void *opaque);
> -    BlockAIOCB *(*bdrv_aio_pdiscard)(BlockDriverState *bs,
> +    BlockAIOCB * coroutine_fn (*bdrv_aio_pdiscard)(BlockDriverState *bs,
>          int64_t offset, int bytes,
>          BlockCompletionFunc *cb, void *opaque);
>  
> @@ -247,7 +247,7 @@ struct BlockDriver {
>      void (*bdrv_lock_medium)(BlockDriverState *bs, bool locked);
>  
>      /* to control generic scsi devices */
> -    BlockAIOCB *(*bdrv_aio_ioctl)(BlockDriverState *bs,
> +    BlockAIOCB * coroutine_fn (*bdrv_aio_ioctl)(BlockDriverState *bs,
>          unsigned long int req, void *buf,
>          BlockCompletionFunc *cb, void *opaque);
>      int coroutine_fn (*bdrv_co_ioctl)(BlockDriverState *bs,
> 


They are, but it's an implementation detail.  Why is this patch necessary?

Thanks,

Paolo
