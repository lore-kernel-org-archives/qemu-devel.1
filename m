Received: from eggs.gnu.org ([209.51.188.92]:60511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h0lGP-0005xT-OD
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h0lGO-0005Yn-1k
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:56:05 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:39110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h0lGN-0005Wn-RM
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 05:56:03 -0500
Received: by mail-wr1-f51.google.com with SMTP id l5so5001118wrw.6
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 02:56:02 -0800 (PST)
References: <20190221173326.31874-1-mst@redhat.com>
	<20190225101718-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a84fe47c-e755-b13e-b176-89b233820bc7@redhat.com>
Date: Mon, 4 Mar 2019 11:55:59 +0100
MIME-Version: 1.0
In-Reply-To: <20190225101718-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 resend 00/26] pci, pc, virtio: fixes,
 cleanups, tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 25/02/19 16:19, Michael S. Tsirkin wrote:
> The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:
> 
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> 
> for you to fetch changes up to 88c869198aa630e0477d653d0abf3f42c7c44d1f
> 
>   pci: Sanity test minimum downstream LNKSTA (2019-02-21 12:28:41 -0500)
> 
> ----------------------------------------------------------------
> 
> Note: this is same as a fixup I sent earlier, this is just a resend to
> make sure it's not missed.  This should also help me figure out whether
> this is a good format to use.

You should have sent it as a new toplevel message, too, otherwise Peter
doesn't see it.

Paolo

> ----------------------------------------------------------------
> pci, pc, virtio: fixes, cleanups, tests
> 
> Lots of work on tests: BiosTablesTest UEFI app,
> vhost-user testing for non-Linux hosts.
> Misc cleanups and fixes all over the place
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Alex Williamson (1):
>       pci: Sanity test minimum downstream LNKSTA
> 
> Alexey Kardashevskiy (1):
>       pci: Move NVIDIA vendor id to the rest of ids
> 
> Changpeng Liu (1):
>       contrib/vhost-user-blk: fix the compilation issue
> 
> Daniel P. Berrangé (1):
>       hw/smbios: fix offset of type 3 sku field
> 
> David Gibson (5):
>       virtio-balloon: Remove unnecessary MADV_WILLNEED on deflate
>       virtio-balloon: Corrections to address verification
>       virtio-balloon: Rework ballon_page() interface
>       virtio-balloon: Use ram_block_discard_range() instead of raw madvise()
>       virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size
> 
> Laszlo Ersek (5):
>       roms: add the edk2 project as a git submodule
>       roms: build the EfiRom utility from the roms/edk2 submodule
>       tests: introduce "uefi-test-tools" with the BiosTablesTest UEFI app
>       tests/uefi-test-tools: add build scripts
>       tests/data: introduce "uefi-boot-images" with the "bios-tables-test" ISOs
> 
> Paolo Bonzini (9):
>       vhost-net: move stubs to a separate file
>       vhost-net-user: add stubs for when no virtio-net device is present
>       vhost: restrict Linux dependency to kernel vhost
>       vhost-user: support cross-endian vnet headers
>       vhost-net: compile it on all targets that have virtio-net.
>       vhost-net: revamp configure logic
>       vhost-user-test: create a main loop per TestServer
>       vhost-user-test: small changes to init_hugepagefs
>       vhost-user-test: create a temporary directory per TestServer
> 
> Peter Xu (1):
>       i386/kvm: ignore masked irqs when update msi routes
> 
> Philippe Mathieu-Daudé (1):
>       Revert "contrib/vhost-user-blk: fix the compilation issue"
> 
> Wei Yang (1):
>       pc-dimm: use same mechanism for [get|set]_addr
> 
>  configure                                          | 102 ++++++++-----
>  Makefile                                           |   6 +-
>  default-configs/virtio.mak                         |   4 +-
>  include/exec/poison.h                              |   1 -
>  include/hw/firmware/smbios.h                       |   1 +
>  include/hw/pci/pci_ids.h                           |   2 +
>  include/hw/virtio/virtio-balloon.h                 |   3 +
>  .../UefiTestToolsPkg/Include/Guid/BiosTablesTest.h |  67 +++++++++
>  hw/mem/pc-dimm.c                                   |   4 +-
>  hw/net/vhost_net-stub.c                            |  92 ++++++++++++
>  hw/net/vhost_net.c                                 |  85 +----------
>  hw/pci/pcie.c                                      |  13 +-
>  hw/smbios/smbios.c                                 |   1 +
>  hw/vfio/pci-quirks.c                               |   2 -
>  hw/virtio/vhost-backend.c                          |  12 +-
>  hw/virtio/vhost-user.c                             |  13 +-
>  hw/virtio/vhost.c                                  |   2 +-
>  hw/virtio/virtio-balloon.c                         | 102 ++++++++++---
>  net/net.c                                          |   2 +-
>  net/vhost-user-stub.c                              |  23 +++
>  net/vhost-user.c                                   |  13 ++
>  .../BiosTablesTest/BiosTablesTest.c                | 130 +++++++++++++++++
>  tests/vhost-user-test.c                            | 160 +++++++++++----------
>  .gitmodules                                        |   3 +
>  backends/Makefile.objs                             |   5 +-
>  hw/net/Makefile.objs                               |   4 +-
>  hw/virtio/Makefile.objs                            |   8 +-
>  net/Makefile.objs                                  |   4 +-
>  roms/Makefile                                      |  13 +-
>  roms/edk2                                          |   1 +
>  tests/Makefile.include                             |   5 +-
>  .../bios-tables-test.aarch64.iso.qcow2             | Bin 0 -> 11776 bytes
>  .../bios-tables-test.arm.iso.qcow2                 | Bin 0 -> 11776 bytes
>  .../bios-tables-test.i386.iso.qcow2                | Bin 0 -> 12800 bytes
>  .../bios-tables-test.x86_64.iso.qcow2              | Bin 0 -> 13312 bytes
>  tests/uefi-test-tools/.gitignore                   |   3 +
>  tests/uefi-test-tools/LICENSE                      |  25 ++++
>  tests/uefi-test-tools/Makefile                     | 106 ++++++++++++++
>  .../BiosTablesTest/BiosTablesTest.inf              |  41 ++++++
>  .../UefiTestToolsPkg/UefiTestToolsPkg.dec          |  27 ++++
>  .../UefiTestToolsPkg/UefiTestToolsPkg.dsc          |  69 +++++++++
>  tests/uefi-test-tools/build.sh                     | 145 +++++++++++++++++++
>  42 files changed, 1051 insertions(+), 248 deletions(-)
>  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
>  create mode 100644 hw/net/vhost_net-stub.c
>  create mode 100644 net/vhost-user-stub.c
>  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c
>  create mode 160000 roms/edk2
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.arm.iso.qcow2
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.i386.iso.qcow2
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.x86_64.iso.qcow2
>  create mode 100644 tests/uefi-test-tools/.gitignore
>  create mode 100644 tests/uefi-test-tools/LICENSE
>  create mode 100644 tests/uefi-test-tools/Makefile
>  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf
>  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dec
>  create mode 100644 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
>  create mode 100755 tests/uefi-test-tools/build.sh
> 
> 
