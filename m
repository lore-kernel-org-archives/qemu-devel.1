Received: from eggs.gnu.org ([2001:4830:134:3::10]:36919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dTM2X-0007gT-3e
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 01:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dTM2S-0003hD-4y
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 01:42:53 -0400
Received: from [59.151.112.132] (port=50001 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dTM2R-0003Wf-OX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 01:42:48 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 7 Jul 2017 13:43:47 +0800
Message-ID: <1499406231-3877-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/4] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

In this serise, we do a lot of job to optimize COLO net performance.
Mainly focus on TCP protocol. 

Zhang Chen (4):
  net/colo-compare.c: Add checkpoint min period to optimize performance
  net/colo-compare.c: compare tcp packet base on sequence number
  net/colo-compare.c: Optimize unpredictable tcp options comparison
  net/colo-compare.c: Adjust net queue pop order for performance

 net/colo-compare.c | 57 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 12 deletions(-)

-- 
2.7.4
