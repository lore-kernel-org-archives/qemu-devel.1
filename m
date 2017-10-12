Received: from eggs.gnu.org ([2001:4830:134:3::10]:44598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e2aTU-0008M4-Uq
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e2aTP-0007VC-UT
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:12:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53520
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1e2aTP-0007SV-Om
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:12:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9CA9XjF037650
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 06:12:10 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dj4rq4jat-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 06:12:10 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 12 Oct 2017 11:12:08 +0100
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-5-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171009084506.77da9d5c@t450s.home>
	<e59c8274-c390-b99f-85dd-ec3763520ff1@linux.vnet.ibm.com>
	<20171010113520.6c3d03e3.cohuck@redhat.com>
	<1952d9c1-6ef8-0f1d-d89a-08e1236ad275@linux.vnet.ibm.com>
	<20171011142053.1f1e2723.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 12 Oct 2017 12:12:05 +0200
MIME-Version: 1.0
In-Reply-To: <20171011142053.1f1e2723.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <68c3c95e-7f8c-5305-5df4-f512cd5dfb72@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/5] s390x/pci: Refuse to realize
 VFIO-PCI if AIS needed but supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, agraf@suse.de

On 11/10/2017 14:20, Cornelia Huck wrote:
> On Tue, 10 Oct 2017 18:01:53 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> Since in the case we have no AIS in KVM only PCI is impacted, do you
>> think we can fence IRQFD for MSI with
>>
>> kvm_msi_via_irqfd_allowed =3D false;
>>
>> in kvm_arch_init_irq_routing() ?
>=20
> Hm, it seems we never set that for s390x... does that imply that we
> never support irqfd for pci anyway?
>=20
>>
>> In fact, if we also verify the AIS availability in the same routine we
>> can avoid the ugly include of vfio/pci.h
>=20
> If we can get the serialization right (and setting that value to false
> does indeed have the desired effect), that's probably the way to go.
>=20

OK, thanks, I give it a try and propose a v2 on this basis.



--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
