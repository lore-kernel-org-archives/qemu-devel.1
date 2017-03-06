Received: from eggs.gnu.org ([2001:4830:134:3::10]:47453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckjwl-00058S-U7
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckjwk-0003tP-VW
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 23:08:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  6 Mar 2017 15:08:18 +1100
Message-Id: <20170306040823.28482-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] ppc-for-2.9 queue 20170306
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 17783ac828adc694d986698d2d7014aedfeb48=
c6:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170303=
' into staging (2017-03-04 16:31:14 +0000)

are available in the git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-2.9-20170306

for you to fetch changes up to 182fe2cf19e829e34f63443ee1ccd9f799715c2c:

  target/ppc: use helper for excp handling (2017-03-06 13:17:28 +1100)

----------------------------------------------------------------
ppc patch queue for 2017-03-06

Looks like my previous batch wasn't quite the last before hard freeze.
This has a handful of bugfixes to go in.  They're all genuine
bugfixes, though not regressions in some cases.

----------------------------------------------------------------
C=C3=A9dric Le Goater (1):
      ppc/xics: register reset handlers for the ICP and ICS objects

Igor Mammedov (1):
      spapr: ensure that all threads within core are on the same NUMA nod=
e

Nikunj A Dadhania (3):
      target/ppc: fmadd check for excp independently
      target/ppc: fmadd: add macro for updating flags
      target/ppc: use helper for excp handling

 hw/intc/xics.c          | 10 ++++---
 hw/intc/xics_kvm.c      | 15 ++++++----
 hw/ppc/spapr.c          |  2 --
 hw/ppc/spapr_cpu_core.c | 23 ++++++++++-----
 target/ppc/fpu_helper.c | 77 ++++++++++++++++++++-----------------------=
------
 5 files changed, 63 insertions(+), 64 deletions(-)
