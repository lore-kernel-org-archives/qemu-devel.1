Received: from eggs.gnu.org ([2001:4830:134:3::10]:46696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eF9yt-0002UZ-PZ
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:32:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eF9yq-0001mm-MR
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:32:43 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:32595
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eF9yq-0001ky-BV
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 21:32:40 -0500
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Thu, 16 Nov 2017 10:28:32 +0800
Message-ID: <20171116022832.24894-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] colo-compare: fix the dangerous assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 8ec14402029d783720f4312ed8a925548e1dad61
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
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
2.9.4
