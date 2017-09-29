Received: from eggs.gnu.org ([2001:4830:134:3::10]:33642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlp5-0007dG-BL
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dxlp4-0002Zm-IX
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dxlp4-0002ZE-DB
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:18:42 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 29 Sep 2017 11:18:30 +0800
Message-Id: <20170929031831.10179-5-famz@redhat.com>
In-Reply-To: <20170929031831.10179-1-famz@redhat.com>
References: <20170929031831.10179-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 4/5] docker: test-block: Don't continue if build
 fails
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
List-ID: <qemu-devel.nongnu.org>

Report error and exit upon compiling error, otherwise the iotests output
will be pure noise.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170926110134.2786-1-famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
