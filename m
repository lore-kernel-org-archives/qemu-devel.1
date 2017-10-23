Received: from eggs.gnu.org ([2001:4830:134:3::10]:47312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6XhT-0007GM-AE
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6XhP-0006bn-Di
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:03:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6XhP-0006b6-8Z
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:03:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 519B42D0FB3
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 08:03:02 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 10:02:45 +0200
Message-Id: <20171023080245.31300-4-kraxel@redhat.com>
In-Reply-To: <20171023080245.31300-1-kraxel@redhat.com>
References: <20171023080245.31300-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] scripts: don't throw away stderr when
 checking out git submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The stderr from git is important if git fails to checkout modules
due to network problems, or other unexpected errors.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20171020130748.22983-1-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.9.3
