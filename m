Received: from eggs.gnu.org ([209.51.188.92]:36597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Gdk-0004uJ-I3
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3Gdj-0002AR-BA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3Gdi-00029S-Vc
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:50:31 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 11 Mar 2019 09:50:19 +0100
Message-Id: <20190311085024.13780-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Vga 20190311 v2 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

The following changes since commit e2a18635a400b0e68679614132e9ef63161055=
90:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-03-08' i=
nto staging (2019-03-09 20:55:44 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20190311-v2-pull-request

for you to fetch changes up to ff243cff11526c0703cefdd60467dfaa5c5803a0:

  mips_fulong2e: Add on-board graphics chip (2019-03-11 08:04:55 +0100)

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
 hw/mips/mips_fulong2e.c        |   7 +
 hw/virtio/virtio-pci.c         |   1 +
 vl.c                           |   1 +
 hw/display/Kconfig             |   6 +
 hw/display/Makefile.objs       |   2 +
 hw/display/trace-events        |   4 +
 15 files changed, 1886 insertions(+), 4 deletions(-)
 create mode 100644 hw/display/ati_int.h
 create mode 100644 hw/display/ati_regs.h
 create mode 100644 hw/display/ati.c
 create mode 100644 hw/display/ati_2d.c
 create mode 100644 hw/display/ati_dbg.c

--=20
2.18.1
