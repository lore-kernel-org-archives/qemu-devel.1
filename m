Received: from eggs.gnu.org ([2001:4830:134:3::10]:56370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70J-0001Ng-EM
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70I-0003zF-8r
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:35 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:42:50 +1000
Message-Id: <20170927074316.4454-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/26] ppc-for-2.11 queue 20170927
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 31bc1d8481af414cfa2857f905e40f7d8e6d5b=
2e:

  Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' i=
nto staging (2017-09-26 19:49:08 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20170927

for you to fetch changes up to e451b85f1bf3c8140be51e2b03eb71ab96c246a5:

  macio: use object link between MACIO_IDE and MAC_DBDMA object (2017-09-=
27 13:05:41 +1000)

----------------------------------------------------------------
ppc patch queue 2017-09-27

Contains
 * a number of Mac machine type fixes
 * a number of embedded machine type fixes (preliminary to adding the
   Sam460ex board)
 * a important fix for handling of migration with KVM PR
 * assorted other minor fixes and cleanups

----------------------------------------------------------------
BALATON Zoltan (4):
      ohci: Allow sysbus version to be used as a companion
      ehci: Add ppc4xx-ehci for the USB 2.0 controller in embedded PPC So=
Cs
      ppc: Add 460EX embedded CPU
      ppc4xx: Add more PLB registers

Benjamin Herrenschmidt (4):
      ppc/mac: Advertise a high clock frequency for NewWorld Macs
      ppc/mac: More rework of the DBDMA emulation
      ppc/ide/macio: Add missing registers
      ppc: Fix OpenPIC model

C=C3=A9dric Le Goater (1):
      ppc/pnv: check for OPAL firmware file presence

Eric Blake (1):
      ppc/pnv: Improve macro parenthesization

Greg Kurz (7):
      ppc/kvm: check some capabilities with kvm_vm_check_extension()
      ppc/kvm: drop kvmppc_has_cap_htab_fd()
      ppc/kvm: change kvmppc_get_htab_fd() to return -errno on error
      ppc/kvm: generalize the use of kvmppc_get_htab_fd()
      spapr: introduce helpers to migrate HPT chunks and the end marker
      spapr_pci: make index property mandatory
      spapr: fix the value of SDR1 in kvmppc_put_books_sregs()

John Snow (2):
      ppc: remove unused CPU definitions
      ppc: remove all unused CPU definitions

Mark Cave-Ayland (7):
      ppc: QOMify g3beige machine
      macio: convert pmac_ide_ops from old_mmio
      mac_dbdma: remove unused IO fields from DBDMAState
      mac_dbdma: QOMify
      mac_dbdma: remove DBDMA_init() function
      macio: pass channel into MACIOIDEState via qdev property
      macio: use object link between MACIO_IDE and MAC_DBDMA object

 hw/ide/macio.c              | 206 +++++++++++++++++++----------------
 hw/intc/openpic.c           |  35 ++++++
 hw/misc/macio/mac_dbdma.c   | 242 +++++++++++++++++++++++++++++---------=
---
 hw/misc/macio/macio.c       |  21 +++-
 hw/ppc/mac.h                |  10 +-
 hw/ppc/mac_newworld.c       |   4 +-
 hw/ppc/mac_oldworld.c       |  17 ++-
 hw/ppc/pnv.c                |   6 +-
 hw/ppc/ppc405_uc.c          |  12 ++-
 hw/ppc/spapr.c              |  68 +++++++-----
 hw/ppc/spapr_cpu_core.c     |  16 +--
 hw/ppc/spapr_hcall.c        |  45 +++++---
 hw/ppc/spapr_pci.c          |  62 ++---------
 hw/usb/hcd-ehci-sysbus.c    |  25 +++++
 hw/usb/hcd-ehci.h           |   1 +
 hw/usb/hcd-ohci.c           |  15 ++-
 include/hw/ppc/mac_dbdma.h  |  11 +-
 include/hw/ppc/openpic.h    |   1 +
 include/hw/ppc/pnv_xscom.h  |   2 +-
 target/ppc/cpu-models.c     |   3 +
 target/ppc/cpu-models.h     | 258 +-------------------------------------=
------
 target/ppc/cpu.h            |   1 +
 target/ppc/kvm.c            |  80 +++++---------
 target/ppc/kvm_ppc.h        |  16 +--
 target/ppc/translate_init.c |  38 +++++++
 25 files changed, 579 insertions(+), 616 deletions(-)
