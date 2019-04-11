Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C83C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948962133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948962133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEYkk-0001Bm-5f
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:24:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEYjP-0000Xq-0q
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hEYjN-0003W5-Ib
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:23:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hEYjG-0003T3-G7; Thu, 11 Apr 2019 08:22:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB8A78AE50;
	Thu, 11 Apr 2019 12:22:52 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EEC8B60FB4;
	Thu, 11 Apr 2019 12:22:47 +0000 (UTC)
Date: Thu, 11 Apr 2019 14:22:46 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <20190411122246.GB5694@linux.fritz.box>
References: <87imw5fv45.fsf@dusky.pond.sub.org>
	<abe1d9cd-85bb-2ef8-630f-af28cae6378c@redhat.com>
	<8736n9eb4s.fsf@dusky.pond.sub.org>
	<bf2decd3-b3cb-08eb-3449-b66f023b084a@huawei.com>
	<c57135ae-41a9-ed7b-976b-bf8fe43596a2@redhat.com>
	<b107e0c0-1c4c-3f0f-eb78-8929c315ce28@huawei.com>
	<a8144a1f-364e-cea5-b0a7-05342bdab936@redhat.com>
	<87bm1fiuo8.fsf@dusky.pond.sub.org>
	<20190409082852.GB6610@localhost.localdomain>
	<c03c51a7-1bb0-b05b-9027-2364ab00517c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <c03c51a7-1bb0-b05b-9027-2364ab00517c@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 11 Apr 2019 12:22:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Message-ID: <20190411122246.sPYtaFZjPzSpII5ZvDpvee9_uU5ZLHUkl8BW34jbriY@z>

Am 10.04.2019 um 10:36 hat Xiang Zheng geschrieben:
> Hi Kevin,
>=20
> On 2019/4/9 16:28, Kevin Wolf wrote:
> > Am 09.04.2019 um 08:01 hat Markus Armbruster geschrieben:
> >> L=E1szl=F3's last sentence below is "This really needs the attention=
 of the
> >> block people."  Cc'ing some.
> >>
> >> Laszlo Ersek <lersek@redhat.com> writes:
> >>
> >>> On 04/08/19 15:43, Xiang Zheng wrote:
> >>>>
> >>>> On 2019/4/3 23:35, Laszlo Ersek wrote:
> >>>>>> I thought about your comments and wrote the following patch (jus=
t for test)
> >>>>>> which uses a file mapping to replace the anonymous mapping. UEFI=
 seems to work
> >>>>>> fine. So why not use a file mapping to read or write a pflash de=
vice?
> >>>>> Honestly I can't answer "why not do this". Maybe we should.
> >>>>>
> >>>>> Regarding "why not do this *exactly as shown below*" -- probably =
because
> >>>>> then we'd have updates to the same underlying regular file via bo=
th
> >>>>> mmap() and write(), and the interactions between those are really=
 tricky
> >>>>> (=3D best avoided).
> >>>>>
> >>>>> One of my favorite questions over the years used to be posting a =
matrix
> >>>>> of possible mmap() and file descriptor r/w/sync interactions, wit=
h the
> >>>>> outcomes as they were "implied" by POSIX, and then asking at the =
bottom,
> >>>>> "is my understanding correct?" I've never ever received an answer=
 to
> >>>>> that. :)
> >>>>
> >>>> In my opinion, it's feasible to r/w/sync the memory devices which =
use a block
> >>>> backend via mmap() and write().
> >>>
> >>> Maybe. I think that would be a first in QEMU, and you'd likely have=
 to
> >>> describe and follow a semi-formal model between fd actions and mmap=
()
> >>> actions.
> >>>
> >>> Here's the (unconfirmed) table I referred to earlier.
> >>>
> >>> +-------------+----------------------------------------------------=
-+
> >>> | change made | change visible via                                 =
 |
> >>> | through     +-----------------+-------------+--------------------=
-+
> >>> |             | MAP_SHARED      | MAP_PRIVATE | read()             =
 |
> >>> +-------------+-----------------+-------------+--------------------=
-+
> >>> | MAP_SHARED  | yes             | unspecified | depends on MS_SYNC,=
 |
> >>> |             |                 |             | MS_ASYNC, or normal=
 |
> >>> |             |                 |             | system activity    =
 |
> >>> +-------------+-----------------+-------------+--------------------=
-+
> >>> | MAP_PRIVATE | no              | no          | no                 =
 |
> >>> +-------------+-----------------+-------------+--------------------=
-+
> >>> | write()     | depends on      | unspecified | yes                =
 |
> >>> |             | MS_INVALIDATE,  |             |                    =
 |
> >>> |             | or the system's |             |                    =
 |
> >>> |             | read/write      |             |                    =
 |
> >>> |             | consistency     |             |                    =
 |
