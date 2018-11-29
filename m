Received: from eggs.gnu.org ([2001:4830:134:3::10]:32944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gSP9E-0007Xd-1H
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gSP99-00080c-Vx
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:26:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50356
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gSP98-0007xo-1y
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:26:34 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wATGEHRE032182
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:26:29 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p2kaks2eq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 11:26:29 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 29 Nov 2018 16:26:27 -0000
Reply-To: pmorel@linux.ibm.com
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
	<20181129124545.18e74622.cohuck@redhat.com>
	<b56b8efd-2532-5028-d4c4-94d163104dd5@linux.ibm.com>
	<20181129161044.5b153ab0.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 29 Nov 2018 17:26:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181129161044.5b153ab0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <59ff9eab-918c-9e5f-b21f-26885f296d1b@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] s390x/vfio: ap: Use the APdevice as
 a child of the APBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, pasic@linux.ibm.com

On 29/11/2018 16:11, Cornelia Huck wrote:
> On Thu, 29 Nov 2018 10:02:24 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>=20
>> On 11/29/18 6:45 AM, Cornelia Huck wrote:
>>> On Thu, 22 Nov 2018 17:35:51 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>>> index 65de952..94e5a1a 100644
>>>> --- a/hw/vfio/ap.c
>>>> +++ b/hw/vfio/ap.c
>>>> @@ -35,9 +35,6 @@ typedef struct VFIOAPDevice {
>>>>        VFIODevice vdev;
>>>>    } VFIOAPDevice;
>>>>   =20
>>>> -#define VFIO_AP_DEVICE(obj) \
>>>> -        OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
>>>
>>> Hm?
>>
>> I received a comment from Thomas Huth in Message ID
>> <2291104a-4cbf-e4fd-3496-fa0910beb96a@redhat.com>
>> that DO_UPCAST should be avoided in new code. This macro
>> should probably be restored and an AP_DEVICE() macro added.
>=20
> Yes, that makes sense.
>=20

Yes,
Thanks

Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
