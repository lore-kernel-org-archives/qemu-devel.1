Received: from eggs.gnu.org ([2001:4830:134:3::10]:54751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vapier@gentoo.org>) id 1eJNXZ-0004nQ-P9
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 12:49:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vapier@gentoo.org>) id 1eJNXW-0008TG-O2
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 12:49:57 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:44462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vapier@gentoo.org>) id 1eJNXW-0008Sp-IF
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 12:49:54 -0500
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 27 Nov 2017 12:49:44 -0500
Message-Id: <20171127174944.12362-1-vapier@gentoo.org>
Subject: [Qemu-devel] [PATCH] build: fix typo in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 scripts/git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index 030617b4ac0c..bc7224a27fe3 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -24,7 +24,7 @@ error() {
     echo "Alternatively you may disable automatic GIT submodule checkout"
     echo "with:"
     echo
-    echo " $ ./configure --disable-git-update'"
+    echo " $ ./configure --disable-git-update"
     echo
     echo "and then manually update submodules prior to running make, with:"
     echo
-- 
2.12.0
