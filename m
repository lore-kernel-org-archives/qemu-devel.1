Received: from eggs.gnu.org ([2001:4830:134:3::10]:33122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8h2-0003tX-UO
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gy-0002nN-B0
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8gy-0002n1-4W
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:48 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:24 +0800
Message-Id: <1504836324-4871-19-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 18/18] colo-compare: Update the COLO document to
 add the IOThread configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Wang Yong <wang.yong155@zte.com.cn>, Wang Guang <wang.guang55@zte.com.cn>, Jason Wang <jasowang@redhat.com>

From: Wang Yong <wang.yong155@zte.com.cn>

Update colo-proxy.txt,add IOThread configuration.
Later we have to configure IOThread,if not COLO can not work.

Reviewed-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Wang Yong <wang.yong155@zte.com.cn>
Signed-off-by: Wang Guang <wang.guang55@zte.com.cn>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 docs/colo-proxy.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
index f6a624f..8b726ea 100644
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
2.7.4
