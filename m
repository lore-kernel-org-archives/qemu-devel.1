Received: from eggs.gnu.org ([2001:4830:134:3::10]:37581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cWHUQ-0004dM-EG
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 01:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cWHUN-0006Kk-DS
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 01:55:30 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:43093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cWHUM-0006Ji-Ia
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 01:55:27 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 25 Jan 2017 14:53:59 +0800
Message-ID: <1485327241-15104-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] savevm: some improvements benefit COLO's
 later optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, quintela@redhat.com, dgilbert@redhat.com, xuquan8@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

Hi,

This series is split from previous COLO frame version which i post
long time ago.

These two patches are prerequisite for the later COLO optimization.
Since it is independent, I'd like to post it as a single series.

Both of them have been reviewed by Dave before, compared with old
version, I fixed the titles/comments for both of them, and I kept the
reviewed-by tag. (Hi Dave, please give it a glance again, since
it has been a long time ;) ).

Please review. Thanks.


zhanghailiang (2):
  savevm: split save/find loadvm_handlers entry into two helper
    functions
  savevm: Add new helpers to process the different stages of
    loadvm/savevm

 include/sysemu/sysemu.h |  4 +++
 migration/savevm.c      | 96 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 85 insertions(+), 15 deletions(-)

-- 
1.8.3.1
