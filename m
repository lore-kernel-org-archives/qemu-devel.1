Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4820C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 02:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4A42147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 02:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4A42147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLI94-0007OA-Qa
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 22:05:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1hLI6q-00067Z-4K
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 22:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1hLI6o-0000ip-Qp
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 22:03:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51092 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1hLI6o-0000hd-Al
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 22:03:02 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 8D72B4A1EBD5F9EC6816;
	Tue, 30 Apr 2019 10:02:57 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS411-HUB.china.huawei.com
	(10.3.19.211) with Microsoft SMTP Server id 14.3.439.0;
	Tue, 30 Apr 2019 10:02:48 +0800
Message-ID: <5CC7ACC7.2010306@huawei.com>
Date: Tue, 30 Apr 2019 10:02:47 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: =?UTF-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
References: <1556523569-44480-1-git-send-email-longpeng2@huawei.com>
	<7e19e93d-9ad4-51a8-3c1e-ed4d1672a47f@redhat.com>
	<5CC6E333.90108@huawei.com>
	<a14a352c-2587-11a6-7068-01bf52bac817@redhat.com>
In-Reply-To: <a14a352c-2587-11a6-7068-01bf52bac817@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.32
Subject: Re: [Qemu-devel] [PATCH] usb/xchi: avoid trigger assertion if guest
 write wrong epid
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
Cc: Gonglei <arei.gonglei@huawei.com>, kraxel@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430020247.bSK08QXQKrBLs3vdwc8g5ZSkGuZ9b2SiLCPzazE1giw@z>



On 2019/4/29 20:10, Philippe Mathieu-Daud=C3=A9 wrote:

> On 4/29/19 1:42 PM, Longpeng (Mike) wrote:
>> Hi Philippe,
>>
>> On 2019/4/29 19:16, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>>> Hi Mike,
>>>
>>> On 4/29/19 9:39 AM, Longpeng(Mike) wrote:
>>>> From: Longpeng <longpeng2@huawei.com>
>>>>
>>>> we found the following core in our environment:
>>>> 0  0x00007fc6b06c2237 in raise ()
>>>> 1  0x00007fc6b06c3928 in abort ()
>>>> 2  0x00007fc6b06bb056 in __assert_fail_base ()
>>>> 3  0x00007fc6b06bb102 in __assert_fail ()
>>>> 4  0x0000000000702e36 in xhci_kick_ep (...)
>>>
>>>   5 xhci_doorbell_write?
>>>
>>>> 6  0x000000000047767f in access_with_adjusted_size (...)
>>>> 7  0x000000000047944d in memory_region_dispatch_write (...)
>>>> 8  0x000000000042df17 in address_space_write_continue (...)
>>>> 10 0x000000000043084d in address_space_rw (...)
>>>> 11 0x000000000047451b in kvm_cpu_exec (cpu=3Dcpu@entry=3D0x1ab11b0)
>>>> 12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=3D0x1ab11b0)
>>>> 13 0x0000000000870631 in qemu_thread_start (args=3Dargs@entry=3D0x1a=
cfb50)
>>>> 14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=3D<opti=
mized out>)
>>>> 15 0x00007fc6b0a60dd5 in start_thread ()
>>>> 16 0x00007fc6b078a59d in clone ()
>>>> (gdb) bt
>>>> (gdb) f 5
>>>
>>> This is the frame you removed...
>>>
>>>> (gdb) p /x tmp
>>>> $9 =3D 0x62481a00 <-- last byte 0x00 is @epid
>>>
>>> I don't see 'tmp' in xhci_doorbell_write().
>>>
>>> Can you use trace events?
>>>
>>> There we have trace_usb_xhci_doorbell_write().
>>>
>>
>> Sorry , I'm careless to remove the important information.
>>
>>
>> This is our whole frame:
>>
>> (gdb) bt
>> #0  0x00007fc6b06c2237 in raise () from /usr/lib64/libc.so.6
>> #1  0x00007fc6b06c3928 in abort () from /usr/lib64/libc.so.6
>> #2  0x00007fc6b06bb056 in __assert_fail_base () from /usr/lib64/libc.s=
o.6
>> #3  0x00007fc6b06bb102 in __assert_fail () from /usr/lib64/libc.so.6
>> #4  0x0000000000702e36 in xhci_kick_ep (...)
>> #5  0x000000000047897a in memory_region_write_accessor (...)
>> #6  0x000000000047767f in access_with_adjusted_size (...)
>> #7  0x000000000047944d in memory_region_dispatch_write
>> (mr=3Dmr@entry=3D0x7fc6a0138df0, addr=3Daddr@entry=3D156, data=3D16488=
92416,
>> size=3Dsize@entry=3D4, attrs=3Dattrs@entry=3D...)
>=20
> So this is a 32-bit access, to address 156 (which is the slotid) and
> data=3D1648892416=3D0x62481a00 indeed.
>=20
> But watch out access_with_adjusted_size() calls adjust_endianness()...
>=20
>> #8  0x000000000042df17 in address_space_write_continue (...)
>> #9  0x00000000004302d5 in address_space_write (...)
>> #10 0x000000000043084d in address_space_rw (...)
>> #11 0x000000000047451b in kvm_cpu_exec (...)
>> #12 0x000000000045dcf5 in qemu_kvm_cpu_thread_fn (arg=3D0x1ab11b0)
>> #13 0x0000000000870631 in qemu_thread_start (args=3Dargs@entry=3D0x1ac=
fb50)
>> #14 0x00000000008959a7 in thread_entry_for_hotfix (pthread_cb=3D<optim=
ized out>)
>> #15 0x00007fc6b0a60dd5 in start_thread () from /usr/lib64/libpthread.s=
o.0
>> #16 0x00007fc6b078a59d in clone () from /usr/lib64/libc.so.6
>>
>> (gdb) f 5
>> #5  0x000000000047897a in memory_region_write_accessor (...)
>> 529	    mr->ops->write(mr->opaque, addr, tmp, size);
>> (gdb) p /x tmp
>> $9 =3D 0x62481a00
>=20
> ... since memory_region_write_accessor() has the same argument, then I
> can assume your guest is running in Little-Endian.
>=20

