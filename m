Received: from eggs.gnu.org ([2001:4830:134:3::10]:36807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAF-0004oc-Kv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTIAB-0001Tn-M7
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTIAB-0001Th-Fn
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 20:02:15 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 16 Jan 2017 23:01:55 -0200
Message-Id: <20170117010204.4909-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/9] i386: query-cpu-model-expansion test script
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

This is a follow-up to the series that implements
query-cpu-model-expansion. Before including the test script, the
series has some fixes to allow the results of
query-cpu-model-expansion to be used in the QEMU command-line.

The script probably will work on s390x too, but I couldn't test
it yet.

This series and its dependencies can be pulled from the branch:
  https://github.com/ehabkost/qemu-hacks.git work/x86-query-cpu-expansion-test

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

Eduardo Habkost (9):
  target-i386: Move "host" properties to base class
  target-i386: Allow short strings to be used as vendor ID
  cpu: Support comma escaping when parsing -cpu
  qemu.py: Make logging optional
  qtest.py: Support QTEST_LOG environment variable
  qtest.py: make logging optional
  qtest.py: Make 'binary' parameter optional
  tests: Add rules to non-gtester qtest test cases
  tests: Test case for query-cpu-model-expansion

 scripts/qemu.py               |  25 ++-
 scripts/qtest.py              |  15 +-
 qom/cpu.c                     |  32 ++--
 target/i386/cpu.c             |  83 ++++-----
 tests/test-x86-cpuid-compat.c |  19 ++
 tests/Makefile.include        |  40 ++++-
 tests/query-cpu-model-test.py | 398 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 551 insertions(+), 61 deletions(-)
 create mode 100755 tests/query-cpu-model-test.py

-- 
2.11.0.259.g40922b1
