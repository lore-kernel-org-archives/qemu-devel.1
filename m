Received: from eggs.gnu.org ([2001:4830:134:3::10]:59730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Tqe-0007Tn-Fz
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Tqd-0007tb-5V
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:24:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d6Tqc-0007tJ-Vh
	for qemu-devel@nongnu.org; Thu, 04 May 2017 23:24:03 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  5 May 2017 11:23:40 +0800
Message-Id: <20170505032340.26467-6-famz@redhat.com>
In-Reply-To: <20170505032340.26467-1-famz@redhat.com>
References: <20170505032340.26467-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/test-block | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tests/docker/test-block

diff --git a/tests/docker/test-block b/tests/docker/test-block
new file mode 100755
index 0000000..20ef705
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
2.9.3
