Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D23DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:17:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223D720833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 06:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223D720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibf1u-0007xV-9T
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 01:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1ibf17-0007Yp-Tg
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1ibf16-0002Qt-2F
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:17:05 -0500
Received: from thoth.sbs.de ([192.35.17.2]:59111)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1ibf15-0002Qf-Or
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 01:17:04 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id xB26GxtF019753
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Dec 2019 07:16:59 +0100
Received: from [167.87.6.91] ([167.87.6.91])
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id xB26Gv0X023939;
 Mon, 2 Dec 2019 07:16:58 +0100
Subject: Re: [RFC][PATCH 0/3] IVSHMEM version 2 device for QEMU
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Liang Yan <LYan@suse.com>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <efd5fa87-90de-fccc-97a5-a4fc71a050c8@suse.com>
 <fb213f9e-8bd8-6c33-7a6e-47dda982903d@siemens.com>
Message-ID: <0c6969db-848f-f05b-2dc0-589cb422aa56@siemens.com>
Date: Mon, 2 Dec 2019 07:16:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <fb213f9e-8bd8-6c33-7a6e-47dda982903d@siemens.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by thoth.sbs.de id
 xB26GxtF019753
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 192.35.17.2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27.11.19 18:19, Jan Kiszka wrote:
> Hi Liang,
>=20
> On 27.11.19 16:28, Liang Yan wrote:
>>
>>
>> On 11/11/19 7:57 AM, Jan Kiszka wrote:
>>> To get the ball rolling after my presentation of the topic at KVM For=
um
>>> [1] and many fruitful discussions around it, this is a first concrete
>>> code series. As discussed, I'm starting with the IVSHMEM implementati=
on
>>> of a QEMU device and server. It's RFC because, besides specification =
and
>>> implementation details, there will still be some decisions needed abo=
ut
>>> how to integrate the new version best into the existing code bases.
>>>
>>> If you want to play with this, the basic setup of the shared memory
>>> device is described in patch 1 and 3. UIO driver and also the
>>> virtio-ivshmem prototype can be found at
>>>
>>>     =20
>>> http://git.kiszka.org/?p=3Dlinux.git;a=3Dshortlog;h=3Drefs/heads/queu=
es/ivshmem2=20
>>>
>>>
>>> Accessing the device via UIO is trivial enough. If you want to use it
>>> for virtio, this is additionally to the description in patch 3 needed=
 on
>>> the virtio console backend side:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 modprobe uio_ivshmem
>>> =C2=A0=C2=A0=C2=A0=C2=A0 echo "1af4 1110 1af4 1100 ffc003 ffffff" >=20
>>> /sys/bus/pci/drivers/uio_ivshmem/new_id
>>> =C2=A0=C2=A0=C2=A0=C2=A0 linux/tools/virtio/virtio-ivshmem-console /d=
ev/uio0
>>>
>>> And for virtio block:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 echo "1af4 1110 1af4 1100 ffc002 ffffff" >=20
>>> /sys/bus/pci/drivers/uio_ivshmem/new_id
>>> =C2=A0=C2=A0=C2=A0=C2=A0 linux/tools/virtio/virtio-ivshmem-console /d=
ev/uio0=20
>>> /path/to/disk.img
>>>
>>> After that, you can start the QEMU frontend instance with the
>>> virtio-ivshmem driver installed which can use the new /dev/hvc* or
>>> /dev/vda* as usual.
>>>
>>> Any feedback welcome!
>>
>> Hi, Jan,
>>
>> I have been playing your code for last few weeks, mostly study and tes=
t,
>> of course. Really nice work. I have a few questions here:
>>
>> First, qemu part looks good, I tried test between couple VMs, and devi=
ce
>> could pop up correctly for all of them, but I had some problems when
>> trying load driver. For example, if set up two VMs, vm1 and vm2, start
>> ivshmem server as you suggested. vm1 could load uio_ivshmem and
>> virtio_ivshmem correctly, vm2 could load uio_ivshmem but could not sho=
w
>> up "/dev/uio0", virtio_ivshmem could not be loaded at all, these still
>> exist even I switch the load sequence of vm1 and vm2, and sometimes
>> reset "virtio_ivshmem" could crash both vm1 and vm2. Not quite sure th=
is
>> is bug or "Ivshmem Mode" issue, but I went through ivshmem-server code=
,
>> did not related information.
>=20
> If we are only talking about one ivshmem link and vm1 is the master,=20
> there is not role for virtio_ivshmem on it as backend. That is purely a=
=20
> frontend driver. Vice versa for vm2: If you want to use its ivshmem=20
> instance as virtio frontend, uio_ivshmem plays no role.
>=20
> The "crash" is would be interesting to understand: Do you see kernel=20
> panics of the guests? Or are they stuck? Or are the QEMU instances=20
> stuck? Do you know that you can debug the guest kernels via gdb (and=20
> gdb-scripts of the kernel)?
>=20
>>
>> I started some code work recently, such as fix code style issues and
>> some work based on above testing, however I know you are also working =
on
>> RFC V2, beside the protocol between server-client and client-client is
>> not finalized yet either, things may change, so much appreciate if you
>> could squeeze me into your develop schedule and share with me some
>> plans, :-)=C2=A0 Maybe I could send some pull request in your github r=
epo?
>=20
> I'm currently working on a refresh of the Jailhouse queue and the kerne=
l=20
> patches to incorporate just two smaller changes:
>=20
>  =C2=A0- use Siemens device ID
>  =C2=A0- drop "features" register from ivshmem device
>=20
> I have not yet touched the QEMU code for that so far, thus no conflict=20
> yet. I would wait for your patches then.
>=20
> If it helps us to work on this together, I can push things to github as=
=20
> well. Will drop you a note when done. We should just present the outcom=
e=20
> frequently as new series to the list.

I've updated my queues, mostly small changes, mostly to the kernel bits.=20
Besides the already announced places, you can also find them as PR=20
targets on

https://github.com/siemens/qemu/commits/wip/ivshmem2
https://github.com/siemens/linux/commits/queues/ivshmem2

To give the whole thing broader coverage, I will now also move forward=20
and integrate the current state into Jailhouse - at the risk of having=20
to rework the interface there once again. But there are a number of=20
users already requiring the extended features (or even using them), plus=20
this gives a nice test coverage of key components and properties.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

