Received: from eggs.gnu.org ([2001:4830:134:3::10]:59113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evlJU-0003ML-KR
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1evlJR-0001LY-HW
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:04 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1evlJR-0001Kk-44
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 10:54:01 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Tue, 13 Mar 2018 17:53:38 +0300
Message-id: <1520952824-3172-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20180313145356eucas1p24b7192c7bc7ecbfd5687c59ae0e649ab@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v1 0/6] postcopy block time calculation + ppc32
 build fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: Alexey Perevalov <a.perevalov@samsung.com>, v.kuramshin@samsung.com, ash.billore@samsung.com, f4bug@amsat.org, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com

This patch set includes patches which were reverted by commit
ee86981bd, due to build problem on 32 powerpc/arm architecture.
Also it includes patch to fix build
([PATCH v4] migration: change blocktime type to uint32_t), but that
patch was merged into:
migration: add postcopy blocktime ctx into MigrationIncomingState
migration: calculate vCPU blocktime on dst side
migration: add postcopy total blocktime into query-migrate

based on
commit 12c06d6f967a63515399b9e1f6a40f5ce871a8b7
Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging


Alexey Perevalov (6):
  migration: introduce postcopy-blocktime capability
  migration: add postcopy blocktime ctx into MigrationIncomingState
  migration: calculate vCPU blocktime on dst side
  migration: postcopy_blocktime documentation
  migration: add blocktime calculation into migration-test
  migration: add postcopy total blocktime into query-migrate

 docs/devel/migration.rst |  14 +++
 hmp.c                    |  15 +++
 migration/migration.c    |  51 ++++++++-
 migration/migration.h    |  13 +++
 migration/postcopy-ram.c | 266 ++++++++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events   |   6 +-
 qapi/migration.json      |  17 ++-
 tests/migration-test.c   |  16 +++
 8 files changed, 390 insertions(+), 8 deletions(-)

-- 
2.7.4
