Received: from eggs.gnu.org ([2001:4830:134:3::10]:35358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0ok-0004Dx-3Y
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gX0of-0002H3-N3
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:28:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gX0od-0002F2-Pd
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:28:29 -0500
From: David Hildenbrand <david@redhat.com>
Date: Wed, 12 Dec 2018 10:28:19 +0100
Message-Id: <20181212092821.18260-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] qapi/range/memory-device: fixes and
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

These are the two leftovers from
    [PATCH v3 0/7] qapi/range/memory-device: fixes and cleanups

The remaining patches extent the QEMU range code and rewrite
memory-device code to make use of it.

v3 -> v4:
- "memory-device: rewrite address assignment using ranges"
-- Use better error messages
-- Fix one theretical overflow

David Hildenbrand (2):
  range: add some more functions
  memory-device: rewrite address assignment using ranges

 hw/mem/memory-device.c | 54 ++++++++++++++++++++----------------
 include/qemu/range.h   | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 23 deletions(-)

-- 
2.17.2
