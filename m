Received: from eggs.gnu.org ([2001:4830:134:3::10]:38060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdv3B-0008Ez-Rc
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdv36-0007ZT-Vw
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:34:57 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:44865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdv36-0007Tg-Kp
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 03:34:52 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 15 Feb 2017 16:34:12 +0800
Message-ID: <1487147657-166092-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/5] colo-compare: fix some bugs
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

Hi,
This series fixes some bugs of colo compare.

Patch 1 is trying to move timer process into colo compare
thread as a new coroutine.

Patch 2 ~ 5 fix several bugs in colo compare, for more details,
please refer to each patch.

Please review, thanks.

zhanghailiang (5):
  colo-compare: use g_timeout_source_new() to process the stale packets
  colo-compare: kick compare thread to exit while finalize
  colo-compare: release all unhandled packets in finalize function
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
