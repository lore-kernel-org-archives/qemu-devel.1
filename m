Received: from eggs.gnu.org ([2001:4830:134:3::10]:58120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwncZ-00025T-4t
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dwncT-0007Dl-N6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:01:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dwncT-0007DW-GB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:01:41 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 26 Sep 2017 19:01:34 +0800
Message-Id: <20170926110134.2786-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] docker: test-block: Don't continue if build
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Report error and exit upon compiling error, otherwise the iotests output
will be pure noise.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/test-block | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/test-block b/tests/docker/test-block
index 2ca1ce54f6..5624b81827 100755
--- a/tests/docker/test-block
+++ b/tests/docker/test-block
@@ -14,7 +14,7 @@
 
 cd "$BUILD_DIR"
 
-build_qemu --target-list=x86_64-softmmu
+build_qemu --target-list=x86_64-softmmu || test_fail "Build failed"
 cd tests/qemu-iotests
 for t in raw qcow2 nbd luks; do
     ./check -g quick -$t || test_fail "Test failed: iotests $t"
-- 
2.13.5
