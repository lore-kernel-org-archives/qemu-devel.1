Received: from eggs.gnu.org ([2001:4830:134:3::10]:58481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwio9-0001ms-9I
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:57:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwio8-0008Hk-Gp
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:57:57 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  3 Sep 2018 08:57:40 +0200
Message-Id: <20180903065745.23055-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] Vga 20180903 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>

The following changes since commit 19b599f7664b2ebfd0f405fb79c14dd2415574=
52:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-08-27=
-v2' into staging (2018-08-27 16:44:20 +0100)

are available in the git repository at:

  git://git.kraxel.org/qemu tags/vga-20180903-pull-request

for you to fetch changes up to 8da132a56f7ebaabc5b674b5a3a2e6fa8934be45:

  virtio-gpu: add iommu support (2018-09-03 08:31:57 +0200)

----------------------------------------------------------------
vga: virtio reset fix, virtio iommu support.

----------------------------------------------------------------

Gerd Hoffmann (5):
  virtio-vga: fix reset
  Revert "virtio-gpu: fix crashes upon warm reboot with vga mode"
  use dpy_gfx_update_full
  virtio-gpu: pass down VirtIOGPU pointer to a bunch of functions
  virtio-gpu: add iommu support

 include/hw/virtio/virtio-gpu.h |  8 +++---
 hw/display/exynos4210_fimd.c   |  4 +--
 hw/display/g364fb.c            |  2 +-
 hw/display/jazz_led.c          |  3 +--
 hw/display/tc6393xb.c          |  4 +--
 hw/display/vga.c               |  3 +--
 hw/display/virtio-gpu-3d.c     |  8 +++---
 hw/display/virtio-gpu.c        | 59 ++++++++++++++++++++++--------------=
------
 hw/display/virtio-vga.c        | 17 ++++--------
 hw/display/vmware_vga.c        |  5 +---
 hw/display/xlnx_dp.c           |  3 +--
 11 files changed, 53 insertions(+), 63 deletions(-)

--=20
2.9.3
