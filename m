Received: from eggs.gnu.org ([2001:4830:134:3::10]:48872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1diKz5-0001jp-Sv
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1diKz4-0000yL-V6
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 09:37:15 -0400
References: <1501579994-3320-1-git-send-email-eric.auger@redhat.com>
	<20170817112627.GA5417@virtx40>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <da30de94-118d-b81e-f163-b60f71894415@arm.com>
Date: Thu, 17 Aug 2017 14:39:34 +0100
MIME-Version: 1.0
In-Reply-To: <20170817112627.GA5417@virtx40>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC v3 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linu Cherian <linuc.decode@gmail.com>, Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, kevin.tian@intel.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, drjones@redhat.com, peterx@redhat.com, bharat.bhushan@nxp.com, christoffer.dall@linaro.org, linu.cherian@cavium.com

Hi Linu,

On 17/08/17 12:26, Linu Cherian wrote:
> Hi Eric,
> 
> On Tue Aug 01, 2017 at 11:33:06AM +0200, Eric Auger wrote:
>> This series implements the virtio-iommu device.
>>
>> This v3 mostly is a rebase on top of v2.10-rc0 that uses
>> IOMMUMmeoryRegion plus some small fixes.
>>
>> This is a proof of concept based on the virtio-iommu specification
>> written by Jean-Philippe Brucker [1].
>>
>> The device gets instantiated using the "-device virtio-iommu-device"
>> option. It currently works with ARM virt machine only, as the machine
>> must handle the dt binding between the virtio-mmio "iommu" node and
>> the PCI host bridge node.
>>
>> ACPI booting is not yet supported.
>>
>> Best Regards
>>
>> Eric
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/v2.10.0-rc0-virtio-iommu-rfcv3
>>
>> References:
>> [1] [RFC 0/3] virtio-iommu: a paravirtualized IOMMU,
>> [2] [RFC PATCH linux] iommu: Add virtio-iommu driver
>> [3] [RFC PATCH kvmtool 00/15] Add virtio-iommu
>>
>> Testing:
>> - >= 4.12 guest kernel + virtio-iommu driver [2]
>> - guest using a virtio-net-pci device:
>>   ,vhost=off,iommu_platform,disable-modern=off,disable-legacy=on
> 
> Was trying to test this out and facing issues.
> Guest and Host Kernel - git://linux-arm.org/linux-jpb.git, Branch virtio-iommu/v0.4
> Qemu - As mentioned above.

Could you try branch virtio-iommu/v0.1? It contains the UAPI headers
compatible with this RFC.

Thanks,
Jean
