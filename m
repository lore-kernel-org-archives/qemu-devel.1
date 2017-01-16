Received: from eggs.gnu.org ([2001:4830:134:3::10]:50380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTEYu-0003Vy-8L
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:11:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTEYt-00013p-AG
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:11:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTEYt-00013k-45
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:11:31 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 19:11:20 -0200
Message-Id: <20170116211124.29245-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] target-i386: Implement
 query-cpu-model-expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>

This series implements query-cpu-model-expansion on target-i386.

Changes v1 -> v2:
-----------------

This version is highly simplified compared to v1. It contains
only an implementation that will return a limited set of
properties. I have a follow-up series that will expend type=full
expansion to return every single QOM property, but this version
will return the same data for type=static and type=full expansion
for simplicity (except that type=static expansion will use the
"base" CPU model as base).

This means this version also won't include "pmu" and
"host-cache-info" in full expansion, and won't require special
code for those properties.

The unit test code was also removed in this version, to keep the
series simple and easier to review. Most of the patches on the
previous series were changes just to make the test case work. I
will send the test-case-related changes as a follow-up series.

---
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: libvir-list@redhat.com
Cc: Jiri Denemark <jdenemar@redhat.com>
Cc: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Blake <eblake@redhat.com>

Eduardo Habkost (4):
  target-i386: Reorganize and document CPUID initialization steps
  qapi-schema: Comment about full expansion of non-migration-safe models
  target-i386: Define static "base" CPU model
  target-i386: Implement query-cpu-model-expansion QMP command

 qapi-schema.json      |   9 ++
 target/i386/cpu-qom.h |   2 +
 monitor.c             |   4 +-
 target/i386/cpu.c     | 317 ++++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 298 insertions(+), 34 deletions(-)

-- 
2.11.0.259.g40922b1
