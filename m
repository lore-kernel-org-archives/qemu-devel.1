Received: from eggs.gnu.org ([2001:4830:134:3::10]:36107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dVX3v-0007O5-Ez
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dVX3t-0006Hx-G2
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:53:19 -0400
Received: from [59.151.112.132] (port=25092 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dVX3t-0006C3-41
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 01:53:17 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Thu, 13 Jul 2017 13:52:51 +0800
Message-ID: <1499925175-21218-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 0/4] Optimize COLO-compare performance
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

V2:
 - Rename p2's subject.

Zhang Chen (4):
  net/colo-compare.c: Add checkpoint min period to optimize performance
  net/colo-compare.c: Compare the tcp packets that has the same sequence
    number
  net/colo-compare.c: Optimize unpredictable tcp options comparison
  net/colo-compare.c: Adjust net queue pop order for performance

 net/colo-compare.c | 57 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 12 deletions(-)

-- 
2.7.4
