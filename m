Received: from eggs.gnu.org ([209.51.188.92]:54339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjhbr-00072f-8O
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gjhbq-0002SZ-H9
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:35:43 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <9b9b651d-729e-d72f-5335-b9c8121135d3@virtuozzo.com>
References: <20190114111744.113188-1-anton.nefedov@virtuozzo.com>
	<20190114111744.113188-10-anton.nefedov@virtuozzo.com>
	<w5136pu54ao.fsf@maestria.local.igalia.com>
	<9b9b651d-729e-d72f-5335-b9c8121135d3@virtuozzo.com>
Date: Wed, 16 Jan 2019 10:35:38 +0100
Message-ID: <w515zupx7v9.fsf@maestria.local.igalia.com>
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

On Wed 16 Jan 2019 10:32:33 AM CET, Anton Nefedov wrote:
>>> +        ret = handle_alloc_space(bs, l2meta);
>> 
>> I insist that it would be nice to have a short comment explaining
>> what this does.
>
> Right sorry forgot your comment.
> I'd go with:
>
> +        /* Try to efficiently initialize the physical space with zeroes */
>           ret = handle_alloc_space(bs, l2meta);
>           if (ret < 0) {
>               qemu_co_mutex_lock(&s->lock);

That looks good, thanks!

Berto
