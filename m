Received: from eggs.gnu.org ([209.51.188.92]:56096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hJhVv-0002es-TF
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hJhVv-00087K-0c
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 12:46:23 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190422101900.13897-2-vsementsov@virtuozzo.com>
References: <20190422101900.13897-1-vsementsov@virtuozzo.com>
	<20190422101900.13897-2-vsementsov@virtuozzo.com>
Date: Thu, 25 Apr 2019 18:46:15 +0200
Message-ID: <w51bm0u119k.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/3] block: include base when checking
 image chain for block allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, den@openvz.org, andrey.shinkevich@virtuozzo.com

On Mon 22 Apr 2019 12:18:58 PM CEST, Vladimir Sementsov-Ogievskiy wrote:
>   * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
>   *
>   * Return true if (a prefix of) the given range is allocated in any image
> - * between BASE and TOP (inclusive).  BASE can be NULL to check if the given
> - * offset is allocated in any image of the chain.  Return false otherwise,
> - * or negative errno on failure.
> + * between BASE and TOP (BASE is only included if include_base is set).
> + * BASE can be NULL to check if the given offset is allocated in any
> + * image of the chain.  Return false otherwise, or negative errno on
> + * failure.

This is a pre-existing problem and probably a bit pedantic, but I just
realized that this description is not quite correct. This function does
not return true and false (bool), but 1 and 0 (int). This is so in order
to be able to return < 0 on errors.

I think I'd replace true and false with 1 and 0 on that message.

Berto
