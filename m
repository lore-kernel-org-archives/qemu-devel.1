Received: from eggs.gnu.org ([2001:4830:134:3::10]:46682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2V-0006Df-GU
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dfL2S-0003z9-Dd
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:04:23 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Aug 2017 17:03:51 +1000
Message-Id: <20170809070357.28723-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] ppc patch queue 2017-08-09
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 54affb3a3623b1d36c95e34faa722a5831323a=
74:

  Update version for v2.10.0-rc2 release (2017-08-08 19:07:46 +0100)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.10-20170809

for you to fetch changes up to f57467e3b326c7736f8e481fd6b680f30e575c87:

  spapr: Fix bug in h_signal_sys_reset() (2017-08-09 14:04:28 +1000)

----------------------------------------------------------------
ppc patch queue 2017-08-09

This series contains a number of bugfixes for ppc and related
machines, for the qemu-2.10.release.  Some are true regressions,
others are serious enough and non-invasive enough to fix that it's
worth putting in 2.10 this late.

----------------------------------------------------------------

I haven't completed a Travis build for this, which is part of my usual
test regime, since the first dozen or so Travis builds are failing
more often than not on master as well.  I don't know why this is -
seems to be failing some of the x86 tests.


David Gibson (2):
      target/ppc: Implement TIDR
      target/ppc: Add stub implementation of the PSSCR

Greg Kurz (2):
      ppc: fix double-free in cpu_post_load()
      spapr_drc: abort if object_property_add_child() fails

KONRAD Frederic (1):
      booke206: fix MAS update on tlb miss

Sam Bobroff (1):
      spapr: Fix bug in h_signal_sys_reset()

 hw/ppc/spapr_drc.c          |  2 +-
 hw/ppc/spapr_hcall.c        |  9 ++++-----
 target/ppc/cpu.h            |  2 ++
 target/ppc/machine.c        |  1 -
 target/ppc/mmu_helper.c     |  2 +-
 target/ppc/translate_init.c | 10 ++++++++++
 6 files changed, 18 insertions(+), 8 deletions(-)
