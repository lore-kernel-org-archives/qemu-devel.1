Received: from eggs.gnu.org ([2001:4830:134:3::10]:52168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzh5b-0007aT-Ps
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzh5Y-00044F-NX
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:39:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzh5Y-00042b-HD
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:39:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B67A7C058EAA
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 10:39:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  4 Oct 2017 12:39:27 +0200
Message-Id: <20171004103933.7898-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/6] Add make check tests for Migration
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

His this series:
- add test for precopy for unix/tcp
  exec and fd to came, don't know how to test rdma without hardware
- add tests using deprecated interfaces
- add test for xbzrle
  Note to myself, there is no way to set the cache size with migraton_set_parameters
- Add test for compress threads
  disabled on the series, right now it appears that compression is not working at all
- Move postcopy to use new results
  Idea is to move it on top of migration-test.c, but first I want some reviews on basic idea

Please, review.

Juan.


Juan Quintela (6):
  tests: Add basic migration precopy test
  tests: Add basic migration precopy tcp test
  tests: Add precopy test using deprecated commands
  tests: Add migration xbzrle test
  tests: Add migration compress threads tests
  tests: Move postcopy migration test to migrate-set-parameters

 tests/Makefile.include |   3 +
 tests/migration-test.c | 707 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/postcopy-test.c  |   8 +-
 3 files changed, 714 insertions(+), 4 deletions(-)
 create mode 100644 tests/migration-test.c

-- 
2.13.5
