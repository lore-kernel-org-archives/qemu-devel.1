Received: from eggs.gnu.org ([209.51.188.92]:35892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDVol-0002kw-7H
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDVoe-0003sN-K4
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:04:13 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Mon, 08 Apr 2019 17:03:44 +0200
Message-ID: <w517ec4y1wv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block: include base when checking
 image chain for block allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On Fri 05 Apr 2019 06:56:17 PM CEST, Andrey Shinkevich wrote:
> +int bdrv_is_allocated_above(BlockDriverState *top,
> +                            BlockDriverState *base,
> +                            int64_t offset, int64_t bytes, int64_t *pnum)
> +{
> +    return bdrv_do_is_allocated_above(top, base, false, offset, bytes, pnum);
> +}
> +
> +int bdrv_is_allocated_above_inclusive(BlockDriverState *top,
> +                                      BlockDriverState *base,
> +                                      int64_t offset, int64_t bytes,
> +                                      int64_t *pnum)
> +{
> +    return bdrv_do_is_allocated_above(top, base, true, offset, bytes, pnum);
> +}

Instead of having these two, isn't it simpler to add an 'include_base'
parameter to the original function?

Another alternative (I haven't checked this one so it could be more
cumbersome): change the semantics of the function to always include the
base and modify the callers.

Berto
