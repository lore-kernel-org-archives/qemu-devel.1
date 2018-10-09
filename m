Received: from eggs.gnu.org ([2001:4830:134:3::10]:54456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9z3z-0005dh-GD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9z3v-0002cP-Gd
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1g9z3v-0002c3-Ap
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 16:57:03 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue,  9 Oct 2018 22:56:45 +0200
Message-Id: <20181009205652.10605-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/7] qapi/range/memory-device: fixes and
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Hildenbrand <david@redhat.com>

While working on memory device code, I noticed that specifiying an uint64_t
on command line does not work in all cases as we always parse an int64_t.
So I fix that and also cleanup the old int64_t parser.

To be able to fix some overflows in memory-device code in a clean way,
I am reusing the range implementation of qemu, for which I need some
more helpers.

This series is based on
    "[PATCH v5 00/16] memory-device: complete refactoring"
which should get merged soon.

David Hildenbrand (7):
  qapi: correctly parse uint64_t values from strings
  qapi: use qemu_strtoi64() in parse_str_int64
  range: pass const pointer where possible
  range: add some more functions
  memory-device: use QEMU_IS_ALIGNED
  memory-device: avoid overflows on very huge devices
  memory-device: rewrite address assignment using ranges

 hw/mem/memory-device.c      |  63 ++++++++++-------
 include/qemu/range.h        |  86 ++++++++++++++++++++++-
 qapi/string-input-visitor.c | 133 ++++++++++++++++++++++++++++++------
 3 files changed, 231 insertions(+), 51 deletions(-)

-- 
2.17.1
