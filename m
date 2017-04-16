Received: from eggs.gnu.org ([2001:4830:134:3::10]:51517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1czgQq-0007Om-U4
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 05:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1czgQn-0001aG-27
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 05:25:20 -0400
Received: from [59.151.112.132] (port=2168 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1czgQm-0001XK-N8
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 05:25:17 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Sun, 16 Apr 2017 17:24:35 +0800
Message-ID: <1492334677-14170-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/2] COLO-compare: Optimize tcp compare
 performance and trace format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

In the first patch, we add tcp options support to optimize compare performance.
and another patch simplified code and adjust trace print format.

Zhang Chen (2):
  COLO-compare: Optimize tcp compare for option field
  COLO-compare: Optimize tcp compare trace event

 net/colo-compare.c | 54 ++++++++++++++++++++++++++++++++++++++++++------------
 net/trace-events   |  3 +--
 2 files changed, 43 insertions(+), 14 deletions(-)

-- 
2.7.4
