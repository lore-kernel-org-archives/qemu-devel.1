Received: from eggs.gnu.org ([2001:4830:134:3::10]:33906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbe-0006RN-QC
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbe-0006bH-7R
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYbe-0006b4-16
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:47:02 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:46:00 +0800
Message-Id: <20170909054613.19148-25-famz@redhat.com>
In-Reply-To: <20170909054613.19148-1-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v2 24/37] docker: Add test-block
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

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170905025614.579-6-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Based-on: 20170905021201.25684-1-famz@redhat.com
---
 tests/docker/test-block | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tests/docker/test-block

diff --git a/tests/docker/test-block b/tests/docker/test-block
new file mode 100755
index 0000000000..2ca1ce54f6
--- /dev/null
+++ b/tests/docker/test-block
@@ -0,0 +1,21 @@
+#!/bin/bash
+#
+# Run block test cases
+#
+# Copyright 2017 Red Hat Inc.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+
+. ./common.rc
+
+cd "$BUILD_DIR"
+
+build_qemu --target-list=x86_64-softmmu
+cd tests/qemu-iotests
+for t in raw qcow2 nbd luks; do
+    ./check -g quick -$t || test_fail "Test failed: iotests $t"
+done
-- 
2.13.5
