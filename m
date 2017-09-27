Received: from eggs.gnu.org ([2001:4830:134:3::10]:40737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6N6-0003HD-KZ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dx6N0-0000pf-UL
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:03:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47970
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dx6N0-0000pN-OU
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:02:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8R6xm0O047590
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:02:55 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d81gkf6v7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 03:02:54 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 27 Sep 2017 08:02:52 +0100
References: <20170926133624.155394-1-borntraeger@de.ibm.com>
	<20170926133624.155394-2-borntraeger@de.ibm.com>
	<7134b571-41dd-97c8-85b8-fb623babb016@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 27 Sep 2017 09:02:48 +0200
MIME-Version: 1.0
In-Reply-To: <7134b571-41dd-97c8-85b8-fb623babb016@linux.vnet.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Message-Id: <5caeb93d-b436-d8c0-2706-fd3476b54ad0@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>



On 09/27/2017 07:45 AM, Yi Min Zhao wrote:
>=20
>=20
> =D4=DA 2017/9/26 =CF=C2=CE=E79:36, Christian Borntraeger =D0=B4=B5=C0:
>> @@ -557,6 +557,12 @@ static void kvm_s390_flic_realize(DeviceState *de=
v, Error **errp)
>>       test_attr.group =3D KVM_DEV_FLIC_CLEAR_IO_IRQ;
>>       flic_state->clear_io_supported =3D !ioctl(flic_state->fd,
>>                                               KVM_HAS_DEVICE_ATTR, tes=
t_attr);
>> +    /* try enable the AIS facility */
>> +    test_attr.group =3D KVM_DEV_FLIC_AISM_ALL;
>> +    if (!ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
>> +            kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_AIS, 0);

yes, will fix.


> Is there an indention error?
> Except this, the code LGTM.
>> +    }
>> +
>>       return;
>=20
