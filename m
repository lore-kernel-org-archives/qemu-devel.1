Received: from eggs.gnu.org ([2001:4830:134:3::10]:40958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1diIVh-0004E6-6G
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1diIVe-0004Kz-4V
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:58:45 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:34570)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1diIVd-0004Kc-HB
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:58:42 -0400
From: Wang yong <wang.yong155@zte.com.cn>
Date: Thu, 17 Aug 2017 18:58:00 +0800
Message-Id: <1502967483-4090-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCHv3 00/03] Replace the COLO comparing thread with
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
 4 file changed, 86 insertions(+), 37 deletions(-)

--
1.8.3.1
