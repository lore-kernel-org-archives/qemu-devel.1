Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D432C10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 08:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484C82075B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 08:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484C82075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55824 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE8mK-0003GV-Fk
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 04:40:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hE8l6-0002d4-7J
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhengxiang9@huawei.com>) id 1hE8l4-0007Zq-GV
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 04:39:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36752 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhengxiang9@huawei.com>)
	id 1hE8kv-0007Qk-9B; Wed, 10 Apr 2019 04:38:53 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 5C26A4B739DB6CDC34AE;
	Wed, 10 Apr 2019 16:38:45 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.32) by DGGEMS412-HUB.china.huawei.com
	(10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 10 Apr 2019
	16:38:35 +0800
From: Xiang Zheng <zhengxiang9@huawei.com>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <87va06kvm6.fsf@dusky.pond.sub.org>
	<59f100b4-f6e9-973d-532b-58fb172a7009@redhat.com>
	<87imw5fv45.fsf@dusky.pond.sub.org>
	<abe1d9cd-85bb-2ef8-630f-af28cae6378c@redhat.com>
	<8736n9eb4s.fsf@dusky.pond.sub.org>
	<bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
	<b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
	<a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
	<87bm1fiuo8.fsf@dusky.pond.sub.org>
	<20190409082852.GB6610@localhost.localdomain>
Message-ID: <c03c51a7-1bb0-b05b-9027-2364ab00517c@huawei.com>
Date: Wed, 10 Apr 2019 16:36:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:64.0) Gecko/20100101
	Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20190409082852.GB6610@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Originating-IP: [10.177.29.32]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410083634.TPOExonZysBGt_OB1Oaub04OqwM33PzI0dvGwcXNwrY@z>

Hi Kevin,

On 2019/4/9 16:28, Kevin Wolf wrote:
> Am 09.04.2019 um 08:01 hat Markus Armbruster geschrieben:
>> L=C3=A1szl=C3=B3's last sentence below is "This really needs the atten=
tion of the
>> block people."  Cc'ing some.
>>
>> Laszlo Ersek <lersek@redhat.com> writes:
>>
>>> On 04/08/19 15:43, Xiang Zheng wrote:
>>>>
>>>> On 2019/4/3 23:35, Laszlo Ersek wrote:
>>>>>> I thought about your comments and wrote the following patch (just =
for test)
>>>>>> which uses a file mapping to replace the anonymous mapping. UEFI s=
eems to work
>>>>>> fine. So why not use a file mapping to read or write a pflash devi=
ce?
>>>>> Honestly I can't answer "why not do this". Maybe we should.
>>>>>
>>>>> Regarding "why not do this *exactly as shown below*" -- probably be=
cause
>>>>> then we'd have updates to the same underlying regular file via both
>>>>> mmap() and write(), and the interactions between those are really t=
ricky
>>>>> (=3D best avoided).
>>>>>
>>>>> One of my favorite questions over the years used to be posting a ma=
trix
>>>>> of possible mmap() and file descriptor r/w/sync interactions, with =
the
>>>>> outcomes as they were "implied" by POSIX, and then asking at the bo=
ttom,
>>>>> "is my understanding correct?" I've never ever received an answer t=
o
>>>>> that. :)
>>>>
>>>> In my opinion, it's feasible to r/w/sync the memory devices which us=
e a block
>>>> backend via mmap() and write().
>>>
>>> Maybe. I think that would be a first in QEMU, and you'd likely have t=
o
>>> describe and follow a semi-formal model between fd actions and mmap()
>>> actions.
>>>
>>> Here's the (unconfirmed) table I referred to earlier.
>>>
>>> +-------------+-----------------------------------------------------+
>>> | change made | change visible via                                  |
>>> | through     +-----------------+-------------+---------------------+
>>> |             | MAP_SHARED      | MAP_PRIVATE | read()              |
>>> +-------------+-----------------+-------------+---------------------+
>>> | MAP_SHARED  | yes             | unspecified | depends on MS_SYNC, |
>>> |             |                 |             | MS_ASYNC, or normal |
>>> |             |                 |             | system activity     |
>>> +-------------+-----------------+-------------+---------------------+
>>> | MAP_PRIVATE | no              | no          | no                  |
>>> +-------------+-----------------+-------------+---------------------+
>>> | write()     | depends on      | unspecified | yes                 |
>>> |             | MS_INVALIDATE,  |             |                     |
>>> |             | or the system's |             |                     |
>>> |             | read/write      |             |                     |
>>> |             | consistency     |             |                     |
>>> +-------------+-----------------+-------------+---------------------+
>>>
>>> Presumably:
>>>
>>> - a write() to some offset range of a regular file should be visible =
in
>>> a MAP_SHARED mapping of that range after a matching msync(...,
>>> MS_INVALIDATE) call;
>>>
>>> - changes through a MAP_SHARED mapping to a regular file should be
>>> visible via read() after a matching msync(..., MS_SYNC) call returns.
>>>
>>> I sent this table first in 2010 to the Austin Group mailing list, and
>>> received no comments. Then another person (on the same list) asked
>>> basically the same questions in 2013, to which I responded with the
>>> above assumptions / interpretations -- and received no comments from
>>> third parties again.
>>>
>>> But, I'm really out of my depth here -- we're not even discussing
>>> generic read()/write()/mmap()/munmap()/msync() interactions, but how
>>> they would fit into the qemu block layer. And I have no idea.
>=20
> There is no infrastructure in the block layer for mmapping image files.
>=20
>>>>> Also... although we don't really use them in practice, some QCOW2
>>>>> features for pflash block backends are -- or would be -- nice. (Not=
 the
>>>>> internal snapshots or the live RAM dumps, of course.)
>>>>
>>>> Regarding sparse files, can we read actual backend size data for the=
 read-only
