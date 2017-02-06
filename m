Received: from eggs.gnu.org ([2001:4830:134:3::10]:35294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYHJ-0004cZ-Ht
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1caYHI-00008Y-FY
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 20:39:37 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  6 Feb 2017 12:39:24 +1100
Message-Id: <20170206013927.13693-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 0/3] isa-cleanup queue 20170206
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, edgar.iglesias@gmail.com, michael@walle.cc, proljc@gmail.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, kbastian@mail.uni-paderborn.de, jcmvbkbc@gmail.com, veroniabahaa@gmail.com, mst@redhat.com, armbru@redhat.com, agraf@suse.de, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit a951316b8a5c3c63254f20a826afeed940dd4cba:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-03 14:41:49 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/isa-cleanup-20170206

for you to fetch changes up to c124c4d13bcb19fc866e7f6de075f906fca6af4a:

  Split ISA and sysbus versions of m48t59 device (2017-02-06 12:33:21 +1100)

----------------------------------------------------------------
Allow ISA to be disabled on some platforms (v3)

This makes some cleanups that are a start on allowing ISA to be
compiled out for platforms which don't use it.

I posted this series last November, and it collected a number of R-bs
and no apparent objections.  So, I've now rebased it (trivially) and
am sending a pull request in the hopes of merge.  A lot of the pieces
here don't have a clear maintainer, so I'm sending it directly to
Peter.

Notes:
  * Patch 3/3 triggers a style warning, but that's just because I'm
    moving a C++ // comment verbatim from one file to another

Changes since v2:
  * Trivial rebase

Changes since v1:
  * Fixed some silly compile errors in 3/3 exposed by some
    changes in other headers

----------------------------------------------------------------
David Gibson (3):
      Split serial-isa into its own config option
      Allow ISA bus to be configured out
      Split ISA and sysbus versions of m48t59 device

 default-configs/alpha-softmmu.mak       |   1 +
 default-configs/arm-softmmu.mak         |   1 +
 default-configs/i386-softmmu.mak        |   1 +
 default-configs/mips-softmmu-common.mak |   1 +
 default-configs/moxie-softmmu.mak       |   2 +
 default-configs/pci.mak                 |   3 +
 default-configs/ppc-softmmu.mak         |   1 +
 default-configs/ppc64-softmmu.mak       |   1 +
 default-configs/ppcemb-softmmu.mak      |   1 +
 default-configs/sh4-softmmu.mak         |   1 +
 default-configs/sh4eb-softmmu.mak       |   1 +
 default-configs/sparc-softmmu.mak       |   1 +
 default-configs/sparc64-softmmu.mak     |   1 +
 default-configs/unicore32-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak      |   1 +
 hw/char/Makefile.objs                   |   3 +-
 hw/isa/Makefile.objs                    |   2 +-
 hw/timer/Makefile.objs                  |   3 +
 hw/timer/m48t59-internal.h              |  82 ++++++++++++
 hw/timer/m48t59-isa.c                   | 181 +++++++++++++++++++++++++
 hw/timer/m48t59.c                       | 228 +++-----------------------------
 21 files changed, 305 insertions(+), 212 deletions(-)
 create mode 100644 hw/timer/m48t59-internal.h
 create mode 100644 hw/timer/m48t59-isa.c
