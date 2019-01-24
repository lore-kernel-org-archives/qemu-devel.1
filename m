Received: from eggs.gnu.org ([209.51.188.92]:58491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmfFY-0005kU-Ao
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:40:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmfBs-0002tW-IG
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:37:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:23569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmfBs-0002lV-8T
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:37:08 -0500
Date: Thu, 24 Jan 2019 21:33:18 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190124133318.GA25633@yangzhon-Virtual>
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-42-yang.zhong@intel.com>
	<fa45d1f5-4bc4-827a-321d-7df073c97861@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa45d1f5-4bc4-827a-321d-7df073c97861@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 41/44] virtio: make virtio
 dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

On Thu, Jan 24, 2019 at 01:51:58PM +0100, Thomas Huth wrote:
> On 2019-01-23 07:56, Yang Zhong wrote:
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  default-configs/i386-softmmu.mak  |  1 -
> >  default-configs/s390x-softmmu.mak |  1 -
> >  default-configs/virtio.mak        | 15 ---------------
> >  hw/9pfs/Kconfig                   |  2 ++
> >  hw/block/Kconfig                  |  2 ++
> >  hw/char/Kconfig                   |  2 ++
> >  hw/display/Kconfig                |  5 +++++
> >  hw/input/Kconfig                  |  2 ++
> >  hw/net/Kconfig                    |  2 ++
> >  hw/pci-host/Kconfig               |  2 ++
> >  hw/scsi/Kconfig                   |  1 +
> >  hw/virtio/Kconfig                 |  9 ++++++++-
> >  12 files changed, 26 insertions(+), 18 deletions(-)
> >  delete mode 100644 default-configs/virtio.mak
> 
> This breaks compilation of aarch64 / arm as long as these targets are
> not fully converted yet:
> 
> Exception: contradiction between clauses when setting VIRTIO_MMIO
> make: *** No rule to make target `aarch64-softmmu/config-devices.mak',
> needed by `config-all-devices.mak'.  Stop.
> 
> I think you temporarily have not to set CONFIG_VIRTIO=y in
> default-configs/arm-softmmu.mak (and likely also in the riscv and s390x
> configs), until they are finally converted completely?
>
   Hello Thomas,
   
   We did not defaultly enable VIRTIO for all ARCHs, and oonly enable this 
   from host bridge. CONFIG_VIRTIO=y is defined in pci.mak, which is not enabled
   for all ARCHs.

   ./hw/pci-host/Kconfig
   config PCI_PIIX
    bool
    select PCI
    select VIRTIO

   config PCI_EXPRESS_Q35
    bool
    select PCI_EXPRESS
    select PCI
    select XIO3130
    select IOH3420
    select I82801B11
    select VIRTIO 
  
    Yang
   
>  Thomas
