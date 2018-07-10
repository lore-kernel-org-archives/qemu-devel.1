Received: from eggs.gnu.org ([2001:4830:134:3::10]:54294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fconh-0002xa-5B
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fcond-0002tZ-PS
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:19:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fcond-0002tO-Kf
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:19:09 -0400
From: Peter Xu <peterx@redhat.com>
Date: Tue, 10 Jul 2018 17:18:52 +0800
Message-Id: <20180710091902.28780-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 v2 00/10] migration: postcopy recovery
 unit test, bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Balamuruhan S <bala24@linux.vnet.ibm.com>

Based-on: <20180627132246.5576-1-peterx@redhat.com>

Based on the series to unbreak postcopy:
  Subject: [PATCH v3 0/4] migation: unbreak postcopy recovery
  Message-Id: <20180627132246.5576-1-peterx@redhat.com>

v2:
- collect r-bs, and t-b for Balamuruhan
- rename matching_target_page_size to matches_target_page_size [Dave]
- fixup the race that Dave reported: the 1st patch was added as
  a new patch (patch 4); the 2nd patch was squashed into the unit test
  patch (patch 9)

Please review.  Thanks,

Peter Xu (10):
  migration: simplify check to use qemu file buffer
  migration: loosen recovery check when load vm
  migration: fix incorrect bitmap size calculation
  migration: show pause/recover state on dst host
  tests: introduce migrate_postcopy_* helpers
  tests: allow migrate() to take extra flags
  tests: introduce migrate_query*() helpers
  tests: introduce wait_for_migration_status()
  tests: add postcopy recovery test
  tests: hide stderr for postcopy recovery test

 migration/migration.c  |   2 +
 migration/ram.c        |  21 +++--
 migration/savevm.c     |  16 ++--
 tests/migration-test.c | 205 ++++++++++++++++++++++++++++++++---------
 4 files changed, 185 insertions(+), 59 deletions(-)

-- 
2.17.1
