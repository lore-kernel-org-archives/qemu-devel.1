Received: from eggs.gnu.org ([2001:4830:134:3::10]:43645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecFE1-0003kI-Gk
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecFDx-00066I-OC
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:47:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ecFDx-00065o-IJ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:47:41 -0500
References: <20180118131308.GA2181@liangdeMacBook-Pro.local>
From: John Snow <jsnow@redhat.com>
Message-ID: <0429bcd2-ad16-5b8c-c944-d002f68dd3ba@redhat.com>
Date: Thu, 18 Jan 2018 13:47:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180118131308.GA2181@liangdeMacBook-Pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH resend] hbitmap: fix missing restore count
 when finish deserialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Weiping Zhang <zhangweiping@didichuxing.com>



On 01/18/2018 08:13 AM, Liang Li wrote:
> The .count of HBitmap is forgot to set in function
> hbitmap_deserialize_finish, let's set it to the right value.
> 
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
> 
> ---
>  util/hbitmap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 289778a..58a2c93 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -630,6 +630,7 @@ void hbitmap_deserialize_finish(HBitmap *bitmap)
>      }
>  
>      bitmap->levels[0][0] |= 1UL << (BITS_PER_LONG - 1);
> +    bitmap->count = hb_count_between(bitmap, 0, bitmap->size - 1);
>  }
>  
>  void hbitmap_free(HBitmap *hb)
> 

Reviewed-by: John Snow <jsnow@redhat.com>

and

Thanks, applied to my bitmaps tree:

https://github.com/jnsnow/qemu/commits/bitmaps
https://github.com/jnsnow/qemu.git

--js
