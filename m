Received: from eggs.gnu.org ([209.51.188.92]:37581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghZnf-0004L9-BQ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghZne-0007pM-Kb
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:51:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1ghZne-0007oX-9z
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:51:06 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0ACmxMm078343
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 07:51:04 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2px48366d4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 07:51:04 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 10 Jan 2019 12:51:01 -0000
Reply-To: pmorel@linux.ibm.com
References: <1546968819-8166-1-git-send-email-pmorel@linux.ibm.com>
	<20190109135919.3ebb7d03.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 10 Jan 2019 13:50:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190109135919.3ebb7d03.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <f26b62c2-1820-e7e8-3439-a9df0534a0a3@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390x/pci: Set the iommu region size as
 guest wants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: walling@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

On 09/01/2019 13:59, Cornelia Huck wrote:
> On Tue,  8 Jan 2019 18:33:39 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> The size of the accessible iommu memory region in the guest
>> is calculated by the gues as:
>=20
> s/gues/guest/
>=20
>>      (PCI Address Limit) - (PCI Base Address) + 1.
>>
>> Let's use this value to limit the IOMMU region size.
>=20
> These are values provided by the guest in the mpcifc call, aren't they?
> Let's mention that in the patch description, so it is more obvious :)
>=20

OK thanks.

Regards,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
