Received: from eggs.gnu.org ([2001:4830:134:3::10]:48476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBwjr-0005IA-4Q
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBwji-0002Mv-10
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:52:24 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:36245)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBwjb-0002IV-87
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:52:11 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 15 Oct 2018 14:51:55 +0800
Message-Id: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 1/3] archive-source.sh: Modern shell scripting
 (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Various shell files contain a mix between obsolete `` and
modern $(); use of `` is only required when using /bin/sh
on Solaris. It would be nice to convert to using $()
everywhere, or at least in all bash scripts, as well as in
all scripts that are known to not be run on Solaris.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 scripts/archive-source.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 4e63774f9a..62bd22578b 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -18,7 +18,7 @@ if test $# -lt 1; then
     error "Usage: $0 <output tarball>"
 fi
 
-tar_file=`realpath "$1"`
+tar_file=$(realpath "$1")
 list_file="${tar_file}.list"
 vroot_dir="${tar_file}.vroot"
 
@@ -34,7 +34,7 @@ if git diff-index --quiet HEAD -- &>/dev/null
 then
     HEAD=HEAD
 else
-    HEAD=`git stash create`
+    HEAD=$(git stash create)
 fi
 git clone --shared . "$vroot_dir"
 test $? -ne 0 && error "failed to clone into '$vroot_dir'"
-- 
2.17.1