>>>> pflash memory as the following steps shown?
>>>>
>>>> 1) Create a sparse file -- QEMU_EFI-test.raw:
>>>>    dd if=3D/dev/zero of=3DQEMU_EFI-test.raw bs=3D1M seek=3D64 count=3D=
0
>>>>
>>>> 2) Read from QEMU_EFI.fd and write to QEMU_EFI-test.raw:
>>>>    dd of=3D"QEMU_EFI-test.raw" if=3D"QEMU_EFI.fd" conv=3Dnotrunc
>>>>
>>>> 3) Use QEMU_EFI-test.raw as the read-only pflash and start qemu with=
 the below
>>>> patch applied:
>>>>
>>>> ---8>---
>>>>
>>>> diff --git a/hw/block/block.c b/hw/block/block.c
>>>> index bf56c76..ad18d5e 100644
>>>> --- a/hw/block/block.c
>>>> +++ b/hw/block/block.c
>>>> @@ -30,7 +30,7 @@
>>>>  bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwad=
dr size,
>>>>                                   Error **errp)
>>>>  {
>>>> -    int64_t blk_len;
>>>> +    int64_t blk_len, actual_len;
>>>>      int ret;
>>>>
>>>>      blk_len =3D blk_getlength(blk);
>>>> @@ -53,7 +53,9 @@ bool blk_check_size_and_read_all(BlockBackend *blk=
, void *buf, hwaddr size,
>>>>       * block device and read only on demand.
>>>>       */
>>>>      assert(size <=3D BDRV_REQUEST_MAX_BYTES);
>>>> -    ret =3D blk_pread(blk, 0, buf, size);
>>>> +    actual_len =3D bdrv_get_allocated_file_size(blk_bs(blk));
>>>> +    ret =3D blk_pread(blk, 0, buf,
>>>> +            (!blk_is_read_only(blk) || actual_len < 0) ? size : act=
ual_len);
>>>>      if (ret < 0) {
>>>>          error_setg_errno(errp, -ret, "can't read block backend");
>>>>          return false;
>>>>
>>>
>>> This hunk looks dubious for a general helper function. It seems to
>>> assume that the holes are punched at the end of the file.
>>>
>>> Sorry, this discussion is making me uncomfortable. I don't want to
>>> ignore your questions, but I have no idea about the right answers. Th=
is
>>> really needs the attention of the block people.
>=20
> Yes, this code is wrong. bdrv_get_allocated_file_size() isn't even
> implemented in all block drivers, and when it is implemented it isn't
> necessarily reliable (e.g. return 0 for block devices). It's fine for
> 'qemu-img info', but that's it.
>=20
> But even if you actually get the correct allocated file size, that's th=
e
> disk space used on the host filesystem, so it doesn't include any holes=
,
> but it does include image format metadata, the data could possibly be
> compressed etc. In other words, for a guest device it's completely
> meaningless.
>=20
> I'm not even sure why you would want to do this even in your special
> case of a raw image that is sparse only at the end. Is it an
> optimisation to avoid reading zeros? This ends up basically being
> memset() for sparse blocks, so very quick. And I think you do want to
> zero out the remaining part of the buffer anyway. So it looks to me as
> if it were complicating the code for no use.

The primary target of this discussion is to save the memory allocated
for UEFI firmware device. On virtual machine, we split it into two flash
devices[1] -- one is read-only in 64MB size and another is read-write in
64MB size. The qemu commandline is:

   -drive file=3DQEMU_EFI-pflash.raw,if=3Dpflash,format=3Draw,unit=3D0,re=
adonly=3Don \
   -drive file=3Dempty_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 \

Regarding the read-only one which are created from QEMU_EFI.fd, the origi=
nal
QEMU_EFI.fd is only 2MB in size and we need to stuff it to 64MB with 62MB
'zeros':

   dd of=3D"QEMU_EFI-pflash.raw" if=3D"/dev/zero" bs=3D1M count=3D64
   dd of=3D"QEMU_EFI-pflash.raw" if=3D"QEMU_EFI.fd" conv=3Dnotrunc

For some historical reasons such as compatibility and extensibility[2], w=
e
restrict both their size to 64MB -- both UEFI and qemu have cold hard
constants.

This will consume a large amount of memory when running multiple VM
simultaneously (each guest needs 128MB).

There are accepted ideas proposed by Markus and Laszlo from prior discuss=
ion[3]:

1) Getting flash memory size from a machine type or property.

2) Map the read-only part so it is shared among guests; Map the read-writ=
e
part normally.

The first idea called explicit configuration which may break migration.

For the second idea, the only way I can imagine is using a file mapping t=
o
read or write pflash devices so that we can allocate memory on demand. So=
 I
tried to fit mmap() actions into the block layer[4]. However I am not sur=
e
that maping image file whether can work fine for block layer.

On the other hand, Laszlo had mentioned the features of QCOW2 and sparse
files which may be nice for pflash block backends. But I am not familiar =
with
it.

Till now I still have no idea to get rid of this problem (more properly i=
t's
a optimization).


[1]https://lists.nongnu.org/archive/html/qemu-devel/2019-01/msg06606.html
[2]https://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg07009.html
[3]https://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg07107.html
[4]https://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg00719.html

--=20

Thanks,
Xiang



