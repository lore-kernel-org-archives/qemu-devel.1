Received: from eggs.gnu.org ([2001:4830:134:3::10]:40499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Linu.Cherian@cavium.com>) id 1diNZx-0005K9-76
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Linu.Cherian@cavium.com>) id 1diNZw-00036O-6k
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 12:23:29 -0400
Date: Thu, 17 Aug 2017 21:52:53 +0530
From: Linu Cherian <linu.cherian@cavium.com>
Message-ID: <20170817162253.GA6192@virtx40>
References: <1501579994-3320-1-git-send-email-eric.auger@redhat.com>
	<20170817112627.GA5417@virtx40>
	<da30de94-118d-b81e-f163-b60f71894415@arm.com>
	<20c68b9d-380d-1fbc-0fae-a5af44c2cdb2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c68b9d-380d-1fbc-0fae-a5af44c2cdb2@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [RFC v3 0/8] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Linu Cherian <linuc.decode@gmail.com>, peter.maydell@linaro.org, kevin.tian@intel.com, drjones@redhat.com, mst@redhat.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, qemu-devel@nongnu.org, peterx@redhat.com, alex.williamson@redhat.com, qemu-arm@nongnu.org, bharat.bhushan@nxp.com, christoffer.dall@linaro.org, eric.auger.pro@gmail.com

On Thu Aug 17, 2017 at 05:26:53PM +0200, Auger Eric wrote:
> Hi Linu, Jean,
> 
> On 17/08/2017 15:39, Jean-Philippe Brucker wrote:
> > Hi Linu,
> > 
> > On 17/08/17 12:26, Linu Cherian wrote:
> >> Hi Eric,
> >>
> >> On Tue Aug 01, 2017 at 11:33:06AM +0200, Eric Auger wrote:
> >>> This series implements the virtio-iommu device.
> >>>
> >>> This v3 mostly is a rebase on top of v2.10-rc0 that uses
> >>> IOMMUMmeoryRegion plus some small fixes.
> >>>
> >>> This is a proof of concept based on the virtio-iommu specification
> >>> written by Jean-Philippe Brucker [1].
> >>>
> >>> The device gets instantiated using the "-device virtio-iommu-device"
> >>> option. It currently works with ARM virt machine only, as the machine
> >>> must handle the dt binding between the virtio-mmio "iommu" node and
> >>> the PCI host bridge node.
> >>>
> >>> ACPI booting is not yet supported.
> >>>
> >>> Best Regards
> >>>
> >>> Eric
> >>>
> >>> This series can be found at:
> >>> https://github.com/eauger/qemu/tree/v2.10.0-rc0-virtio-iommu-rfcv3
> >>>
> >>> References:
> >>> [1] [RFC 0/3] virtio-iommu: a paravirtualized IOMMU,
> >>> [2] [RFC PATCH linux] iommu: Add virtio-iommu driver
> >>> [3] [RFC PATCH kvmtool 00/15] Add virtio-iommu
> >>>
> >>> Testing:
> >>> - >= 4.12 guest kernel + virtio-iommu driver [2]
> >>> - guest using a virtio-net-pci device:
> >>>   ,vhost=off,iommu_platform,disable-modern=off,disable-legacy=on
> >>
> >> Was trying to test this out and facing issues.
> >> Guest and Host Kernel - git://linux-arm.org/linux-jpb.git, Branch virtio-iommu/v0.4
> >> Qemu - As mentioned above.
> > 
> > Could you try branch virtio-iommu/v0.1? It contains the UAPI headers
> > compatible with this RFC.
> Thank you Jean. Yes the QEMU virtio-iommu device is based on the first
> user API written in [2]. I plan to rebase on v0.4 in short delay. Jean
> can I rebase on virtio-iommu/v0.4 or shall I wait a bit more?
> 
> Thanks

Yes, virtio-iommu/v0.1 works for me. Thanks.

> 
> Eric
> > 
> > Thanks,
> > Jean
> > 

-- 
Linu cherian
