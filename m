Received: from eggs.gnu.org ([2001:4830:134:3::10]:34769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07W-0004SL-E7
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eg07V-0001c2-FF
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 22:28:34 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 29 Jan 2018 14:28:14 +1100
Message-Id: <20180129032826.16876-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/12] ppc-for-2.12 queue 20180129
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, surajjs@au1.ibm.com, groug@kaod.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit e607bbee553cfe73072870cef458cfa4e78133=
e2:

  Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018=
-01-26.for-upstream' into staging (2018-01-26 14:24:25 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180129

for you to fetch changes up to c59704b254734182c3202e0c261589ea2ccf485e:

  target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS (2018-01-29 14:2=
4:55 +1100)

----------------------------------------------------------------
ppc patch queue 2018-01-29

Here's another batch of patches for ppc, spapr and related things.
Higlights:

  * Implement (with a bunch of necessary infrastructure) a hypercall
    to let guests properly apply Spectre and Meltdown workarounds.
  * Convert a number of old devices to trace events
  * Fix some bugs

----------------------------------------------------------------
C=C3=A9dric Le Goater (1):
      ppc/pnv: fix PnvChip redefinition in <hw/ppc/pnv_xscom.h>

Greg Kurz (1):
      spapr_pci: fix MSI/MSIX selection

Mark Cave-Ayland (3):
      grackle: convert to trace-events
      uninorth: convert to trace-events
      input: add missing newline from trace-events

Suraj Jitindar Singh (6):
      target/ppc/kvm: Add cap_ppc_safe_[cache/bounds_check/indirect_branc=
h]
      target/ppc/spapr_caps: Add support for tristate spapr_capabilities
      target/ppc/spapr_caps: Add new tristate cap safe_cache
      target/ppc/spapr_caps: Add new tristate cap safe_bounds_check
      target/ppc/spapr_caps: Add new tristate cap safe_indirect_branch
      target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS

thuth@redhat.com (1):
      ppc: Deprecate qemu-system-ppcemb

 hw/input/trace-events      |   1 +
 hw/pci-host/grackle.c      |  13 +----
 hw/pci-host/trace-events   |   9 ++++
 hw/pci-host/uninorth.c     |  24 ++-------
 hw/ppc/ppc405_boards.c     |  14 +++++
 hw/ppc/ppc440_bamboo.c     |   9 ++++
 hw/ppc/spapr.c             |   6 +++
 hw/ppc/spapr_caps.c        | 124 +++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ppc/spapr_hcall.c       |  58 +++++++++++++++++++++
 hw/ppc/spapr_pci.c         |  61 +++++++++++++++-------
 hw/ppc/virtex_ml507.c      |   8 +++
 include/hw/ppc/pnv_xscom.h |   2 -
 include/hw/ppc/spapr.h     |  28 +++++++++-
 qemu-doc.texi              |   6 +++
 target/ppc/kvm.c           |  58 +++++++++++++++++++++
 target/ppc/kvm_ppc.h       |  18 +++++++
 16 files changed, 387 insertions(+), 52 deletions(-)
