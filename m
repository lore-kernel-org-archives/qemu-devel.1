Received: from eggs.gnu.org ([2001:4830:134:3::10]:36305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGmOW-0004SC-Pc
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dGmOV-0007XO-VY
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:13:36 -0400
References: <1496330073-51338-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1496330073-51338-4-git-send-email-anton.nefedov@virtuozzo.com>
	<dc70b146-4a16-428f-e2f3-ea9ea09ecc06@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <ed77ab63-6203-8ec1-4d9a-cb2751e2edaa@virtuozzo.com>
Date: Fri, 2 Jun 2017 16:13:23 +0300
MIME-Version: 1.0
In-Reply-To: <dc70b146-4a16-428f-e2f3-ea9ea09ecc06@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/15] blkdebug: support
 BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org



On 06/01/2017 10:50 PM, Eric Blake wrote:
> On 06/01/2017 10:14 AM, Anton Nefedov wrote:
>> Support the flag if the underlying BDS supports it
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/blkdebug.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Shouldn't other passthrough drivers (like raw-format.c) make this change
> as well?
> 

Right.

Wonder why they even enumerate those instead of just

bs->supported_zero_flags = bs->file->bs->supported_zero_flags;

>>
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index a5196e8..8b1401b 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -415,7 +415,8 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
>>   
>>       bs->supported_write_flags = BDRV_REQ_FUA &
>>           bs->file->bs->supported_write_flags;
>> -    bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
>> +    bs->supported_zero_flags =
>> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_ALLOCATE) &
>>           bs->file->bs->supported_zero_flags;
>>       ret = -EINVAL;
>>   
>>
> 

/Anton
