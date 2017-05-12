Received: from eggs.gnu.org ([2001:4830:134:3::10]:54645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zVn-0004mn-AS
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zVl-0007BS-DF
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:36:55 -0400
Received: from [59.151.112.132] (port=25371 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zVl-00074l-0Q
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:36:53 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:35:53 +0800
Message-ID: <1494552955-30529-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494552955-30529-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494552955-30529-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] net/filter-mirror.c: Remove duplicate
 check code.
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

The s->outdev have checked in filter_mirror_set_outdev().

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/filter-mirror.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 72fa7c2..fd0322f 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -194,12 +194,6 @@ static void filter_mirror_setup(NetFilterState *nf, Error **errp)
     MirrorState *s = FILTER_MIRROR(nf);
     Chardev *chr;
 
-    if (!s->outdev) {
-        error_setg(errp, "filter mirror needs 'outdev' "
-                   "property set");
-        return;
-    }
-
     chr = qemu_chr_find(s->outdev);
     if (chr == NULL) {
         error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
-- 
2.7.4