Yes.

>> static void xhci_doorbell_write(void *ptr, hwaddr reg,
>>                                 uint64_t val, unsigned size)
>> So, the @val is 0x62481a00, and the last byte is epid, right?
>>
>>>>
>>>> xhci_doorbell_write() already check the upper bound of @slotid an @e=
pid,
>>>> it also need to check the lower bound.
>>>>
>>>> Cc: Gonglei <arei.gonglei@huawei.com>
>>>> Signed-off-by: Longpeng <longpeng2@huawei.com>
>>>> ---
>>>>  hw/usb/hcd-xhci.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>>> index ec28bee..b4e6bfc 100644
>>>> --- a/hw/usb/hcd-xhci.c
>>>> +++ b/hw/usb/hcd-xhci.c
>>>> @@ -3135,9 +3135,9 @@ static void xhci_doorbell_write(void *ptr, hwa=
ddr reg,
>>>
>>> Expanding the diff:
>>>
>>>        if (reg =3D=3D 0) {
>>>            if (val =3D=3D 0) {
>>>                xhci_process_commands(xhci);
>>>            } else {
>>>                DPRINTF("xhci: bad doorbell 0 write: 0x%x\n",
>>>                        (uint32_t)val);
>>>            }
>>>>      } else {
>>>>          epid =3D val & 0xff;
>>>>          streamid =3D (val >> 16) & 0xffff;
>>>> -        if (reg > xhci->numslots) {
>>>> +        if (reg =3D=3D 0 || reg > xhci->numslots) {
>>>
>>> So 'reg' can not be zero here...
>>>
>>
>> Oh, you're right.
>>
>>>>              DPRINTF("xhci: bad doorbell %d\n", (int)reg);
>>>> -        } else if (epid > 31) {
>>>> +        } else if (epid =3D=3D 0 || epid > 31) {
>>>
>>> Here neither.
>>>
>>
>> In our frame, the epid is zero. The @val is from guest which is untrus=
ted, when
>> this problem happened, I saw it wrote many invalid value, not only usb=
 but also
>> other devices.
>=20
> If you use mainstream QEMU, we have:
>=20
> static void qemu_xhci_instance_init(Object *obj)
> {
>     ...
>     xhci->numslots =3D MAXSLOTS;
>     ...
> }
>=20
> $ git grep define.*MAXSLOTS
> hw/usb/hcd-xhci.c:52:#define LEN_DOORBELL    ((MAXSLOTS + 1) * 0x20)
> hw/usb/hcd-xhci.h:33:#define MAXSLOTS 64
> hw/usb/hcd-xhci.h:37:#define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)
>=20
>>
>>>>              DPRINTF("xhci: bad doorbell %d write: 0x%x\n",
>>>>                      (int)reg, (uint32_t)val);
>>>>          } else {
>>>>
>>>
>>> Isn't it the other line that triggered the assertion?
>>>
>>> static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
>>>                          unsigned int epid, unsigned int streamid)
>>> {
>>>     XHCIEPContext *epctx;
>>>
>>>     assert(slotid >=3D 1 && slotid <=3D xhci->numslots); // <=3D=3D=3D
>=20
> slotid >=3D 1 // true
> slotid <=3D xhci->numslots // FALSE (156 > 64)
>=20
> So this assertion won't pass.
>=20

Oh, you miss the following code in xhci_doorbell_write():
    reg >>=3D 2;

So the @slotid pass to xhci_kick_ep() is 156/4 =3D 39 < 64 and the
'assert(slotid >=3D 1 && slotid <=3D xhci->numslots)' assertion will pass=
.

Check the @epid in xhci_doorbell_write() is still needed.

>>>     assert(epid >=3D 1 && epid <=3D 31);
>>>
>>> Regards,
>>>
>>> Phil.
>>>
>=20
> .
>=20


--=20
Regards,
Longpeng(Mike)


