Received: from eggs.gnu.org ([209.51.188.92]:56021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjQdJ-0004t4-E9
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjQdG-0003oq-S2
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:28:05 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190114111744.113188-10-anton.nefedov@virtuozzo.com>
References: <20190114111744.113188-1-anton.nefedov@virtuozzo.com>
	<20190114111744.113188-10-anton.nefedov@virtuozzo.com>
Date: Tue, 15 Jan 2019 16:27:59 +0100
Message-ID: <w5136pu54ao.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 09/10] qcow2: skip writing zero buffers
 to empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Mon 14 Jan 2019 12:18:30 PM CET, Anton Nefedov wrote:
> If COW areas of the newly allocated clusters are zeroes on the backing image,
> efficient bdrv_write_zeroes(flags=BDRV_REQ_ALLOCATE) can be used on the whole
> cluster instead of writing explicit zero buffers later in perform_cow().
>
> iotest 060:
> write to the discarded cluster does not trigger COW anymore.
> Use a backing image instead.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

> +        ret = handle_alloc_space(bs, l2meta);

I insist that it would be nice to have a short comment explaining what
this does.

Berto
