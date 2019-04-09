Received: from eggs.gnu.org ([209.51.188.92]:56775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDqSb-0003Wo-Qo
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hDqSZ-00081w-TH
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:06:45 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <15f8499f-812d-1bf9-ad22-21971687826a@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w511s2cy08l.fsf@maestria.local.igalia.com>
	<15f8499f-812d-1bf9-ad22-21971687826a@virtuozzo.com>
Date: Tue, 09 Apr 2019 15:06:17 +0200
Message-ID: <w51ef6b49bq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 3/3] block/stream: introduce a bottom
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Mon 08 Apr 2019 08:17:37 PM CEST, Andrey Shinkevich wrote:
>>> +    for (iter = bs; iter != bottom; iter = backing_bs(iter)) {
>>> +        block_job_add_bdrv(&s->common, "intermediate node", backing_bs(iter),
>>> +                           0, basic_flags, &error_abort);
>>>       }
>> 
>> This stops when iter == bottom, so bottom is not actually blocked.
>
> The bottom is actually blocked because backing_bs(iter) == bottom is
> passed to the block_job_add_bdrv() with the last iteration of the
> loop.

Right, I hadn't noticed that you are passing backing_bs(iter) to
block_job_add_bdrv() now.

Berto
