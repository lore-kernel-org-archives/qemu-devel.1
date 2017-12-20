Received: from eggs.gnu.org ([2001:4830:134:3::10]:38824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1eRbHl-00074A-Cc
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:07:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1eRbHh-0003e5-4C
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:07:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2124 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sochin.jiang@huawei.com>)
	id 1eRbHg-0003VH-Ob
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:07:33 -0500
From: sochin.jiang <sochin.jiang@huawei.com>
Date: Wed, 20 Dec 2017 18:06:41 +0800
Message-ID: <1513764401-24239-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH]  scripts: correct a spelling error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, sochin.jiang@huawei.com, eric.fangyi@huawei.com

From: "sochin.jiang" <sochin.jiang@huawei.com>

 Correct a spelling error in prompt message.

Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
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
1.8.3.1
