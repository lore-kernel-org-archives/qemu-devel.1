Received: from eggs.gnu.org ([2001:4830:134:3::10]:51462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1df69a-0004qD-1L
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1df69W-0005SS-SS
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:10:41 -0400
References: <20170807141630.105066-1-vsementsov@virtuozzo.com>
	<20170807155717.GI6578@localhost.localdomain>
	<692a163e-acce-e594-896d-da96b7a099e9@virtuozzo.com>
	<20170808085352.GF4850@dhcp-200-186.str.redhat.com>
	<896f8482-6e3a-13e9-4cce-ca115a6c8881@virtuozzo.com>
	<645f5e9d-6a4b-1d7b-6907-6ab27e1ffa7e@virtuozzo.com>
	<51899b88-6b4b-88ce-f820-f62bc944c034@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2983bfe2-0646-2a50-0025-0211c4725f63@virtuozzo.com>
Date: Tue, 8 Aug 2017 18:10:34 +0300
MIME-Version: 1.0
In-Reply-To: <51899b88-6b4b-88ce-f820-f62bc944c034@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 185
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

08.08.2017 18:07, Eric Blake wrote:
> On 08/08/2017 04:04 AM, Vladimir Sementsov-Ogievskiy wrote:
>
>>>>> Throttling "guaranties" that there will not be more than one
>>>>> request. But
>>>>> what prevent less than one, i.e. zero, like in my reproduction?
>>>> Yes, I understand. Can we somehow make sure that at least one iteration
>>>> is made? I'd really like to keep the functional test for block job
>>>> throttling. I suppose a simple 'sleep 0.1' would do the trick, though
>>>> it's not very clean.
>>>>
>>>> Kevin
>>>
>>> I've started with 'sleep 0.5', now there are >100 successful
>>> iterations... The other way is to check in test that there was 0 or 1
>>> requests, but for this it looks better to rewrite it in python.
>>>
>>>
>> is sleep for ms portable?
> Sadly, sub-second sleep is a GNU coreutils feature; I suspect the BSD
> machines may fail to parse it.  (Of course, we could do some sort of
> 'sleep $SMALL', where $SMALL is 0.5 if sleep supports it, and 1 otherwise).
>
sleep for 1 second may lead to more then one request done before qemu quite.


-- 
Best regards,
Vladimir
