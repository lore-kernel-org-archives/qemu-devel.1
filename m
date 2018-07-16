Received: from eggs.gnu.org ([2001:4830:134:3::10]:40016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fez1R-0001De-Fs
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fez1N-0004yJ-4y
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:38:21 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 16 Jul 2018 18:38:03 +1000
Message-Id: <20180716083809.17115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/6] ppc-for-3.0 queue 20180716
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

The following changes since commit 9277d81f5c2c6f4d0b5e47c8476eb7ee7e5c0b=
eb:

  docs: Grammar and spelling fixes (2018-07-13 10:16:04 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-3.0-20180716

for you to fetch changes up to 6730df0514d3aec35e646ff9833fbe8b05fd0776:

  sm501: Fix warning about unreachable code (2018-07-16 11:19:10 +1000)

----------------------------------------------------------------
ppc patch queue 2018-07-16

Here's my first hard freeze pull request for qemu-3.0.  This contains
an assortment of bugfixes. Several are for regressions, others are for
bugs that I think are significant enough to address during hard freeze.

----------------------------------------------------------------
BALATON Zoltan (3):
      sm501: Update screen on frame buffer address change
      sam460ex: Correct use after free error
      sm501: Fix warning about unreachable code

David Gibson (1):
      spapr: Correct inverted test in spapr_pc_dimm_node()

Greg Kurz (1):
      ppc/xics: fix ICP reset path

Michael Davidsaver (1):
      etsec: fix IRQ (un)masking

 hw/display/sm501.c           |  4 ++-
 hw/intc/xics.c               | 14 +++++++--
 hw/net/fsl_etsec/etsec.c     | 68 +++++++++++++++++++++++---------------=
------
 hw/net/fsl_etsec/etsec.h     |  2 ++
 hw/net/fsl_etsec/registers.h | 10 +++++++
 hw/net/fsl_etsec/rings.c     | 12 +-------
 hw/ppc/sam460ex.c            |  3 +-
 hw/ppc/spapr.c               |  2 +-
 8 files changed, 66 insertions(+), 49 deletions(-)
