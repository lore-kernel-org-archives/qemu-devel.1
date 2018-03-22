Received: from eggs.gnu.org ([2001:4830:134:3::10]:56964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1ez4vU-00063q-1B
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1ez4vQ-0006J1-T6
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:27:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:32869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1ez4vQ-0006Hc-N6
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 14:26:56 -0400
From: Alexey Perevalov <a.perevalov@samsung.com>
Date: Thu, 22 Mar 2018 21:17:21 +0300
Message-id: <1521742647-25550-1-git-send-email-a.perevalov@samsung.com>
References: <CGME20180322181739eucas1p2b5f31dc21663881bc244deaedec22712@eucas1p2.samsung.com>
Subject: [Qemu-devel] [PATCH v2 0/6] postcopy block time calculation + ppc32
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

V1-V2
    accidentally appeared __nocheck after rebase
    this patch set also rebased after latest pull request

This patch set includes patches which were reverted by commit
ee86981bd, due to build problem on 32 powerpc/arm architecture.
Also it includes patch to fix build
([PATCH v4] migration: change blocktime type to uint32_t), but that
patch was merged into:
migration: add postcopy blocktime ctx into MigrationIncomingState
migration: calculate vCPU blocktime on dst side
migration: add postcopy total blocktime into query-migrate


based on
commit c6740fc88ecd8f5cf3cf3185ee112c3eea41caa2
"hw/rdma: Implementation of PVRDMA device"

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
 migration/postcopy-ram.c | 268 ++++++++++++++++++++++++++++++++++++++++++++++-
 migration/trace-events   |   6 +-
 qapi/migration.json      |  17 ++-
 tests/migration-test.c   |  16 +++
 8 files changed, 392 insertions(+), 8 deletions(-)

-- 
2.7.4
