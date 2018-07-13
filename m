Received: from eggs.gnu.org ([2001:4830:134:3::10]:45362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fdrqc-0008T3-Gg
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 02:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fdrqb-0001Xv-Bl
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 02:46:34 -0400
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<DB6PR0801MB2056B99A8BFC3613E368B2A5C1590@DB6PR0801MB2056.eurprd08.prod.outlook.com>
	<70365880-eb2c-e313-ea11-e16bc302a939@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <69e94126-5c46-aac3-5966-c81a64d20fd4@virtuozzo.com>
Date: Fri, 13 Jul 2018 09:46:18 +0300
MIME-Version: 1.0
In-Reply-To: <70365880-eb2c-e313-ea11-e16bc302a939@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/6] fix persistent bitmaps migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, Eric Blake <eblake@redhat.com>

12.07.2018 23:25, John Snow wrote:
>
> On 07/12/2018 03:00 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi, what about this?
>> I'll be on vacation next two weeks.
>> Best regards, Vladimir.
> By the end of today.
>
> If there are fixes necessary I will take over the series if necessary so
> you can enjoy your vacation, if that's OK with you?

yes, I just mean that I can discuss it only on this week. Of course, you 
can discuss/fix/merge it without me, I hope my comments and commit 
messages are exhaustive.

>
> --js
>
>> ------------------------------------------------------------------------
>> *Ô‘:* Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> *Ô‘–“¡◊Ã≈Œœ:* 26 …¿Œ— 2018 «. 16:50:29
>> *ÎœÕ’:* qemu-devel@nongnu.org; qemu-block@nongnu.org
>> *Îœ–…—:* dgilbert@redhat.com; quintela@redhat.com; stefanha@redhat.com;
>> jsnow@redhat.com; famz@redhat.com; mreitz@redhat.com; kwolf@redhat.com;
>> Vladimir Sementsov-Ogievskiy; Denis Lunev
>> *Ù≈Õ¡:* [PATCH 0/6] fix persistent bitmaps migration logic
>>   
>> Hi all.
>>
>> To continue talk about correct loading of persistent bitmaps here is
>> a patch (04), with some surrounding.
>>
>> Patch 04 contains new (and I hope, more clean) logic of bitmaps
>> loading/inactivation/invalidation/migration, with the whole description.
>> Let me not duplicate it here, you can safely start reading from 04
>> commit message and internal big comment.
>>
>> Vladimir Sementsov-Ogievskiy (6):
>>  ö iotests: 169: drop deprecated 'autoload' parameter
>>  ö block/qcow2: improve error message in qcow2_inactivate
>>  ö bloc/qcow2: drop dirty_bitmaps_loaded state variable
>>  ö dirty-bitmaps: clean-up bitmaps loading and migration logic
>>  ö iotests: improve 169
>>  ö iotests: 169: add cases for source vm resuming
>>
>>  öblock/qcow2.hööööööööööööööööö |ö 1 -
>>  öinclude/block/dirty-bitmap.höö |ö 2 +-
>>  öblock.cööööööööööööööööööööööö | 11 ++++--
>>  öblock/dirty-bitmap.cöööööööööö | 36 +++++++-----------
>>  öblock/qcow2-bitmap.cöööööööööö | 16 ++++++++
>>  öblock/qcow2.cööööööööööööööööö | 86
>> ++++++++++++++++++++++++++++++++----------
>>  ömigration/block-dirty-bitmap.c | 10 ++++-
>>  ötests/qemu-iotests/169öööööööö | 70 +++++++++++++++++++++++++++++++++-
>>  ötests/qemu-iotests/169.outöööö |ö 4 +-
>>  ö9 files changed, 182 insertions(+), 54 deletions(-)
>>
>> -- 
>> 2.11.1
>>


-- 
Best regards,
Vladimir
