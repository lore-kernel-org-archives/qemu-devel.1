Received: from eggs.gnu.org ([2001:4830:134:3::10]:47064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dhuPR-00033e-Md
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dhuPO-0004en-8K
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:14:41 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:39316 helo=zte.com.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dhuPN-0004dU-Tr
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 05:14:38 -0400
From: Wang yong <wang.yong155@zte.com.cn>
Date: Wed, 16 Aug 2017 17:14:00 +0800
Message-Id: <1502874842-4191-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCHv3 00/02] Replace the COLO comparing thread with
 IOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, famz@redhat.com
Cc: wang.yong155@zte.com.cn, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org

From: Wang Yong <wang.yong155@zte.com.cn>

Note: This series is based on the patch of "qemu-iothread: 
IOThread supports theGMainContext event loop".

It's a good idea to use IOThread instead of COLO comparing thread.
comparing thread can be completely replaced by IOThread, so this idea came.

This series of updates mainly include the old packet regularly check and
primary/secondary network packets compare all into the IOThread processing.

Please review,thanks.

wangyong(2):
colo-compare: Use IOThread to Check old packet regularly and
 Process pactkets of the primary
colo-compare: Update the COLO document to add the IOThread
 configuration

 docs/colo-proxy.txt |   5 +-
 net/colo-compare.c | 75 ++++++++++++++++++++++++++++--------------------------
 2 file changed, 39 insertions(+), 36 deletions(-)

--
1.8.3.1
