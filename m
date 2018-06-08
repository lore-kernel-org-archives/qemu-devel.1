Received: from eggs.gnu.org ([2001:4830:134:3::10]:51455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRGoa-0005GO-Un
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:48:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fRGoW-0006Dd-3I
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:48:25 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  8 Jun 2018 14:48:10 +0200
Message-Id: <20180608124816.22140-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/6] spapr: machine hotplug handler cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

I'll be messing with machine hotplug handlers of pc/spapr/s390x in the
context of
    [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers

So this is a spin-off of the cleanup patches in the context of hotplug
handlers.

v1 -> v2:
- dropped the three "local_err" patches
- tweaked some patch descriptions
- Split "spapr: move all DIMM checks into spapr_memory_plug" up
-- Move the memory hotplug check into the pre_plug handler
- Use &error_abort instead of NULL

David Hildenbrand (6):
  spapr: no need to verify the node
  spapr: move lookup of the node into spapr_memory_plug()
  spapr: move memory hotplug support check into spapr_memory_pre_plug()
  spapr: introduce machine unplug handler
  spapr: handle pc-dimm unplug via hotplug handler chain
  spapr: handle cpu core unplug via hotplug handler chain

 hw/ppc/spapr.c | 67 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 24 deletions(-)

-- 
2.17.0
