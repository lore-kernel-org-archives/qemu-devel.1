Received: from eggs.gnu.org ([2001:4830:134:3::10]:47545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dGdtN-0002lX-TI
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 00:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dGdtJ-00032U-TQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 00:08:53 -0400
Received: from [59.151.112.132] (port=56405 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quwenruo@cn.fujitsu.com>) id 1dGdtJ-00030I-IA
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 00:08:49 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
	by cn.fujitsu.com (Postfix) with ESMTP id 1BA6D47C6523
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 12:08:42 +0800 (CST)
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Date: Fri, 2 Jun 2017 12:08:38 +0800
Message-ID: <20170602040838.29995-1-quwenruo@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] gitignore: Ignore vim per-project config and
 clang complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since we have already ignored ctags, ignoring .clangcomplete for
vim-clang_completion is quite reasonable for me.
(Not to mention vim-clang_completion provides better and more accurate
completion and definition search)

Also, qemu coding style is using 4 space as indent other than 8-space
tab, it also makes sense to ignore per-project vim config file.

Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
---
 .gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitignore b/.gitignore
index 55a001e3b8..c7c6eec0b6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -113,6 +113,8 @@
 cscope.*
 tags
 TAGS
+.vim*
+.clang_complete
 docker-src.*
 *~
 trace.h
-- 
2.13.0
