Received: from eggs.gnu.org ([2001:4830:134:3::10]:45539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d1657-0003S2-TA
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d1651-0006kW-7U
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d1651-0006kJ-18
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:00:39 -0400
Date: Thu, 20 Apr 2017 15:00:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170420070022.GE26087@pxdev.xzpeter.org>
References: <A2975661238FB949B60364EF0F2C257439054049@shsmsx102.ccr.corp.intel.com>
	<20170418045400.GC22226@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C2574390540D1@shsmsx102.ccr.corp.intel.com>
	<20170418072717.GD22226@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257439054360@shsmsx102.ccr.corp.intel.com>
	<672ae592-e6ba-9152-b775-ec2bde931ef1@intel.com>
	<20170420030427.GA26087@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C2574390555FB@shsmsx102.ccr.corp.intel.com>
	<20170420054018.GD26087@pxdev.xzpeter.org>
	<1001fe60-570f-9882-a0b7-b74b7ea59a95@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1001fe60-570f-9882-a0b7-b74b7ea59a95@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Lan, Tianyu" <tianyu.lan@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Tian, Kevin" <kevin.tian@intel.com>

On Thu, Apr 20, 2017 at 02:51:11PM +0800, Lan, Tianyu wrote:
> On 4/20/2017 1:40 PM, Peter Xu wrote:

[...]

> >>>a slightly hackish way.
> >>
> >>In my understanding, container->space->as->root cannot work here no matter passthru-mode
> >>is enabled or not. The code here is aiming to check if vIOMMU exists. After the vfio series,
> >>the vtd_dev_as->root is not initialized to be a iommu MemoryRegion. Compared with checking
> >>if it is system_memory(), I think adding a mechanism to get the iommu MemoryRegion may
> >>be a better choice. Just like the current pci_device_iommu_address_space().
> >
> >Isn't pci_device_iommu_address_space() used to get that IOMMU memory
> >region? And, one thing to mention is that container->space->as is
> >actually derived from pci_device_iommu_address_space() (when calling
> >vfio_get_group()).
> >
> >I feel like that playing around with an IOMMU memory region is still
> >not clear enough in many cases. I still feel like some day we would
> >like an "IOMMU object". Then, we can register non-iotlb notifiers
> >against that IOMMU object, rather than memory regions...
> 
> Our target is to check whether assigned device is under a vIOMMU.
> We may check whether iommu_fn point has been populated in its pci bus' data
> structure(PCIDevice). This is what pci_device_iommu_address_space()
> does.

Agreed. Thanks,

-- 
Peter Xu
