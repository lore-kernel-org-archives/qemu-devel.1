Received: from eggs.gnu.org ([2001:4830:134:3::10]:38082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ccKhp-00056Z-BJ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:34:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ccKho-00084M-8b
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:34:21 -0500
References: <20170203094018.15493-1-vsementsov@virtuozzo.com>
	<20170203094018.15493-13-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <013bd30c-decf-2467-d147-45f53b55401e@redhat.com>
Date: Fri, 10 Feb 2017 18:34:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170203094018.15493-13-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/24] block/dirty-bitmap: add
 bdrv_dirty_bitmap_next()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 02/03/2017 04:40 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/dirty-bitmap.c         | 7 +++++++
>  include/block/dirty-bitmap.h | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 4d026df1bd..fe34d488aa 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -582,3 +582,10 @@ bool bdrv_has_persistent_bitmaps(BlockDriverState *bs)
>  
>      return false;
>  }
> +
> +BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
> +                                        BdrvDirtyBitmap *bitmap)
> +{
> +    return bitmap == NULL ? QLIST_FIRST(&bs->dirty_bitmaps) :
> +                            QLIST_NEXT(bitmap, list);
> +}
> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap.h
> index 8dbd16b040..d71edc4d13 100644
> --- a/include/block/dirty-bitmap.h
> +++ b/include/block/dirty-bitmap.h
> @@ -81,6 +81,9 @@ void bdrv_dirty_bitmap_set_persistance(BdrvDirtyBitmap *bitmap,
>                                                  bool persistent);
>  bool bdrv_dirty_bitmap_get_persistance(BdrvDirtyBitmap *bitmap);
>  
> +BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
> +                                        BdrvDirtyBitmap *bitmap);
> +
>  bool bdrv_has_persistent_bitmaps(BlockDriverState *bs);
>  
>  #endif
> 

Reviewed-by: John Snow <jsnow@redhat.com>
