Received: from eggs.gnu.org ([209.51.188.92]:49934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1glZqp-0001Gk-U2
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1glZqp-0006sm-1s
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:42:55 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 21 Jan 2019 14:42:47 +0100
Message-Id: <20190121134249.16615-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] s390x/pci: hotplug handler fixes and
 reworks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

These are the remaining two patches, rebased to current upstream.

Patch 1: Rework unplug handler (introduce unplug_request handler) which
         also fixes some unplug scenarios
Patch 2: Handle leftover unplug requests on reset

v2 -> v3:
- Rebased

v1 -> v2:
- Some rewordings in patch descriptions
- "s390x/pci: Introduce unplug requests and split unplug handler"
-- Some simplifications regarding s390_pci_perform_unplug()

David Hildenbrand (2):
  s390x/pci: Introduce unplug requests and split unplug handler
  s390x/pci: Unplug remaining devices on pcihost reset

 hw/s390x/s390-pci-bus.c | 174 +++++++++++++++++++++++++++-------------
 hw/s390x/s390-pci-bus.h |   1 +
 2 files changed, 121 insertions(+), 54 deletions(-)

-- 
2.17.2
