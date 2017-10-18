Received: from eggs.gnu.org ([2001:4830:134:3::10]:38733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e4l69-0002Vo-Vz
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1e4l65-00008Z-42
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:57:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:62340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1e4l64-000073-SN
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:57:09 -0400
Date: Wed, 18 Oct 2017 17:56:42 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20171018095642.GA5442@yangzhon-Virtual>
References: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
	<ebb88add-3173-78b9-397e-53a364ca0d53@gmail.com>
	<0ea87d45-f1c9-21c5-ddc3-c1d5bd0c6df8@redhat.com>
	<20171018055755.GB4352@yangzhon-Virtual>
	<1ecf42be-b0e6-43a1-8747-c94425ded449@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ecf42be-b0e6-43a1-8747-c94425ded449@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] add "nopin" option in the
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: xiaoguangrong.eric@gmail.com, ehabkost@redhat.com, alex.williamson@redhat.com, anthony.xu@intel.com, yang.zhong@intel.com

On Wed, Oct 18, 2017 at 11:48:11AM +0200, Paolo Bonzini wrote:
> On 18/10/2017 07:57, Zhong Yang wrote:
> >   Your suggestion can avoid DMA target to nvdimm if the nvdimm memory region
> >   was skipped during VFIO hotplug. It is valuable to try this solution. by the
> >   way, please share me some clue for PCI address space related with memory region,
> >   below address_space_mem is right?  Many thanks!
> > 
> >   static void pci_bus_init(PCIBus *bus, DeviceState *parent,
> >                          MemoryRegion *address_space_mem,
> >                          MemoryRegion *address_space_io,
> >                          uint8_t devfn_min)  
> 
> Yes.  You would have to add the region directly to the CPU address
> space, and not to address_space_memory (which is included in both the
> CPU and PCI address spaces).
> 
> Paolo
  
  Thanks Paolo for your great help! I will try this solution in next week, thanks again.

  Regards,

  Yang
