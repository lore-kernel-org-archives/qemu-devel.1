Received: from eggs.gnu.org ([209.51.188.92]:40508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gubFn-0007EE-La
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gubE3-0002NM-GE
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:00:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50850
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gubE3-0002Lx-BT
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:00:11 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FAtQiX091391
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:00:10 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qnt8td8p8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:00:09 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 15 Feb 2019 11:00:07 -0000
Reply-To: pmorel@linux.ibm.com
References: <1550146494-21085-1-git-send-email-pmorel@linux.ibm.com>
	<1550146494-21085-2-git-send-email-pmorel@linux.ibm.com>
	<68ef1f07-75c2-5d40-1bf9-d6f1db1fa839@linux.ibm.com>
	<6ae3208c-11ea-0fe5-bebb-5c3febb06339@de.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 15 Feb 2019 12:00:00 +0100
MIME-Version: 1.0
In-Reply-To: <6ae3208c-11ea-0fe5-bebb-5c3febb06339@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <772b60d0-4ab0-f57e-575e-188550c64148@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] s390x/cpumodel: Set up CPU model for
 AQIC interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: akrowiak@linux.ibm.com, peter.maydell@linaro.org, david@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.ibm.com, eric.auger@redhat.com, qemu-s390x@nongnu.org, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net

On 15/02/2019 10:58, Christian Borntraeger wrote:
>=20
>=20
> On 15.02.2019 10:53, Pierre Morel wrote:
>> On 14/02/2019 13:14, Pierre Morel wrote:
>>> A new CPU model facilities is introduced to support AP devices
>>> interruption interception for a KVM guest.
>>>
>>> "APQI" for "AP-Queue Interruption" facility
>>>
>>> The S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, CPU facility indicates
>>> whether the PQAP instruction with the AQIC command is available
>>> to the guest.
>>> This feature will be enabled only if the AP instructions are
>>> available on the linux host and AQIC facility is installed on
>>> the host.
>>>
>>> This feature must be turned on from userspace to intercept AP
>>> instructions on the KVM guest. The QEMU command line to turn
>>> this feature on looks something like this:
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 qemu-system-s390x ... -cpu xxx,apqi=3Don ...
>>
>>
>>
>> Hi,
>>
>> I suddenly have a very big doubt on this QEMU patch.
>>
>> Older Linux advertise PQAP/AQIC feature (65)
>=20
> Which Linuxes advertise PQAP/AQIC (stfle.65)?
> This was never advertised by any previous Linux as far as I can tell.
>=20

OK, very sorry, you are right, I checked on a different machine and it=20
is not.
I must have left something in my system.

Sorry for the panic.
I will look at what made me experience this.

Regards,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
