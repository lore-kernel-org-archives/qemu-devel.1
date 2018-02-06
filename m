Received: from eggs.gnu.org ([2001:4830:134:3::10]:40468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej8W6-0004hM-Oj
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej8W5-0007MT-KD
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:02:54 -0500
References: <20180206140722.10110-1-vsementsov@virtuozzo.com>
	<20180206140722.10110-3-vsementsov@virtuozzo.com>
	<c501a095-43e6-95f3-b7bb-96ab80f99689@redhat.com>
	<cf41e939-1670-89a5-ab2b-0f182a7555fa@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c7a61e61-9f08-38d1-5a54-35f2471c6eb4@redhat.com>
Date: Tue, 6 Feb 2018 13:02:37 -0600
MIME-Version: 1.0
In-Reply-To: <cf41e939-1670-89a5-ab2b-0f182a7555fa@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com

On 02/06/2018 12:06 PM, Vladimir Sementsov-Ogievskiy wrote:
> 06.02.2018 18:50, Eric Blake wrote:
>> On 02/06/2018 08:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Set (and clear) histogram through new command
>>> block-latency-histogram-set and show new statistics in
>>> query-blockstats results.
>>>
>>
>> The commit message mentioned that you can set and clear histogram=20
>> tracking; how does this interface let you clear things?=C2=A0 By passi=
ng a=20
>> 0-length latency array?=C2=A0 If you violate the constraint (pass=20
>> non-ascending points, for example), does the previous latency map get=20
>> wiped out or is it still preserved unchanged?
>=20
> On error nothing is changed.
>=20
> By "clear" I mean zeroing statistics, not removing the whole histogram.=
=20
> And to zero statistics you can call set with the same latency array.
> There is no way to remove histogram at all.. We can add=20
> block-latency-histogram-unset later if needed.

Maybe "set (or restart) histogram collection points" might read better?=20
I also don't think we need a new command; if you make 'latency'=20
optional, then omitting it can serve to stop collecting statistics=20
altogether, without needing a new command (then again, if you do that,=20
now the command is used to "set, restart, and clear histogram collection"=
).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
