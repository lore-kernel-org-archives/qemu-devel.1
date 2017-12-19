Received: from eggs.gnu.org ([2001:4830:134:3::10]:45700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eR7QC-0004e1-07
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 21:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eR7Q7-0004Hi-OI
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 21:14:19 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:59898
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eR7Q7-0004EC-Bc
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 21:14:15 -0500
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Tue, 19 Dec 2017 10:09:21 +0800
Message-ID: <20171219020921.23887-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RESEND PATCH] build: Fix error script name in
 git-submodule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

When I follow the command line prompts to run
"$ scripts/git-sbumodule.sh update  ui/keycodemapdb dtc capstone"

this is what I got:
-bash: ./scripts/git-sbumodule.sh: No such file or directory

Cc: Daniel P. Berrange <berrange@redhat.com>
Fixes: f62bbee55d503f639ee9498878ebf42ff4f4299a
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
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
2.9.4
