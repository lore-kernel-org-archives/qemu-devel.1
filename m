Received: from eggs.gnu.org ([2001:4830:134:3::10]:32882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYVfl-00056Z-Ii
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYVfk-0000M1-2M
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:05:13 -0400
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<720156db-7910-2825-5485-6ce328a68ba3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a65f10c6-3ec5-3501-8cfb-0a31e0b64a72@virtuozzo.com>
Date: Thu, 28 Jun 2018 15:04:56 +0300
MIME-Version: 1.0
In-Reply-To: <720156db-7910-2825-5485-6ce328a68ba3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/6] fix persistent bitmaps migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

26.06.2018 21:22, John Snow wrote:
>
> On 06/26/2018 09:50 AM, Vladimir Sementsov-Ogievskiy wrote:
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
>>    iotests: 169: drop deprecated 'autoload' parameter
>>    block/qcow2: improve error message in qcow2_inactivate
>>    bloc/qcow2: drop dirty_bitmaps_loaded state variable
>>    dirty-bitmaps: clean-up bitmaps loading and migration logic
>>    iotests: improve 169
>>    iotests: 169: add cases for source vm resuming
>>
>>   block/qcow2.h                  |  1 -
>>   include/block/dirty-bitmap.h   |  2 +-
>>   block.c                        | 11 ++++--
>>   block/dirty-bitmap.c           | 36 +++++++-----------
>>   block/qcow2-bitmap.c           | 16 ++++++++
>>   block/qcow2.c                  | 86 ++++++++++++++++++++++++++++++++----------
>>   migration/block-dirty-bitmap.c | 10 ++++-
>>   tests/qemu-iotests/169         | 70 +++++++++++++++++++++++++++++++++-
>>   tests/qemu-iotests/169.out     |  4 +-
>>   9 files changed, 182 insertions(+), 54 deletions(-)
>>
>
> Does this effectively supersede "[PATCH] block/qcow2: fix logic around
> dirty_bitmaps_loaded"?
>
> (I'll review it in just a moment, regardless, but I'm trying to keep my
> notes tidy.)
>
> --js

Yes, "fix logic" should be dropped.

-- 
Best regards,
Vladimir
