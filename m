Received: from eggs.gnu.org ([2001:4830:134:3::10]:40904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpA3d-0000pG-45
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dpA3V-0002Os-FP
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dpA3V-0002O4-5Y
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v859JjgQ093648
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 05:21:59 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2csqchpyhm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 05:21:59 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 5 Sep 2017 19:21:56 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
	by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v859LtpI42991658
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 19:21:55 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
	by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v859Lsu9024673
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 19:21:55 +1000
References: <1504239778-29893-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1504239778-29893-2-git-send-email-zyimin@linux.vnet.ibm.com>
	<20170905102928.6b23a28a.cohuck@redhat.com>
	<0923f97e-4f69-0bf3-b9ab-8e5f69a56bbb@linux.vnet.ibm.com>
	<20170905105041.3409c8cd.cohuck@redhat.com>
	<07ef5826-6b09-5ac8-7d51-d00db7170437@linux.vnet.ibm.com>
	<20170905111540.027058d1.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Tue, 5 Sep 2017 17:21:52 +0800
MIME-Version: 1.0
In-Reply-To: <20170905111540.027058d1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <65b4c93c-fc2e-7ba3-b6e2-aa6c2312df3b@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] s390x/pci: remove idx from msix msg
 data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org



=E5=9C=A8 2017/9/5 =E4=B8=8B=E5=8D=885:15, Cornelia Huck =E5=86=99=E9=81=93=
:
> On Tue, 5 Sep 2017 17:08:14 +0800
> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>
>> =E5=9C=A8 2017/9/5 =E4=B8=8B=E5=8D=884:50, Cornelia Huck =E5=86=99=E9=81=
=93:
>>> On Tue, 5 Sep 2017 16:44:37 +0800
>>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>>  =20
>>>> =E5=9C=A8 2017/9/5 =E4=B8=8B=E5=8D=884:29, Cornelia Huck =E5=86=99=E9=
=81=93:
>>>>> On Fri,  1 Sep 2017 06:22:56 +0200
>>>>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>>>>     =20
>>>>>> PCIDevice pointer has been a parameter of kvm_arch_fixup_msi_route=
().
>>>>>> So we don't need to store zpci idx in msix message data to find ou=
t the
>>>>>> specific zpci device. Instead, we could use pci device id to find =
its
>>>>>> corresponding zpci device.
>>>>>>
>>>>>> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>     hw/s390x/s390-pci-bus.c  | 16 +++++-----------
>>>>>>     hw/s390x/s390-pci-bus.h  |  2 ++
>>>>>>     hw/s390x/s390-pci-inst.c | 24 ------------------------
>>>>>>     hw/s390x/s390-pci-stub.c |  6 ++++++
>>>>>>     target/s390x/kvm.c       |  7 +++++--
>>>>>>     5 files changed, 18 insertions(+), 37 deletions(-)
>>>>>>
>>>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>>>> index 1338c29528..3d490c5e4b 100644
>>>>>> --- a/target/s390x/kvm.c
>>>>>> +++ b/target/s390x/kvm.c
>>>>>> @@ -2533,10 +2533,13 @@ int kvm_arch_fixup_msi_route(struct kvm_ir=
q_routing_entry *route,
>>>>>>                                  uint64_t address, uint32_t data, =
PCIDevice *dev)
>>>>>>     {
>>>>>>         S390PCIBusDevice *pbdev;
>>>>>> -    uint32_t idx =3D data >> ZPCI_MSI_VEC_BITS;
>>>>>>         uint32_t vec =3D data & ZPCI_MSI_VEC_MASK;
>>>>>>    =20
>>>>>> -    pbdev =3D s390_pci_find_dev_by_idx(s390_get_phb(), idx);
>>>>>> +    if (!dev) {
>>>>>> +        return -ENODEV;
>>>>> Can this actually happen?
>>>> I think this cannot happen. But I'm afraid that I miss something.
>>>> So I added this to avoid NULL pointer. But from the code and
>>>> my test, there has not been NULL pointer happened.
>>> I'm wondering if that is in the same category as the instance I
>>> commented on above. Do you want to log something?
>>>  =20
>> For the case above, I ensure that zpci device must exist. But here, I'=
m
>> not sure.
>> Because it's called from outside. I'm not sure if the caller might cal=
l
>> kvm_irqchip_add_msi_route() with NULL as pci device argument.
>>
>> Although msix ctrl mr is accessed from outside. But its initialization
>> is controled by our code and the pointer to zpci device is saved as
>> mr's opaque.
> OK. Maybe add a DPRINTF as for the condition below?
OK. How about DPRINTF("add_msi_route no pci device\n")?
And change the DPRINTF for the below condition to
DPRINTF("add_msi_route no zpci device\n").
>
>>>>>     =20
>>>>>> +    }
>>>>>> +
>>>>>> +    pbdev =3D s390_pci_find_dev_by_target(s390_get_phb(), DEVICE(=
dev)->id);
>>>>>>         if (!pbdev) {
>>>>>>             DPRINTF("add_msi_route no dev\n");
>>>>>>             return -ENODEV;
>>>>>     =20
>>>  =20
>
