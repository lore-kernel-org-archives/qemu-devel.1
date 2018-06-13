Received: from eggs.gnu.org ([2001:4830:134:3::10]:43298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fT4uU-0002se-FZ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fT4uT-00064I-CQ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:29:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 13 Jun 2018 14:29:44 +0200
Message-Id: <20180613122948.18149-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/4] ramfb: simple boot framebuffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

  Hi,

So, the first ramfb bits should be ready for merge.  This series
includes the ramfb core support bits, the ramfb standalone device
and vfio-pci-ramfb device for vgpu boot display support.

If you want play with it I recommend getting the bits from

	https://www.kraxel.org/cgit/qemu/log/?h=sirius/ramfb

because they come with an updated seabios and a new vgabios rom and an
experimental OVMF build.  Firmware patches are here:

	https://www.kraxe.org/cgit/seabios/log/?h=ramfb
	https://github.com/kraxel/edk2/commits/ramfb

They should land upstream soon.

changes:
 v5: codestyle fixes.

cheers,
  Gerd

Gerd Hoffmann (4):
  hw/display: add ramfb, a simple boot framebuffer living in guest ram
  hw/display: add standalone ramfb device
  hw/vfio/display: add ramfb support
  Add ramfb MAINTAINERS entry

 include/hw/display/ramfb.h    | 12 ++++++
 include/hw/vfio/vfio-common.h |  2 +
 hw/arm/sysbus-fdt.c           |  7 ++++
 hw/arm/virt.c                 |  2 +
 hw/display/ramfb-standalone.c | 62 ++++++++++++++++++++++++++++
 hw/display/ramfb.c            | 95 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c             |  2 +
 hw/i386/pc_q35.c              |  2 +
 hw/vfio/display.c             | 12 ++++++
 hw/vfio/pci.c                 | 15 +++++++
 MAINTAINERS                   |  6 +++
 hw/display/Makefile.objs      |  3 ++
 12 files changed, 220 insertions(+)
 create mode 100644 include/hw/display/ramfb.h
 create mode 100644 hw/display/ramfb-standalone.c
 create mode 100644 hw/display/ramfb.c

-- 
2.9.3
