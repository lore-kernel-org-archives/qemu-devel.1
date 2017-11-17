Received: from eggs.gnu.org ([2001:4830:134:3::10]:57060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFjKZ-00087c-E3
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eFjKW-0004QQ-7W
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:17:27 -0500
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<fb5c092b-9db5-c5bf-3f61-9317a6371168@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <bb7ce518-8542-f3ab-ac42-7d1106f52b69@virtuozzo.com>
Date: Fri, 17 Nov 2017 19:17:14 +0300
MIME-Version: 1.0
In-Reply-To: <fb5c092b-9db5-c5bf-3f61-9317a6371168@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v22 00/30] qcow2: persistent dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

17.11.2017 19:04, Eric Blake wrote:
> Revisiting an old series:
>
> On 06/28/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> There is a new update of qcow2-bitmap series - v22.
>>
>> web: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=qcow2-bitmap-v22
>> git: https://src.openvz.org/scm/~vsementsov/qemu.git (tag qcow2-bitmap-v22)
>>
>> v22:
>>
>> Rebase on master, so changes, mostly related to new dirty bitmaps mutex:
>>
>>    qcow2: add persistent dirty bitmaps support
>>   block.c                      |   65 +-
>>   block/Makefile.objs          |    2 +-
>>   block/dirty-bitmap.c         |  154 ++++-
>>   block/io.c                   |    8 +
>>   block/qcow2-bitmap.c         | 1481 ++++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2-refcount.c       |   59 +-
>>   block/qcow2.c                |  155 ++++-
>>   block/qcow2.h                |   43 ++
>>   blockdev.c                   |   73 ++-
>>   docs/interop/qcow2.txt       |    8 +-
>>   include/block/block.h        |    3 +
>>   include/block/block_int.h    |   14 +
>>   include/block/dirty-bitmap.h |   22 +-
>>   include/qemu/hbitmap.h       |   49 +-
>>   qapi/block-core.json         |   42 +-
>>   tests/Makefile.include       |    2 +-
>>   tests/qemu-iotests/165       |  105 +++
>>   tests/qemu-iotests/165.out   |    5 +
>>   tests/qemu-iotests/group     |    1 +
>>   tests/test-hbitmap.c         |   19 +
>>   util/hbitmap.c               |   51 +-
>>   21 files changed, 2280 insertions(+), 81 deletions(-)
> Nothing in this series touched qemu-img.  At the very minimum, it would
> be nice if 'qemu-img info' were to display a summary of all bitmaps in
> the qcow2 file; the QMP type ImageInfoSpecificQCow2 should be updated to
> mention this information, and qemu-img updated to output it.  Being able
> to create and remove persistent bitmaps from an at-rest qcow2 file
> without having to fire up qemu to issue QMP commands to do so would also
> be nice.
>
> It's a bit late for getting this request into 2.12, but had it been
> available, it would make my work at testing that 'qemu-img commit'
> doesn't corrupt persistent bitmaps.
>

You are right, this is needed, but I can't promise something for the 
nearest future..

-- 
Best regards,
Vladimir
