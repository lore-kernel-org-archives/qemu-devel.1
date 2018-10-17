Received: from eggs.gnu.org ([2001:4830:134:3::10]:53506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCiiC-000617-6x
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gCii6-0002CY-MJ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gCii6-00014u-CX
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:50 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 17 Oct 2018 12:04:59 +0200
Message-Id: <1539770707-7289-8-git-send-email-thuth@redhat.com>
In-Reply-To: <1539770707-7289-1-git-send-email-thuth@redhat.com>
References: <1539770707-7289-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 07/15] archive-source.sh: Modern shell scripting
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
 scripts/archive-source.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 4e63774..62bd225 100755
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
1.8.3.1
