Received: from eggs.gnu.org ([2001:4830:134:3::10]:57643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz3Or-00074X-Ae
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz3Oq-0000uA-B3
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:16:57 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:42330 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dz3Op-0000t2-Tm
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 12:16:56 -0400
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
	<20171002143919.207741-2-vsementsov@virtuozzo.com>
	<7afabb38-abb6-a261-20a0-48aa6526c315@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e51eb2e1-a272-6261-c662-dc76d7fca69e@virtuozzo.com>
Date: Mon, 2 Oct 2017 19:16:37 +0300
MIME-Version: 1.0
In-Reply-To: <7afabb38-abb6-a261-20a0-48aa6526c315@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/5] hbitmap: add next_zero function
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

02.10.2017 18:43, Eric Blake wrote:
> On 10/02/2017 09:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>> The function searches for next zero bit.
>> Also add interface for BdrvDirtyBitmap.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   include/block/dirty-bitmap.h |  1 +
>>   include/qemu/hbitmap.h       |  8 ++++++++
>>   block/dirty-bitmap.c         |  5 +++++
>>   util/hbitmap.c               | 29 +++++++++++++++++++++++++++++
>>   4 files changed, 43 insertions(+)
>>
>> +++ b/block/dirty-bitmap.c
>> @@ -715,3 +715,8 @@ char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, Error **errp)
>>   {
>>       return hbitmap_sha256(bitmap->bitmap, errp);
>>   }
>> +
>> +int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap, uint64_t offset)
>> +{
>> +    return hbitmap_next_zero(bitmap->bitmap, offset);
>> +}
> Returns an answer in the same scale as the underlying hbitmap; if this
> is applied before my byte-based dirty bitmap series, that means offset
> is a sector count and the result is likewise a sector number (awkward);
> if this is applied after my series, you pass in a byte offset start and
> get a byte result (nice).

Oh, I forget to say it: it's based on your series)

>
> I don't see any obvious errors in the implementation, but DO think that
> you should include a testsuite enhancement in tests/test-hbitmap.c to
> cover the new functionality before we accept this.
>


-- 
Best regards,
Vladimir
