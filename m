Received: from eggs.gnu.org ([2001:4830:134:3::10]:40597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMG-00073U-Ku
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ewKMF-00041c-GH
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 00:19:16 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 15 Mar 2018 15:18:54 +1100
Message-Id: <20180315041903.10046-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] ppc-for-2.12 queue 20180315
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

The following changes since commit 026aaf47c02b79036feb830206cfebb2a72651=
0d:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2018-03-13 16:26:44 +0000)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180315

for you to fetch changes up to a9ab8cc157054ea6941fb849c78d9e6c515a7730:

  target/ppc: fix tlbsync to check privilege level depending on GTSE (201=
8-03-15 11:18:31 +1100)

----------------------------------------------------------------
ppc patch queue for 2018-03-15

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

Thomas Huth (5):
      tests/boot-serial: Check the 40p machine, too
      hw/ppc/prep: Fix implicit creation of "-drive if=3Dscsi" devices
      hw/misc/macio: Mark the macio devices with user_creatable =3D false
      hw/ppc/spapr: Allow "spapr-vlan" as NIC model name beside "ibmveth"
      tests/boot-serial: Test the sam460ex board

 hw/ide/sii3112.c         | 12 ------------
 hw/misc/macio/macio.c    |  2 ++
 hw/ppc/e500.c            |  9 ++++-----
 hw/ppc/ppc440_pcix.c     | 11 +++++++----
 hw/ppc/prep.c            |  2 +-
 hw/ppc/spapr.c           |  5 +++--
 hw/scsi/lsi53c895a.c     |  7 +++++++
 include/hw/pci/pci.h     |  1 +
 target/ppc/translate.c   |  9 +++++++--
 tests/boot-serial-test.c |  8 ++++++--
 10 files changed, 38 insertions(+), 28 deletions(-)
