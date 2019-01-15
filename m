Received: from eggs.gnu.org ([209.51.188.92]:57093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gjScx-0004hp-9I
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gjScv-0000ec-CH
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:35:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51250
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gjSct-0000ag-CQ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:35:47 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0FHYaTd058247
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 12:35:42 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q1h5c383c-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 12:35:42 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 15 Jan 2019 17:35:40 -0000
Reply-To: pmorel@linux.ibm.com
References: <1547125207-16907-1-git-send-email-pmorel@linux.ibm.com>
	<1547125207-16907-2-git-send-email-pmorel@linux.ibm.com>
	<20190115164735.3732b9d8.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 15 Jan 2019 18:35:35 +0100
MIME-Version: 1.0
In-Reply-To: <20190115164735.3732b9d8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <ccb1ea02-ba4f-bbc5-13f2-f51fedc2e93e@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390x/pci: Set the iommu region size
 mpcifc request
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

On 15/01/2019 16:47, Cornelia Huck wrote:
> On Thu, 10 Jan 2019 14:00:07 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> The size of the accessible iommu memory region in the guest
>> is given to the IOMMU by the guest through the mpcifc request
>> specifying the PCI Base Address and the PCI Address Limit.
>>
>> Let set the size of the IOMMU region to:
>>      (PCI Address Limit) - (PCI Base Address) + 1.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Thanks, applied.
>=20

Thanks. :)

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
