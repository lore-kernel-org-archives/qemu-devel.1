Received: from eggs.gnu.org ([2001:4830:134:3::10]:50748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ec8YF-0003y8-Ua
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:40:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ec8Y9-0007Yb-VN
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:40:12 -0500
Received: from mail-he1eur01on0713.outbound.protection.outlook.com
	([2a01:111:f400:fe1e::713]:57854
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ec8Y9-0007WV-9U
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:40:05 -0500
References: <20180118105841.GA1897@liangdeMacBook-Pro.local>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b0c18bba-7688-13f9-5578-bedcd5ba8622@virtuozzo.com>
Date: Thu, 18 Jan 2018 14:39:58 +0300
MIME-Version: 1.0
In-Reply-To: <20180118105841.GA1897@liangdeMacBook-Pro.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hbitmap: fix missing restore count when
 finish deserialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Li <liliangleo@didichuxing.com>, famz@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org

18.01.2018 13:58, Liang Li wrote:
> The .count of HBitmap is forgot to set in function
> hbitmap_deserialize_finish, let's set it to the right value.
>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
> Signed-off-by: Liang Li <liliangleo@didichuxing.com>
> ---
>   util/hbitmap.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index 289778a..58a2c93 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -630,6 +630,7 @@ void hbitmap_deserialize_finish(HBitmap *bitmap)
>       }
>   
>       bitmap->levels[0][0] |= 1UL << (BITS_PER_LONG - 1);
> +    bitmap->count = hb_count_between(bitmap, 0, bitmap->size - 1);
>   }
>   
>   void hbitmap_free(HBitmap *hb)

Hm, right, my fault. Thank you!

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir
