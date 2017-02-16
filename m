Received: from eggs.gnu.org ([2001:4830:134:3::10]:46250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceF7s-0003CN-3w
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:01:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceF7p-0003BQ-5b
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:01:08 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:14582)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1ceF7o-0003Ae-NM
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 01:01:05 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Thu, 16 Feb 2017 14:00:17 +0800
Message-ID: <1487224821-120916-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/4] colo-compare: fix some bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, xuquan8@huawei.com, pss.wulizhen@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

This series includes two parts: codes optimization and bug fix.
patch 1 tries to move timer process into colo compare thread as 
a new coroutine.
patch 2 ~ 4 fixe some bugs of colo compare.

v2:
 - Squash patch 3 of last version into patch 2. (ZhangChen's suggestion)

zhanghailiang (4):
  colo-compare: use g_timeout_source_new() to process the stale packets
  colo-compare: kick compare thread to exit after some cleanup in
    finalization
  char: remove the right fd been watched in qemu_chr_fe_set_handlers()
  colo-compare: Fix removing fds been watched incorrectly in
    finalization

 chardev/char-io.c  |  13 ++++--
 chardev/char-io.h  |   2 +
 chardev/char.c     |   2 +-
 net/colo-compare.c | 115 +++++++++++++++++++++++++++--------------------------
 4 files changed, 71 insertions(+), 61 deletions(-)

-- 
1.8.3.1
