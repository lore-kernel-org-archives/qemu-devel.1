Received: from eggs.gnu.org ([2001:4830:134:3::10]:44490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1eRDDg-0000dW-Gn
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1eRDDd-0003Jl-DV
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:25:48 -0500
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:38917)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1eRDDd-0003Gq-73
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:25:45 -0500
From: Lin Ma <lma@suse.com>
Date: Tue, 19 Dec 2017 16:25:18 +0800
Message-Id: <20171219082518.19724-1-lma@suse.com>
Subject: [Qemu-devel]  [PATCH] build: Fix typo in scripts/git-submodule.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Lin Ma <lma@suse.com>
---
 scripts/git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index bc7224a..807ca0b 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -28,7 +28,7 @@ error() {
     echo
     echo "and then manually update submodules prior to running make, with:"
     echo
-    echo " $ scripts/git-sbumodule.sh update $modules"
+    echo " $ scripts/git-submodule.sh update $modules"
     echo
     exit 1
 }
-- 
2.9.2
