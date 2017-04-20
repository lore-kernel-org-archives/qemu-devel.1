Received: from eggs.gnu.org ([2001:4830:134:3::10]:54243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16oi-00041a-D3
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16od-0001Ed-HP
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:52 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3443
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d16od-00013y-5q
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:47:47 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Thu, 20 Apr 2017 15:46:52 +0800
Message-ID: <1492674416-9408-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/3] colo-compare: fix three bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: qemu-devel@nongnu.org, weidong.huang@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

Hi, 

This series fixes three bugs found in our test, please review.

Thanks.

zhanghailiang (3):
  colo-compare: serialize compare thread's initialization with main
    thread
  colo-compare: Check main_loop value before call g_main_loop_quit
  colo-compare: fix a memory leak

 net/colo-compare.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
1.8.3.1
