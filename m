Received: from eggs.gnu.org ([209.51.188.92]:33251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggabe-0008EF-Pp
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggabc-0000Et-PE
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:30:38 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 Jan 2019 17:30:17 -0200
Message-Id: <20190107193020.21744-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] machine: Make compat_props arrays shorter
 and more readable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org

Current declarations of compat_props arrays are very verbose,
with each entry taking 4 lines of code.  By omitting the field
designators, we can make each array entry fit a single line of
code and be more readable.

Eduardo Habkost (3):
  spapr: Eliminate SPAPR_PCI_2_7_MMIO_WIN_SIZE macro
  machine: Eliminate unnecessary stringify() usage
  machine: Use shorter format for GlobalProperty arrays

 include/hw/i386/pc.h        |  18 +-
 include/hw/pci-host/spapr.h |   1 -
 hw/core/machine.c           | 338 ++++-------------
 hw/i386/pc.c                | 720 +++++++-----------------------------
 hw/i386/pc_piix.c           | 192 ++--------
 hw/ppc/spapr.c              |  72 +---
 hw/s390x/s390-virtio-ccw.c  |  75 +---
 hw/xen/xen-common.c         |  18 +-
 8 files changed, 265 insertions(+), 1169 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140
