Received: from eggs.gnu.org ([2001:4830:134:3::10]:53461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiiA-0005yT-Eg
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii7-0002Ea-7k
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCii6-000174-MC
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:51 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:05:00 +0200
Message-Id: <1539770707-7289-9-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 08/15] git-submodule.sh: Modern shell scripting
 (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Various shell files contain a mix between obsolete ``
and modern $(); It would be nice to convert to using $()
everywhere.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 807ca0b..98ca0f2 100755
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
1.8.3.1
