Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E373C282DA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 03:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FFF02082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 03:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFF02082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34519 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDhdb-0004jN-5o
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 23:41:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hDhck-0004Fn-Ll
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 23:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hDhcj-00015T-EP
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 23:40:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41008 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
	id 1hDhcg-00012K-Cd; Mon, 08 Apr 2019 23:40:34 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 9A3995741DF2E25977FF;
	Tue,  9 Apr 2019 11:40:28 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.32) by DGGEMS403-HUB.china.huawei.com
	(10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
	11:40:18 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20190325125142.11628-1-zhengxiang9@huawei.com>
	<CAFEAcA-O5+A0Q=14k2vrBg3KNM7MmqbcyhBoZZOe=AsyE-UDbw@mail.gmail.com>
	<19929558-9f2d-148a-4357-d48b46f8b62b@huawei.com>
	<87va06kvm6.fsf@dusky.pond.sub.org>
	<59f100b4-f6e9-973d-532b-58fb172a7009@redhat.com>
	<87imw5fv45.fsf@dusky.pond.sub.org>
	<abe1d9cd-85bb-2ef8-630f-af28cae6378c@redhat.com>
	<8736n9eb4s.fsf@dusky.pond.sub.org>
	<bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
	<b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
	<a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
Message-ID: <55de8a19-220d-c236-d727-28ce1d6b6d45@huawei.com>
Date: Tue, 9 Apr 2019 11:39:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
	Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	qemu-arm <qemu-arm@nongnu.org>, Heyi Guo <guoheyi@huawei.com>,
	wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409033959.senOPaSoorTwRPvykvKeCbK15orJWKREh-jToJy5Xm8@z>


On 2019/4/9 0:14, Laszlo Ersek wrote:
> On 04/08/19 15:43, Xiang Zheng wrote:
>>
>> On 2019/4/3 23:35, Laszlo Ersek wrote:
>>>> I thought about your comments and wrote the following patch (just for test)
>>>> which uses a file mapping to replace the anonymous mapping. UEFI seems to work
>>>> fine. So why not use a file mapping to read or write a pflash device?
>>> Honestly I can't answer "why not do this". Maybe we should.
>>>
>>> Regarding "why not do this *exactly as shown below*" -- probably because
>>> then we'd have updates to the same underlying regular file via both
>>> mmap() and write(), and the interactions between those are really tricky
>>> (= best avoided).
>>>
>>> One of my favorite questions over the years used to be posting a matrix
>>> of possible mmap() and file descriptor r/w/sync interactions, with the
>>> outcomes as they were "implied" by POSIX, and then asking at the bottom,
>>> "is my understanding correct?" I've never ever received an answer to
>>> that. :)
>>
>> In my opinion, it's feasible to r/w/sync the memory devices which use a block
>> backend via mmap() and write().
> 
> Maybe. I think that would be a first in QEMU, and you'd likely have to
> describe and follow a semi-formal model between fd actions and mmap()
> actions.
> 
> Here's the (unconfirmed) table I referred to earlier.
> 
> +-------------+-----------------------------------------------------+
> | change made | change visible via                                  |
> | through     +-----------------+-------------+---------------------+
> |             | MAP_SHARED      | MAP_PRIVATE | read()              |
> +-------------+-----------------+-------------+---------------------+
> | MAP_SHARED  | yes             | unspecified | depends on MS_SYNC, |
> |             |                 |             | MS_ASYNC, or normal |
> |             |                 |             | system activity     |
> +-------------+-----------------+-------------+---------------------+
> | MAP_PRIVATE | no              | no          | no                  |
> +-------------+-----------------+-------------+---------------------+
> | write()     | depends on      | unspecified | yes                 |
> |             | MS_INVALIDATE,  |             |                     |
> |             | or the system's |             |                     |
> |             | read/write      |             |                     |
> |             | consistency     |             |                     |
> +-------------+-----------------+-------------+---------------------+
> 
> Presumably:
> 
> - a write() to some offset range of a regular file should be visible in
> a MAP_SHARED mapping of that range after a matching msync(...,
> MS_INVALIDATE) call;
> 
> - changes through a MAP_SHARED mapping to a regular file should be
> visible via read() after a matching msync(..., MS_SYNC) call returns.
> 
> I sent this table first in 2010 to the Austin Group mailing list, and
> received no comments. Then another person (on the same list) asked
> basically the same questions in 2013, to which I responded with the
> above assumptions / interpretations -- and received no comments from
> third parties again.
> 
> But, I'm really out of my depth here -- we're not even discussing
> generic read()/write()/mmap()/munmap()/msync() interactions, but how
> they would fit into the qemu block layer. And I have no idea.
> 
>>
>>>
>>> Also... although we don't really use them in practice, some QCOW2
>>> features for pflash block backends are -- or would be -- nice. (Not the
>>> internal snapshots or the live RAM dumps, of course.)
>>
>> Regarding sparse files, can we read actual backend size data for the read-only
>> pflash memory as the following steps shown?
>>
>> 1) Create a sparse file -- QEMU_EFI-test.raw:
>>    dd if=/dev/zero of=QEMU_EFI-test.raw bs=1M seek=64 count=0
>>
>> 2) Read from QEMU_EFI.fd and write to QEMU_EFI-test.raw:
>>    dd of="QEMU_EFI-test.raw" if="QEMU_EFI.fd" conv=notrunc
>>
>> 3) Use QEMU_EFI-test.raw as the read-only pflash and start qemu with the below
>> patch applied:
>>
>> ---8>---
>>
>> diff --git a/hw/block/block.c b/hw/block/block.c
>> index bf56c76..ad18d5e 100644
>> --- a/hw/block/block.c
>> +++ b/hw/block/block.c
>> @@ -30,7 +30,7 @@
>>  bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
>>                                   Error **errp)
>>  {
>> -    int64_t blk_len;
>> +    int64_t blk_len, actual_len;
>>      int ret;
>>
>>      blk_len = blk_getlength(blk);
>> @@ -53,7 +53,9 @@ bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr size,
>>       * block device and read only on demand.
>>       */
>>      assert(size <= BDRV_REQUEST_MAX_BYTES);
>> -    ret = blk_pread(blk, 0, buf, size);
>> +    actual_len = bdrv_get_allocated_file_size(blk_bs(blk));
>> +    ret = blk_pread(blk, 0, buf,
>> +            (!blk_is_read_only(blk) || actual_len < 0) ? size : actual_len);
>>      if (ret < 0) {
>>          error_setg_errno(errp, -ret, "can't read block backend");
>>          return false;
>>
> 
> This hunk looks dubious for a general helper function. It seems to
> assume that the holes are punched at the end of the file.
> 
> Sorry, this discussion is making me uncomfortable. I don't want to
> ignore your questions, but I have no idea about the right answers. This
> really needs the attention of the block people.

I feel deeply sorry for making you uncomfortable. It's generous of you to give me so much
of your time.

-- 

Thanks,
Xiang



