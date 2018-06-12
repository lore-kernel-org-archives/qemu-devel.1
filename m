Received: from eggs.gnu.org ([2001:4830:134:3::10]:46881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn2-0002os-5i
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fSgn1-0007wm-0J
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:44:40 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 12 Jun 2018 12:44:22 +0200
Message-Id: <20180612104430.25745-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] Usb 20180612 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Zhang Chen <zhangckid@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>

The following changes since commit 2afc4e3df80d947dd1bd42ce80278f591b35c7=
4a:

  Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-06-=
11' into staging (2018-06-11 15:31:20 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/usb-20180612-pull-request

for you to fetch changes up to 3c969a6022438cf59de10d2dc3c58f4807788f98:

  usb-mtp: Return error on suspicious TYPE_DATA packet from initiator (20=
18-06-12 12:08:12 +0200)

----------------------------------------------------------------
usb: bug fix collection, doc update.

----------------------------------------------------------------

Bandan Das (1):
  usb-mtp: Return error on suspicious TYPE_DATA packet from initiator

Gerd Hoffmann (1):
  usb: update docs

Marc-Andr=C3=A9 Lureau (4):
  bus: do not unref the added child bus on realize
  object: fix OBJ_PROP_LINK_UNREF_ON_RELEASE ambivalence
  usb-ccid: fix bus leak
  usb-hcd-xhci-test: add a test for ccid hotplug

Philippe Mathieu-Daud=C3=A9 (2):
  usb: correctly handle Zero Length Packets
  usb/dev-mtp: Fix use of uninitialized values

 docs/usb2.txt                 | 99 ++++++++++++++++++++++++-------------=
------
 include/qom/object.h          | 12 ++++--
 hw/core/bus.c                 |  1 -
 hw/core/qdev-properties.c     |  2 +-
 hw/core/qdev.c                |  2 +-
 hw/display/xlnx_dp.c          |  2 +-
 hw/dma/xilinx_axidma.c        |  4 +-
 hw/dma/xlnx-zdma.c            |  2 +-
 hw/i386/pc.c                  |  2 +-
 hw/i386/pc_piix.c             |  2 +-
 hw/i386/pc_q35.c              |  2 +-
 hw/ipmi/ipmi.c                |  2 +-
 hw/net/xilinx_axienet.c       |  4 +-
 hw/ssi/xilinx_spips.c         |  2 +-
 hw/usb/dev-mtp.c              | 11 ++++-
 hw/usb/dev-smartcard-reader.c |  1 +
 hw/usb/redirect.c             |  2 +-
 net/can/can_host.c            |  2 +-
 net/colo-compare.c            |  2 +-
 qom/object.c                  |  8 ++--
 target/arm/cpu.c              |  4 +-
 tests/usb-hcd-xhci-test.c     | 10 +++++
 ui/console.c                  |  2 +-
 23 files changed, 109 insertions(+), 71 deletions(-)

--=20
2.9.3
