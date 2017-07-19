Received: from eggs.gnu.org ([2001:4830:134:3::10]:45787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dXlR3-0001lQ-PK
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:38:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dXlQz-00052g-RR
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:38:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37510
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dXlQz-00052W-LM
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:38:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J9YCSd127712
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 05:38:21 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bsu0snja9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 05:38:20 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Wed, 19 Jul 2017 05:38:20 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v6J9cHdm19464342
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 09:38:17 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1653BAE034
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 05:38:27 -0400 (EDT)
Received: from zyimindembp.cn.ibm.com (unknown [9.115.193.8])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 66F6EAE03C
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 05:38:26 -0400 (EDT)
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-5-cohuck@redhat.com>
	<5f8a2315-9224-f20c-7524-11f9a8ac8efd@de.ibm.com>
	<20170719100007.1071ce70@gondolin>
	<8eadfe2a-7923-6c10-287e-06ad9eaffead@linux.vnet.ibm.com>
	<20170719112430.432e66da@gondolin>
	<f5d5bff4-4c3c-df91-f10f-d3602a62fe3b@linux.vnet.ibm.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 19 Jul 2017 17:38:15 +0800
MIME-Version: 1.0
In-Reply-To: <f5d5bff4-4c3c-df91-f10f-d3602a62fe3b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a93a045e-b37b-7763-cfcc-8dcb684d149d@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/9] s390x/pci: do not advertise pci
 on non-pci builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



=E5=9C=A8 2017/7/19 =E4=B8=8B=E5=8D=885:27, Yi Min Zhao =E5=86=99=E9=81=93=
:
>
>
> =E5=9C=A8 2017/7/19 =E4=B8=8B=E5=8D=885:24, Cornelia Huck =E5=86=99=E9=81=
=93:
>> On Wed, 19 Jul 2017 16:56:18 +0800
>> Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:
>>
>>> =E5=9C=A8 2017/7/19 =E4=B8=8B=E5=8D=884:00, Cornelia Huck =E5=86=99=E9=
=81=93:
>>>> On Tue, 18 Jul 2017 21:56:26 +0200
>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>> On 07/18/2017 04:24 PM, Cornelia Huck wrote:
>>>>>> Only set the zpci and aen feature bits on builds that actually
>>>>>> support pci.
>>>>>>
>>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>>> ---
>>>>>>    target/s390x/kvm.c | 2 ++
>>>>>>    1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>>>> index 831492f9a2..880eccd58a 100644
>>>>>> --- a/target/s390x/kvm.c
>>>>>> +++ b/target/s390x/kvm.c
>>>>>> @@ -2685,8 +2685,10 @@ void=20
>>>>>> kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>>>>>        }
>>>>>>
>>>>>>        /* set zpci and aen facilities */
>>>>>> +#ifdef CONFIG_PCI
>>>>>>        set_bit(S390_FEAT_ZPCI, model->features);
>>>>>>        set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION,=20
>>>>>> model->features);
>>>>>> +#endif
>>>>>>
>>>>>>        if (s390_known_cpu_type(cpu_type)) {
>>>>>>            /* we want the exact model, even if some features are=20
>>>>>> missing */
>>>>> Not strictly necessary but do you also want to ifdef this
>>>>>
>>>>>    kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
>>>>>
>>>>> call?
>>>>>
>>>>> If not you could actually even allow AEN but not PCI for !CONFIG_PC=
I.
>>>> I'm a bit unsure about the relationship of ais and aen with pci. I
>>>> remember that only adapters for pci currently support suppression,
>>>> although it could spread to other adapter types in the future. Not=20
>>>> sure
>>>> about aen.
>>>>
>>>> So I'd keep the ais enablement call, even though it won't have much =
of
>>>> an effect as no pci adapters will be registered.
>>>>
>>>> As I don't quite remember what aen governed, I need to rely on your
>>>> feedback here.
>>>>
>>> My understanding is that zpci replies on aen. But aen could exist
>>> independently.
>>> After all, there is other device type using aen. I think only wrappin=
g
>>> zpci is
>>> enough.
>> Ah, was aen the indicator bits related support? If yes, I agree that w=
e
>> should only turn off zpci.
>>
>>
> Yes, set summary and indicator bits. Related stuff is in flic, but not=20
> in zpci.
>
>
>
I think of another problem. If we didn't config pci, then we don't have z=
pci
feature in max cpu model. So how to process the conflict between requeste=
d
cpu model and max cpu model. For example, if we start 2.10 machine and
want to use z12 cpu model, maybe the guest cannot startup because of
missing zpci feature. So the only way is we explicitly turn it off in=20
qemu cmdline.
But I'm not sure if it's an issue.
