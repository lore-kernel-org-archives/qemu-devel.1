Received: from eggs.gnu.org ([2001:4830:134:3::10]:51211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1qA-0000mU-Ft
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fs1q7-0001Oz-9t
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:16:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fs1q7-0001Og-3e
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 04:16:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97991402242D
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 08:16:34 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Aug 2018 10:16:27 +0200
Message-Id: <20180821081631.19160-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Vga 20180821 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit d0092d90eb546a8bbe9e9120426c1894741237=
97:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180820' into =
staging (2018-08-20 17:41:18 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180821-pull-request

for you to fetch changes up to 421ab725677b0382fd8f1fc5356fb16747a5beca:

  hw/pci-host/bonito: Move away from old_mmio accessors (2018-08-21 09:52=
:22 +0200)

----------------------------------------------------------------
hw/display: misc fixes

----------------------------------------------------------------

Gerd Hoffmann (1):
  qxl: drop unused generation variable

Peter Maydell (2):
  hw/display/vga-isa-mm: Convert away from old_mmio
  hw/pci-host/bonito: Move away from old_mmio accessors

Thomas Huth (1):
  hw/display/ramfb: Compile the ramfb code only when CONFIG_FW_CFG_DMA
    is set

 hw/display/qxl.h         |   1 -
 hw/display/qxl.c         |   1 -
 hw/display/vga-isa-mm.c  |  60 +++++---------------
 hw/pci-host/bonito.c     | 145 +++++------------------------------------=
------
 hw/display/Makefile.objs |   4 +-
 5 files changed, 30 insertions(+), 181 deletions(-)

--=20
2.9.3
