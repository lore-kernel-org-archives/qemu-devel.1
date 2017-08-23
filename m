Received: from eggs.gnu.org ([2001:4830:134:3::10]:56746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dkXT7-0000NB-8I
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dkXT3-000121-2p
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:21:21 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:47256 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dkXT2-0000yW-NM
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:21:17 -0400
References: <20170815150907.21495-1-eblake@redhat.com>
	<20170815150907.21495-8-eblake@redhat.com>
	<aca0bbb8-0893-c02a-c3cb-b85fa431437b@virtuozzo.com>
	<7e7d839d-7ae7-9b92-7830-d568eb8f1be2@virtuozzo.com>
	<a206b659-b7b7-912a-bbb3-e9b5edee8635@virtuozzo.com>
	<ee37fd0d-453e-4854-e67e-7a4f50ea1505@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <06901d57-2fb8-c21b-20c6-5e0a3f51082b@virtuozzo.com>
Date: Wed, 23 Aug 2017 18:21:09 +0300
MIME-Version: 1.0
In-Reply-To: <ee37fd0d-453e-4854-e67e-7a4f50ea1505@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] nbd-client: Fix regression when server sends
 garbage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

23.08.2017 18:17, Eric Blake wrote:
> On 08/23/2017 10:09 AM, Vladimir Sementsov-Ogievskiy wrote:
>> ping
>>
> We're still trying to round up last-minute patches for a 2.10-rc4 pull
> request.


>
>
>>>>> @@ -107,6 +107,9 @@ static coroutine_fn void
>>>>> nbd_read_reply_entry(void *opaque)
>>>>>            qemu_coroutine_yield();
>>>>>        }
>>>>>
>>>>> +    if (ret < 0) {
>>>>> +        s->quit =3D true;
>>>> but on wrong handle ret is 0:
>>> s/0/positive/
>>>
> Is your issue fixed by Stefan's patch?
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04027.html


Yes it fixed,=C2=A0 I'm now composing reply on it.

>
> In fact, he listed a reproduction formula in his earlier attempt at it,
> that demonstrates that we still had a hang possible with just what made
> it into -rc3
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03853.html
>

--=20
Best regards,
Vladimir
