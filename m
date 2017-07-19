Received: from eggs.gnu.org ([2001:4830:134:3::10]:41313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXjOe-0006MZ-CR
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXjOb-0000dn-32
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:48 -0400
Received: from [59.151.112.132] (port=20158 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dXjOa-0000bK-Lj
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:27:45 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Wed, 19 Jul 2017 15:29:55 +0800
Message-ID: <1500449399-19107-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 0/4] Optimize COLO-compare performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

In this serise, we do a lot of job to optimize COLO net performance.
Mainly focus on TCP protocol.

V3:
 - Rebase on upstream.
 - Remove origin p2.
 - Move the "checkpoint_time_ms" to CompareState,
   in order to aviod multi colo-compare instance conflict.
 - Add "TODO comments" for reset s->checkpoint_time_ms.
 - Add a new patch fix comments and scheme.

V2:
 - Rename p2's subject.


Zhang Chen (4):
  net/colo-compare.c: Add checkpoint min period to optimize performance
  net/colo-compare.c: Optimize unpredictable tcp options  comparison
  net/colo-compare.c: Adjust net queue pop order for performance
  net/colo-compare.c: Fix comments and scheme

 net/colo-compare.c | 83 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 23 deletions(-)

-- 
2.7.4
