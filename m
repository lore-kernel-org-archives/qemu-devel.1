Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQde-0003ZZ-9m
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fBQdb-0002z5-5i
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fBQdb-0002yp-1C
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 16:03:35 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 25 Apr 2018 21:03:10 +0100
Message-Id: <20180425200326.72337-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 00/16] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, a.perevalov@samsung.com, xiaoguangrong@tencent.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 4743c23509a51bd4ee85cc272287a41917d1be35:

  Update version for v2.12.0 release (2018-04-24 16:44:55 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20180425a

for you to fetch changes up to da3f56cb2e767016d3f204837a77caf35b463f90:

  migration: remove ram_save_compressed_page() (2018-04-25 18:04:14 +0100)

----------------------------------------------------------------
Migration pull for 2.13

Alexey Perevalov's postcopy blocktime statistics
Xiao Guangrong's compression performance improvements

----------------------------------------------------------------
Alexey Perevalov (6):
      migration: introduce postcopy-blocktime capability
      migration: add postcopy blocktime ctx into MigrationIncomingState
      migration: calculate vCPU blocktime on dst side
      migration: postcopy_blocktime documentation
      migration: add blocktime calculation into migration-test
      migration: add postcopy total blocktime into query-migrate

Xiao Guangrong (10):
      migration: stop compressing page in migration thread
      migration: stop compression to allocate and free memory frequently
      migration: stop decompression to allocate and free memory frequently
      migration: detect compression and decompression errors
      migration: introduce control_save_page()
      migration: move some code to ram_save_host_page
      migration: move calling control_save_page to the common place
      migration: move calling save_zero_page to the common place
      migration: introduce save_normal_page()
      migration: remove ram_save_compressed_page()

 docs/devel/migration.rst |  14 ++
 hmp.c                    |  15 ++
 migration/migration.c    |  51 ++++-
 migration/migration.h    |  13 ++
 migration/postcopy-ram.c | 268 +++++++++++++++++++++++++-
 migration/qemu-file.c    |  43 ++++-
 migration/qemu-file.h    |   6 +-
 migration/ram.c          | 482 ++++++++++++++++++++++++++++-------------------
 migration/trace-events   |   6 +-
 qapi/migration.json      |  17 +-
 tests/migration-test.c   |  16 ++
 11 files changed, 716 insertions(+), 215 deletions(-)
