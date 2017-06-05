Received: from eggs.gnu.org ([2001:4830:134:3::10]:45931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWN-0003lA-EK
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWK-0003z9-5z
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:03 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60908)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWJ-0003tQ-Ru
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:00 -0400
From: Yong Wang <wang.yong155@zte.com.cn>
Date: Mon, 5 Jun 2017 18:44:49 +0800
Message-Id: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCHv2 00/04] Replace the COLO comparing thread with
 IOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.yong155@zte.com.cn, wang.guang55@zte.com.cn

It's a good idea to use IOThread instead of COLO comparing thread.
comparing thread can be completely replaced by IOThread, so this idea came.

This series of updates mainly include the old packet regularly check and
primary/secondary network packets compare all into the IOThread processing.

Please review,thanks.

wangyong(4):
colo-compare: Use IOThread context timer to Check old packet
 regularly
colo-compare: Process pactkets in the IOThread of the primary
colo-compare: Update the COLO document to add the IOThread
 configuration
colo-compare: Update the COLO document to fix the processing
 of secondary packets in the main thread

 docs/colo-proxy.txt |   5 +-
 net/colo-compare.c  | 175 ++++++++++++++++++++++++++++++++++++++--------------
 net/colo.h          |   1 +
 3 files changed, 134 insertions(+), 47 deletions(-)

--
1.8.3.1
