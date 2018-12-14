Received: from eggs.gnu.org ([2001:4830:134:3::10]:33884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gXnF0-0007F5-U7
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gXnEy-0001lW-5H
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:10:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gXnEx-0001l0-Vv
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:10:52 -0500
From: David Hildenbrand <david@redhat.com>
Date: Fri, 14 Dec 2018 14:10:41 +0100
Message-Id: <20181214131043.25071-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 0/2] range/memory-device: fixes and cleanups
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

v34 -> v5:
- "memory-device: rewrite address assignment using ranges"
-- Squash to error pathes that resulted in the same error message

v3 -> v4:
- "memory-device: rewrite address assignment using ranges"
-- Use better error messages
-- Fix one theretical overflow

David Hildenbrand (2):
  range: add some more functions
  memory-device: rewrite address assignment using ranges

 hw/mem/memory-device.c | 51 +++++++++++++++++-----------------
 include/qemu/range.h   | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 25 deletions(-)

-- 
2.17.2
