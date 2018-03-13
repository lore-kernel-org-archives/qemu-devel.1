Received: from eggs.gnu.org ([2001:4830:134:3::10]:49858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqMg-0005AU-2C
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1evqMc-0003Rs-TU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1evqMc-0003Re-Mv
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:17:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 075E08050A
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 20:17:38 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 13 Mar 2018 14:17:34 -0600
Message-ID: <20180313201415.2327.62402.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 00/11] vfio updates for QEMU-2.12 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 9f750794985d7386f088da941c76b73880b2b6c4:

  sev/i386: add sev_get_capabilities() (2018-03-13 17:36:06 +0100)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180313.0

for you to fetch changes up to fcad0d2121976df4b422b4007a5eb7fcaac01134:

  ppc/spapr, vfio: Turn off MSIX emulation for VFIO devices (2018-03-13 11:17:31 -0600)

----------------------------------------------------------------
VFIO updates 2018-03-13

 - Display support for vGPUs (Gerd Hoffmann)

 - Enable new kernel support for mmaps overlapping MSI-X vector table,
   disable MSI-X emulation on POWER (Alexey Kardashevskiy)

----------------------------------------------------------------

NOTE: Above tag is based on Paolo's v2 KVM pull request[1] as both
      series here depend on v4.16 header updates.

[1] 1520959261-96820-1-git-send-email-pbonzini@redhat.com

Alexey Kardashevskiy (3):
      vfio/pci: Relax DMA map errors for MMIO regions
      vfio-pci: Allow mmap of MSIX BAR
      ppc/spapr, vfio: Turn off MSIX emulation for VFIO devices

Gerd Hoffmann (8):
      standard-headers: add drm/drm_fourcc.h
      ui/pixman: add qemu_drm_format_to_pixman()
      console: minimal hotplug suport
      secondary-vga: properly close QemuConsole on unplug
      vfio/common: cleanup in vfio_region_finalize
      vfio/display: core & wireup
      vfio/display: adding region support
      vfio/display: adding dmabuf support

 hw/display/vga-pci.c                      |   9 +
 hw/ppc/spapr.c                            |   7 +
 hw/vfio/Makefile.objs                     |   2 +-
 hw/vfio/common.c                          |  77 +++++-
 hw/vfio/display.c                         | 347 +++++++++++++++++++++++++
 hw/vfio/pci.c                             |  32 +++
 hw/vfio/pci.h                             |   5 +
 include/hw/vfio/vfio-common.h             |  23 ++
 include/standard-headers/drm/drm_fourcc.h | 411 ++++++++++++++++++++++++++++++
 include/ui/console.h                      |   2 +
 include/ui/qemu-pixman.h                  |   5 +
 scripts/update-linux-headers.sh           |   5 +
 ui/console.c                              |  79 +++++-
 ui/qemu-pixman.c                          |  22 ++
 ui/trace-events                           |   2 +
 15 files changed, 1015 insertions(+), 13 deletions(-)
 create mode 100644 hw/vfio/display.c
 create mode 100644 include/standard-headers/drm/drm_fourcc.h
