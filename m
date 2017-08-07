Received: from eggs.gnu.org ([2001:4830:134:3::10]:44633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dego8-0000pQ-FF
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dego3-0005Zl-Di
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:06:52 -0400
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501597152-25342-9-git-send-email-anton.nefedov@virtuozzo.com>
	<4316158c-7775-477f-bc1f-56425872c35f@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <09c7d8cb-e98a-9f96-fdf7-9bd86fbacccf@virtuozzo.com>
Date: Mon, 7 Aug 2017 15:06:28 +0300
MIME-Version: 1.0
In-Reply-To: <4316158c-7775-477f-bc1f-56425872c35f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 08/15] qcow2: set inactive flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com


On 08/04/2017 11:00 PM, Eric Blake wrote:
> On 08/01/2017 09:19 AM, Anton Nefedov wrote:
>> Qcow2State and BlockDriverState flags have to be in sync
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/qcow2.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Is this a bug fix needed for 2.10?
> 

I don't think this bites us now, but yes looks like a bug

>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 66aa8c2..2a1d2f2 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2138,6 +2138,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
>>   
>>       if (result == 0) {
>>           qcow2_mark_clean(bs);
>> +        s->flags |= BDRV_O_INACTIVE;
>>       }
>>   
>>       return result;
>>
> 
/Anton
