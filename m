Received: from eggs.gnu.org ([2001:4830:134:3::10]:56291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5X1n-0003Fz-FP
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e5X1k-0001hu-QR
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:07:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e5X1k-0001hR-KS
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:07:52 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 20 Oct 2017 14:07:48 +0100
Message-Id: <20171020130748.22983-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] scripts: don't throw away stderr when checking
 out git submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The stderr from git is important if git fails to checkout modules
due to network problems, or other unexpected errors.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/git-submodule.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/git-submodule.sh b/scripts/git-submodule.sh
index d8fbc7e47e..08932a35f0 100755
--- a/scripts/git-submodule.sh
+++ b/scripts/git-submodule.sh
@@ -32,7 +32,7 @@ status)
     exit $?
     ;;
 update)
-    git submodule update --init $modules 1>/dev/null 2>&1
+    git submodule update --init $modules 1>/dev/null
     git submodule status $modules > "${substat}"
     ;;
 esac
-- 
2.13.6
