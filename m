Received: from eggs.gnu.org ([209.51.188.92]:56864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzP12-0005G4-UT
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gzP11-0007Ft-8A
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:63406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1gzP10-0007D6-WE
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:58:35 -0500
From: Zhang Chen <chen.zhang@intel.com >
Date: Fri,  1 Mar 2019 00:55:01 +0800
Message-Id: <20190228165508.21594-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH V2 0/7] Migration/colo: Fix upstream bugs when
 occur failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

This series focus on COLO failover bug fix and optimization.

V2:
 - Add patch 4/7 to handle failover state. 
 - Add new patches to optimize failover status.

V1:
 - Init patch.

Zhang Chen (7):
  Migration/colo.c: Fix double close bug when occur COLO failover
  Migration/colo.c: Fix COLO failover status error
  Migration/colo.c: Make COLO node running after failover
  Migration/colo.c: Add new COLOExitReason to handle all failover state
  qapi/migration.json: Remove a variable that doesn't exist in example
  Migration/colo.c: Add the necessary checks for colo_do_failover
  Migration/colo.c: Make user obtain the COLO mode info after failover

 migration/colo.c      | 69 ++++++++++++++++++++++++++++++-------------
 migration/migration.c |  3 ++
 qapi/migration.json   | 17 ++++++-----
 3 files changed, 61 insertions(+), 28 deletions(-)

-- 
2.17.GIT
