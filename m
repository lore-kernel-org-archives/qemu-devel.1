Received: from eggs.gnu.org ([2001:4830:134:3::10]:42986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da1M0-00031t-82
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da1Lz-0002tj-AQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:02:32 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170714123341.373857-1-vsementsov@virtuozzo.com>
	<b9f574d1-91b5-c5dc-46b2-1a8976c5539f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f8f9bbae-2440-b2e0-b0dd-0c407515e736@amsat.org>
Date: Tue, 25 Jul 2017 12:02:20 -0300
MIME-Version: 1.0
In-Reply-To: <b9f574d1-91b5-c5dc-46b2-1a8976c5539f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qcow2-bitmap: fix bitmap_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, peter.maydell@linaro.org, Eric Blake <eblake@redhat.com>

Maybe worth adding "Coverity: CID 1377700"

On 07/14/2017 01:00 PM, Max Reitz wrote:
> On 2017-07-14 14:33, Vladimir Sementsov-Ogievskiy wrote:
>> Fix possible crash on error path in
>> qcow2_remove_persistent_dirty_bitmap. Although bitmap_free was added in
>> 88ddffae8fc the bug was introduced later in commit 469c71edc72 (when
>> qcow2_remove_persistent_dirty_bitmap was added).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/qcow2-bitmap.c | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
> Thanks, applied to my block branch:
> 
> https://github.com/XanClic/qemu/commits/block
> 
> Max
> 
