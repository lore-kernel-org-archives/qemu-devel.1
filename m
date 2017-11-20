Received: from eggs.gnu.org ([2001:4830:134:3::10]:39405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eGco6-00075F-KV
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eGco4-0000ql-7O
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eGco4-0000qZ-0n
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:36 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Nov 2017 11:31:22 +0800
Message-Id: <1511148687-24909-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1511148687-24909-1-git-send-email-jasowang@redhat.com>
References: <1511148687-24909-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] colo-compare: fix the dangerous assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 8ec14402029d783720f4312ed8a925548e1dad61
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index ccdcba2..1ce195f 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -179,7 +179,7 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
                          "drop packet");
         }
     }
-    con = &conn;
+    *con = conn;
 
     return 0;
 }
-- 
2.7.4
