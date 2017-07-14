Received: from eggs.gnu.org ([2001:4830:134:3::10]:33602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dVylX-0004ab-FK
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dVylU-0000KN-CP
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:28:11 -0400
Received: from m15-112.126.com ([220.181.15.112]:47052)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dVylT-0000II-NG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:28:08 -0400
From: indiffPig@126.com
Date: Fri, 14 Jul 2017 07:27:57 -0400
Message-Id: <1500031677-2362-1-git-send-email-indiffPig@126.com>
Subject: [Qemu-devel] [PATCH] dvs services stop then qemu may be accesse
 null address case core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, "yin.zuowei" <indiffPig@126.com>

From: "yin.zuowei" <indiffPig@126.com>

Signed-off-by: yin.zuowei <indiffPig@126.com>
---
 chardev/char-fe.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 3f90f05..82f7e2b 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -353,7 +353,13 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondition cond,
 
 void qemu_chr_fe_disconnect(CharBackend *be)
 {
-    Chardev *chr = be->chr;
+    Chardev *chr = NULL;
+
+    if (be) {
+        chr = be->chr;
+    } else {
+        return ;
+    }
 
     if (chr && CHARDEV_GET_CLASS(chr)->chr_disconnect) {
         CHARDEV_GET_CLASS(chr)->chr_disconnect(chr);
-- 
1.8.3.1
