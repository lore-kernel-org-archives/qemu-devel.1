Received: from eggs.gnu.org ([2001:4830:134:3::10]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp42R-0004sR-0q
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp42M-0003Kc-Ju
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp42M-0003Jn-Dr
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:26 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 10:56:09 +0800
Message-Id: <20170905025614.579-2-famz@redhat.com>
In-Reply-To: <20170905025614.579-1-famz@redhat.com>
References: <20170905025614.579-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/6] docker: Fix return code of build_qemu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, kchamart@redhat.com, eblake@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Without "set -e", the "&&" makes sure that the return code reflects the
result status, and that make only runs if configure succeeds.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/common.rc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 6865689bb5..c22d825b16 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -33,6 +33,5 @@ build_qemu()
                  $@"
     echo "Configure options:"
     echo $config_opts
-    $QEMU_SRC/configure $config_opts
-    make $MAKEFLAGS
+    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
 }
-- 
2.13.5
