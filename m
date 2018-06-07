Received: from eggs.gnu.org ([2001:4830:134:3::10]:55704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy9D-0002k7-Gl
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fQy99-0001qK-Gl
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 12:52:27 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Jun 2018 18:52:10 +0200
Message-Id: <20180607165218.9558-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/8] pc/spapr/s390x: machine hotplug handler
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
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, david@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>

I'll be messing with machine hotplug handlers of pc/spapr/s390x in the
context of
    [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers

So this is a spin-off of the cleanup patches produced so far.

David Hildenbrand (8):
  pc: local error handling in hotplug handler functions
  spapr: no need to verify the node
  spapr: move all DIMM checks into spapr_memory_plug
  spapr: local error handling in hotplug handler functions
  spapr: introduce machine unplug handler
  spapr: handle pc-dimm unplug via hotplug handler chain
  spapr: handle cpu core unplug via hotplug handler chain
  s390x: local error handling in hotplug handler functions

 hw/i386/pc.c               | 32 +++++++++-----
 hw/ppc/spapr.c             | 89 +++++++++++++++++++++++++-------------
 hw/s390x/s390-virtio-ccw.c | 11 +++--
 3 files changed, 89 insertions(+), 43 deletions(-)

-- 
2.17.0
