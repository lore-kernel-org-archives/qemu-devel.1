Received: from eggs.gnu.org ([2001:4830:134:3::10]:41481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e1ZvO-0003YL-Um
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1e1ZvK-0007jW-1H
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:24:58 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <8796fa81-4168-9931-1f29-a6331e40fc0e@redhat.com>
References: <20171009144840.973-1-berto@igalia.com>
	<8796fa81-4168-9931-1f29-a6331e40fc0e@redhat.com>
Date: Mon, 09 Oct 2017 17:24:50 +0200
Message-ID: <w51infobayl.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qcow2: Use BDRV_SECTOR_BITS
 instead of its literal value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon 09 Oct 2017 05:07:56 PM CEST, Max Reitz wrote:
> On 2017-10-09 16:48, Alberto Garcia wrote:
>> BDRV_SECTOR_BITS is defined to be 9 in block.h (and BDRV_SECTOR_SIZE
>> is calculated from that), but there are still a few placed where we
>> are using the literal value instead of the macro.
>> 
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2-cluster.c | 6 +++---
>>  block/qcow2.c         | 4 ++--
>>  2 files changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index 0e5aec81cb..0a63604af6 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -748,8 +748,8 @@ uint64_t qcow2_alloc_compressed_cluster_offset(BlockDriverState *bs,
>>          return 0;
>>      }
>>  
>> -    nb_csectors = ((cluster_offset + compressed_size - 1) >> 9) -
>> -                  (cluster_offset >> 9);
>> +    nb_csectors = ((cluster_offset + compressed_size - 1) >> BDRV_SECTOR_BITS) -
>> +                  (cluster_offset >> BDRV_SECTOR_BITS);
>
> I'm not sure about this one, because technically this is not the block
> layer's sector size but actually 512 bytes ("Compressed size of the
> images in sectors of 512 bytes" as per the spec).

You're right, I'll resend the patch leaving this part out for now.

Berto
