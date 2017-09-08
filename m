Received: from eggs.gnu.org ([2001:4830:134:3::10]:41837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG0w-00086P-Gu
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG0r-0004ny-Vv
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG0r-0004nS-PJ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:49 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:54:48 +0800
Message-Id: <20170908095506.13594-21-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 20/38] docker: Fix return code of build_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Without "set -e", the "&&" makes sure that the return code reflects the
result status, and that make only runs if configure succeeds.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170905025614.579-2-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Based-on: 20170905021201.25684-1-famz@redhat.com
---
 tests/docker/common.rc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 64b36ba2d0..3b45eb91c6 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -30,6 +30,5 @@ build_qemu()
                  $@"
     echo "Configure options:"
     echo $config_opts
-    $QEMU_SRC/configure $config_opts
-    make $MAKEFLAGS
+    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
 }
-- 
2.13.5
