Received: from eggs.gnu.org ([2001:4830:134:3::10]:50143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzoQ-00055A-Fi
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzoP-0005Ql-AV
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dCzoP-0005QJ-5J
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:44:41 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 May 2017 10:43:58 +0800
Message-Id: <1495507439-1784-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
References: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 8/9] net/filter-rewriter: Remove unused option
 in filter-rewriter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f07a310..f63f7dc 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4072,7 +4072,7 @@ Create a filter-redirector we need to differ outdev id from indev id, id can not
 be the same. we can just use indev or outdev, but at least one of indev or outdev
 need to be specified.
 
-@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},rewriter-mode=@var{mode}[,queue=@var{all|rx|tx}]
+@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid}[,queue=@var{all|rx|tx}]
 
 Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
 secondary from primary to keep secondary tcp connection,and rewrite
-- 
2.7.4
