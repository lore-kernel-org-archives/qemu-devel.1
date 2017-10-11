Received: from eggs.gnu.org ([2001:4830:134:3::10]:48052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e2JZQ-0007j2-3D
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e2JZP-0004Ue-85
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:09:20 -0400
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-0MK18DakmNPRXCNYbDpBvzE0h12nNjg7zr+F_m0EnDw@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f3a263b7-27e6-26df-592d-a34902bab6fe@redhat.com>
Date: Wed, 11 Oct 2017 18:08:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-0MK18DakmNPRXCNYbDpBvzE0h12nNjg7zr+F_m0EnDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 00/16] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, Andrew Jones <drjones@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, jean-philippe.brucker@arm.com, Tomasz Nowicki <tn@semihalf.com>, Will Deacon <will.deacon@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, linuc.decode@gmail.com, Bharat Bhushan <bharat.bhushan@nxp.com>, Christoffer Dall <christoffer.dall@linaro.org>, eric.auger.pro@gmail.com

Hi Peter,

On 11/10/2017 16:56, Peter Maydell wrote:
> On 19 September 2017 at 08:46, Eric Auger <eric.auger@redhat.com> wrote:
>> This series implements the virtio-iommu device.
>>
>> This v4 is an upgrade to v0.4 spec [1] and applies on QEMU v2.10.0.
>> - probe request support although no reserved region is returned at
>>   the moment
>> - unmap semantics less strict, as specified in v0.4
>> - device registration, attach/detach revisited
>> - split into smaller patches to ease review
>> - propose a way to inform the IOMMU mr about the page_size_mask
>>   of underlying HW IOMMU, if any
>> - remove warning associated with the translation of the MSI doorbell
>>
>> The device gets instantiated using the "-device virtio-iommu-device"
>> option. It currently works with ARM virt machine only, as the machine
>> must handle the dt binding between the virtio-mmio "iommu" node and
>> the PCI host bridge node.
> 
> Could this work on x86, or is it inherently arm-only?

Yes this is the goal. At the moment the ACPI probing is not yet properly
specified but a Q35 prototype was developed in the Red Hat Virt team.
This will be presented at the KVM forum.

Thanks

Eric
> 
> thanks
> -- PMM
> 
