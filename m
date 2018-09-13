Received: from eggs.gnu.org ([2001:4830:134:3::10]:40292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g0VDY-0007Hv-MS
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g0VDT-0001vX-OI
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:15:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1g0VDT-0001uQ-9X
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 13:15:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w8DHErCE083723
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 13:15:41 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mft065cn9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 13:15:39 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Thu, 13 Sep 2018 11:15:22 -0600
From: Tony Krowiak <akrowiak@linux.ibm.com>
References: <1536782900-17656-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1536782900-17656-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<49de34fa-253f-a306-0cad-519961c2c183@redhat.com>
	<b89ad0b9-8d4c-21a2-c706-5df93a51887c@de.ibm.com>
	<21bb71bb-e80c-152b-3018-8cac3926d2ea@linux.ibm.com>
Date: Thu, 13 Sep 2018 13:15:10 -0400
MIME-Version: 1.0
In-Reply-To: <21bb71bb-e80c-152b-3018-8cac3926d2ea@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <81da8612-fe80-9a45-a4c4-80dc86b604c2@linux.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 09/13/2018 01:02 PM, Tony Krowiak wrote:
> On 09/13/2018 02:29 AM, Christian Borntraeger wrote:
>>
>> On 09/13/2018 07:48 AM, Thomas Huth wrote:
>>> On 2018-09-12 22:08, Tony Krowiak wrote:
>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>
>>>> Introduces the base object model for virtualizing AP devices.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>> [...]
>>>> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
>>>> new file mode 100644
>>>> index 0000000..4f10425
>>>> --- /dev/null
>>>> +++ b/hw/s390x/ap-bridge.c
>>> [...]
>>>> +void s390_init_ap(void)
>>>> +{
>>>> +    DeviceState *dev;
>>>> +
>>>> +    /* Create bridge device */
>>>> +    dev = qdev_create(NULL, TYPE_AP_BRIDGE);
>>>> +    object_property_add_child(qdev_get_machine(), TYPE_AP_BRIDGE,
>>>> +                              OBJECT(dev), NULL);
>>>> +    qdev_init_nofail(dev);
>>>> +
>>>> +    /* Create bus on bridge device */
>>>> +    qbus_create(TYPE_VFIO_AP_BUS, dev, TYPE_VFIO_AP_BUS);
>>>> + }
>>> [...]
>>>> +type_init(ap_device_register)
>>>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>>>> index f0f7fdc..3c100c2 100644
>>>> --- a/hw/s390x/s390-virtio-ccw.c
>>>> +++ b/hw/s390x/s390-virtio-ccw.c
>>>> @@ -32,6 +32,7 @@
>>>>   #include "ipl.h"
>>>>   #include "hw/s390x/s390-virtio-ccw.h"
>>>>   #include "hw/s390x/css-bridge.h"
>>>> +#include "hw/s390x/ap-bridge.h"
>>>>   #include "migration/register.h"
>>>>   #include "cpu_models.h"
>>>>   #include "hw/nmi.h"
>>>> @@ -263,6 +264,9 @@ static void ccw_init(MachineState *machine)
>>>>       /* init the SIGP facility */
>>>>       s390_init_sigp();
>>>>   +    /* create AP bridge and bus(es) */
>>>> +    s390_init_ap();
>>>> +
>>> Not sure since there is no explicit migration state involved here, 
>>> but I
>>> think you cannot simply create the ap-bridge device always
>>> unconditionally, can you? Did you check whether you can ping-pong
>>> migrate an guest that runs on an older version of QEMU to a QEMU that
>>> contains this patch and back? If it does not work, it might be 
>>> necessary
>>> to restrict this ap-bridge device for new machine types only, I think.
>> We have already the cpu features at this point in time. So simply doing
>> s390_has_feat(S390_FEAT_AP) in s390_init_ap ?
>
> This seems like a reasonable solution to me. If the S390_FEAT_AP is 
> not switched
> on for the guest, then the vfio-ap device will not be realized; 
> therefore,
> there is no need for a bridge device. I will fix the s390_init_ap() 
> function such
> that the AP bridge device is created only if the S390_FEAT_AP is 
> switched on for
> the guest. That ought to solve the migration issue David pointed out. 
> Thanks
> David.

Sorry, meant Thomas.

>
>
