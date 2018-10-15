Received: from eggs.gnu.org ([2001:4830:134:3::10]:50602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6nD-0002wD-SV
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6nC-0003Br-Cj
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gC6nC-0003AF-3b
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:36:34 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 15 Oct 2018 11:36:23 -0600
Message-ID: <153962488126.21502.17134983449941187881.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 0/6] vfio updates 2018-10-15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Eric Auger <eric.auger@redhat.com>, Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit ff56877e911782dedc9a424233fd3f62369c258c:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20181015-pull-request' into staging (2018-10-15 15:03:45 +0100)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-updates-20181015.0

for you to fetch changes up to 2683ccd5be8f4bad197aa95bf29154640519f4c2:

  vfio-pci: make vfio-pci device more QOM conventional (2018-10-15 11:22:29 -0600)

----------------------------------------------------------------
VFIO updates 2018-10-15

 - ramfb support for vfio-pci via new -nohotplug device variant
   (Gerd Hoffmann)

 - Preparation for generic DT pass-through in vfio-platform
   (Geert Uytterhoeven & Eric Auger)

 - vfio-pci QOM fixups (Li Qiang)

----------------------------------------------------------------
Eric Auger (2):
      vfio/platform: Make the vfio-platform device non-abstract
      hw/arm/sysbus-fdt: Allow device matching with DT compatible value

Geert Uytterhoeven (1):
      hw/arm/virt: Allow dynamic vfio-platform devices again

Gerd Hoffmann (2):
      stubs: add ramfb
      hw/vfio/display: add ramfb support

Li Qiang (1):
      vfio-pci: make vfio-pci device more QOM conventional

 hw/arm/sysbus-fdt.c             | 61 +++++++++++++++++++++++++++++++----------
 hw/arm/virt.c                   |  1 +
 hw/vfio/amd-xgbe.c              |  1 +
 hw/vfio/calxeda-xgmac.c         |  1 +
 hw/vfio/display.c               | 12 ++++++++
 hw/vfio/pci.c                   | 54 ++++++++++++++++++++++++++----------
 hw/vfio/pci.h                   |  1 +
 hw/vfio/platform.c              | 25 ++++++++++++++++-
 include/hw/vfio/vfio-common.h   |  2 ++
 include/hw/vfio/vfio-platform.h |  3 +-
 stubs/Makefile.objs             |  1 +
 stubs/ramfb.c                   | 13 +++++++++
 12 files changed, 145 insertions(+), 30 deletions(-)
 create mode 100644 stubs/ramfb.c
