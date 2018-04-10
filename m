Received: from eggs.gnu.org ([2001:4830:134:3::10]:45375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slV-00078R-H0
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slT-0002eU-0H
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 10 Apr 2018 22:52:26 +1000
Message-Id: <20180410125233.31618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] ppc-for-2.12 queue 20180410
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 915d34c5f99b0ab91517c69f54272bfdb6ca2b=
32:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-04-09 17:29:10 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180410

for you to fetch changes up to 6b3913e0858488ef3358c1683605d6894a6cadb0:

  roms/u-boot-sam460ex: Change to qemu git mirror and update (2018-04-10 =
10:05:38 +1000)

----------------------------------------------------------------
ppc patch queue 2018-04-10

Here's a rather late pull request with a handful of fixes for 2.12.
These have been blocked for some time, because I wasn't able to
complete my usual test set due to the SCSI problem fixed in 37c5174
"scsi-disk: Don't enlarge min_io_size to max_io_size".

Since we're in hard freeze, these are all bugfixes.  Most are also
regressions, although in one case it's only a "regression" because a
longstanding bug has been exposed by a new machine type (sam460ex) in
the testcases.  There are also a couple of sam460ex fixes that aren't
regressions since the board didn't exist before.  On the flipside
though, they're low risk because they only touch board specific code
for a board that doesn't exist in any released version.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      spapr: Initialize reserved areas list in FDT in H_CAS handler

BALATON Zoltan (2):
      sam460ex: Fix timer frequency and clock multipliers
      roms/u-boot-sam460ex: Change to qemu git mirror and update

David Gibson (2):
      target/ppc: Initialize lazy_tlb_flush correctly
      target/ppc: Fix backwards migration of msr_mask

Thomas Huth (2):
      hw/misc/macio: Fix crash when listing device properties of macio de=
vice
      tests/boot-serial: Test the sam460ex board

 .gitmodules              |  2 +-
 hw/misc/macio/macio.c    | 14 +++++++-------
 hw/ppc/ppc440_uc.c       |  3 +--
 hw/ppc/sam460ex.c        |  7 ++++---
 hw/ppc/spapr.c           |  1 +
 roms/u-boot-sam460ex     |  2 +-
 target/ppc/machine.c     | 10 +++++++++-
 target/ppc/translate.c   |  7 +++----
 tests/boot-serial-test.c |  2 ++
 9 files changed, 29 insertions(+), 19 deletions(-)
