Received: from eggs.gnu.org ([2001:4830:134:3::10]:58083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eBeHk-000370-0E
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eBeHf-0005Ax-U1
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:05:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eBeHf-0005A0-L3
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 05:05:35 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6A4aOM058539
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 05:05:25 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2jgc07xd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 05:05:25 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 10:05:22 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
	[9.149.105.58])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id vA6A5KA529294762
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 10:05:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 904C64C058
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 10:00:43 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B6FB4C05C
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 10:00:43 +0000 (GMT)
Received: from [9.145.183.31] (unknown [9.145.183.31])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 10:00:43 +0000 (GMT)
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<feea3ded-fecc-50ff-fe70-09e63966933b@de.ibm.com>
	<20171030134233.6aaa81a1.cohuck@redhat.com>
	<54504556-d508-e86f-388b-b07fa7576978@de.ibm.com>
	<90f3e3b9-be67-cda8-4ff8-20dac42090c7@linux.vnet.ibm.com>
	<b0bd0d34-548d-b461-7397-9ab92fb4e6fc@de.ibm.com>
	<20171030175937.23ef49a8.cohuck@redhat.com>
	<2f5c22e1-e9c2-9fb2-e0ce-4d19dc005d8e@de.ibm.com>
	<7c945da5-aca6-7fd6-ebe1-55c89b5567f5@linux.vnet.ibm.com>
	<13099ab4-3afe-04ea-f6eb-f0acffd06f9c@linux.vnet.ibm.com>
	<20171106095225.11036a6b.cohuck@redhat.com>
	<85e83a9c-b3d9-00a0-003d-b51dc4d6945e@de.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 11:05:20 +0100
MIME-Version: 1.0
In-Reply-To: <85e83a9c-b3d9-00a0-003d-b51dc4d6945e@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d92ffef7-71d1-2add-89fd-ef6802ce9d5d@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/5][RFC] Refactoring of AIS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 06/11/2017 09:54, Christian Borntraeger wrote:
>=20
>=20
> On 11/06/2017 09:52 AM, Cornelia Huck wrote:
>> On Mon, 30 Oct 2017 19:58:15 +0100
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> On 10/30/2017 06:38 PM, Pierre Morel wrote:
>>>> On 30/10/2017 18:08, Christian Borntraeger wrote:
>>>>>
>>>>> On 10/30/2017 05:59 PM, Cornelia Huck wrote:
>>>>>> On Mon, 30 Oct 2017 14:48:23 +0100
>>>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>>>
>>>>>>  =20
>>>>>>> FWIW, I am testing a guest patch that enables zPCI without AIS. I=
ts as simple as
>>>>>>>
>>>>>>>
>>>>>>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>>>>>>> index 7b30af5..9b24836 100644
>>>>>>> --- a/arch/s390/pci/pci.c
>>>>>>> +++ b/arch/s390/pci/pci.c
>>>>>>> @@ -953,7 +953,7 @@ static int __init pci_base_init(void)
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s390_pci_p=
robe)
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_facility(=
69) || !test_facility(71) || !test_facility(72))
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_facility(69) || !=
test_facility(71))
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D z=
pci_debug_init();
>>>>>>> diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
>>>>>>> index ea34086..61f8c82 100644
>>>>>>> --- a/arch/s390/pci/pci_insn.c
>>>>>>> +++ b/arch/s390/pci/pci_insn.c
>>>>>>> @@ -7,6 +7,7 @@
>>>>>>>  =C2=A0 #include <linux/export.h>
>>>>>>>  =C2=A0 #include <linux/errno.h>
>>>>>>>  =C2=A0 #include <linux/delay.h>
>>>>>>> +#include <asm/facility.h>
>>>>>>>  =C2=A0 #include <asm/pci_insn.h>
>>>>>>>  =C2=A0 #include <asm/pci_debug.h>
>>>>>>>  =C2=A0 #include <asm/processor.h>
>>>>>>> @@ -93,6 +94,8 @@ int zpci_refresh_trans(u64 fn, u64 addr, u64 ra=
nge)
>>>>>>>  =C2=A0 /* Set Interruption Controls */
>>>>>>>  =C2=A0 void zpci_set_irq_ctrl(u16 ctl, char *unused, u8 isc)
>>>>>>>  =C2=A0 {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_facility(72))
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm volatile (
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ins=
n=C2=A0=C2=A0 rsy,0xeb00000000d1,%[ctl],%[isc],%[u]\n"
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : : [ctl] "d" (ctl), [isc] "d" (isc << 27)=
, [u] "Q" (*unused));
>>>>>>>  =20
>>>>>>
>>>>>> Sounds good. Presumably this makes the adapter interrupt handling =
work
>>>>>> as for virtio (and qdio)? Is there any ais-less pci hardware out i=
n the
>>>>>> wild?
>>>
>>> @Connie:
>>> Do you have something in mind, or is curiosity the only reason for as=
king?
>>
>> I just want to make sure we don't miss anything.
>>
>>>
>>>>>>  =20
>>>>>
>>>>> ais is z specific, not PCI specific. So PCI cards should not care a=
s far as I can tell.
>>>>>
>>>>>  =20
>>>>
>>>> I bet Conny meant PCI hardware globaly, including zPCI adapters.
>>>> I bet none but I will better ask Sebastian or Gerald if they know.
>>>>   =20
>>>
>>> I side with Christian: it is a machine thing and not a card thing. So
>>> the question is if there is a z machine which supports zpci but does
>>> not support AIS. My guess is that such a machine was never produced.
>>
>> That's exactly what I meant, and I would not expect such a machine to
>> exist either.
>=20
> That machine is called qemu 2.10 :-p
>=20
>=20
>=20
> FWIW, I talked with Sebastian about that and he is fine with such a cha=
nge. He
> required some changes and I will work on such a patch.
>=20
>=20

My analyze is that providing AIS to the guest can work, with the=20
precaution to handle spurious interrupts, until we use GISA for PCI.

Then when we introduce GISA for PCI, we will need to think again about=20
providing AIS to the guest.

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
