Received: from eggs.gnu.org ([2001:4830:134:3::10]:52594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dzVQT-0007MK-Is
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dzVQQ-0002bD-6m
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:12:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dzVQQ-0002aZ-11
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 18:12:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFB3C19D4D1
	for <qemu-devel@nongnu.org>; Tue,  3 Oct 2017 22:12:24 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 03 Oct 2017 16:12:21 -0600
Message-ID: <20171003221012.17156.23559.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/3] VFIO updates 2017-10-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10ea:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-10-03 16:27:24 +0100)

are available in the git repository at:


  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20171003.0

for you to fetch changes up to dfbee78db8fdf7bc8c151c3d29504bb47438480b:

  vfio/pci: Add NVIDIA GPUDirect Cliques support (2017-10-03 12:57:36 -0600)

----------------------------------------------------------------
VFIO updates 2017-10-03

 - NVIDIA GPUDirect Cliques experimental support (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (3):
      vfio/pci: Do not unwind on error
      vfio/pci: Add virtual capabilities quirk infrastructure
      vfio/pci: Add NVIDIA GPUDirect Cliques support

 hw/vfio/pci-quirks.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c        |  17 +++++++-
 hw/vfio/pci.h        |   4 ++
 3 files changed, 133 insertions(+), 2 deletions(-)
