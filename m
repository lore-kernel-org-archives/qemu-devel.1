Received: from eggs.gnu.org ([2001:4830:134:3::10]:35174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7i3p-00016Y-3R
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7i3o-0001iJ-7C
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:23:33 -0400
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
	<20181001102928.20533-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b34bc12a-cae0-a7a0-36dd-2b6c75c16419@redhat.com>
Date: Wed, 3 Oct 2018 09:23:11 -0500
MIME-Version: 1.0
In-Reply-To: <20181001102928.20533-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/18] block/dirty-bitmap: allow
 set/reset bits in disabled bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

On 10/1/18 5:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> It is needed for use the bitmaps in backup. "disabled" means that
> bitmap is not auto set by writes. Let's allow changing bitmap for other
> uses.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   block/dirty-bitmap.c | 2 --
>   1 file changed, 2 deletions(-)

Looks like this duplicates John's series:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00406.html

> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 89c11111ae..65d2e92ec3 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -532,7 +532,6 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
>   void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>                                     int64_t offset, int64_t bytes)
>   {
> -    assert(bdrv_dirty_bitmap_enabled(bitmap));
>       assert(!bdrv_dirty_bitmap_readonly(bitmap));
>       hbitmap_set(bitmap->bitmap, offset, bytes);
>   }
> @@ -549,7 +548,6 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
>   void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
>                                       int64_t offset, int64_t bytes)
>   {
> -    assert(bdrv_dirty_bitmap_enabled(bitmap));
>       assert(!bdrv_dirty_bitmap_readonly(bitmap));
>       hbitmap_reset(bitmap->bitmap, offset, bytes);
>   }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
