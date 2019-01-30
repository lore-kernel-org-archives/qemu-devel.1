Received: from eggs.gnu.org ([209.51.188.92]:46798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFK-00074k-7H
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gosFJ-0008VJ-EB
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:57:50 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Jan 2019 16:57:27 +0100
Message-Id: <20190130155733.32742-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] s390x/pci: remaining hot/un)plug patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>

These are all the patches that are not yet upstream (@Conny you might
already picked some, including them for the full picture) and after
a good discussion yesterday, including a patch t get rid of the release
timer. I ran a couple of sanity tests on this series.

#1 and #2 fix hotplugging of PCI bridges.
#3 warns when "zpci=off"
#4 refactors unplugging
#5 get's rid of the release timer
#6 processes all unplug requests on reboot

@Colin, can you review/ack? Especially Patch #4 is needed for qdev
patches already on the list. ("[PATCH RFCv2 0/9] qdev: Hotplug handler
chaining + virtio-pmem")

David Hildenbrand (6):
  s390x/pci: Fix primary bus number for PCI bridges
  s390x/pci: Fix hotplugging of PCI bridges
  s390x/pci: Warn when adding PCI devices without the 'zpci' feature
  s390x/pci: Introduce unplug requests and split unplug handler
  s390x/pci: Drop release timer and replace it with a flag
  s390x/pci: Unplug remaining requested devices on pcihost reset

 hw/s390x/s390-pci-bus.c | 233 ++++++++++++++++++++++++++--------------
 hw/s390x/s390-pci-bus.h |   4 +-
 2 files changed, 152 insertions(+), 85 deletions(-)

-- 
2.17.2
