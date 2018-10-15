Received: from eggs.gnu.org ([2001:4830:134:3::10]:50963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gByon-00021e-7n
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gByog-0008TP-Vw
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gByog-0008KR-Ip
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:05:34 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 15 Oct 2018 11:05:10 +0200
Message-Id: <20181015090517.26884-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] Vga 20181015 patches
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

The following changes since commit a73549f99612f758dec0fdea6ae1c30b6c709a=
0b:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20181012-pull-requ=
est' into staging (2018-10-12 16:45:51 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20181015-pull-request

for you to fetch changes up to 9f42e0b3c2355c4a2475124c3fc40421a88de813:

  Makefile: Install new vgabios binaries (2018-10-15 09:57:33 +0200)

----------------------------------------------------------------
vga: config tweaks, edid updates, qxl bugfix, install new vgabios blobs.

----------------------------------------------------------------

Alex Williamson (1):
  Makefile: Install new vgabios binaries

Gerd Hoffmann (5):
  edid: fix alignment issues
  display: add separate config option for bochs-display
  bochs-display: wire up edid support
  qxl: check qxl_phys2virt return value
  i2c: switch ddc to use the new edid generator

Thomas Huth (1):
  hw/display/cirrus_vga: Move "isa-cirrus-vga" device into a separate
    file

 Makefile                         |   1 +
 hw/display/cirrus_vga_internal.h | 103 ++++++++++++++++++++
 include/hw/i2c/i2c-ddc.h         |   4 +-
 hw/display/bochs-display.c       |  13 +++
 hw/display/cirrus_vga.c          | 143 +---------------------------
 hw/display/cirrus_vga_isa.c      |  98 +++++++++++++++++++
 hw/display/edid-generate.c       |   8 +-
 hw/display/qxl.c                 |   2 +-
 hw/i2c/i2c-ddc.c                 | 200 ++-------------------------------=
------
 default-configs/pci.mak          |   1 +
 hw/display/Makefile.objs         |   4 +-
 11 files changed, 240 insertions(+), 337 deletions(-)
 create mode 100644 hw/display/cirrus_vga_internal.h
 create mode 100644 hw/display/cirrus_vga_isa.c

--=20
2.9.3
