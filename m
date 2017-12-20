Received: from eggs.gnu.org ([2001:4830:134:3::10]:59411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRaJA-0007Io-Un
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 04:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRaJ5-00011v-Gl
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 04:05:00 -0500
References: <20171212051853.24583-1-aik@ozlabs.ru>
	<20171211224650.71237179@w520.home>
	<ca9cd686-ea2f-716e-b909-f6e22d1c704c@redhat.com>
	<20171219070919.42d90b94@w520.home>
	<87e241ad-4d65-1b51-aa22-a84f18de1cb6@redhat.com>
	<344fb27b-1765-92e0-312f-6d5610925c5a@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ada748a5-f174-89ab-9741-165b424c5485@redhat.com>
Date: Wed, 20 Dec 2017 10:04:46 +0100
MIME-Version: 1.0
In-Reply-To: <344fb27b-1765-92e0-312f-6d5610925c5a@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 20/12/2017 02:47, Alexey Kardashevskiy wrote:
>> - if we foresee having more IOMMU devices in KVM, let's rename
>> KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE to KVM_DEV_VFIO_GROUP_ATTACH_IOMMU and
>> add a new function
>>
>>      int iommu_memory_region_get_kvm_fd(IOMMUMemoryRegion *iommu);
>>
>> that requires no object-type check in VFIO.
>
> This is how it started and the comment was that this KVM fd needs to have a
> well defined semantic which I struggle to provide.

I don't think the definition should be anything more than "it can be
passed to KVM_DEV_VFIO_GROUP_ATTACH_IOMMU".  I'll discuss it with Alex
later today.

Paolo
