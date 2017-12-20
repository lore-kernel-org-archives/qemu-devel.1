Received: from eggs.gnu.org ([2001:4830:134:3::10]:35582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eRf7h-0001nN-Cr
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eRf7e-0007D5-Dx
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:13:29 -0500
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:34705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eRf7e-0007Av-8t
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 09:13:26 -0500
Received: by mail-pl0-x232.google.com with SMTP id d21so9066929pll.1
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 06:13:25 -0800 (PST)
References: <20171212051853.24583-1-aik@ozlabs.ru>
	<20171211224650.71237179@w520.home>
	<ca9cd686-ea2f-716e-b909-f6e22d1c704c@redhat.com>
	<20171219070919.42d90b94@w520.home>
	<87e241ad-4d65-1b51-aa22-a84f18de1cb6@redhat.com>
	<344fb27b-1765-92e0-312f-6d5610925c5a@ozlabs.ru>
	<ada748a5-f174-89ab-9741-165b424c5485@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <fb78f948-0b49-1cbc-d9a6-7b29d63e605f@ozlabs.ru>
Date: Thu, 21 Dec 2017 01:13:18 +1100
MIME-Version: 1.0
In-Reply-To: <ada748a5-f174-89ab-9741-165b424c5485@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] RFC: spapr/iommu: Enable in-kernel
 TCE acceleration via VFIO KVM device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 20/12/17 20:04, Paolo Bonzini wrote:
> On 20/12/2017 02:47, Alexey Kardashevskiy wrote:
>>> - if we foresee having more IOMMU devices in KVM, let's rename
>>> KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE to KVM_DEV_VFIO_GROUP_ATTACH_IOMMU and
>>> add a new function
>>>
>>>      int iommu_memory_region_get_kvm_fd(IOMMUMemoryRegion *iommu);
>>>
>>> that requires no object-type check in VFIO.
>>
>> This is how it started and the comment was that this KVM fd needs to have a
>> well defined semantic which I struggle to provide.
> 
> I don't think the definition should be anything more than "it can be
> passed to KVM_DEV_VFIO_GROUP_ATTACH_IOMMU".  I'll discuss it with Alex
> later today.

That was more David's concern :)


-- 
Alexey
