Received: from eggs.gnu.org ([2001:4830:134:3::10]:56695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA92F-0005PY-8d
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA92E-0003DB-9v
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:59:11 -0400
Received: from [59.151.112.132] (port=23820 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dA92D-0003CJ-T0
	for qemu-devel@nongnu.org; Mon, 15 May 2017 01:59:10 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Mon, 15 May 2017 13:58:29 +0800
Message-ID: <1494827909-640-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494827909-640-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494827909-640-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V2 3/3] net/filter-rewriter: Remove unused
 option in filter-rewriter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Eric Blake <eblake@redhat.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f806af9..85cf0f5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4038,7 +4038,7 @@ Create a filter-redirector we need to differ outdev id from indev id, id can not
 be the same. we can just use indev or outdev, but at least one of indev or outdev
 need to be specified.
 
-@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},rewriter-mode=@var{mode}[,queue=@var{all|rx|tx}]
+@item -object filter-rewriter,id=@var{id},netdev=@var{netdevid},[,queue=@var{all|rx|tx}]
 
 Filter-rewriter is a part of COLO project.It will rewrite tcp packet to
 secondary from primary to keep secondary tcp connection,and rewrite
-- 
2.7.4
