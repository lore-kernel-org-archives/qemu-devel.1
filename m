Received: from eggs.gnu.org ([2001:4830:134:3::10]:52723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGnPi-0004kR-Kt
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGnPf-0000H1-EH
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:18:54 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:45865 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dGnPf-0000Ew-2B
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:18:51 -0400
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
	<20170531165541.47338-2-vsementsov@virtuozzo.com>
	<70aa332e-c868-15ac-0c4c-23d41a777b6c@redhat.com>
	<76a74826-f9ed-825e-0d3d-3043943d636c@virtuozzo.com>
	<8e900b35-65a9-789f-2cf4-9de6d16460a3@virtuozzo.com>
	<40ed0b31-84b7-380f-65ce-bc79de780c04@redhat.com>
	<ec8e6b9b-29e5-dc07-17cb-bdcd2ad8fc14@virtuozzo.com>
	<0eaa8f22-e16f-8701-cf55-992b7116c80f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d6cdf362-fa16-0f01-98ac-ff2f6b4a9a76@virtuozzo.com>
Date: Fri, 2 Jun 2017 17:18:47 +0300
MIME-Version: 1.0
In-Reply-To: <0eaa8f22-e16f-8701-cf55-992b7116c80f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 01/12] nbd: rename read_sync and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

02.06.2017 17:15, Eric Blake wrote:
> On 06/02/2017 08:54 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Finally, are you OK with my wording? If I reroll, can I add your r-b?
>>> What final wording are you proposing (full paragraph, not a snippet)?
>> 2. _sync suffix
>>     _sync is related to the fact that nbd_wr_syncv doesn't return if
> s/if/if a/
>
>>     write to socket returns EAGAIN. In first implementation nbd_wr_syncv
> s/In first implementation/The first implementation of/
>
>>     (was wr_sync in 7a5ca8648b) just loops while getting EAGAIN, current
> s/current/the current/
>
>>     implementation yields in this case.
>>     Why to get rid of it:
> maybe: s/Why/Why we want/
>
>>     - it is normal for r/w functions to be synchronous, so having
> s/having/having an/
>
>>       additional suffix for it looks redundant (contrariwise, we have
>>       _aio suffix for async functions)
>>     - _sync suffix in block layer is used when function does flush (so
>>       using it for other thing is confusing a bit)
>>     - keep function names short after adding nbd_ prefix
> Thanks for bearing with me, and letting me help on the grammar subtleties.

No problem, thank you too)

>
>>>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> At any rate, I already gave R-b for the code, so finessing the commit
>>> message doesn't change that if the code remains unchanged.
>>>

-- 
Best regards,
Vladimir
