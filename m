Received: from eggs.gnu.org ([2001:4830:134:3::10]:57409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1g0WIK-00082Q-TV
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 14:24:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1g0WIE-0007yB-I8
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 14:24:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56970
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1g0WI8-0007oy-La
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 14:24:38 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w8DIOFDx131836
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 14:24:27 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2mfw2888ej-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 14:24:26 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 13 Sep 2018 19:24:24 +0100
References: <1536782900-17656-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1536782900-17656-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<49de34fa-253f-a306-0cad-519961c2c183@redhat.com>
	<b89ad0b9-8d4c-21a2-c706-5df93a51887c@de.ibm.com>
	<21bb71bb-e80c-152b-3018-8cac3926d2ea@linux.ibm.com>
	<81da8612-fe80-9a45-a4c4-80dc86b604c2@linux.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 13 Sep 2018 20:24:18 +0200
MIME-Version: 1.0
In-Reply-To: <81da8612-fe80-9a45-a4c4-80dc86b604c2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <2fc80ba3-d14b-bf0b-f5d0-56eba3f549e8@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 4/6] s390x/ap: base Adjunct
 Processor (AP) object model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, pasic@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, qemu-s390x@nongnu.org, heiko.carstens@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, eric.auger@redhat.com, alex.williamson@redhat.com, jjherne@linux.vnet.ibm.com, pbonzini@redhat.com, schwidefsky@de.ibm.com, mimu@linux.ibm.com, david@redhat.com, alifm@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net



On 09/13/2018 07:15 PM, Tony Krowiak wrote:
> On 09/13/2018 01:02 PM, Tony Krowiak wrote:
>> On 09/13/2018 02:29 AM, Christian Borntraeger wrote:
>>>
>>> On 09/13/2018 07:48 AM, Thomas Huth wrote:
>>>> On 2018-09-12 22:08, Tony Krowiak wrote:
>>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>>
>>>>> Introduces the base object model for virtualizing AP devices.
>>>>>
>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>> ---
>>>> [...]
>>>>> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
>>>>> new file mode 100644
>>>>> index 0000000..4f10425
>>>>> --- /dev/null
>>>>> +++ b/hw/s390x/ap-bridge.c
>>>> [...]
>>>>> +void s390_init_ap(void)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0 DeviceState *dev;
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 /* Create bridge device */
>>>>> +=C2=A0=C2=A0=C2=A0 dev =3D qdev_create(NULL, TYPE_AP_BRIDGE);
>>>>> +=C2=A0=C2=A0=C2=A0 object_property_add_child(qdev_get_machine(), T=
YPE_AP_BRIDGE,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT(dev), NULL);
>>>>> +=C2=A0=C2=A0=C2=A0 qdev_init_nofail(dev);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 /* Create bus on bridge device */
>>>>> +=C2=A0=C2=A0=C2=A0 qbus_create(TYPE_VFIO_AP_BUS, dev, TYPE_VFIO_AP=
_BUS);
>>>>> + }
>>>> [...]
>>>>> +type_init(ap_device_register)
>>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.=
c
>>>>> index f0f7fdc..3c100c2 100644
>>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>>> @@ -32,6 +32,7 @@
>>>>> =C2=A0 #include "ipl.h"
>>>>> =C2=A0 #include "hw/s390x/s390-virtio-ccw.h"
>>>>> =C2=A0 #include "hw/s390x/css-bridge.h"
>>>>> +#include "hw/s390x/ap-bridge.h"
>>>>> =C2=A0 #include "migration/register.h"
>>>>> =C2=A0 #include "cpu_models.h"
>>>>> =C2=A0 #include "hw/nmi.h"
>>>>> @@ -263,6 +264,9 @@ static void ccw_init(MachineState *machine)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* init the SIGP facility */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s390_init_sigp();
>>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /* create AP bridge and bus(es) */
>>>>> +=C2=A0=C2=A0=C2=A0 s390_init_ap();
>>>>> +
>>>> Not sure since there is no explicit migration state involved here, b=
ut I
>>>> think you cannot simply create the ap-bridge device always
>>>> unconditionally, can you? Did you check whether you can ping-pong
>>>> migrate an guest that runs on an older version of QEMU to a QEMU tha=
t
>>>> contains this patch and back? If it does not work, it might be neces=
sary
>>>> to restrict this ap-bridge device for new machine types only, I thin=
k.

@Thomas
I re-checked the back and forth migration using libvirt's save/restore. I=
t
works, because as you said, there in no migration state. So there are no
missing/unexpected subsections in the migration stream/file.

>>> We have already the cpu features at this point in time. So simply doi=
ng
>>> s390_has_feat(S390_FEAT_AP) in s390_init_ap ?
>>
>> This seems like a reasonable solution to me. If the S390_FEAT_AP is no=
t switched
>> on for the guest, then the vfio-ap device will not be realized; theref=
ore,
>> there is no need for a bridge device. I will fix the s390_init_ap() fu=
nction such
>> that the AP bridge device is created only if the S390_FEAT_AP is switc=
hed on for
>> the guest. That ought to solve the migration issue David pointed out. =
Thanks
>> David.

With that said, creating the ap-bridge only under the condition
s390_has_feat(S390_FEAT_AP) could still be the better option. We
could probably drop the check in vfio_ap_realize(). I'm not sure, so
I'm fine either way.

Regards,
Halil


>>
>>
>=20
>=20
