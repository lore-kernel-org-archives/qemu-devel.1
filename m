Received: from eggs.gnu.org ([2001:4830:134:3::10]:46878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eJLHK-0005NZ-Qd
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eJLHH-0008Nb-Eh
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:25:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33658
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eJLHH-0008NP-8d
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 10:24:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vARFOs5c033515
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 10:24:56 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2egkp8w8sx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 10:24:55 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 15:24:12 -0000
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
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 16:24:08 +0100
MIME-Version: 1.0
In-Reply-To: <20171127153436.200a01c7.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <c0fd850b-3d6f-4a4b-f9e0-e5009a273be0@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Qemu-s390x list <qemu-s390x@nongnu.org>

On 27/11/2017 15:34, Cornelia Huck wrote:
> On Mon, 27 Nov 2017 12:02:55 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
>> On Mon, 27 Nov 2017 07:59:36 +0100
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> On 25.11.2017 14:49, Pierre Morel wrote:
>>>> On 24/11/2017 07:19, Yi Min Zhao wrote:
>>>>>
>>>>>
>>>>> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=888:18, Thomas Huth =E5=86=99=E9=
=81=93:
>>>>>> On 23.11.2017 13:07, Yi Min Zhao wrote:
>>
>>>>>>> Another question, does 'cpu' in cpu_to_le**() or le**_to_cpu() me=
an the
>>>>>>> host endianess?
>>>>>> Yes, the "cpu" in cpu_to_le or le_to_cpu means the host, indeed. I=
t's
>>>>>> confusing :-/
>>>>>>    =20
>>>>>>> If the answers to upper two questions are yes, we actually need h=
andle
>>>>>>> two cases.
>>>>>>> 1) For pcilg, we need to translate the data to little-endian, thu=
s
>>>>>>> cpu_to_le**().
>>>>>>> 2) For pcistg, we need to translate the data to host endianess, t=
hus
>>>>>>> le**_to_cpu().
>>>>>> I think we've got to byte-swap if the host is big endian (s390x), =
but
>>>>>> not if the host is little endian (x86 with TCG).
>>>>
>>>> Here is my comprehension of this funny swapping:
>>>>
>>>> - TCG for a BE guest and a le host swap bytes because if we do (regi=
ster
>>>> & 0x01) in the zPCI interception code it must work what ever the
>>>> endianess is.
>>>
>>> Uhhh, I might have missed that the value has already been byte-swappe=
d
>>> once by TCG for env->regs[r1] ...
>>> Now I'm pretty much completely confused ... sorry for the noise if I =
was
>>> wrong... I think it's best you ignore my comment for now (i.e. go wit=
h
>>> bswapXX() instead of le_to_cpuXX()), and if we later wire up zPCI wit=
h
>>> TCG, we still can fix this if necessary.
>>
>> I'll try my current pci/tcg patches on LPAR with this (or a v4) on top.
>> If it works there (it doesn't yet on my laptop), we do have a
>> endianness issue... (unfortunately, the reverse isn't true.)
>=20
> It does not look too bad: I can get a nice enP1p0s0 device from a
> virtio-net-pci with my tcg patches on my laptop (with these patches as
> well, of course). So, endianness is likely mostly fine.

On the Lpar and on the Laptop or only on the Lpar ?

>=20
>>
>> I'll post my pci/tcg patches once I get it mostly working (and it does
>> not look like a horror from the crypt anymore).
>=20
> Time to get out the make up kit for these.
>=20



--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
