Received: from eggs.gnu.org ([2001:4830:134:3::10]:40810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f953V-0007km-Sv
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f953R-0007E3-MQ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 04:36:37 -0400
References: <20180413143156.11409-1-vsementsov@virtuozzo.com>
	<461d56f3-4381-4cd6-f66d-1dd510c35fa8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7c4c3551-6235-d8a0-db64-83c7952d8284@virtuozzo.com>
Date: Thu, 19 Apr 2018 11:36:20 +0300
MIME-Version: 1.0
In-Reply-To: <461d56f3-4381-4cd6-f66d-1dd510c35fa8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] nbd/server: introduce NBD_CMD_CACHE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, pbonzini@redhat.com

18.04.2018 19:37, Eric Blake wrote:
> On 04/13/2018 09:31 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Handle nbd CACHE command. Just do read, without sending read data back.
>> Cache mechanism should be done by exported node driver chain.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/nbd.h |  3 ++-
>>   nbd/server.c        | 10 ++++++----
>>   2 files changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>> index fcdcd54502..b4793d0a29 100644
>> --- a/include/block/nbd.h
>> +++ b/include/block/nbd.h
>> @@ -135,6 +135,7 @@ typedef struct NBDExtent {
>>   #define NBD_FLAG_SEND_TRIM         (1 << 5) /* Send TRIM (discard) */
>>   #define NBD_FLAG_SEND_WRITE_ZEROES (1 << 6) /* Send WRITE_ZEROES */
>>   #define NBD_FLAG_SEND_DF           (1 << 7) /* Send DF (Do not Fragment) */
>> +#define NBD_FLAG_SEND_CACHE        (1 << 8) /* Send CACHE (prefetch) */
> Hmm, this flag is not documented in the upstream NBD protocol yet; are
> we sure it matches the xNBD implementation?  We'll want at least a
> documentation patch proposed for the NBD list before taking this.
>

The discussion already on list:
https://lists.debian.org/nbd/2018/03/msg00040.html

-- 
Best regards,
Vladimir
