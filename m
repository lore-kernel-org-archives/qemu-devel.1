Received: from eggs.gnu.org ([2001:4830:134:3::10]:48662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eJCxK-0000yn-IE
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 01:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eJCxH-00046U-E1
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 01:31:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38094
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1eJCxH-00045K-8J
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 01:31:47 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAR6TOE7035016
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 01:31:46 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eg89v3du6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 01:31:45 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 27 Nov 2017 01:31:45 -0500
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
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2017 14:31:36 +0800
MIME-Version: 1.0
In-Reply-To: <37aa6eb3-cbdf-39af-2068-7d0e5949e601@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <2f341436-e52f-c045-992c-9a24a6fb358e@linux.vnet.ibm.com>
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
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Qemu-s390x list <qemu-s390x@nongnu.org>



=E5=9C=A8 2017/11/25 =E4=B8=8B=E5=8D=889:49, Pierre Morel =E5=86=99=E9=81=
=93:
> On 24/11/2017 07:19, Yi Min Zhao wrote:
>>
>>
>> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=888:18, Thomas Huth =E5=86=99=E9=81=
=93:
>>> On 23.11.2017 13:07, Yi Min Zhao wrote:
>>>>
>>>> =E5=9C=A8 2017/11/23 =E4=B8=8B=E5=8D=886:33, Cornelia Huck =E5=86=99=
=E9=81=93:
>>>>> On Thu, 23 Nov 2017 11:25:10 +0100
>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>
>>>>>> On 23.11.2017 11:08, Cornelia Huck wrote:
>>>>>>> On Thu, 23 Nov 2017 11:01:23 +0100
>>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>>> On 23.11.2017 10:49, Cornelia Huck wrote:
>>>>>>>>> On Thu, 23 Nov 2017 09:48:41 +0100
>>>>>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>>>>>> On 22.11.2017 23:05, Pierre Morel wrote:
>>>>>> [...]
>>>>>>>>>>> +/**
>>>>>>>>>>> + * Swap data contained in s390x big endian registers to litt=
le
>>>>>>>>>>> endian
>>>>>>>>>>> + * PCI bars.
>>>>>>>>>>> + *
>>>>>>>>>>> + * @ptr: a pointer to a uint64_t data field
>>>>>>>>>>> + * @len: the length of the valid data, must be 1,2,4 or 8
>>>>>>>>>>> + */
>>>>>>>>>>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>>>>>>>>>>> +{
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 uint64_t data =3D *ptr;
>>>>>>>>>>> +
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 switch (len) {
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 1:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 2:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap16(=
data);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 4:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap32(=
data);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 case 8:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D bswap64(=
data);
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 *ptr =3D data;
>>>>>>>>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>>>>> +}
>>>>>>>>>> While you're at it, I think that should rather be leXX_to_cpu(=
)
>>>>>>>>>> instead
>>>>>>>>>> of bswapXX() here,
>>>>>>>>> I don't think that's correct, as this is supposed to swap BE
>>>>>>>>> registers
>>>>>>>>> to LE PCI bars.
>>>>>>>> Yes, but for the CPU emulation, the registers are stored in the=20
>>>>>>>> host's
>>>>>>>> endianness in the CPUS390XState structure. Or why do we=20
>>>>>>>> byte-swap them
>>>>>>>> again with cpu_to_be64() during s390_store_status(), for example=
?
>>>>>>> Gah, endian conversion is eating my brain...
>>>>>>>
>>>>>>> So, is the content we get BE or not? I thought in our last=20
>>>>>>> discussion
>>>>>>> we came to the conclusion that it is.
>>>>>> data is read from / written to env->regs[r1], so this is host=20
>>>>>> endian, as
>>>>>> far as I know. PCI is little endian, so using le32_to_cpu() /
>>>>>> cpu_to_le32() should IMHO be the right way to go here.
>>>>>>
>>>>>> By the way, if we want to use both, cpu_to_le and le_to_cpu,=20
>>>>>> depending
>>>>>> on whether we read from or write to PCI, we should maybe *not*=20
>>>>>> put this
>>>>>> code into a separate function?
>>>>> Yes, if your assessment is correct, we need two functions (I think=20
>>>>> this
>>>>> conversion is used in other places in later patches as well). Or ar=
e
>>>>> there mechanisms for that already available?
>>>> I have a question, is the data in cpu->regs the guest's endianess?
>>> As far as I know, it's host endianness, so on x86 with TCG emulation,
>>> it's little endian.
>>>
>>>> In our case, the guest is S390. Although the arch is big-endian, the
>>>> data in
>>>> pcilg/stg instructions is little-endian.
>>> PCI memory is always little endian, right.
>>>
>>>> Another question, does 'cpu' in cpu_to_le**() or le**_to_cpu() mean=20
>>>> the
>>>> host endianess?
>>> Yes, the "cpu" in cpu_to_le or le_to_cpu means the host, indeed. It's
>>> confusing :-/
>>>
>>>> If the answers to upper two questions are yes, we actually need hand=
le
>>>> two cases.
>>>> 1) For pcilg, we need to translate the data to little-endian, thus
>>>> cpu_to_le**().
>>>> 2) For pcistg, we need to translate the data to host endianess, thus
>>>> le**_to_cpu().
>>> I think we've got to byte-swap if the host is big endian (s390x), but
>>> not if the host is little endian (x86 with TCG).
>
>
>
> Here is my comprehension of this funny swapping:
>
> - TCG for a BE guest and a le host swap bytes because if we do=20
> (register & 0x01) in the zPCI interception code it must work what ever=20
> the endianess is.
>
> - Guest always write data Little Endian because it think it writes to=20
> PCI.
>
> - Kernel standard PCI code needs to swap endianness for a BE host but=20
> not for a le host.
>
>
> So it follows:
>
> Z Guest writes data BE in its register and swap its data to le before=20
> issuing zPCI
The data in register has been already le. For any zPCI instruction access=
ing
PCI data, the endianess is little-endian. Although s390 is be, its PCI=20
instructions
follow PCI Spec (byte ordering is le).

