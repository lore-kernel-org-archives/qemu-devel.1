Received: from eggs.gnu.org ([2001:4830:134:3::10]:46001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ccIxz-0007j7-MT
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ccIxw-0002WH-Gs
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:42:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ccIxw-0002UJ-Ao
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 16:42:52 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 765EBC04B30E
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 21:42:51 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 10 Feb 2017 14:42:49 -0700
Message-ID: <20170210214127.22071.16525.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/3] VFIO updates 2017-02-10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 98b2faeaee96ab084d0b1669918688d8895c155f:

  Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into
staging (2017-02-10 18:07:02 +0000)

are available in the git repository at:


  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20170210.0

for you to fetch changes up to e197de50c6cfad69d2c26c22693b57678ae99d14:

  hw/vfio: Add CONFIG switches for calxeda-xgmac and amd-xgbe (2017-02-10
13:12:03 -0700)

----------------------------------------------------------------
VFIO updates 2017-02-10

 - Fix GTT wrap-around for Skylake IGD assignment (Alex Williamson)
 - Tag vfio-pci-igd-lpc-bridge as bridge device category (Thomas Huth)
 - Don't build calxeda-xgmac or amd-xgbe except on ARM (Thomas Huth)

----------------------------------------------------------------
Alex Williamson (1):
      vfio-pci: Fix GTT wrap-around for Skylake+ IGD

Thomas Huth (2):
      hw/vfio/pci-quirks: Set category of the "vfio-pci-igd-lpc-bridge" device
      hw/vfio: Add CONFIG switches for calxeda-xgmac and amd-xgbe

 default-configs/arm-softmmu.mak | 2 ++
 hw/vfio/Makefile.objs           | 4 ++--
 hw/vfio/pci-quirks.c            | 6 +++++-
 3 files changed, 9 insertions(+), 3 deletions(-)
