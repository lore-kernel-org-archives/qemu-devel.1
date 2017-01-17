Received: from eggs.gnu.org ([2001:4830:134:3::10]:41529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTTLf-0002Gu-Tu
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTTLa-000381-Tf
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:58:51 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:15709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cTTLZ-00033K-SV
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 07:58:46 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Tue, 17 Jan 2017 20:57:41 +0800
Message-ID: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] COLO: fix some bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, quintela@redhat.com, dgilbert@redhat.com, eddie.dong@intel.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

Hi,

This series fix three bugs of COLO. 
patch 1 fix one usage case which users want to change checkpoint-delay
with an extream big value set before, the new value may not take effect
until finishing a long time of sleep.

Patch 2 and 3 are old patches that split from previous version
long time ago, and has been reviewed by Dave.

I'd like to pick these three patches from the later COLO series,
which will include some optimization and integrating with block
replication and COLO net proxy.

Please review, thanks.


zhanghailiang (3):
  COLO: fix setting checkpoint-delay not working properly
  COLO: Shutdown related socket fd while do failover
  COLO: Don't process failover request while loading VM's state

 include/migration/colo.h      |   2 +
 include/migration/migration.h |   8 ++++
 migration/colo.c              | 102 +++++++++++++++++++++++++++++++++++++-----
 migration/migration.c         |   3 ++
 qapi-schema.json              |   4 +-
 5 files changed, 108 insertions(+), 11 deletions(-)

-- 
1.8.3.1
