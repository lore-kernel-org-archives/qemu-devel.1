Received: from eggs.gnu.org ([2001:4830:134:3::10]:41014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euLBa-000050-E8
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euLBZ-00038k-IO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:48:02 -0500
References: <20180309153347.62552-1-vsementsov@virtuozzo.com>
	<adfa3a5c-0e8e-ff2d-216c-1d73fbb223cc@redhat.com>
	<8654ed9f-14bd-4e36-0df0-5eff5fccdb7a@virtuozzo.com>
	<6ed49ea1-af9d-bfb5-12b5-97c1f1bb6f22@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2bdc5088-a51c-dc20-101b-1aaa9114cc3e@virtuozzo.com>
Date: Fri, 9 Mar 2018 19:47:49 +0300
MIME-Version: 1.0
In-Reply-To: <6ed49ea1-af9d-bfb5-12b5-97c1f1bb6f22@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 0/2] block latency histogram
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

09.03.2018 19:37, Eric Blake wrote:
> On 03/09/2018 10:31 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 09.03.2018 18:40, Eric Blake wrote:
>>> On 03/09/2018 09:33 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> v4:
>>>>
>>>> Move block_latency_histogram_set from block/accounting.c to
>>>> blockdev.c, as it uses qapi type uint64List and this fact breaks
>>>> build.
>>>
>>> Was the cross file motion necessary, or could you just fix the=20
>>> #includes according to the recent qapi header refactoring?
>>>
>>
>> Looks like it's not as simple..
>>
>> /tmp/qemu-test/src/include/block/accounting.h:30:10: fatal error:=20
>> qapi-types.h: No such file or directory
>> =C2=A0=C2=A0#include "qapi-types.h
>>
>>
>> what to do now? Looks like qapi-types are not generated for some=20
>> builds. So, this version (v4) should take place.
>
> top-level qapi-types.h was replaced by lots of qapi/qapi*.h modular=20
> headers.=C2=A0 Unfortunately, incremental builds don't delete the stale=20
> qapi-types.h that was left in tree from the point prior to the qapi=20
> header refactoring.
>
> To get uint64List, use qapi/qapi-builtin-types.h.=C2=A0 To get any type=20
> defined in a qapi/MODULE.json file, use qapi/qapi-MODULE-types.h.
>

thanks, now it works, after git clean..

--=20
Best regards,
Vladimir
