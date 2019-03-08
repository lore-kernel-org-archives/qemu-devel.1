Received: from eggs.gnu.org ([209.51.188.92]:53418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h2EnC-0001Lk-J3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h2En5-0004fV-Va
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:39:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h2En5-0003V3-IZ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:39:55 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  8 Mar 2019 13:39:32 +0100
Message-Id: <20190308123937.2346-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Vga 20190308 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65=
e2:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2019-03-06 18:52:19 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20190308-pull-request

for you to fetch changes up to 61dbd9eaa1450f94886fb41366e4687d405c52c8:

  virtio-gpu: make virtio_gpu_reset static (2019-03-08 09:36:23 +0100)

----------------------------------------------------------------
vga: virtio reset fix, add ati emulation.

----------------------------------------------------------------

BALATON Zoltan (2):
  hw/display: Add basic ATI VGA emulation
  mips_fulong2e: Add on-board graphics chip

Gerd Hoffmann (3):
  virtio: add class_size to VirtioPCIDeviceTypeInfo
  virtio-vga: fix reset.
  virtio-gpu: make virtio_gpu_reset static

 hw/display/ati_int.h           |  96 ++++
 hw/display/ati_regs.h          | 461 ++++++++++++++++++
 hw/virtio/virtio-pci.h         |   1 +
 include/hw/virtio/virtio-gpu.h |   1 -
 hw/display/ati.c               | 865 +++++++++++++++++++++++++++++++++
 hw/display/ati_2d.c            | 167 +++++++
 hw/display/ati_dbg.c           | 259 ++++++++++
 hw/display/virtio-gpu.c        |   2 +-
 hw/display/virtio-vga.c        |  17 +-
 hw/mips/mips_fulong2e.c        |   6 +
 hw/virtio/virtio-pci.c         |   1 +
 vl.c                           |   1 +
 default-configs/pci.mak        |   1 +
 hw/display/Makefile.objs       |   2 +
 hw/display/trace-events        |   4 +
 15 files changed, 1880 insertions(+), 4 deletions(-)
 create mode 100644 hw/display/ati_int.h
 create mode 100644 hw/display/ati_regs.h
 create mode 100644 hw/display/ati.c
 create mode 100644 hw/display/ati_2d.c
 create mode 100644 hw/display/ati_dbg.c

--=20
2.18.1
