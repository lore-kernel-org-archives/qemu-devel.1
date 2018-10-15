Received: from eggs.gnu.org ([2001:4830:134:3::10]:55641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBz0w-0003O3-Jk
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBz0t-00008r-Qy
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:18:14 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:20665)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBz0t-0008R9-6d
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 05:18:11 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 15 Oct 2018 17:17:35 +0800
Message-Id: <20181015091736.14997-2-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181015091736.14997-1-maozhongyi@cmss.chinamobile.com>
References: <20181015091736.14997-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v2 2/3] git-submodule.sh: Modern shell
 scripting (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, thuth@redhat.com, Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Various shell files contain a mix between obsolete ``
and modern $(); It would be nice to convert to using $()
everywhere.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 scripts/git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 807ca0b4f8..98ca0f2737 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -59,8 +59,8 @@ status)
     fi
 
     test -f "$substat" || exit 1
-    CURSTATUS=`$GIT submodule status $modules`
-    OLDSTATUS=`cat $substat`
+    CURSTATUS=$($GIT submodule status $modules)
+    OLDSTATUS=$(cat $substat)
     test "$CURSTATUS" = "$OLDSTATUS"
     exit $?
     ;;
-- 
2.17.1
