Received: from eggs.gnu.org ([2001:4830:134:3::10]:51887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gAZ2B-0004b3-62
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gAZ27-0006kV-VO
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:21:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56836
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gAZ25-0006iS-Vk
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 07:21:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w9BBKdWc011641
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 07:21:25 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2n25jd00y2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 07:21:25 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 11 Oct 2018 12:21:23 +0100
Reply-To: pmorel@linux.ibm.com
References: <20181010170309.12045-1-akrowiak@linux.ibm.com>
	<ceeafd70-b1d3-9e80-d357-65740dd125cd@de.ibm.com>
	<20181011114845.75275acd.cohuck@redhat.com>
	<85bc92db-56f9-fcca-e4c6-205f767d5c8e@de.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 11 Oct 2018 13:21:16 +0200
MIME-Version: 1.0
In-Reply-To: <85bc92db-56f9-fcca-e4c6-205f767d5c8e@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <9903d08b-f1c3-5f28-1a9b-90b89c1d8d37@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 0/6] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: peter.maydell@linaro.org, akrowiak@linux.vnet.ibm.com, fiuczy@linux.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, eskultet@redhat.com, agraf@suse.de, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, mjrosato@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, qemu-s390x@nongnu.org, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, Tony Krowiak <akrowiak@linux.ibm.com>, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, alex.williamson@redhat.com, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 11/10/2018 12:00, Christian Borntraeger wrote:
>=20
>=20
> On 10/11/2018 11:48 AM, Cornelia Huck wrote:
>> On Wed, 10 Oct 2018 20:15:55 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 10/10/2018 07:03 PM, Tony Krowiak wrote:
>>>> This patch series is the QEMU counterpart to the KVM/kernel support =
for
>>>> guest dedicated crypto adapters. The KVM/kernel model is built on th=
e
>>>> VFIO mediated device framework and provides the infrastructure for
>>>> granting exclusive guest access to crypto devices installed on the l=
inux
>>>> host. This patch series introduces a new QEMU command line option, Q=
EMU
>>>> object model and CPU model features to exploit the KVM/kernel model.
>>>>
>>>> See the detailed specifications for AP virtualization provided by th=
is
>>>> patch set in docs/vfio-ap.txt for a more complete discussion of the
>>>> design introduced by this patch series.
>>>>
>>>> v10 =3D> v11 Change log:
>>>
>>>
>>>
>>> Series seems to work fine.
>>>
>>> Christian
>>
>> Is that a Tested-by:, or just 'looks sane'?
>=20
> It was limited to some cases, but lets make it a tested-by.
>=20
>=20

I tested it yesterday, so you can keep my tested-by too.

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