In kernel, s390 pci code swaps the data to le before it really issues=20
pcistg.
>
> QEMU intercepts, receives the data from the register and store it
> =C2=A0=C2=A0=C2=A0=C2=A0-> Native: it stores as is: -> le
I think you talked about PCI stg (storing data to PCI device).
The data from the register is le. But we swapped it back to be
because qemu in s390 is be. Then any pci_config write would
transfer data from be to le finally. The process is:
1) data from register : le (because the data in pcistg is in le)
2) pcistg intercept handler in qemu : le->be
3) pci->config_write : be->le
> =C2=A0=C2=A0=C2=A0=C2=A0-> TCG: it stores swapping data -> BE
For this case, we only talk about the case that the host is le.
As my understanding, the data in the register should be in
the byte ordering which the guest is.

So, for s390 guest, the data in pcistg is le. Then pcistg intercept
handler swaps the data from le to be, thus the final callback
would write the data with the wrong byte ordering to PCI device
because the host is le and cpu_to_le32() would not swaps the data.
>
> QEMU-PCI swaps the bytes always
> =C2=A0=C2=A0=C2=A0=C2=A0-> Native : data is now BE
> =C2=A0=C2=A0=C2=A0=C2=A0-> TCG: data is now le
Why is the data le under TCG? Isn't the data stored in register
the same as the guest's endianess?
>
> QEMU send the data to the PCI card
> =C2=A0=C2=A0=C2=A0=C2=A0-> Native, it goes through kernel which swap BE=
 ->le
> =C2=A0=C2=A0=C2=A0=C2=A0-> TCG: data is directly written to PCI memory:=
 -> le
>
> So for my view, we must always swap data. if we want it le at the end
>
> It comes because
> 1) guest and host kernels both make and translation BE->le
> =C2=A0=C2=A0 the QEMU PCI needs to swap back the data before sending to=
 the host
>
> 2) TCG swap the bytes, i.e. le->BE on saving registers
> =C2=A0=C2=A0 the QEMU PCI writes directly to the memory then it needs t=
o swap to
> =C2=A0=C2=A0 back to le
>
> I may have miss something or misunderstood something else so : Is it=20
> right?
>
> Regards,
>
> Pierre
>
>
>>
>>
>> Thanks for your replies! We will send the new version ASAP to udpate=20
>> this patch.
>>>
>>> =C2=A0 Thomas
>>>
>>>
>>
>
>
