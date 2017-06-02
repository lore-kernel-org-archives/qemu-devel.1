Received: from eggs.gnu.org ([2001:4830:134:3::10]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGtil-0005Mb-Ed
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dGtik-000403-MX
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 17:02:59 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-10-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e45c747d-240d-4a31-8935-ae8c42af16ea@redhat.com>
Date: Fri, 2 Jun 2017 17:02:45 -0400
MIME-Version: 1.0
In-Reply-To: <20170602112158.232757-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v20 09/30] block/dirty-bitmap: fix comment
 for BlockDirtyBitmap.disabled field
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



On 06/02/2017 07:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 90af37287f..f25428868c 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -42,7 +42,8 @@ struct BdrvDirtyBitmap {
>      BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
>      char *name;                 /* Optional non-empty unique ID */
>      int64_t size;               /* Size of the bitmap (Number of sectors) */
> -    bool disabled;              /* Bitmap is read-only */
> +    bool disabled;              /* Bitmap is disabled. It skips all writes to
> +                                   the device */


Or, "Bitmap is disabled. Writes to the device are ignored." or similar.

It's not very important.

Reviewed-by: John Snow <jsnow@redhat.com>

>      int active_iterators;       /* How many iterators are active */
>      QLIST_ENTRY(BdrvDirtyBitmap) list;
>  };
> 
