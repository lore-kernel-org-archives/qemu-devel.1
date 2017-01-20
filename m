Received: from eggs.gnu.org ([2001:4830:134:3::10]:46833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQCC-0005Pi-13
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQCB-0006fo-47
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:49:00 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Fri, 20 Jan 2017 11:47:54 +0800
Message-ID: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 0/6] COLO block replication supports shared
 disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Juan
	Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>, "Dr .
	David Alan Gilbert" <dgilbert@redhat.com>, eddie.dong@intel.com

COLO block replication doesn't support the shared disk case,
Here we try to implement it and this is the third version.

Last posted series patches:
https://lists.gnu.org/archive/html/qemu-block/2016-12/msg00039.html
You can refer to the above link if want to test it.

I have uploaded the new version to github:
https://github.com/coloft/qemu/tree/colo-developing-with-shared-disk-2016-1-20

Please review and any commits are welcomed.

Cc: Juan Quintela <quintela@redhat.com>
Cc: Amit Shah <amit.shah@redhat.com> 
Cc: Dr. David Alan Gilbert (git) <dgilbert@redhat.com>
Cc: eddie.dong@intel.com

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

 block/nbd.c                |  12 ++++
 block/replication.c        | 156 +++++++++++++++++++++++++++++++++++----------
 docs/block-replication.txt | 139 ++++++++++++++++++++++++++++++++++++++--
 qapi/block-core.json       |  10 ++-
 4 files changed, 279 insertions(+), 38 deletions(-)

-- 
1.8.3.1
