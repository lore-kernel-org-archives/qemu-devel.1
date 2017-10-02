Received: from eggs.gnu.org ([2001:4830:134:3::10]:57857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz3Pm-0007ZM-2l
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz3Pl-0001Ve-3a
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:17:54 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:24141 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dz3Pk-0001UY-Mq
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:17:53 -0400
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
	<628fc0f2-55d2-5b9a-acf9-b38fdeb13b9f@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <658be1f0-e00e-0526-f866-b2e4e8f2637a@virtuozzo.com>
Date: Mon, 2 Oct 2017 19:17:38 +0300
MIME-Version: 1.0
In-Reply-To: <628fc0f2-55d2-5b9a-acf9-b38fdeb13b9f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/5] backup improvements part 1
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
List-ID: <qemu-devel.nongnu.org>

02.10.2017 18:38, Eric Blake wrote:
> On 10/02/2017 09:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all. Here is a continuation of my "new backup architecture" series,
>> The very first part, but it is meaningful itself.
>>
>> 01: was previously sent in other my series, but here is more correct
>>      version, one mistake is fixed.
>> 02: only rebased to new byte-based interfaces (by Eric), r-bs saved
> Presumably, that means we need to tell patchew:
>
> Based-on:
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg06848.html
> [PATCH v10 00/20] make dirty-bitmap byte-based

Yes, surely, I forgot to note it.

>
>> 03: changed to use hbitmap_next_zero, also a comment added to
>>      none-mode (Fam)
>> 04: commit message rewritten. The patch was controversial, but I need
>>      it for further backup enhancement, so, let's continue the
>>      discussion.
>> 05: rebased, logic is not changed, r-bs saved
>>
>>
>> Vladimir Sementsov-Ogievskiy (5):
>>    hbitmap: add next_zero function
>>    backup: move from done_bitmap to copy_bitmap
>>    backup: init copy_bitmap from sync_bitmap for incremental
>>    backup: simplify non-dirty bits progress processing
>>    backup: use copy_bitmap in incremental backup
>>
>>   include/block/dirty-bitmap.h |   1 +
>>   include/qemu/hbitmap.h       |   8 +++
>>   block/backup.c               | 117 ++++++++++++++++++++++++-------------------
>>   block/dirty-bitmap.c         |   5 ++
>>   util/hbitmap.c               |  29 +++++++++++
>>   5 files changed, 108 insertions(+), 52 deletions(-)
>>


-- 
Best regards,
Vladimir
