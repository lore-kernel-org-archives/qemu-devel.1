Received: from eggs.gnu.org ([2001:4830:134:3::10]:37380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1edvvF-0005mn-7N
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1edvvE-0000Pt-A1
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:35:21 -0500
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-3-git-send-email-anton.nefedov@virtuozzo.com>
	<260e0e0b-97a3-073f-a020-390e047d6b9d@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <a85b24f9-a366-a697-cbff-fc6a66b2f770@virtuozzo.com>
Date: Tue, 23 Jan 2018 13:35:04 +0300
MIME-Version: 1.0
In-Reply-To: <260e0e0b-97a3-073f-a020-390e047d6b9d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/8] qapi: add unmap to BlockDeviceStats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com



On 22/1/2018 11:47 PM, Eric Blake wrote:
> On 01/19/2018 06:50 AM, Anton Nefedov wrote:
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>>   qapi/block-core.json       | 29 +++++++++++++++++++++++------
>>   include/block/accounting.h |  1 +
>>   block/qapi.c               |  6 ++++++
>>   3 files changed, 30 insertions(+), 6 deletions(-)
>>
> 
>> @@ -688,6 +693,9 @@
>>   #
>>   # @rd_total_time_ns: Total_time_spend on reads in nano-seconds (since 0.15.0).
> 
> While we are here, we could change s/Total_time_spend/Total time spent/
> 
>>   #
>> +# @unmap_total_time_ns: Total time spent on unmap operations in nano-seconds
>> +#                       (Since 2.12)
> 
> Also, s/nano-seconds/nanoseconds/ (for both lines, if we are touching both).
> 
> The QAPI maintainer can touch that up (that may be me, depending on
> Markus' schedule in the next few weeks); but I'm not seeing any UI
> problems with the addition, so
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thanks, fixed
