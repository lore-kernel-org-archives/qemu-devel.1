Received: from eggs.gnu.org ([2001:4830:134:3::10]:48540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dmarr-0005Pb-Ei
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 03:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dmarm-0008Kr-MQ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 03:23:23 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:64479)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dmarm-0008Hj-Bd
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 03:23:18 -0400
From: Wang yong <wang.yong155@zte.com.cn>
Date: Tue, 29 Aug 2017 15:22:36 +0800
Message-Id: <1503991359-3353-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCHv5 00/03] Replace the COLO comparing thread with
 IOThread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, stefanha@redhat.com, famz@redhat.com, jasowang@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhang.zhanghailiang@huawei.com
Cc: wang.yong155@zte.com.cn, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org

From: Wang Yong <wang.yong155@zte.com.cn>

It's a good idea to use IOThread instead of COLO comparing thread.
comparing thread can be completely replaced by IOThread, so this idea came.

This series of updates mainly include IOThread supports the GMainContext
event loop, then the old packet regularly check and primary/secondary network
packets compare all into the IOThread processing.

Please review,thanks.

wangyong(3):
qemu-iothread: IOThread supports the GMainContext event loop
colo-compare: Use IOThread to Check old packet regularly and
 Process pactkets of the primary
colo-compare: Update the COLO document to add the IOThread
 configuration

 include/sysemu/iothread.h | 10 +++++++++
 iothread.c                | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 net/colo-compare.c | 75 ++++++++++++++++++++++++++++--------------------------
 docs/colo-proxy.txt | 3 ++- 
 4 file changed, 97 insertions(+), 39 deletions(-)

--
1.8.3.1
