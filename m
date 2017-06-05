Received: from eggs.gnu.org ([2001:4830:134:3::10]:45930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWN-0003l9-EK
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWJ-0003yf-As
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:03 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60921)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWI-0003vF-N0
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:45:59 -0400
From: Yong Wang <wang.yong155@zte.com.cn>
Date: Mon, 5 Jun 2017 18:44:52 +0800
Message-Id: <1496659493-1105-4-git-send-email-wang.yong155@zte.com.cn>
In-Reply-To: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
References: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCHv2 03/04] colo-compare: Update the COLO document
 to add the IOThread configuration
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

From: Wang Yong <wang.yong155@zte.com.cn>

Update colo-proxy.txt,add IOThread configuration.
Later we have to configure IOThread,if not COLO can not work.

Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
---
 docs/colo-proxy.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
index c4941de..ce3f783 100644
--- a/docs/colo-proxy.txt
+++ b/docs/colo-proxy.txt
@@ -170,10 +170,11 @@ Primary(ip:3.3.3.3):
 -chardev socket,id=compare0-0,host=3.3.3.3,port=9001
 -chardev socket,id=compare_out,host=3.3.3.3,port=9005,server,nowait
 -chardev socket,id=compare_out0,host=3.3.3.3,port=9005
+-object iothread,id=iothread1
 -object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0
 -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out
 -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0
--object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0
+-object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,iothread=iothread1
 
 Secondary(ip:3.3.3.8):
 -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
-- 
1.8.3.1
