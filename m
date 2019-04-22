Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18E7C10F14
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 01:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BEB20859
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 01:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BEB20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59233 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIO4c-0001XS-GN
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 21:48:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hIO3d-0000yQ-0n
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hINv5-0008FU-57
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:38:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53276 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
	id 1hINv1-000897-I7; Sun, 21 Apr 2019 21:38:52 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 2487296AA549D80AF36A;
	Mon, 22 Apr 2019 09:38:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.32) by DGGEMS409-HUB.china.huawei.com
	(10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 22 Apr 2019
	09:38:33 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
	<b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
	<a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
	<87bm1fiuo8.fsf@dusky.pond.sub.org>
	<20190409082852.GB6610@localhost.localdomain>
	<c03c51a7-1bb0-b05b-9027-2364ab00517c@huawei.com>
	<20190411122246.GB5694@linux.fritz.box>
	<0c6c32b7-46f8-cf80-b7a6-1b48995b84e4@huawei.com>
	<355cd139-2084-e282-9a60-3574fe0746bd@huawei.com>
	<20190412105737.GC4522@linux.fritz.box>
	<a6affbbb-ab69-7ebd-13ba-a42dbf1ed78e@huawei.com>
Message-ID: <14accbba-6885-3b6a-2a03-169bfdc2f5d4@huawei.com>
Date: Mon, 22 Apr 2019 09:37:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
	Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <a6affbbb-ab69-7ebd-13ba-a42dbf1ed78e@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [RFC PATCH] hw/arm/virt: use variable size of
 flash device to save memory
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com,
	Max Reitz <mreitz@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422013756.vfpSoR6wTgoiVA7tmjROeYUICyrWLx9p5iuHMHnRuz8@z>

Ping?

On 2019/4/15 10:39, Xiang Zheng wrote:
> On 2019/4/12 18:57, Kevin Wolf wrote:
>> Am 12.04.2019 um 11:50 hat Xiang Zheng geschrieben:
>>>
>>> On 2019/4/12 9:52, Xiang Zheng wrote:
>>>> On 2019/4/11 20:22, Kevin Wolf wrote:
>>>>> Okay, so your problem is that blk_pread() writes to the whole buffer,
>>>>> writing explicit zeroes for unallocated parts of the image, while you
>>>>> would like to leave those parts of the buffer untouched so that we don't
>>>>> actually allocate the memory, but can just use the shared zero page.
>>>>>
>>>>> If you just want to read the non-zero parts of the image, that can be
>>>>> done by using a loop that calls bdrv_block_status() and only reads from
>>>>> the image if the BDRV_BLOCK_ZERO bit is clear.
>>>>>
>>>>> Would this solve your problem?
>>>>
>>>> Sounds good! What if guest tried to read/write the zero parts?
>>>>
>>>
>>> I wrote the below patch (refer to bdrv_make_zero()) for test, it seems
>>> that everything is OK and the memory is also exactly allocated on demand.
>>>
>>> This requires pflash devices to use sparse files backend. Thus I have to
>>> create images like:
>>>
>>>    dd of="QEMU_EFI-pflash.raw" if="/dev/zero" bs=1M seek=64 count=0
>>>    dd of="QEMU_EFI-pflash.raw" if="QEMU_EFI.fd" conv=notrunc
>>>
>>>    dd of="empty_VARS.fd" if="/dev/zero" bs=1M seek=64 count=0
>>>
>>>
>>> ---8>---
>>>
>>> diff --git a/block/block-backend.c b/block/block-backend.c
>>> index f78e82a..ed8ca87 100644
>>> --- a/block/block-backend.c
>>> +++ b/block/block-backend.c
>>> @@ -1379,6 +1379,12 @@ BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
>>>                          flags | BDRV_REQ_ZERO_WRITE, cb, opaque);
>>>  }
>>>
>>> +int blk_pread_nonzeroes(BlockBackend *blk, void *buf)
>>> +{
>>> +    int ret = bdrv_pread_nonzeroes(blk->root, buf);
>>> +    return ret;
>>> +}
>>
>> I don't think this deserves a place in the public block layer interface,
>> as it's only a single device that makes use of it.
>>
>> Maybe you wrote things this way because there is no blk_block_status(),
>> but you can get the BlockDriverState with blk_bs(blk) and then implement
>> everything inside hw/block/block.c.
> 
> Yes, you are right.
> 
>>
>>>  int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int count)
>>>  {
>>>      int ret = blk_prw(blk, offset, buf, count, blk_read_entry, 0);
>>> diff --git a/block/io.c b/block/io.c
>>> index dfc153b..83e5ea7 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -882,6 +882,38 @@ int bdrv_pwrite_zeroes(BdrvChild *child, int64_t offset,
>>>                          BDRV_REQ_ZERO_WRITE | flags);
>>>  }
>>>
>>> +int bdrv_pread_nonzeroes(BdrvChild *child, void *buf)
>>> +{
>>> +    int ret;
>>> +    int64_t target_size, bytes, offset = 0;
>>> +    BlockDriverState *bs = child->bs;
>>> +
>>> +    target_size = bdrv_getlength(bs);
>>> +    if (target_size < 0) {
>>> +        return target_size;
>>> +    }
>>> +
>>> +    for (;;) {
>>> +        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_BYTES);
>>> +        if (bytes <= 0) {
>>> +            return 0;
>>> +        }
>>> +        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
>>> +        if (ret < 0) {
>>> +            return ret;
>>> +        }
>>> +        if (ret & BDRV_BLOCK_ZERO) {
>>> +            offset += bytes;
>>> +            continue;
>>> +        }
>>> +        ret = bdrv_pread(child, offset, buf, bytes);
>>> +        if (ret < 0) {
>>> +            return ret;
>>> +        }
>>> +        offset += bytes;
>>
>> I think the code becomes simpler the other way round:
>>
>>     if (!(ret & BDRV_BLOCK_ZERO)) {
>>         ret = bdrv_pread(child, offset, buf, bytes);
>>         if (ret < 0) {
>>             return ret;
>>         }
>>     }
>>     offset += bytes;
>>
>> You don't increment buf, so if you have a hole in the file, this will
>> corrupt the buffer. You need to either increment buf, too, or use
>> (uint8_t*) buf + offset for the bdrv_pread() call.
>>
> 
> Yes, I didn't notice it. I think the latter is better. Does *BDRV_BLOCK_ZERO*
> mean that there are all-zeroes data or a hole in the sector? But if I use an
> image filled with zeroes, it will not set BDRV_BLOCK_ZERO bit on return.
> 
> Should I resend a patch?
> 
> ---8>---
> 
>>From 4dbfe4955aa9fe23404cbe1890fbe148be2ff10e Mon Sep 17 00:00:00 2001
> From: Xiang Zheng <zhengxiang9@huawei.com>
> Date: Sat, 13 Apr 2019 02:27:03 +0800
> Subject: [PATCH] pflash: Only read non-zero parts of backend image
> 
> Currently we fill the VIRT_FLASH memory space with two 64MB NOR images
> when using persistent UEFI variables on virt board. Actually we only use
> a very small(non-zero) part of the memory while the rest significant
> large(zero) part of memory is wasted.
> 
> So this patch checks the block status and only writes the non-zero part
> into memory. This requires pflash devices to use sparse files for
> backends.
> 
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  hw/block/block.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/block.c b/hw/block/block.c
> index bf56c76..3cb9d4c 100644
> --- a/hw/block/block.c
> +++ b/hw/block/block.c
> @@ -15,6 +15,44 @@
>  #include "qapi/qapi-types-block.h"
> 
>  /*
> + * Read the non-zeroes parts of @blk into @buf
> + * Reading all of the @blk is expensive if the zeroes parts of @blk
> + * is large enough. Therefore check the block status and only write
> + * the non-zeroes block into @buf.
> + *
> + * Return 0 on success, non-zero on error.
> + */
> +static int blk_pread_nonzeroes(BlockBackend *blk, void *buf)
> +{
> +    int ret;
> +    int64_t target_size, bytes, offset = 0;
> +    BlockDriverState *bs = blk_bs(blk);
> +
> +    target_size = bdrv_getlength(bs);
> +    if (target_size < 0) {
> +        return target_size;
> +    }
> +
> +    for (;;) {
> +        bytes = MIN(target_size - offset, BDRV_REQUEST_MAX_SECTORS);
> +        if (bytes <= 0) {
> +            return 0;
> +        }
> +        ret = bdrv_block_status(bs, offset, bytes, &bytes, NULL, NULL);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +        if (!(ret & BDRV_BLOCK_ZERO)) {
> +            ret = bdrv_pread(bs->file, offset, (uint8_t *) buf + offset, bytes);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
> +        offset += bytes;
> +    }
> +}
> +
> +/*
>   * Read the entire contents of @blk into @buf.
>   * @blk's contents must be @size bytes, and @size must be at most
>   * BDRV_REQUEST_MAX_BYTES.
> @@ -53,7 +91,7 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
>       * block device and read only on demand.
>       */
>      assert(size <= BDRV_REQUEST_MAX_BYTES);
> -    ret = blk_pread(blk, 0, buf, size);
> +    ret = blk_pread_nonzeroes(blk, buf);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "can't read block backend");
>          return false;
> 
-- 

Thanks,
Xiang



