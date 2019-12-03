Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F87C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0897C206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 07:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0897C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic2RW-0006Q1-CO
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 02:17:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.kiszka@siemens.com>) id 1ic2Om-0005LO-UN
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:15:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1ic2Ol-0008As-5q
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:15:04 -0500
Received: from goliath.siemens.de ([192.35.17.28]:49250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1ic2Oj-000874-QT
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 02:15:02 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
 by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id xB37Euf8022422
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Dec 2019 08:14:57 +0100
Received: from [167.87.39.168] ([167.87.39.168])
 by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id xB37EtoJ008189;
 Tue, 3 Dec 2019 08:14:55 +0100
Subject: Re: [RFC][PATCH 0/3] IVSHMEM version 2 device for QEMU
To: Liang Yan <LYan@suse.com>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <efd5fa87-90de-fccc-97a5-a4fc71a050c8@suse.com>
 <fb213f9e-8bd8-6c33-7a6e-47dda982903d@siemens.com>
 <0c6969db-848f-f05b-2dc0-589cb422aa56@siemens.com>
 <877b0cd9-d1c5-00c9-c4b6-567c67740962@suse.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8397c8c4-eeda-1805-ada3-6ca0155ee63d@siemens.com>
Date: Tue, 3 Dec 2019 08:14:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <877b0cd9-d1c5-00c9-c4b6-567c67740962@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by goliath.siemens.de id
 xB37Euf8022422
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 192.35.17.28
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

On 03.12.19 06:53, Liang Yan wrote:
>=20
> On 12/2/19 1:16 AM, Jan Kiszka wrote:
>> On 27.11.19 18:19, Jan Kiszka wrote:
>>> Hi Liang,
>>>
>>> On 27.11.19 16:28, Liang Yan wrote:
>>>>
>>>>
>>>> On 11/11/19 7:57 AM, Jan Kiszka wrote:
>>>>> To get the ball rolling after my presentation of the topic at KVM F=
orum
>>>>> [1] and many fruitful discussions around it, this is a first concre=
te
>>>>> code series. As discussed, I'm starting with the IVSHMEM implementa=
tion
>>>>> of a QEMU device and server. It's RFC because, besides specificatio=
n
>>>>> and
>>>>> implementation details, there will still be some decisions needed a=
bout
>>>>> how to integrate the new version best into the existing code bases.
>>>>>
>>>>> If you want to play with this, the basic setup of the shared memory
>>>>> device is described in patch 1 and 3. UIO driver and also the
>>>>> virtio-ivshmem prototype can be found at
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0
>>>>> http://git.kiszka.org/?p=3Dlinux.git;a=3Dshortlog;h=3Drefs/heads/qu=
eues/ivshmem2
>>>>>
>>>>>
>>>>> Accessing the device via UIO is trivial enough. If you want to use =
it
>>>>> for virtio, this is additionally to the description in patch 3
>>>>> needed on
>>>>> the virtio console backend side:
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 modprobe uio_ivshmem
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 echo "1af4 1110 1af4 1100 ffc003 ffffff" >
>>>>> /sys/bus/pci/drivers/uio_ivshmem/new_id
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 linux/tools/virtio/virtio-ivshmem-console =
/dev/uio0
>>>>>
>>>>> And for virtio block:
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 echo "1af4 1110 1af4 1100 ffc002 ffffff" >
>>>>> /sys/bus/pci/drivers/uio_ivshmem/new_id
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 linux/tools/virtio/virtio-ivshmem-console =
/dev/uio0
>>>>> /path/to/disk.img
>>>>>
>>>>> After that, you can start the QEMU frontend instance with the
>>>>> virtio-ivshmem driver installed which can use the new /dev/hvc* or
>>>>> /dev/vda* as usual.
>>>>>
>>>>> Any feedback welcome!
>>>>
>>>> Hi, Jan,
>>>>
>>>> I have been playing your code for last few weeks, mostly study and t=
est,
>>>> of course. Really nice work. I have a few questions here:
>>>>
>>>> First, qemu part looks good, I tried test between couple VMs, and de=
vice
>>>> could pop up correctly for all of them, but I had some problems when
>>>> trying load driver. For example, if set up two VMs, vm1 and vm2, sta=
rt
>>>> ivshmem server as you suggested. vm1 could load uio_ivshmem and
>>>> virtio_ivshmem correctly, vm2 could load uio_ivshmem but could not s=
how
>>>> up "/dev/uio0", virtio_ivshmem could not be loaded at all, these sti=
ll
>>>> exist even I switch the load sequence of vm1 and vm2, and sometimes
>>>> reset "virtio_ivshmem" could crash both vm1 and vm2. Not quite sure =
this
>>>> is bug or "Ivshmem Mode" issue, but I went through ivshmem-server co=
de,
>>>> did not related information.
>>>
>>> If we are only talking about one ivshmem link and vm1 is the master,
>>> there is not role for virtio_ivshmem on it as backend. That is purely
>>> a frontend driver. Vice versa for vm2: If you want to use its ivshmem
>>> instance as virtio frontend, uio_ivshmem plays no role.
>>>
> Hi, Jan,
>=20
> Sorry for the late response. Just came back from Thanksgiving holiday.
>=20
> I have a few questions here.
> First, how to decide master/slave node? I used two VMs here, they did
> not show same behavior even if I change the boot sequence.

The current mechanism works by selecting the VM gets ID 0 as the
backend, thus sending it also a different protocol ID than the frontend
gets. Could possibly be improved by allowing selection also on the VM
side (QEMU command line parameter etc.).

Inherently, this only affects virtio over ivshmem. Other, symmetric
protocols do not need this differentiation.

>=20
> Second, in order to run virtio-ivshmem-console demo, VM1 connect to VM2
> Console. So, need to install virtio frontend driver in VM2, then instal=
l
> uio frontend driver in VM1 to get "/dev/uio0", then run demo, right?
> Could you share your procedure?
>=20
> Also, I could not get "/dev/uio0" all the time.

OK, should have collected this earlier. This is how I start the console
demo right now:

- ivshmem2-server -F -l 64K -n 2 -V 3 -P 0x8003
- start backend qemu with something like
  "-chardev socket,path=3D/tmp/ivshmem_socket,id=3Divshm
  -device ivshmem,chardev=3Divshm" in its command line
- inside that VM
   - modprobe uio_ivshmem
   - echo "110a 4106 1af4 1100 ffc003 ffffff" > \
     /sys/bus/pci/drivers/uio_ivshmem/new_id
   - virtio-ivshmem-console /dev/uio0
- start frontend qemu (can be identical options)

Now the frontend VM should see the ivshmem-virtio transport device and
attach a virtio console driver to it (/dev/hvc0). If you build the
transport into the kernel, you can even do "console=3Dhvc0".

>=20
>=20
>>> The "crash" is would be interesting to understand: Do you see kernel
>>> panics of the guests? Or are they stuck? Or are the QEMU instances
>>> stuck? Do you know that you can debug the guest kernels via gdb (and
>>> gdb-scripts of the kernel)?
>>>
>=20
> They are stuck, no kernel panics, It's like during console connection, =
I
> try to load/remove/reset module from the other side, then two VMs are
> stuck. One VM could still run if I killed the other VM. Like I said
> above, it may be just wrong operation from my side. I am working on
> ivshmem-block now, it is easier to understand for dual connection case.
>=20

As I said, would be good to have an exact description of steps how to
reproduce - or you could attach gdb to the instances and do a some
backtraces on where the VMs are stuck.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

