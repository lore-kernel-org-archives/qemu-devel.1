Received: from eggs.gnu.org ([2001:4830:134:3::10]:52810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVHZZ-0001j5-KE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dVHZV-0000XF-Kd
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:20:57 -0400
Date: Wed, 12 Jul 2017 15:20:38 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170712152038.16cddfbc@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170711035620.4232-1-aik@ozlabs.ru>
References: <20170711035620.4232-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v9 0/2] memory/iommu: QOM'fy IOMMU
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
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org

On Tue, 11 Jul 2017 13:56:18 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> Here is a couple of patches to QOM'fy IOMMU memory regions.
> 
> I have made them in order to proceed with in-kernel TCE stuff acceleration
> enablement which sort of depends on sPAPR IOMMU MR being QOM'ed.
> 
> 
> This is based on sha1
> 3f0602927b Peter Maydell "Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20170613' into staging".
> 
> Please comment. Thanks.
> 
> 
> Changes:
> v9:
> * reworked 2/2 to follow the existing function naming style
> 
> v8:
> * now 2 patches
> 
> This is based on sha1
> b113658675 Peter Maydell "Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20170706' into staging".
> 
> Please comment. Thanks.

While the patches seem sane to me at a glance, I haven't done a
in-depth review. But for the s390 parts:

Acked-by: Cornelia Huck <cohuck@redhat.com>

for both patches.

> 
> 
> 
> Alexey Kardashevskiy (2):
>   memory/iommu: QOM'fy IOMMU MemoryRegion
>   memory/iommu: introduce IOMMUMemoryRegionClass
> 
>  hw/i386/amd_iommu.h           |   5 +-
>  hw/s390x/s390-pci-bus.h       |   3 +-
>  include/exec/memory.h         |  94 +++++++++++++++++++++++++----------
>  include/hw/i386/intel_iommu.h |   5 +-
>  include/hw/mips/mips.h        |   2 +-
>  include/hw/ppc/spapr.h        |   7 ++-
>  include/hw/vfio/vfio-common.h |   2 +-
>  include/qemu/typedefs.h       |   1 +
>  exec.c                        |  14 +++---
>  hw/alpha/typhoon.c            |  31 +++++++++---
>  hw/dma/rc4030.c               |  34 +++++++++----
>  hw/i386/amd_iommu.c           |  33 +++++++++---
>  hw/i386/intel_iommu.c         |  42 +++++++++++-----
>  hw/mips/mips_jazz.c           |   2 +-
>  hw/pci-host/apb.c             |  29 ++++++++---
>  hw/ppc/spapr_iommu.c          |  42 ++++++++++------
>  hw/s390x/s390-pci-bus.c       |  29 +++++++----
>  hw/s390x/s390-pci-inst.c      |  11 ++--
>  hw/vfio/common.c              |  12 +++--
>  hw/vfio/spapr.c               |   3 +-
>  memory.c                      | 113 ++++++++++++++++++++++++++++--------------
>  21 files changed, 355 insertions(+), 159 deletions(-)
> 
