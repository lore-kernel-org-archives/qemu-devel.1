Received: from eggs.gnu.org ([2001:4830:134:3::10]:54649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zVn-0004mp-Bc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zVm-0007Bj-Au
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:36:55 -0400
Received: from [59.151.112.132] (port=23931 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zVl-0007BF-Tq
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:36:54 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:35:55 +0800
Message-ID: <1494552955-30529-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494552955-30529-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494552955-30529-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/3] net/filter-rewriter: Remove unused option
 in filter-rewirter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 qemu-options.hx | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 70c0ded..f5e088e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4038,7 +4038,8 @@ Create a filter-redirector we need to differ outdev id from indev id, id can not
 be the same. we can just use indev or outdev, but at least one of indev or outdev
 need to be specified.
 
-@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},rewriter-mode=@var{mode}[,queue=@var{all|rx|tx}]
+@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},
+[,queue=@var{all|rx|tx}]
 
 Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
 secondary from primary to keep secondary tcp connection,and rewrite
-- 
2.7.4
