Received: from eggs.gnu.org ([2001:4830:134:3::10]:36644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cyIuj-000331-Sm
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cyIuc-0001Co-Db
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:06:28 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 12 Apr 2017 22:05:15 +0800
Message-ID: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 0/6] COLO block replication supports shared
 disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, eddie.dong@intel.com

COLO block replication doesn't support the shared disk case,
Here we try to implement it and this is the 4th version.

Please review and any commits are welcomed.

Cc: Dr. David Alan Gilbert (git) <dgilbert@redhat.com>
Cc: eddie.dong@intel.com

v4:
- Add proper comment for primary_disk in patch 2 (Stefan)
- Call bdrv_invalidate_cache() while do checkpoint for shared disk in patch 5

v3:
- Fix some comments from Stefan and Eric

v2:
- Drop the patch which add a blk_root() helper
- Fix some comments from Changlong

zhanghailiang (6):
  docs/block-replication: Add description for shared-disk case
  replication: add shared-disk and shared-disk-id options
  replication: Split out backup_do_checkpoint() from
    secondary_do_checkpoint()
  replication: fix code logic with the new shared_disk option
  replication: Implement block replication for shared disk case
  nbd/replication: implement .bdrv_get_info() for nbd and replication
    driver

 block/nbd.c                |  12 +++
 block/replication.c        | 198 ++++++++++++++++++++++++++++++++++-----------
 docs/block-replication.txt | 139 ++++++++++++++++++++++++++++++-
 qapi/block-core.json       |  10 ++-
 4 files changed, 306 insertions(+), 53 deletions(-)

-- 
1.8.3.1
