Received: from eggs.gnu.org ([2001:4830:134:3::10]:58092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7Go1-0001Pd-FG
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7Gny-000722-DK
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:40:37 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:20 +0300
Message-Id: <f07f38c6c149a7d63855666d2d265eb54e19e7c1.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 17/23] scripts/qemu-binfmt-conf.sh: Fix shell
 portability issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Kamil Rytarowski <n54@gmx.com>

Appease pkgsrc and use portable shell variable comparison.
This switches "==" to "=". It should not be a functional change.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 scripts/qemu-binfmt-conf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 0f1aa63872..8afc3eb5bb 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -284,12 +284,12 @@ while true ; do
         shift
         # check given cpu is in the supported CPU list
         for cpu in ${qemu_target_list} ; do
-            if [ "$cpu" == "$1" ] ; then
+            if [ "$cpu" = "$1" ] ; then
                 break
             fi
         done
 
-        if [ "$cpu" == "$1" ] ; then
+        if [ "$cpu" = "$1" ] ; then
             qemu_target_list="$1"
         else
             echo "ERROR: unknown CPU \"$1\"" 1>&2
-- 
2.11.0
