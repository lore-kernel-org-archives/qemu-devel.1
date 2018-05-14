Received: from eggs.gnu.org ([2001:4830:134:3::10]:44483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fICfv-0005Hd-3O
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fICfr-00012e-Ub
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:33:59 -0400
References: <20180512012537.22478-1-jsnow@redhat.com>
	<20180512012537.22478-3-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8dab36a9-9719-1df7-19fc-cc4063ead191@virtuozzo.com>
Date: Mon, 14 May 2018 15:33:48 +0300
MIME-Version: 1.0
In-Reply-To: <20180512012537.22478-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC PATCH 02/12] qcow2/dirty-bitmap: cache loaded
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

12.05.2018 04:25, John Snow wrote:
> For bitmaps that we succeeded in loading, we can cache a reference
> to that object. This will let us iterate over the more convenient
> form of in-memory bitmaps for qemu-img bitmap manipulation tools.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   block/qcow2-bitmap.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index fb0a4f3ec4..d89758f235 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -986,6 +986,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>               if (bitmap == NULL) {
>                   goto fail;
>               }
> +            bm->dirty_bitmap = bitmap;
>   
>               if (!(bm->flags & BME_FLAG_AUTO)) {
>                   bdrv_disable_dirty_bitmap(bitmap);

Looks correct, I just suppose to reuse this information somehow in 
qcow2_store_persistent_dirty_bitmaps, at least for an assert.

-- 
Best regards,
Vladimir
