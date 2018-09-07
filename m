Received: from eggs.gnu.org ([2001:4830:134:3::10]:45574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFT-0007UH-Qn
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFQ-000531-I4
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  7 Sep 2018 17:31:41 +1000
Message-Id: <20180907073155.26200-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] ppc-for-3.1 queue 20180907
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, mark.cave-ayland@ilande.co.uk, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd2415574=
52:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27=
-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-3.1-20180907

for you to fetch changes up to be0c46d464c7c6b601adcd21fe9d2dd054a6a2cf:

  target-ppc: Extend HWCAP2 bits for ISA 3.0 (2018-09-07 11:29:50 +1000)

----------------------------------------------------------------
ppc patch queue 2018-09-07

Here's another pull request for qemu-3.1.  No real theme here, just an
assortment of various fixes.  Probably the most notable thing is the
removal of the ppcemb target which has been deprecated for some time
now.

----------------------------------------------------------------
Emilio G. Cota (1):
      spapr: fix leak of rev array

Greg Kurz (1):
      spapr_pci: fix potential NULL pointer dereference

Jose Ricardo Ziviani (1):
      Fix a deadlock case in the CPU hotplug flow

Mark Cave-Ayland (7):
      macio: move MACIOIDEState type declarations to macio.h
      macio: add macio bus to help with fw path generation
      macio: add addr property to macio IDE object
      grackle: set device fw_name and address for correct fw path generat=
ion
      mac_oldworld: implement custom FWPathProvider
      uninorth: add ofw-addr property to allow correct fw path generation
      mac_newworld: implement custom FWPathProvider

Nikunj A Dadhania (1):
      target/ppc/kvm: set vcpu as online/offline

Sam Bobroff (1):
      spapr: Correct reference count on spapr-cpu-core

Sandipan Das (1):
      target-ppc: Extend HWCAP2 bits for ISA 3.0

Thomas Huth (1):
      ppc: Remove deprecated ppcemb target

 configure                          | 13 ++-------
 cpus.c                             |  1 -
 default-configs/ppcemb-softmmu.mak | 23 ---------------
 hw/ide/macio.c                     |  2 ++
 hw/misc/macio/macio.c              | 42 ++++++++++++++++++++-------
 hw/pci-host/grackle.c              | 17 +++++++++++
 hw/pci-host/uninorth.c             | 16 +++++++++++
 hw/ppc/mac.h                       | 26 -----------------
 hw/ppc/mac_newworld.c              | 59 ++++++++++++++++++++++++++++++++=
+++++-
 hw/ppc/mac_oldworld.c              | 59 ++++++++++++++++++++++++++++++++=
+++++-
 hw/ppc/ppc405_boards.c             | 14 ---------
 hw/ppc/ppc440_bamboo.c             |  7 -----
 hw/ppc/sam460ex.c                  |  7 -----
 hw/ppc/spapr.c                     |  3 ++
 hw/ppc/spapr_cpu_core.c            | 11 +++----
 hw/ppc/spapr_pci.c                 |  2 +-
 hw/ppc/spapr_rtas.c                |  2 ++
 hw/ppc/virtex_ml507.c              |  7 -----
 include/exec/poison.h              |  1 -
 include/hw/misc/macio/macio.h      | 37 ++++++++++++++++++++++++
 include/hw/pci-host/uninorth.h     |  1 +
 linux-user/elfload.c               |  2 ++
 qapi/common.json                   |  2 +-
 qemu-deprecated.texi               |  6 ----
 target/ppc/cpu-qom.h               |  2 --
 target/ppc/cpu.h                   | 16 -----------
 target/ppc/kvm.c                   | 13 +++++++--
 target/ppc/kvm_ppc.h               |  7 +++++
 target/ppc/mmu_helper.c            |  6 ++--
 target/ppc/translate_init.inc.c    | 35 +---------------------
 tests/machine-none-test.c          |  1 -
 31 files changed, 259 insertions(+), 181 deletions(-)
 delete mode 100644 default-configs/ppcemb-softmmu.mak
