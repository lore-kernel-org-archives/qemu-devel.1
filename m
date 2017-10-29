Received: from eggs.gnu.org ([2001:4830:134:3::10]:44890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLT-00038D-6T
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e8nLP-0001ja-TD
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e8nLP-0001iO-O1
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 09:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9069437E68
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 13:09:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Sun, 29 Oct 2017 14:09:25 +0100
Message-Id: <20171029130934.4555-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/9] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

This includes the patches reviewed form:
- migrate_set_cache_size series (quintela)
- migrate tests (quintela)

Please apply.

Later, Juan.

The following changes since commit a93ece47fd9edbd4558db24300056c9a57d3bcd4:

  Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20171026-tag' into staging (2017-10-27 14:43:02 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20171029

for you to fetch changes up to 56b4a42a2e0ae74cee629abcb82993e79deeb356:

  tests: check that migration parameters are really assigned (2017-10-29 14:06:16 +0100)

----------------------------------------------------------------
migration/next for 20171029

----------------------------------------------------------------
Juan Quintela (9):
      migration: Make sure that we pass the right cache size
      migration: Don't play games with the requested cache size
      migration: No need to return the size of the cache
      migration: Make xbzrle_cache_size a migration parameter
      tests: rename postcopy-test to migration-test
      tests: Refactor setting of parameters/capabilities
      tests: Factorize out migrate_test_start/end
      tests: Don't abuse global_qtest
      tests: check that migration parameters are really assigned

 MAINTAINERS                                 |   1 +
 hmp.c                                       |  14 ++
 migration/migration.c                       |  45 +++--
 migration/migration.h                       |   1 -
 migration/page_cache.c                      |  12 +-
 migration/ram.c                             |  20 +--
 migration/ram.h                             |   2 +-
 qapi/migration.json                         |  26 ++-
 tests/Makefile.include                      |   6 +-
 tests/{postcopy-test.c => migration-test.c} | 259 +++++++++++++++++-----------
 10 files changed, 244 insertions(+), 142 deletions(-)
 rename tests/{postcopy-test.c => migration-test.c} (78%)
