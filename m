Received: from eggs.gnu.org ([2001:4830:134:3::10]:44361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ef3nr-0002ri-MU
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ef3nl-0005Kf-SG
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:12:23 -0500
References: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
	<1b55edad-f820-6898-1630-ccc76e6c4845@redhat.com>
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Message-ID: <5858df64-9495-1332-3c53-fab0204f79a9@virtuozzo.com>
Date: Fri, 26 Jan 2018 13:39:23 +0100
MIME-Version: 1.0
In-Reply-To: <1b55edad-f820-6898-1630-ccc76e6c4845@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: implement bdrv_get_info callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

PIng

So, let me know if I need to make any changes in patch

On 1/18/18 1:09 PM, Paolo Bonzini wrote:
> On 18/01/2018 12:51, Edgar Kaziakhmedov wrote:
>> +static int nbd_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
>> +{
>> +    if (bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP) {
>> +        bdi->can_write_zeroes_with_unmap = true;
>> +    }
>> +    return 0;
>> +}
>> +
> Other drivers set the flag always, while NBD only sets it if the server
> knows the flag.
>
> I think NBD is more correct, so:
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>
> However, it would be nice to remove can_write_zeroes_with_unmap from
> BlockDriverInfo, and make bdrv_can_write_zeroes_with_unmap just return
> !!(bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP).  Kevin, what do you
> think?
>
> Paolo
> .
>
