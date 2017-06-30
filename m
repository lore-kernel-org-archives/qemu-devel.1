Received: from eggs.gnu.org ([2001:4830:134:3::10]:53952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dR06Q-0006VA-UA
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 13:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dR06Q-0001pj-4Q
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 13:53:11 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-7-vsementsov@virtuozzo.com>
	<7089b5b7-3346-2144-eff9-64e1e77e6bd2@redhat.com>
	<4612abfc-40b0-ce2a-f953-0b5a4e6c99c0@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1de5cd07-095c-e045-2d2b-da77295d32c5@redhat.com>
Date: Fri, 30 Jun 2017 13:52:56 -0400
MIME-Version: 1.0
In-Reply-To: <4612abfc-40b0-ce2a-f953-0b5a4e6c99c0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v22 06/30] block/dirty-bitmap: add
 deserialize_ones func
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 06/29/2017 10:01 PM, Eric Blake wrote:
> On 06/29/2017 08:55 PM, Eric Blake wrote:
>> On 06/28/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Add bdrv_dirty_bitmap_deserialize_ones() function, which is needed for
>>> qcow2 bitmap loading, to handle unallocated bitmap parts, marked as
>>> all-ones.
>>>
> 
>>> + * hbitmap_deserialize_ones
>>> + * @hb: HBitmap to operate on.
>>> + * @start: First bit to restore.
>>> + * @count: Number of bits to restore.
>>
>> This part is accurate (the dirty-bitmap is using an underlying bitmap
>> with "one bit per sector" before my series, afterwards it will be "one
>> bit per byte", remembering that hbitmap really stores only one bit per
>> granularity multiple of the underlying unit), if incomplete (the code
>> asserts that things are aligned, but doesn't document that the caller
>> must pass in aligned values); but again, that's matching the
>> pre-existing deserialize_zeroes code.
> 
> Okay, I looked again; the documentation for
> hbitmap_serialization_granularity() has a blanket statement that all
> other hbitmap_serialization_* functions taking a start and count must be
> aligned. Indirect, but at least documented, so I retract my statement
> about the docs being incomplete.
> 

If the docs are confusing, please send patches to amend them; the bitmap
code is definitely very confusing at times and I appreciate any and all
insight to make the names, variable and documentation read better to be
more intuitive.

Thanks!
