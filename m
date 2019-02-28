Received: from eggs.gnu.org ([209.51.188.92]:52551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gzDQ2-0005wg-LE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 23:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gzDQ1-0002d7-W3
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 23:35:38 -0500
Received: from ozlabs.ru ([107.173.13.209]:51527)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gzDQ1-0002b6-Pq
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 23:35:37 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 28 Feb 2019 15:35:03 +1100
Message-Id: <20190228043503.68494-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] configure: Enable werror for git worktrees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>

The configure script checks multiple times whether it works in a git
repository and it does this by "test -e "${source_path}/.git" in 4 cases
but in one case where it tries to enable werror "-d" is used there which
fails on git worktrees as .git is a file then and not a directory.

This changes the test to "-e" as other occurrences.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 05d72f1..f481ff9 100755
--- a/configure
+++ b/configure
@@ -1835,7 +1835,7 @@ fi
 # Consult white-list to determine whether to enable werror
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
-    if test -d "$source_path/.git" && \
+    if test -e "$source_path/.git" && \
         { test "$linux" = "yes" || test "$mingw32" = "yes"; }; then
         werror="yes"
     else
-- 
2.17.1
