Received: from eggs.gnu.org ([2001:4830:134:3::10]:50078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eaucd-0003kJ-My
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 21:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eauca-0002uz-Lt
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 21:35:39 -0500
Received: from ozlabs.ru ([107.173.13.209]:52058)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eauca-0002sY-FX
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 21:35:36 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 15 Jan 2018 13:35:01 +1100
Message-Id: <20180115023501.37361-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] configure: Allow capstone=git only if git
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

Even with --disable-git-update, ./configure tries updating the capstone
submodule instead of marking it "no"; this disables capstone submodule
if git update is disabled.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 89bd662..92c21b3 100755
--- a/configure
+++ b/configure
@@ -4502,7 +4502,7 @@ case "$capstone" in
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
