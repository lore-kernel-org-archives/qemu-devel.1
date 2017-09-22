Received: from eggs.gnu.org ([2001:4830:134:3::10]:37693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgL-000868-Fj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgK-0000xx-P0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIgK-0000xf-Im
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:47:28 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:35 +0800
Message-Id: <20170922074659.30097-13-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 12/36] docker: Add test-block
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
