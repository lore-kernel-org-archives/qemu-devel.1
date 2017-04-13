Received: from eggs.gnu.org ([2001:4830:134:3::10]:34338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cyauH-0002dR-39
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cyauD-0001q9-V3
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:19:13 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:28317 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cyauD-0001pZ-Jp
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:19:09 -0400
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-4-eblake@redhat.com>
	<bdff9bc8-a521-ddd6-3c71-bb97976b75ec@redhat.com>
	<44a88413-bbe0-c67f-8700-d3777888647c@redhat.com>
	<43ec2498-b32f-b3c1-37cb-e5bce27844be@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <077cd9f0-110a-f2ea-fcf9-31b6f4c8b2c1@virtuozzo.com>
Date: Thu, 13 Apr 2017 12:19:00 +0300
MIME-Version: 1.0
In-Reply-To: <43ec2498-b32f-b3c1-37cb-e5bce27844be@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/12] dirty-bitmap: Drop unused functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

13.04.2017 02:40, John Snow wrote:
>
> On 04/12/2017 07:36 PM, Eric Blake wrote:
>> On 04/12/2017 05:47 PM, John Snow wrote:
>>>
>>> On 04/12/2017 01:49 PM, Eric Blake wrote:
>>>> We had several functions that no one was using, and which used
>>>> sector-based interfaces.  I'm trying to convert towards byte-based
>>>> interfaces, so it's easier to just drop the unused functions:
>>>>
>>>> bdrv_dirty_bitmap_size
>>>> bdrv_dirty_bitmap_get_meta
>>>> bdrv_dirty_bitmap_reset_meta
>>>> bdrv_dirty_bitmap_meta_granularity
>>>>
>>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>> ---
>>>>   include/block/dirty-bitmap.h |  8 --------
>>>>   block/dirty-bitmap.c         | 34 ----------------------------------
>>>>   2 files changed, 42 deletions(-)
>>>>
>>> I think it's likely Vladimir is or at least was relying on some of these
>>> for his migration and persistence series.
>>>
>>> Might be nice to let him chime in to see how much of a hassle this is.
>> Then let's add him in cc ;)
>>
> Err... I can't just summon people by mentioning them?
>
>> I'm okay if these functions stay because they have a user, but it would
>> also be nice if they were properly byte-based (like everything else in
>> dirty-bitmap at the end of my series).  So even if we remove them here,
>> we can revert the removal, and re-add them but with a sane interface.
>>
> OK, but I will offer to do the work in the interest of not slowing
> things down any further.
>
> Do you use any of these, Vladimir?
>
> --js
HI all!

only bdrv_dirty_bitmap_size() is used. No problem to add it back with my 
series next update


-- 
Best regards,
Vladimir