> >>> +-------------+-----------------+-------------+--------------------=
-+
> >>>
> >>> Presumably:
> >>>
> >>> - a write() to some offset range of a regular file should be visibl=
e in
> >>> a MAP_SHARED mapping of that range after a matching msync(...,
> >>> MS_INVALIDATE) call;
> >>>
> >>> - changes through a MAP_SHARED mapping to a regular file should be
> >>> visible via read() after a matching msync(..., MS_SYNC) call return=
s.
> >>>
> >>> I sent this table first in 2010 to the Austin Group mailing list, a=
nd
> >>> received no comments. Then another person (on the same list) asked
> >>> basically the same questions in 2013, to which I responded with the
> >>> above assumptions / interpretations -- and received no comments fro=
m
> >>> third parties again.
> >>>
> >>> But, I'm really out of my depth here -- we're not even discussing
> >>> generic read()/write()/mmap()/munmap()/msync() interactions, but ho=
w
> >>> they would fit into the qemu block layer. And I have no idea.
> >=20
> > There is no infrastructure in the block layer for mmapping image file=
s.
> >=20
> >>>>> Also... although we don't really use them in practice, some QCOW2
> >>>>> features for pflash block backends are -- or would be -- nice. (N=
ot the
> >>>>> internal snapshots or the live RAM dumps, of course.)
> >>>>
> >>>> Regarding sparse files, can we read actual backend size data for t=
he read-only
> >>>> pflash memory as the following steps shown?
> >>>>
> >>>> 1) Create a sparse file -- QEMU_EFI-test.raw:
> >>>>    dd if=3D/dev/zero of=3DQEMU_EFI-test.raw bs=3D1M seek=3D64 coun=
t=3D0
> >>>>
> >>>> 2) Read from QEMU_EFI.fd and write to QEMU_EFI-test.raw:
> >>>>    dd of=3D"QEMU_EFI-test.raw" if=3D"QEMU_EFI.fd" conv=3Dnotrunc
> >>>>
> >>>> 3) Use QEMU_EFI-test.raw as the read-only pflash and start qemu wi=
th the below
> >>>> patch applied:
> >>>>
> >>>> ---8>---
> >>>>
> >>>> diff --git a/hw/block/block.c b/hw/block/block.c
> >>>> index bf56c76..ad18d5e 100644
> >>>> --- a/hw/block/block.c
> >>>> +++ b/hw/block/block.c
> >>>> @@ -30,7 +30,7 @@
> >>>>  bool blk_check_size_and_read_all(BlockBackend *blk, void *buf, hw=
addr size,
> >>>>                                   Error **errp)
> >>>>  {
> >>>> -    int64_t blk_len;
> >>>> +    int64_t blk_len, actual_len;
> >>>>      int ret;
> >>>>
> >>>>      blk_len =3D blk_getlength(blk);
> >>>> @@ -53,7 +53,9 @@ bool blk_check_size_and_read_all(BlockBackend *b=
lk, void *buf, hwaddr size,
> >>>>       * block device and read only on demand.
> >>>>       */
> >>>>      assert(size <=3D BDRV_REQUEST_MAX_BYTES);
> >>>> -    ret =3D blk_pread(blk, 0, buf, size);
> >>>> +    actual_len =3D bdrv_get_allocated_file_size(blk_bs(blk));
> >>>> +    ret =3D blk_pread(blk, 0, buf,
> >>>> +            (!blk_is_read_only(blk) || actual_len < 0) ? size : a=
ctual_len);
> >>>>      if (ret < 0) {
> >>>>          error_setg_errno(errp, -ret, "can't read block backend");
> >>>>          return false;
> >>>>
> >>>
> >>> This hunk looks dubious for a general helper function. It seems to
> >>> assume that the holes are punched at the end of the file.
> >>>
> >>> Sorry, this discussion is making me uncomfortable. I don't want to
> >>> ignore your questions, but I have no idea about the right answers. =
This
> >>> really needs the attention of the block people.
> >=20
> > Yes, this code is wrong. bdrv_get_allocated_file_size() isn't even
> > implemented in all block drivers, and when it is implemented it isn't
> > necessarily reliable (e.g. return 0 for block devices). It's fine for
> > 'qemu-img info', but that's it.
> >=20
> > But even if you actually get the correct allocated file size, that's =
the
> > disk space used on the host filesystem, so it doesn't include any hol=
es,
> > but it does include image format metadata, the data could possibly be
> > compressed etc. In other words, for a guest device it's completely
> > meaningless.
> >=20
> > I'm not even sure why you would want to do this even in your special
> > case of a raw image that is sparse only at the end. Is it an
> > optimisation to avoid reading zeros? This ends up basically being
> > memset() for sparse blocks, so very quick. And I think you do want to
> > zero out the remaining part of the buffer anyway. So it looks to me a=
s
> > if it were complicating the code for no use.
>=20
> The primary target of this discussion is to save the memory allocated
> for UEFI firmware device. On virtual machine, we split it into two flas=
h
> devices[1] -- one is read-only in 64MB size and another is read-write i=
n
> 64MB size. The qemu commandline is:
>=20
>    -drive file=3DQEMU_EFI-pflash.raw,if=3Dpflash,format=3Draw,unit=3D0,=
readonly=3Don \
>    -drive file=3Dempty_VARS.fd,if=3Dpflash,format=3Draw,unit=3D1 \
>=20
> Regarding the read-only one which are created from QEMU_EFI.fd, the ori=
ginal
> QEMU_EFI.fd is only 2MB in size and we need to stuff it to 64MB with 62=
MB
> 'zeros':
>=20
>    dd of=3D"QEMU_EFI-pflash.raw" if=3D"/dev/zero" bs=3D1M count=3D64
>    dd of=3D"QEMU_EFI-pflash.raw" if=3D"QEMU_EFI.fd" conv=3Dnotrunc
>=20
> For some historical reasons such as compatibility and extensibility[2],=
 we
> restrict both their size to 64MB -- both UEFI and qemu have cold hard
> constants.
>=20
> This will consume a large amount of memory when running multiple VM
> simultaneously (each guest needs 128MB).

Okay, so your problem is that blk_pread() writes to the whole buffer,
writing explicit zeroes for unallocated parts of the image, while you
would like to leave those parts of the buffer untouched so that we don't
actually allocate the memory, but can just use the shared zero page.

If you just want to read the non-zero parts of the image, that can be
done by using a loop that calls bdrv_block_status() and only reads from
the image if the BDRV_BLOCK_ZERO bit is clear.

Would this solve your problem?

Kevin

