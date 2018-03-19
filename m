Received: from eggs.gnu.org ([2001:4830:134:3::10]:56128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim4-0006Ye-2n
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1exim2-0000Ha-V1
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 20:35:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 19 Mar 2018 11:35:16 +1100
Message-Id: <20180319003524.28143-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] ppc-for-2.12 queue 20180319
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, lvivier@redhat.com, surajjs@au1.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit e1e44a9916b4318e943aecd669e096222cb3ea=
eb:

  Merge remote-tracking branch 'remotes/xtensa/tags/20180316-xtensa' into=
 staging (2018-03-17 14:15:03 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180319

for you to fetch changes up to 91c60f124e682a78c9a2ef951e8e58ebab6441d0:

  target/ppc: fix tlbsync to check privilege level depending on GTSE (201=
8-03-18 21:03:20 +1100)

----------------------------------------------------------------
ppc patch queue for 2018-03-19

This pull request supersedes the one for 2018-03-15.  The only
difference is one patch is removed, since it exposed some code which
triggers ubsan warnings.

Here's the set of accumulated patches now that we're into soft freeze.
I've split new functionality into a ppc-for-2.13 branch, so this only
has bugfixes.  Well.. and a couple of simple cleanups to make bugfixes
easier, some test improvements and a trivial change to make command
line options more obvious.  I think those are all acceptable for soft
freeze.

----------------------------------------------------------------
BALATON Zoltan (2):
      sii3112: Remove unneeded exit function
      ppc440_pcix: Change some error_report to qemu_log_mask(LOG_UNIMP, .=
..)

C=C3=A9dric Le Goater (1):
      target/ppc: fix tlbsync to check privilege level depending on GTSE

David Engraf (1):
      PPC e500: Fix gap between u-boot and kernel

Thomas Huth (4):
      tests/boot-serial: Check the 40p machine, too
      hw/ppc/prep: Fix implicit creation of "-drive if=3Dscsi" devices
      hw/misc/macio: Mark the macio devices with user_creatable =3D false
      hw/ppc/spapr: Allow "spapr-vlan" as NIC model name beside "ibmveth"

 hw/ide/sii3112.c         | 12 ------------
 hw/misc/macio/macio.c    |  2 ++
 hw/ppc/e500.c            |  9 ++++-----
 hw/ppc/ppc440_pcix.c     | 11 +++++++----
 hw/ppc/prep.c            |  2 +-
 hw/ppc/spapr.c           |  5 +++--
 hw/scsi/lsi53c895a.c     |  7 +++++++
 include/hw/pci/pci.h     |  1 +
 target/ppc/translate.c   |  9 +++++++--
 tests/boot-serial-test.c |  6 ++++--
 10 files changed, 36 insertions(+), 28 deletions(-)
