Received: from eggs.gnu.org ([2001:4830:134:3::10]:40497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cK1Cd-0004kl-F8
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 06:06:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cK1Ca-00064W-9a
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 06:06:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cK1Ca-000646-0k
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 06:06:24 -0500
Date: Thu, 22 Dec 2016 12:06:16 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161222110616.ocgmojb3vrs46o4c@kamzik.brq.redhat.com>
References: <1481512100-10380-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481512100-10380-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v8 00/14] VT-d unit test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, rkrcmar@redhat.com, agordeev@redhat.com, jan.kiszka@web.de, pbonzini@redhat.com


Alex,

Are you happy with v8? If so, then, as far as I'm concerned, this
series is ready. I'd like to try driving the edu device from ARM
tests too.

Thanks,
drew


On Mon, Dec 12, 2016 at 11:08:06AM +0800, Peter Xu wrote:
> This is v8 of vt-d unit test series.
> 
> (CC qemu-devel list this time.)
> 
> Patch "libcflat: add IS_ALIGNED() macro, and page sizes" is picked up
> by Drew in the ARM GIC framework series, so please feel free to drop
> it when needed.
> 
> Online repo:
> 
>   https://github.com/xzpeter/kvm-unit-tests.git iommu-ut-v8
> 
> Please review. Thanks,
> 
> v8:
> - use ioremap() to access vt-d/edu registers (adding vtd_reg_base to
>   store vt-d mmio base register vaddr, and pci_edu_dev.reg_base to
>   store edu device base register vaddr) [Alex]
> - check vt-d version [Alex]
> - vtd_install_pte: do phys_to_virt() for root pointer [Alex]
> - renaming VTD_FETCH_VIRT_ADDR to VTD_PHYS_TO_VIRT [Alex]
> - define VTD_PAGE_SHIFT and VTD_PAGE_SIZE, use them when necessary
>   [Alex]
> - change define of VTD_PTE_ADDR to cover bits 63:12
> 
> v7:
> - patch 13: add r-b for Drew
> - change type of dev_offset in edu_dma() into unsigned [Alex]
> - squash Alex's fix (thanks) for ARM build into patch 08/14 [Alex]
> 
> v6:
> - pci: rename pci_dev.bar to pcidev.resource (to Drew: I didn't remove
>   your r-b in several patches due to this change, assuming the change
>   is trivial) [Alex]
> - pci_cap_walk(): add an assert to avoid dead loop [Alex]
> - pci_cap_walk(): another assertion to make sure cap_id is valid
>   [Drew]
> 
> v5:
> - add one more patch at the beginning of series to add "extern" to
>   pci_testdev() header definition [Drew]
> - add "extern" to all pci.h functions [Drew]
> - update IS_ALIGNED patch to be aligned with Drew's gic series [Drew]
> - replace one more PCI_DEVFN_MAX/PCI_BAR_NUM in lib/pci-host-generic.c
>   [Drew]
> - add {} in vtd_install_pte() when there are one line code and one
>   line comment [Drew]
> - drop Drew's suggested-by in patch "x86: intel-iommu: add IR MSI
>   test" (I forgot why I added it, but anyway let me drop it here...)
>   [Drew]
> 
> v4:
> (same as v3, but with correct patches sent out)
> 
> v3:
> - is_power_of_2(): remove outer "()" [Drew]
> - fix indent for vtd_root_table() [Drew]
> - pci_find_dev(): keep {} to avoid touching more codes [Drew]
> - pci_scan_bars(): check whether bar is 64bits [Drew]
> - pci_enable_defaults(): make it return nothing [Drew]
> - fix strnang blanks in lib/x86/intel-iommu.h [Drew]
> - pci_setup_msi(): fix correct assert() inside [Drew]
> - squash patches: 03+17 08+09 10+11 12+14 [Drew]
> - remove all "()" for raw defines (numbers) in macros [Drew]
> 
> v2:
> - move cpu_relax patch to the beginning, and use them in all places
> [Drew]
> - replace all corresponding 256 into PCI_DEVFN_MAX, as well for
> PCI_BAR_NUM [Drew]
> - adding is_power_of_2() to replace ONE_BIT_ONLY() [Drew]
> - add SZ_64K macro [Drew]
> - declare pci_config_write[wb] in lib/asm-generic/pci-host-bridge.h [Alex]
> - edu_reg_read/write() add "l" in func name [Drew]
> - drop pci_set_master(), instead, provide pci_cmd_set_clr() [Drew]
> - change return code into bool (always) for functions that apply
> [Drew]
> - keep old pci_find_dev() interface [Drew/Alex]
> - use __raw_{read|write}*() for both vt-d and edu register read/writes
> [Alex]
> - remove pci_ prefix for all pci_dev fields [Drew]
> - replace 0xff in cap_handlers[0xff] into (PCI_CAP_ID_MAX + 1) [Drew]
> - make x86/unittest.cfg simpler by using q35 directly with eim=off
> [Drew]
> 
> RFC -> v1:
> - when init edu device fail, report_skip() rather than return error
> [Radim]
> - use asserts rather than "static bool inited" to avoid multiple init
> of components (affects patch 1/2) [Drew]
> - moving the first two patches out of the series [Drew]
> - int vtd_init(), do not setup_idt() since smp_init() did it [Drew]
> - when edu do not have MSI enabled, skip interrupt test [Radim]
> - rename vtd_reg_*() into vtd_{read|write}[lq](), and move them to
> header file [Drew]
> - use PAGE_MASK when able [Drew]
> - use "&" instead of "|" in intel-iommu init test (three places)
> [Drew]
> - use "vtd_init()" in unit test [Drew]
> - mention that where intel-iommu.h comes from [Drew]
> - re-written vtd_gcmd_or(), make it also work on even hardware [Drew]
> - remove most of the oneline wrapper for VT-d registers, instead, use
> vtd_{read|write}* with register names [Drew]
> - remove useless BDF helpers [Drew]
> - move edu device macros into header file [Drew]
> - make edu_check_alive static inline [Drew]
> - remove all useless wrappers in pci-edu.c [Drew]
> - remove pci_dma_dir_t and all its users, instead, use "bool
> from_device" [Drew]
> - not use typedef for structs, to follow Linux/kvm-unit-tests coding
> style [Drew]
> - let pci_dev_init() clean and simple, then provide
> pci_enable_defaults() for more complicated things [Drew]
> - add one more patch to add intel-iommu test into x86/unittest [Radim]
> - use 0x60 intr request instead of factorial to trigger edu device
> interrupt [Drew]
> - ...and some other changes I just forgot to note down...
> 
> Currently only a very small test scope is covered:
> 
> * VT-d init
> * DMAR: 4 bytes copy
> * IR: MSI
> 
> However this series could be a base point to add more test cases for
> VT-d. The problem is, there are many IOMMU error conditions which are
> very hard to be triggered in a real guest (IOMMU has merely no
> interface for guest user, and it's totally running in the background).
> This piece of work can be a start point if we want to do more
> complicated things and play around with Intel IOMMU devices (also for
> IOMMU regression tests).
> 
> Please review. Thanks,
> 
> Peter Xu (14):
>   pci: fix missing extern for pci_testdev()
>   x86/asm: add cpu_relax()
>   libcflat: introduce is_power_of_2()
>   x86: intel-iommu: add vt-d init test
>   libcflat: add IS_ALIGNED() macro, and page sizes
>   libcflat: moving MIN/MAX here
>   vm/page: provide PGDIR_OFFSET() macro
>   pci: introduce struct pci_dev
>   pci: provide pci_scan_bars()
>   pci: provide pci_enable_defaults()
>   pci: edu: introduce pci-edu helpers
>   x86: intel-iommu: add dmar test
>   pci: add msi support for 32/64bit address
>   x86: intel-iommu: add IR MSI test
> 
>  lib/alloc.c            |   3 -
>  lib/libcflat.h         |  14 +++
>  lib/pci-edu.c          |  73 +++++++++++
>  lib/pci-edu.h          |  84 +++++++++++++
>  lib/pci-host-generic.c |  19 +--
>  lib/pci-testdev.c      |  10 +-
>  lib/pci.c              | 161 ++++++++++++++++++++----
>  lib/pci.h              |  42 +++++--
>  lib/x86/asm/barrier.h  |  11 ++
>  lib/x86/asm/page.h     |   3 +
>  lib/x86/intel-iommu.c  | 326 +++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/x86/intel-iommu.h  | 146 ++++++++++++++++++++++
>  lib/x86/vm.c           |   4 +-
>  x86/Makefile.common    |   1 +
>  x86/Makefile.x86_64    |   2 +
>  x86/intel-iommu.c      | 120 ++++++++++++++++++
>  x86/unittests.cfg      |   7 ++
>  x86/vmexit.c           |  27 ++--
>  18 files changed, 989 insertions(+), 64 deletions(-)
>  create mode 100644 lib/pci-edu.c
>  create mode 100644 lib/pci-edu.h
>  create mode 100644 lib/x86/intel-iommu.c
>  create mode 100644 lib/x86/intel-iommu.h
>  create mode 100644 x86/intel-iommu.c
> 
> -- 
> 2.7.4
> 
> 
