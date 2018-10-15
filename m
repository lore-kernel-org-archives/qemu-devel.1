Received: from eggs.gnu.org ([2001:4830:134:3::10]:48492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBwjs-0005Kb-IA
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBwjj-0002NT-KW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:52:24 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:42117)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gBwjc-0002Hu-2d
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:52:13 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 15 Oct 2018 14:51:56 +0800
Message-Id: <20181015065157.3634-2-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
References: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 2/3] git-submodule.sh: Modern shell scripting
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
 scripts/git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 807ca0b4f8..d452149c1a 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -59,7 +59,7 @@ status)
     fi
 
     test -f "$substat" || exit 1
-    CURSTATUS=`$GIT submodule status $modules`
+    CURSTATUS=$($GIT submodule status $modules)
     OLDSTATUS=`cat $substat`
     test "$CURSTATUS" = "$OLDSTATUS"
     exit $?
-- 
2.17.1
