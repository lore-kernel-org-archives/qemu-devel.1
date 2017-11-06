Received: from eggs.gnu.org ([2001:4830:134:3::10]:58324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eBdBa-0004cz-W6
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 03:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eBdBX-0003YS-4B
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 03:55:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eBdBW-0003X3-SH
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 03:55:11 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA68sCcp006885
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 03:55:03 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2jgbwdwe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 03:55:02 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 6 Nov 2017 08:54:59 -0000
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
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 6 Nov 2017 09:54:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171106095225.11036a6b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <85e83a9c-b3d9-00a0-003d-b51dc4d6945e@de.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, zyimin@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, qemu-s390x@nongnu.org



On 11/06/2017 09:52 AM, Cornelia Huck wrote:
> On Mon, 30 Oct 2017 19:58:15 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>=20
>> On 10/30/2017 06:38 PM, Pierre Morel wrote:
>>> On 30/10/2017 18:08, Christian Borntraeger wrote: =20
>>>>
>>>> On 10/30/2017 05:59 PM, Cornelia Huck wrote: =20
>>>>> On Mon, 30 Oct 2017 14:48:23 +0100
>>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>>
>>>>> =20
>>>>>> FWIW, I am testing a guest patch that enables zPCI without AIS. It=
s as simple as
>>>>>>
>>>>>>
>>>>>> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
>>>>>> index 7b30af5..9b24836 100644
>>>>>> --- a/arch/s390/pci/pci.c
>>>>>> +++ b/arch/s390/pci/pci.c
>>>>>> @@ -953,7 +953,7 @@ static int __init pci_base_init(void)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s390_pci_pro=
be)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_facility(69=
) || !test_facility(71) || !test_facility(72))
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_facility(69) || !t=
est_facility(71))
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D zpc=
i_debug_init();
>>>>>> diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
>>>>>> index ea34086..61f8c82 100644
>>>>>> --- a/arch/s390/pci/pci_insn.c
>>>>>> +++ b/arch/s390/pci/pci_insn.c
>>>>>> @@ -7,6 +7,7 @@
>>>>>> =C2=A0 #include <linux/export.h>
>>>>>> =C2=A0 #include <linux/errno.h>
>>>>>> =C2=A0 #include <linux/delay.h>
>>>>>> +#include <asm/facility.h>
>>>>>> =C2=A0 #include <asm/pci_insn.h>
>>>>>> =C2=A0 #include <asm/pci_debug.h>
>>>>>> =C2=A0 #include <asm/processor.h>
>>>>>> @@ -93,6 +94,8 @@ int zpci_refresh_trans(u64 fn, u64 addr, u64 ran=
ge)
>>>>>> =C2=A0 /* Set Interruption Controls */
>>>>>> =C2=A0 void zpci_set_irq_ctrl(u16 ctl, char *unused, u8 isc)
>>>>>> =C2=A0 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_facility(72))
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 asm volatile (
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ins=
n=C2=A0=C2=A0 rsy,0xeb00000000d1,%[ctl],%[isc],%[u]\n"
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : : [ctl] "d" (ctl), [isc] "d" (isc << 27)=
, [u] "Q" (*unused));
>>>>>> =20
>>>>>
>>>>> Sounds good. Presumably this makes the adapter interrupt handling w=
ork
>>>>> as for virtio (and qdio)? Is there any ais-less pci hardware out in=
 the
>>>>> wild? =20
>>
>> @Connie:
>> Do you have something in mind, or is curiosity the only reason for ask=
ing?
>=20
> I just want to make sure we don't miss anything.
>=20
>>
>>>>> =20
>>>>
>>>> ais is z specific, not PCI specific. So PCI cards should not care as=
 far as I can tell.
>>>>
>>>> =20
>>>
>>> I bet Conny meant PCI hardware globaly, including zPCI adapters.
>>> I bet none but I will better ask Sebastian or Gerald if they know.
>>>  =20
>>
>> I side with Christian: it is a machine thing and not a card thing. So
>> the question is if there is a z machine which supports zpci but does
>> not support AIS. My guess is that such a machine was never produced.
>=20
> That's exactly what I meant, and I would not expect such a machine to
> exist either.

That machine is called qemu 2.10 :-p



FWIW, I talked with Sebastian about that and he is fine with such a chang=
e. He
required some changes and I will work on such a patch.
