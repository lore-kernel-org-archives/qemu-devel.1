Received: from eggs.gnu.org ([2001:4830:134:3::10]:57390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx1I-0004p7-DO
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdx1G-0003q6-0X
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:56 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:53801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdx1F-0003ol-QD
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:17:53 -0400
Received: by mail-wm0-x242.google.com with SMTP id s9-v6so1304801wmh.3
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 05:17:53 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Jul 2018 13:17:35 +0100
Message-Id: <20180713121741.19262-11-alex.bennee@linaro.org>
In-Reply-To: <20180713121741.19262-1-alex.bennee@linaro.org>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 for 3.0 10/16] docker: add test-unit runner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This test doesn't even build QEMU, it just builds and runs all the
unit tests. Intended to make checking unit tests on all docker images
easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - make script -e to error out on failure
  - add comment as to why the configure step is run
---
 tests/docker/test-unit | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 tests/docker/test-unit

diff --git a/tests/docker/test-unit b/tests/docker/test-unit
new file mode 100755
index 0000000000..8905d01150
--- /dev/null
+++ b/tests/docker/test-unit
@@ -0,0 +1,21 @@
+#!/bin/bash -e
+#
+# Build and run the unit tests
+#
+# Copyright (c) 2018 Linaro Ltd.
+#
+# Authors:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or (at your option) any later version. See the COPYING file in
+# the top-level directory.
+
+. common.rc
+
+cd "$BUILD_DIR"
+
+# although we are not building QEMU itself we still need a configured
+# build for the unit tests to be built and run
+configure_qemu
+check_qemu check-unit
-- 
2.17.1
