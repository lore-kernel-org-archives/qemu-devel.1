Received: from eggs.gnu.org ([209.51.188.92]:40333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gyVRt-0005eB-Jt
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 00:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1gyVRr-0008UZ-43
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 00:38:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:12518)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1gyVRg-0008JC-6m
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 00:38:27 -0500
From: Zhang Chen <chen.zhang@intel.com >
Date: Tue, 26 Feb 2019 13:34:31 +0800
Message-Id: <20190226053434.6252-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 0/3] Migration/colo.c: Fix upstream bugs when
 occur failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

Fix three bugs after COLO failover.


Zhang Chen (3):
  Migration/colo.c: Fix double close bug when occur COLO failover
  Migration/colo.c: Fix COLO failover status error
  Migration/colo.c: Make COLO node running after failover

 migration/colo.c      | 9 +++++----
 migration/migration.c | 3 +++
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.17.GIT
