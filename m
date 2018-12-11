Received: from eggs.gnu.org ([2001:4830:134:3::10]:42363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOG-0007P7-II
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gWmOB-0006tR-Ge
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:04:16 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 11 Dec 2018 19:03:22 +0100
Message-Id: <20181211180352.19644-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/30] Trivial patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>

The following changes since commit 32a1a94dd324d33578dca1dc96d7896a0244d768:

  Update version for v3.1.0 release (2018-12-11 17:18:37 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-patches-pull-request

for you to fetch changes up to 82c48fb79df5596a9d0a3b6d998c4491e542aa7a:

  Fixes i386 xchgq test (2018-12-11 18:41:25 +0100)

----------------------------------------------------------------
Trivial patches (2018-12-11)

----------------------------------------------------------------

Dongli Zhang (1):
  virtio: pass argument by value for virtqueue_map_iovec()

Eric Blake (4):
  qapi: Reduce Makefile boilerplate
  misc: Avoid UTF-8 in error messages
  cutils: Assert in-range base for string-to-integer conversions
  maint: Grammar fix to mailmap

Fam Zheng (1):
  MAINTAINERS: Update email address for Fam Zheng

Li Qiang (5):
  hw: qdev: fix error in comment
  hw: set_netdev: remove useless code
  target: hax: replace g_malloc with g_new0
  target: hax: fix errors in comment
  util: vfio-helpers: use ARRAY_SIZE in qemu_vfio_init_pci()

Marc-André Lureau (1):
  misc: fix spelling

Philippe Mathieu-Daudé (15):
  MAINTAINERS: Fix ACPI tests data files path
  MAINTAINERS: Add a missing entry to the SPARC CPU
  MAINTAINERS: Add missing entries for the Xilinx ZynqMP machine
  MAINTAINERS: Add missing entries for the Jazz machine
  MAINTAINERS: Add a missing entry for the Xilinx S3A-DSP 1800 machine
  MAINTAINERS: Add a missing entry for the Old World machines
  MAINTAINERS: Add a missing entry for the sun4m machines
  MAINTAINERS: Add missing entries to the PC Chipset section
  MAINTAINERS: Add missing entries to the vhost section
  MAINTAINERS: Add missing entries for the Canon DIGIC machine
  MAINTAINERS: Add missing entries for the MPS2 machine
  MAINTAINERS: Add a missing entry to SPICE
  MAINTAINERS: Add a missing entry to the QMP section
  MAINTAINERS: Add a missing entry for the NVDIMM device
  MAINTAINERS: Use my work email to review Build and test automation
    patches

Thomas Huth (2):
  MAINTAINERS: Add missing hw/pci-host entries
  MAINTAINERS: Add nios2-related files to the Nios2 section

fabrice.desclaux@cea.fr (1):
  Fixes i386 xchgq test

 .gitignore                       |  72 +-----------
 .mailmap                         |   2 +-
 MAINTAINERS                      |  49 +++++---
 Makefile                         | 194 ++++---------------------------
 Makefile.objs                    |  75 ++----------
 hw/core/qdev-properties-system.c |   4 -
 hw/misc/tmp105.c                 |   2 +-
 hw/misc/tmp421.c                 |   2 +-
 hw/virtio/virtio.c               |   8 +-
 include/hw/qdev-core.h           |   2 +-
 target/i386/cpu.c                |   2 +-
 target/i386/hax-all.c            |  17 +--
 tests/tcg/i386/test-i386.c       |   2 +-
 util/cutils.c                    |   8 ++
 util/vfio-helpers.c              |   2 +-
 15 files changed, 94 insertions(+), 347 deletions(-)

-- 
2.19.2
