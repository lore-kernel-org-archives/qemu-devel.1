Received: from eggs.gnu.org ([2001:4830:134:3::10]:50179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp42i-00052a-1M
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp42d-0003Qy-Ji
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp42d-0003Qo-EH
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 10:56:13 +0800
Message-Id: <20170905025614.579-6-famz@redhat.com>
In-Reply-To: <20170905025614.579-1-famz@redhat.com>
References: <20170905025614.579-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/6] docker: Add test-block
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

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/test-block | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tests/docker/test-block

diff --git a/tests/docker/test-block b/tests/docker/test-block
new file mode 100755
index 0000000000..64d8bbadf7
--- /dev/null
+++ b/tests/docker/test-block
@@ -0,0 +1,22 @@
+#!/bin/bash
+#
+# Run block test cases
+#
+# Copyright 2017 Red Hat Inc.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or (at your option) any later version. See the COPYING file in
+# the top-level directory.
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
