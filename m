Received: from eggs.gnu.org ([2001:4830:134:3::10]:60335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQHT-0007JT-LV
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQHQ-0003HJ-Aq
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 03:13:07 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:55:03 +0300
Message-Id: <123ac0bba97597ae79915c4691b95515b60f00e7.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
References: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 08/17] configure: Allow capstone=git only if git
 update is not disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

Even with --disable-git-update, ./configure tries updating the capstone
submodule instead of marking it "no"; this disables capstone submodule
if git update is disabled.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 62562f08cf..c1bbf17559 100755
--- a/configure
+++ b/configure
@@ -4568,7 +4568,7 @@ case "$capstone" in
   "" | yes)
     if $pkg_config capstone; then
       capstone=system
-    elif test -e "${source_path}/.git" ; then
+    elif test -e "${source_path}/.git" -a $git_update = 'yes' ; then
       capstone=git
     elif test -e "${source_path}/capstone/Makefile" ; then
       capstone=internal
-- 
2.11.0
