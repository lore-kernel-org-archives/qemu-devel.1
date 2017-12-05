Received: from eggs.gnu.org ([2001:4830:134:3::10]:45676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eMGov-0001Ic-D1
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eMGop-0001N9-Pk
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:15:49 -0500
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1511196664-85304-2-git-send-email-anton.nefedov@virtuozzo.com>
	<w51shcp5i0c.fsf@maestria.local.igalia.com>
	<b88c73db-c3a5-014e-0ee8-0ce157642834@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <f5cd7843-d266-a01f-031c-3c65834406d5@virtuozzo.com>
Date: Tue, 5 Dec 2017 20:15:29 +0300
MIME-Version: 1.0
In-Reply-To: <b88c73db-c3a5-014e-0ee8-0ce157642834@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/7] qapi: add unmap to
 BlockDeviceStats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com



On 5/12/2017 6:19 PM, Eric Blake wrote:
> On 12/05/2017 09:09 AM, Alberto Garcia wrote:
>> On Mon 20 Nov 2017 05:50:58 PM CET, Anton Nefedov wrote:
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   qapi/block-core.json       | 20 ++++++++++++++++++++
>>>   include/block/accounting.h |  1 +
>>>   block/qapi.c               |  6 ++++++
>>>   3 files changed, 27 insertions(+)
>>>
> 
>>
>> Admittedtly this is just a style issue and I don't know what others
>> think, but wouldn't it be nicer if the documentation of new fields is
>> located together with the existing ones?
>>
>> E.g
>>
>>   @rd_bytes
>>   @wr_bytes
>> +@unmap_bytes
>>   @rd_operations
>>   @wr_operations
>>   @flush_operations
>> +@unmap_operations
>>
> 
> Grouping is fine, and your suggestion makes sense to me.  One of the
> nice things of QMP is that since it is name/value based, you don't have
> to worry about inserting a name in the middle if that makes more sense
> logically (it doesn't break backwards compatibility with old QMP
> clients, the way that inserting something into the middle of a C struct
> breaks all callers that were using the old struct layout).
> 

Thank you, agree, will fix

/Anton
