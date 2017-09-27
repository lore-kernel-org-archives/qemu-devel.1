Received: from eggs.gnu.org ([2001:4830:134:3::10]:55007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dx8Zn-0007f6-1i
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dx8Zl-0004Um-Km
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 05:24:19 -0400
References: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
	<20170927074109.GA31587@virtx40>
	<AM5PR0401MB25450ACC804B20D93C4F2D9D9A780@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<9700cf30-65ed-9c55-c1b9-14bb8deb669f@redhat.com>
	<20170927092147.GA32183@virtx40>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0af599c0-f859-f90c-c999-bc4a0a678768@redhat.com>
Date: Wed, 27 Sep 2017 11:24:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170927092147.GA32183@virtx40>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 0/5] virtio-iommu: VFIO
 integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linu Cherian <linuc.decode@gmail.com>
Cc: Bharat Bhushan <bharat.bhushan@nxp.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>

Hi Linu,

On 27/09/2017 11:21, Linu Cherian wrote:
> On Wed Sep 27, 2017 at 10:55:07AM +0200, Auger Eric wrote:
>> Hi Linu,
>>
>> On 27/09/2017 10:30, Bharat Bhushan wrote:
>>> Hi,
>>>
>>>> -----Original Message-----
>>>> From: Linu Cherian [mailto:linuc.decode@gmail.com]
>>>> Sent: Wednesday, September 27, 2017 1:11 PM
>>>> To: Bharat Bhushan <bharat.bhushan@nxp.com>
>>>> Cc: eric.auger@redhat.com; eric.auger.pro@gmail.com;
>>>> peter.maydell@linaro.org; alex.williamson@redhat.com; mst@redhat.com;
>>>> qemu-arm@nongnu.org; qemu-devel@nongnu.org; kevin.tian@intel.com;
>>>> marc.zyngier@arm.com; tn@semihalf.com; will.deacon@arm.com;
>>>> drjones@redhat.com; robin.murphy@arm.com; christoffer.dall@linaro.org;
>>>> bharatb.yadav@gmail.com
>>>> Subject: Re: [Qemu-arm] [PATCH v4 0/5] virtio-iommu: VFIO integration
>>>>
>>>> Hi,
>>>>
>>>> On Wed Sep 27, 2017 at 12:03:15PM +0530, Bharat Bhushan wrote:
>>>>> This patch series integrates VFIO/VHOST with virtio-iommu.
>>>>>
>>>>> This version is mainly about rebasing on v4 version on virtio-iommu
>>>>> device framework from Eric Augur and addresing review comments.
>>>>>
>>>>> This patch series allows PCI pass-through using virtio-iommu.
>>>>>
>>>>> This series is based on:
>>>>>  - virtio-iommu kernel driver by Jean-Philippe Brucker
>>>>>     [1] [RFC] virtio-iommu version 0.4
>>>>>     git://linux-arm.org/virtio-iommu.git branch viommu/v0.4
>>
>> Just to make sure, do you use the v0.4 virtio-iommu driver from above
>> branch?
>>
>> Thanks
> 
> I am using git://linux-arm.org/linux-jpb.git branch virtio-iommu/v0.4.
> Hope you are referring to the same.

Yes that's the right one. I will also investigate on my side this afternoon.

Thanks

Eric
> 
> 
>>
>> Eric
>>>>>
>>>>>  - virtio-iommu device emulation by Eric Augur.
>>>>>    [RFC v4 00/16] VIRTIO-IOMMU device
>>>>>    https://github.com/eauger/qemu/tree/v2.10.0-virtio-iommu-v4
>>>>>
>>>>> Changes are available at : https://github.com/bharaty/qemu.git
>>>>> virtio-iommu-vfio-integration-v4
>>>>>
>>>>
>>>> # With the above sources, was trying to test the vfio-pci device assigned to
>>>>   guest using Qemu.
>>>> # Both guest and host kernels are configured with 4k as page size.
>>>> # releavant qemu command snippet,
>>>>   -device virtio-iommu-device -device virtio-blk-device,drive=hd0 \
>>>>   -net none -device vfio-pci,host=xxx
>>>>
>>>>
>>>> On guest booting, observed mutliple messages as below,
>>>>
>>>> qemu-system-aarch64: iommu has granularity incompatible with target AS
>>>>
>>>> # On adding necessary prints, 0x5000 is len, 0x4fff is address mask
>>>>   and the code expects the address mask to be 0xfff.
>>>
>>> I have not seen these errors, I am also using 4K page-size on both host and guest. Can you share compete qemu command and log. 
>>>
>>> Thanks
>>> -Bharat
>>>
>>>>
>>>> if (len & iotlb->addr_mask) {
>>>>         error_report
>>>>
>>>> # vfio_dma_map is failing due to this error.
>>>>
>>>> Any pointers ?
>>>>
>>>>
>>>>> v3->v4:
>>>>>  - Rebase to v4 version from Eric
>>>>>  - Fixes from Eric with DPDK in VM
>>>>>  - Logical division in multiple patches
>>>>>
>>>>> v2->v3:
>>>>>  - This series is based on "[RFC v3 0/8] VIRTIO-IOMMU device"
>>>>>    Which is based on top of v2.10-rc0 that
>>>>>  - Fixed issue with two PCI devices
>>>>>  - Addressed review comments
>>>>>
>>>>> v1->v2:
>>>>>   - Added trace events
>>>>>   - removed vSMMU3 link in patch description
>>>>>
>>>>> Bharat Bhushan (5):
>>>>>   target/arm/kvm: Translate the MSI doorbell in
>>>> kvm_arch_fixup_msi_route
>>>>>   virtio-iommu: Add iommu notifier for map/unmap
>>>>>   virtio-iommu: Call iommu notifier for attach/detach
>>>>>   virtio-iommu: add iommu replay
>>>>>   virtio-iommu: add iommu notifier memory-region
>>>>>
>>>>>  hw/virtio/trace-events           |   5 ++
>>>>>  hw/virtio/virtio-iommu.c         | 181
>>>> ++++++++++++++++++++++++++++++++++++++-
>>>>>  include/hw/virtio/virtio-iommu.h |   6 ++
>>>>>  target/arm/kvm.c                 |  27 ++++++
>>>>>  target/arm/trace-events          |   3 +
>>>>>  5 files changed, 219 insertions(+), 3 deletions(-)
>>>>>
>>>>> --
>>>>> 1.9.3
>>>>>
>>>>>
>>>>
>>>> --
>>>> Linu cherian
> 
