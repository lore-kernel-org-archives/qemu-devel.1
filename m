Received: from eggs.gnu.org ([2001:4830:134:3::10]:56626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ejN2C-00073S-Ji
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ejN27-0005q7-W0
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:33:00 -0500
References: <20180206140722.10110-1-vsementsov@virtuozzo.com>
	<20180206140722.10110-3-vsementsov@virtuozzo.com>
	<c501a095-43e6-95f3-b7bb-96ab80f99689@redhat.com>
	<cf41e939-1670-89a5-ab2b-0f182a7555fa@virtuozzo.com>
	<c7a61e61-9f08-38d1-5a54-35f2471c6eb4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <072dbd8a-d1a2-fbfc-1847-b0eac640f78f@virtuozzo.com>
Date: Wed, 7 Feb 2018 13:32:39 +0300
MIME-Version: 1.0
In-Reply-To: <c7a61e61-9f08-38d1-5a54-35f2471c6eb4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: add block latency histogram
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com

06.02.2018 22:02, Eric Blake wrote:
> On 02/06/2018 12:06 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 06.02.2018 18:50, Eric Blake wrote:
>>> On 02/06/2018 08:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Set (and clear) histogram through new command
>>>> block-latency-histogram-set and show new statistics in
>>>> query-blockstats results.
>>>>
>>>
>>> The commit message mentioned that you can set and clear histogram=20
>>> tracking; how does this interface let you clear things?=C2=A0 By passin=
g=20
>>> a 0-length latency array?=C2=A0 If you violate the constraint (pass=20
>>> non-ascending points, for example), does the previous latency map=20
>>> get wiped out or is it still preserved unchanged?
>>
>> On error nothing is changed.
>>
>> By "clear" I mean zeroing statistics, not removing the whole=20
>> histogram. And to zero statistics you can call set with the same=20
>> latency array.
>> There is no way to remove histogram at all.. We can add=20
>> block-latency-histogram-unset later if needed.
>
> Maybe "set (or restart) histogram collection points" might read=20
> better? I also don't think we need a new command; if you make=20
> 'latency' optional, then omitting it can serve to stop collecting=20
> statistics altogether, without needing a new command (then again, if=20
> you do that, now the command is used to "set, restart, and clear=20
> histogram collection").
>

I like the idea, will do.

--=20
Best regards,
Vladimir
