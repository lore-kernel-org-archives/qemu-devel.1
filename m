Received: from eggs.gnu.org ([2001:4830:134:3::10]:37940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJcfU-0004le-Rc
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJcfL-0006Ec-Lq
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:03:38 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon,  5 Nov 2018 12:03:09 +0100
Message-Id: <20181105110313.29312-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/4] s390x/zpci: some hotplug handler
 cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, =Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

The hotplug code needs more love, but let's do some obvious cleanups
first. In the future, we want to propery make use of unplug_request() +
unplug(), instead of routing everything (especially two separate but
linked) devices via a single unplug call. Also, we want to move all
errors in plug() into the pre_plug() handler, but this will require
general PCI refactorings (moving stuff from realize() to the pre_plug/plug
handler).

This series is based on "[PATCH v2 00/10] pci: hotplug handler reworks",
which contains one cleanup for s390x.

David Hildenbrand (4):
  s390x/zpci: drop msix.available
  s390x/zpci: use hotplug_dev instead of looking up the host bridge
  s390x/zpci: move some hotplug checks to the pre_plug handler
  s390x/zpci: properly fail if the zPCI device cannot be created

 hw/s390x/s390-pci-bus.c | 74 ++++++++++++++++++++++++++---------------
 hw/s390x/s390-pci-bus.h |  1 -
 2 files changed, 47 insertions(+), 28 deletions(-)

-- 
2.17.2
