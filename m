Received: from eggs.gnu.org ([209.51.188.92]:54769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEuEx-0007gW-NA
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hEuEs-0001IU-G0
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:21:00 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 12 Apr 2019 21:20:43 +1000
Message-Id: <20190412112044.15361-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/1] ppc-for-4.0 queue 20190412
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, mst@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, clg@redhat.com, David Gibson <david@gibson.dropbear.id.au>

The following changes since commit 532cc6da74ec25b5ba6893b5757c977d545829=
49:

  Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-4.0-20190412

for you to fetch changes up to 4560116e42a21989a4b6cf9551ce2f90b16c7238:

  spapr_pci: Fix broken naming of PCI bus (2019-04-12 12:23:02 +1000)

----------------------------------------------------------------
ppc patch queue for 2018-04-12

Here's a last minute pull request for 4.0.  Turns out my last pull
request, to fix a regression in extended config space access for the
pseries machine didn't fix things hard enough.  This PR has a single
patch which improves the fix to work in more cases.

It's a ghastly, ghastly hack, but it's simple and localized.  I
already have patches almost ready to go in 4.1 that provides a simpler
and cleaner solution to all this.

----------------------------------------------------------------
Greg Kurz (1):
      spapr_pci: Fix broken naming of PCI bus

 hw/ppc/spapr_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
