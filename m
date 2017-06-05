Received: from eggs.gnu.org ([2001:4830:134:3::10]:45953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWP-0003mm-VQ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWL-000403-B9
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:06 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:37696)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dHpWK-0003yW-MJ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 06:46:01 -0400
From: Yong Wang <wang.yong155@zte.com.cn>
Date: Mon, 5 Jun 2017 18:44:53 +0800
Message-Id: <1496659493-1105-5-git-send-email-wang.yong155@zte.com.cn>
In-Reply-To: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
References: <1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn>
Subject: [Qemu-devel] [PATCHv2 04/04] colo-compare: Update the COLO document
 to fix the processing of secondary packets in the main thread
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

In my test, secondary does not process the packets comparing in the IOThread
but in the qemu main thread processing.
secondary's configuration " -chardev socket,id=compare1,host=3.3.3.3,port=9004,server,nowait"
here,we should use 'wait' instead of 'nowait' configuration .
after use  'wait' configuration ,packets can be process in the IOThread from the secondary,
not in the qemu main thread.

Signed-off-by: Wang Yong<wang.yong155@zte.com.cn>
Signed-off-by: Wang Guang<wang.guang55@zte.com.cn>
---
 docs/colo-proxy.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
index ce3f783..567cc8b 100644
--- a/docs/colo-proxy.txt
+++ b/docs/colo-proxy.txt
@@ -165,7 +165,7 @@ Primary(ip:3.3.3.3):
 -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
 -device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
 -chardev socket,id=mirror0,host=3.3.3.3,port=9003,server,nowait
--chardev socket,id=compare1,host=3.3.3.3,port=9004,server,nowait
+-chardev socket,id=compare1,host=3.3.3.3,port=9004,server,wait
 -chardev socket,id=compare0,host=3.3.3.3,port=9001,server,nowait
 -chardev socket,id=compare0-0,host=3.3.3.3,port=9001
 -chardev socket,id=compare_out,host=3.3.3.3,port=9005,server,nowait
-- 
1.8.3.1
