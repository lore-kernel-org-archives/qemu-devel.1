Received: from eggs.gnu.org ([2001:4830:134:3::10]:50516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dkYjQ-0008Br-2R
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dkYjP-00010c-5a
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:42:16 -0400
References: <1503312534-6642-1-git-send-email-Bharat.Bhushan@nxp.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2e23327a-3e5e-abaf-387f-d23462d8aba7@redhat.com>
Date: Wed, 23 Aug 2017 18:41:35 +0200
MIME-Version: 1.0
In-Reply-To: <1503312534-6642-1-git-send-email-Bharat.Bhushan@nxp.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] virtio-iommu: VFIO integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: wei@redhat.com, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, robin.murphy@arm.com, christoffer.dall@linaro.org

Hi Bharat,

On 21/08/2017 12:48, Bharat Bhushan wrote:
> This V3 version is mainly about rebasing on v3 version on Virtio-iommu device
> framework from Eric Augur and addresing review comments.
s/Augur/Auger ;-)
> 
> This patch series allows PCI pass-through using virtio-iommu.
>   
> This series is based on:
>  - virtio-iommu specification written by Jean-Philippe Brucker
>    [RFC 0/3] virtio-iommu: a paravirtualized IOMMU,
>  
>  - virtio-iommu driver by Jean-Philippe Brucker
>    [RFC PATCH linux] iommu: Add virtio-iommu driver
>  
>  - virtio-iommu device emulation by Eric Augur.
>    [RFC v3 0/8] VIRTIO-IOMMU device
> 
> PCI device pass-through and virtio-net-pci is tested with these changes using dma-ops

I confirm it works fine now with 2 assigned VFs.

However at the moment DPDK testpmd using those 2 VFs does not work for me:
1: [/home/augere/UPSTREAM/dpdk/install/bin/testpmd(rte_dump_stack+0x24)
[0x4a8a78]]

I haven't investigated yet...

Thanks

Eric
> 
> This patch series does not implement RESV_MEM changes proposal by Jean-Philippe "https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01796.html"
> 
> v2->v3:
>  - This series is based on "[RFC v3 0/8] VIRTIO-IOMMU device"
>    Which is based on top of v2.10-rc0 that 
>  - Fixed issue with two PCI devices
>  - Addressed review comments
> 
> v1->v2:
>   - Added trace events
>   - removed vSMMU3 link in patch description
> 
> Bharat Bhushan (2):
>   target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route
>   virtio-iommu: vfio integration with virtio-iommu
> 
>  hw/virtio/trace-events           |   5 ++
>  hw/virtio/virtio-iommu.c         | 163 +++++++++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-iommu.h |   6 ++
>  target/arm/kvm.c                 |  27 +++++++
>  target/arm/trace-events          |   3 +
>  5 files changed, 204 insertions(+)
> 
