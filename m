Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918EEC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5B920883
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 06:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5B920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDjql-0005t1-Vm
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 02:03:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjpK-0005Bv-4t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjpI-0006Ss-5E
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:01:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hDjpA-0006Le-9e; Tue, 09 Apr 2019 02:01:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0988320276;
	Tue,  9 Apr 2019 06:01:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A5CA61090;
	Tue,  9 Apr 2019 06:01:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 127741138648; Tue,  9 Apr 2019 08:01:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
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
Date: Tue, 09 Apr 2019 08:01:27 +0200
In-Reply-To: <a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com> (Laszlo Ersek's
	message of "Mon, 8 Apr 2019 18:14:15 +0200")
Message-ID: <87bm1fiuo8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Tue, 09 Apr 2019 06:01:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-block@nongnu.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
	Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Heyi Guo <guoheyi@huawei.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409060127.PszrfsQmK7gKx_B9J0rp9PciUvSswOkq-gTqSZvVD_4@z>

L=C3=A1szl=C3=B3's last sentence below is "This really needs the attention =
of the
block people."  Cc'ing some.

Laszlo Ersek <lersek@redhat.com> writes:

> On 04/08/19 15:43, Xiang Zheng wrote:
>>=20
>> On 2019/4/3 23:35, Laszlo Ersek wrote:
>>>> I thought about your comments and wrote the following patch (just for =
test)
>>>> which uses a file mapping to replace the anonymous mapping. UEFI seems=
 to work
>>>> fine. So why not use a file mapping to read or write a pflash device?
>>> Honestly I can't answer "why not do this". Maybe we should.
>>>
>>> Regarding "why not do this *exactly as shown below*" -- probably because
>>> then we'd have updates to the same underlying regular file via both
>>> mmap() and write(), and the interactions between those are really tricky
>>> (=3D best avoided).
>>>
>>> One of my favorite questions over the years used to be posting a matrix
>>> of possible mmap() and file descriptor r/w/sync interactions, with the
>>> outcomes as they were "implied" by POSIX, and then asking at the bottom,
>>> "is my understanding correct?" I've never ever received an answer to
>>> that. :)
>>=20
>> In my opinion, it's feasible to r/w/sync the memory devices which use a =
block
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
>>=20
>>>
>>> Also... although we don't really use them in practice, some QCOW2
>>> features for pflash block backends are -- or would be -- nice. (Not the
>>> internal snapshots or the live RAM dumps, of course.)
>>=20
>> Regarding sparse files, can we read actual backend size data for the rea=
d-only
>> pflash memory as the following steps shown?
>>=20
>> 1) Create a sparse file -- QEMU_EFI-test.raw:
>>    dd if=3D/dev/zero of=3DQEMU_EFI-test.raw bs=3D1M seek=3D64 count=3D0
>>=20
>> 2) Read from QEMU_EFI.fd and write to QEMU_EFI-test.raw:
>>    dd of=3D"QEMU_EFI-test.raw" if=3D"QEMU_EFI.fd" conv=3Dnotrunc
>>=20
>> 3) Use QEMU_EFI-test.raw as the read-only pflash and start qemu with the=
 below
>> patch applied:
>>=20
>> ---8>---
>>=20
>> diff --git a/hw/block/block.c b/hw/block/block.c
>> index bf56c76..ad18d5e 100644
>> --- a/hw/block/block.c
>> +++ b/hw/block/block.c
>> @@ -30,7 +30,7 @@
>>  bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hwaddr s=
ize,
>>                                   Error **errp)
>>  {
>> -    int64_t blk_len;
>> +    int64_t blk_len, actual_len;
>>      int ret;
>>=20
>>      blk_len =3D blk_getlength(blk);
>> @@ -53,7 +53,9 @@ bool blk_check_size_and_read_all(BlockBackend *blk, vo=
id *buf, hwaddr size,
>>       * block device and read only on demand.
>>       */
>>      assert(size <=3D BDRV_REQUEST_MAX_BYTES);
>> -    ret =3D blk_pread(blk, 0, buf, size);
>> +    actual_len =3D bdrv_get_allocated_file_size(blk_bs(blk));
>> +    ret =3D blk_pread(blk, 0, buf,
>> +            (!blk_is_read_only(blk) || actual_len < 0) ? size : actual_=
len);
>>      if (ret < 0) {
>>          error_setg_errno(errp, -ret, "can't read block backend");
>>          return false;
>>=20
>
> This hunk looks dubious for a general helper function. It seems to
> assume that the holes are punched at the end of the file.
>
> Sorry, this discussion is making me uncomfortable. I don't want to
> ignore your questions, but I have no idea about the right answers. This
> really needs the attention of the block people.

