Received: from eggs.gnu.org ([2001:4830:134:3::10]:54646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnNYI-0004l3-OI
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnNYH-0006PU-Pk
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnNYH-0006PJ-K5
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 07:22:25 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 31 Aug 2017 19:22:10 +0800
Message-Id: <20170831112210.19921-4-famz@redhat.com>
In-Reply-To: <20170831112210.19921-1-famz@redhat.com>
References: <20170831112210.19921-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
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

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/test-block | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tests/docker/test-block

diff --git a/tests/docker/test-block b/tests/docker/test-block
new file mode 100755
index 0000000000..20ef70538f
--- /dev/null
+++ b/tests/docker/test-block
@@ -0,0 +1,21 @@
+#!/bin/bash -e
+#
+# Run block test cases
+#
+# Copyright (c) 2017 Red Hat Inc.
+#
+# Authors:
+#  Fam Zheng <famz@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or (at your option) any later version. See the COPYING file in
+# the top-level directory.
+
+. common.rc
+
+cd "$BUILD_DIR"
+
+build_qemu --target-list=x86_64-softmmu
+cd tests/qemu-iotests
+./check -raw
+./check -qcow2
-- 
2.13.5
