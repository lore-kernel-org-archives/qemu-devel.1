Received: from eggs.gnu.org ([2001:4830:134:3::10]:54327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ecTyw-0004zQ-Mk
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ecTyt-00056y-Ir
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 05:33:10 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Fri, 19 Jan 2018 11:32:33 +0100
Message-Id: <20180119103233.26075-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] build: fix typo in error message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P . Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 scripts/git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index bc7224a27f..807ca0b4f8 100755
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
2.14.3
