Received: from eggs.gnu.org ([2001:4830:134:3::10]:40803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gK3KU-0004Kc-VS
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gK3KF-000115-4L
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:31:39 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <e1d4fa92-9f84-080c-04e3-4fc9b683c11d@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
	<20181101182738.70462-7-vsementsov@virtuozzo.com>
	<w514lcudz3y.fsf@maestria.local.igalia.com>
	<e1d4fa92-9f84-080c-04e3-4fc9b683c11d@virtuozzo.com>
Date: Tue, 06 Nov 2018 16:30:40 +0100
Message-ID: <w511s7ydxzz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 6/7] qcow2: aio support for
 compressed cluster read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>

On Tue 06 Nov 2018 04:13:58 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> 06.11.2018 18:06, Alberto Garcia wrote:
>> On Thu 01 Nov 2018 07:27:37 PM CET, Vladimir Sementsov-Ogievskiy wrote:
>>
>>> +    buf = g_try_malloc(csize);
>>> +    if (!buf) {
>>> +        return -ENOMEM;
>>> +    }
>>> +    iov.iov_base = buf;
>>> +    iov.iov_len = csize;
>>> +    qemu_iovec_init_external(&local_qiov, &iov, 1);
>>>   
>>> -        iov.iov_base = s->cluster_data;
>>> -        iov.iov_len = csize;
>>> -        qemu_iovec_init_external(&local_qiov, &iov, 1);
>>> +    out_buf = qemu_blockalign(bs, s->cluster_size);
>> You should also check whether out_buf is NULL, shouldn't you?
>
> No, it will abort on fail. qemu_try_blockalign result should be
> checked.

Is there any reason why some parts of the QEMU code use qemu_blockalign
and others qemu_try_blockalign() ? From what I can see it seems to be up
to whoever wrote it...

Berto
