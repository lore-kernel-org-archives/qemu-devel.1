Received: from eggs.gnu.org ([2001:4830:134:3::10]:34859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eJMSP-0001Rg-VF
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eJMSJ-0005a0-Qs
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:40:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eJMSJ-0005ZC-Gr
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:40:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vARGdChc097653
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 11:40:24 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2egns4a8cx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 11:40:24 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 16:40:22 -0000
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<3acc6fdb-5638-97b2-2dc7-bce34d22cd1f@redhat.com>
	<20171123104903.24424b40.cohuck@redhat.com>
	<a3655016-0e6b-b80f-2282-f6efbff9e1f9@redhat.com>
	<20171123110844.4649f3b1.cohuck@redhat.com>
	<58a08c1d-3935-42e7-cdc0-7bc45c08d2d3@redhat.com>
	<20171123113326.3b2c5281.cohuck@redhat.com>
	<6ab0d29e-1af0-888a-c932-a0a294ea225d@linux.vnet.ibm.com>
	<d59edb51-71ba-7b75-83df-e4be246d2fce@redhat.com>
	<4000596f-d2a0-c32e-7683-7e074e8132e2@linux.vnet.ibm.com>
	<37aa6eb3-cbdf-39af-2068-7d0e5949e601@linux.vnet.ibm.com>
	<2ab76ab0-b20a-9eaf-cafb-195e1621edd6@redhat.com>
	<20171127120255.2d36c8f3.cohuck@redhat.com>
	<20171127153436.200a01c7.cohuck@redhat.com>
	<c0fd850b-3d6f-4a4b-f9e0-e5009a273be0@linux.vnet.ibm.com>
	<20171127163055.6c9989cf.cohuck@redhat.com>
	<b4f9fd77-4efa-ad51-73f1-bcd17ec0ede4@linux.vnet.ibm.com>
	<20171127170242.170d01f6.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 17:40:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171127170242.170d01f6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d83da95d-63a1-39ac-40d7-63b6ca3a8697@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 1/7] s390x/pci: factor out
 endianess conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Qemu-s390x list <qemu-s390x@nongnu.org>

On 27/11/2017 17:02, Cornelia Huck wrote:
> On Mon, 27 Nov 2017 16:53:04 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> On 27/11/2017 16:30, Cornelia Huck wrote:
>>> On Mon, 27 Nov 2017 16:24:08 +0100
>>> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>>>   =20
>>>> On 27/11/2017 15:34, Cornelia Huck wrote:
>>>>> On Mon, 27 Nov 2017 12:02:55 +0100
>>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>>      =20
>>>>>> On Mon, 27 Nov 2017 07:59:36 +0100
>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>     =20
>>>>>>> On 25.11.2017 14:49, Pierre Morel wrote:
>>>>>>>> On 24/11/2017 07:19, Yi Min Zhao wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=888:18, Thomas Huth =E5=86=
=99=E9=81=93:
>>>>>>>>>> On 23.11.2017 13:07, Yi Min Zhao wrote:
>>>>>>     =20
>>>>>>>>>>> Another question, does 'cpu' in cpu_to_le**() or le**_to_cpu(=
) mean the
>>>>>>>>>>> host endianess?
>>>>>>>>>> Yes, the "cpu" in cpu_to_le or le_to_cpu means the host, indee=
d. It's
>>>>>>>>>> confusing :-/
>>>>>>>>>>          =20
>>>>>>>>>>> If the answers to upper two questions are yes, we actually ne=
ed handle
>>>>>>>>>>> two cases.
>>>>>>>>>>> 1) For pcilg, we need to translate the data to little-endian,=
 thus
>>>>>>>>>>> cpu_to_le**().
>>>>>>>>>>> 2) For pcistg, we need to translate the data to host endianes=
s, thus
>>>>>>>>>>> le**_to_cpu().
>>>>>>>>>> I think we've got to byte-swap if the host is big endian (s390=
x), but
>>>>>>>>>> not if the host is little endian (x86 with TCG).
>>>>>>>>
>>>>>>>> Here is my comprehension of this funny swapping:
>>>>>>>>
>>>>>>>> - TCG for a BE guest and a le host swap bytes because if we do (=
register
>>>>>>>> & 0x01) in the zPCI interception code it must work what ever the
>>>>>>>> endianess is.
>>>>>>>
>>>>>>> Uhhh, I might have missed that the value has already been byte-sw=
apped
>>>>>>> once by TCG for env->regs[r1] ...
>>>>>>> Now I'm pretty much completely confused ... sorry for the noise i=
f I was
>>>>>>> wrong... I think it's best you ignore my comment for now (i.e. go=
 with
>>>>>>> bswapXX() instead of le_to_cpuXX()), and if we later wire up zPCI=
 with
>>>>>>> TCG, we still can fix this if necessary.
>>>>>>
>>>>>> I'll try my current pci/tcg patches on LPAR with this (or a v4) on=
 top.
>>>>>> If it works there (it doesn't yet on my laptop), we do have a
>>>>>> endianness issue... (unfortunately, the reverse isn't true.)
>>>>>
>>>>> It does not look too bad: I can get a nice enP1p0s0 device from a
>>>>> virtio-net-pci with my tcg patches on my laptop (with these patches=
 as
>>>>> well, of course). So, endianness is likely mostly fine.
>>>>
>>>> On the Lpar and on the Laptop or only on the Lpar ?
>>>
>>> Both :)
>>
>> That's great! :)
>=20
> Btw, lspci says
>=20
> 0001:00:00.0 Ethernet controller: Red Hat, Inc. Virtio network device
>          Subsystem: Red Hat, Inc. Device 0001
>          Physical Slot: 00000000
>          Flags: bus master, fast devsel, latency 0
>          I/O ports at <unassigned> [disabled]
>          [virtual] Memory at 8001000000000000 (32-bit, non-prefetchable=
) [size=3D4K]
>          Memory at 8002000000000000 (64-bit, prefetchable) [size=3D16K]
>          Expansion ROM at <unassigned> [disabled] [size=3D256K]
>          Capabilities: [98] MSI-X: Enable+ Count=3D3 Masked-
>          Capabilities: [84] Vendor Specific Information: VirtIO: <unkno=
wn>
>          Capabilities: [70] Vendor Specific Information: VirtIO: Notify
>          Capabilities: [60] Vendor Specific Information: VirtIO: Device=
Cfg
>          Capabilities: [50] Vendor Specific Information: VirtIO: ISR
>          Capabilities: [40] Vendor Specific Information: VirtIO: Common=
Cfg
>          Kernel driver in use: virtio-pci
>=20
> Does that look reasonable to you?
>=20

Yes, I see no problem in what is listed.
Slot, memory, ROM, I/O port look reasonable to me.
The 4 Vendor Specific informations look like the VIRTIO subregions from B=
AR





--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
