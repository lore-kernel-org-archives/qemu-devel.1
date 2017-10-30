Received: from eggs.gnu.org ([2001:4830:134:3::10]:58202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e9ANC-0003Ol-9O
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e9AN9-0002p7-51
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:45:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1e9AN8-0002ny-Sa
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:44:59 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9UDiDGY055949
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 09:44:53 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dx22k3kyd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 09:44:53 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 30 Oct 2017 13:44:50 -0000
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<feea3ded-fecc-50ff-fe70-09e63966933b@de.ibm.com>
	<20171030134233.6aaa81a1.cohuck@redhat.com>
	<54504556-d508-e86f-388b-b07fa7576978@de.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 30 Oct 2017 14:44:47 +0100
MIME-Version: 1.0
In-Reply-To: <54504556-d508-e86f-388b-b07fa7576978@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <90f3e3b9-be67-cda8-4ff8-20dac42090c7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 0/5][RFC] Refactoring of AIS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org

On 30/10/2017 13:44, Christian Borntraeger wrote:
>=20
>=20
> On 10/30/2017 01:42 PM, Cornelia Huck wrote:
>> On Mon, 30 Oct 2017 09:28:09 +0100
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> Now I thought about that for a while and I start to think that we can=
not implement ais
>>> in QEMU and cover all cases.
>>> One aspect was certainly passthrough (like you handled in patch 4).
>>> Another aspect is that some interrupts might be injected from the ker=
nel - even for
>>> emulated devices. e.g. virtio-pci together with vhost-net, will injec=
t interrupts via
>>> the set_irq callback. I think disabling irqfd for these cases is not =
a good idea.
>>
>> Is there still a fallback for irqfd emulation?
>=20
> it might disable dataplane or other things. (it once did). So I think w=
e should not
> go down this path.
>=20
>>
>>>
>>> So what about adding a new KVM capability (for 4.14), fixup the other=
 things in
>>> QEMU and then bind it to the new capability?
>>
>> For 4.15, surely?
>>
>> Probably the only way we can make this work correctly...
>>

I may have not understand.

Why do we need a new capability, we already have the KVM_CAP_S390_AIS=20
capability?
The PCI device has a netdev property pointing to a netdev, if this=20
netdev sets the vhost property, can't we test this to know if we can=20
realize this device or not?

Using virtio-pci instead of virtio-ccw is not the first choice for S390.=20
The use case I see for S390 using virtio-pci is as a fallback in case=20
for the migration of a PCI device the target host does not support AIS=20
or do not have VFIO device and one do not want to modify the guest.

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
