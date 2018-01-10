Received: from eggs.gnu.org ([2001:4830:134:3::10]:54819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eZLdW-00047b-RX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eZLdS-0003Kq-Iy
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eZLdS-0003Fs-AC
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:02:02 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Wed, 10 Jan 2018 12:01:41 -0700
Message-ID: <20180110190049.5389.12984.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/5] vfio/pci: MSI-X MMIO relocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, eric.auger@redhat.com, aik@ozlabs.ru

v1: https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03350.html

See patch 5/5 for a thorough description.  v2 changes the 'auto'
behavior as we've determined that there's no algorithm which has even
a likely chance of success.  Instead, auto is now a placeholder for
a device/platform lookup for known good combinations (though if I'm
pessimistic, even that might depend on guest and driver versions).
Thanks,

Alex

---

Alex Williamson (5):
      vfio/pci: Fixup VFIOMSIXInfo comment
      vfio/pci: Add base BAR MemoryRegion
      vfio/pci: Emulate BARs
      qapi: Create DEFINE_PROP_OFF_AUTO_PCIBAR
      vfio/pci: Allow relocating MSI-X MMIO


 hw/core/qdev-properties.c    |   11 +++
 hw/vfio/pci.c                |  175 ++++++++++++++++++++++++++++++++++++++----
 hw/vfio/pci.h                |    6 +
 hw/vfio/trace-events         |    2 
 include/hw/qdev-properties.h |    4 +
 qapi/common.json             |   26 ++++++
 6 files changed, 206 insertions(+), 18 deletions(-)
