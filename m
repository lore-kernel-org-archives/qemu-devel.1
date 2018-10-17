Received: from eggs.gnu.org ([2001:4830:134:3::10]:53452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiiA-0005yO-DG
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii6-0002DT-VX
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCii6-0001B4-Jx
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:50 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:05:01 +0200
Message-Id: <1539770707-7289-10-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 09/15] show-fixed-bugs.sh: Modern shell
 scripting (use $() instead of ``)
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
 scripts/show-fixed-bugs.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/show-fixed-bugs.sh b/scripts/show-fixed-bugs.sh
index 36f3068..a095a4d 100755
--- a/scripts/show-fixed-bugs.sh
+++ b/scripts/show-fixed-bugs.sh
@@ -23,10 +23,10 @@ while getopts "s:e:cbh" opt; do
 done
 
 if [ "x$start" = "x" ]; then
-    start=`git tag -l 'v[0-9]*\.[0-9]*\.0' | tail -n 2 | head -n 1`
+    start=$(git tag -l 'v[0-9]*\.[0-9]*\.0' | tail -n 2 | head -n 1)
 fi
 if [ "x$end" = "x" ]; then
-    end=`git tag -l  'v[0-9]*\.[0-9]*\.0' | tail -n 1`
+    end=$(git tag -l  'v[0-9]*\.[0-9]*\.0' | tail -n 1)
 fi
 
 if [ "x$start" = "x" ] || [ "x$end" = "x" ]; then
@@ -38,9 +38,9 @@ fi
 echo "Searching git log for bugs in the range $start..$end"
 
 urlstr='https://bugs.launchpad.net/\(bugs\|qemu/+bug\)/'
-bug_urls=`git log $start..$end \
+bug_urls=$(git log $start..$end \
   | sed -n '\,'"$urlstr"', s,\(.*\)\('"$urlstr"'\)\([0-9]*\).*,\2\4,p' \
-  | sort -u`
+  | sort -u)
 
 echo Found bug URLs:
 for i in $bug_urls ; do echo " $i" ; done
@@ -68,7 +68,7 @@ elif [ "x$show_in_browser" = "x1" ]; then
         bugbrowser=xdg-open
     elif command -v gnome-open >/dev/null 2>&1; then
         bugbrowser=gnome-open
-    elif [ "`uname`" = "Darwin" ]; then
+    elif [ "$(uname)" = "Darwin" ]; then
         bugbrowser=open
     elif command -v sensible-browser >/dev/null 2>&1; then
         bugbrowser=sensible-browser
-- 
1.8.3.1
