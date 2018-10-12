Received: from eggs.gnu.org ([2001:4830:134:3::10]:49042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAwif-0006uU-W8
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:39:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAwiY-0007cG-U2
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:39:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAwiY-0007ab-K0
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 08:38:58 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Oct 2018 14:38:46 +0200
Message-Id: <20181012123851.30856-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Vga 20181012 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

The following changes since commit 75e50c80e051423a6f55a34ee4a1eec842444a=
5b:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2018-10-10'=
 into staging (2018-10-11 10:43:37 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20181012-pull-request

for you to fetch changes up to b398f03c60bb5739ae68c161c315c7cce8ef2fde:

  hw/display/cirrus_vga: Move "isa-cirrus-vga" device into a separate fil=
e (2018-10-12 13:50:38 +0200)

----------------------------------------------------------------
vga: config tweaks, edid updates, qxl bugfix.

----------------------------------------------------------------

Gerd Hoffmann (4):
  display: add separate config option for bochs-display
  bochs-display: wire up edid support
  qxl: check qxl_phys2virt return value
  i2c: switch ddc to use the new edid generator

Thomas Huth (1):
  hw/display/cirrus_vga: Move "isa-cirrus-vga" device into a separate
    file

 hw/display/cirrus_vga_internal.h | 103 ++++++++++++++++++++
 include/hw/i2c/i2c-ddc.h         |   4 +-
 hw/display/bochs-display.c       |  13 +++
 hw/display/cirrus_vga.c          | 143 +---------------------------
 hw/display/cirrus_vga_isa.c      |  98 +++++++++++++++++++
 hw/display/qxl.c                 |   2 +-
 hw/i2c/i2c-ddc.c                 | 200 ++-------------------------------=
------
 default-configs/pci.mak          |   1 +
 hw/display/Makefile.objs         |   4 +-
 9 files changed, 235 insertions(+), 333 deletions(-)
 create mode 100644 hw/display/cirrus_vga_internal.h
 create mode 100644 hw/display/cirrus_vga_isa.c

--=20
2.9.3
