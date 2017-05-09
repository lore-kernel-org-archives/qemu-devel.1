Received: from eggs.gnu.org ([2001:4830:134:3::10]:33697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d83aY-0007K9-00
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d83aU-0007Db-QB
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:45:57 -0400
Date: Tue, 9 May 2017 19:45:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170509114545.GN2820@pxdev.xzpeter.org>
References: <20170505101930.45837-1-aik@ozlabs.ru>
	<20170509091451.GJ2820@pxdev.xzpeter.org>
	<2d7d85cc-a90e-fba1-ede9-2b71c7f68224@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d7d85cc-a90e-fba1-ede9-2b71c7f68224@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v6] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Tue, May 09, 2017 at 09:34:34PM +1000, Alexey Kardashevskiy wrote:
> On 09/05/17 19:14, Peter Xu wrote:
> 
> >> +void memory_region_init_iommu(IOMMUMemoryRegion *iommu_mr,
> >> +                              Object *owner,
> >> +                              const MemoryRegionIOMMUOps *ops,
> >> +                              const char *name,
> >> +                              uint64_t size)
> >> +{
> >> +    memory_region_init_iommu_type(TYPE_IOMMU_MEMORY_REGION, iommu_mr,
> >> +                                  owner, ops, name, size);
> > 
> > I see that memory_region_init_iommu_type() is only used to create
> > TYPE_IOMMU_MEMORY_REGION typed MRs. Then would
> > memory_region_init_iommu() enough for us? Or do you have plan to add
> > new memory region types?
> 
> Yes, I am still thinking of adding TYPE_SPAPR_TCE_IOMMU_MEMORY_REGION
> later, for strict types checking when enabling in-kernel DMA operations
> support (our SPAPR thingy).

I see. Then this looks okay to me. Thanks,

-- 
Peter Xu
