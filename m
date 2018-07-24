Received: from eggs.gnu.org ([2001:4830:134:3::10]:60180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuf-00011m-0L
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuub-0006YE-6z
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuua-0006Y3-Vt
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id r16-v6so3637677wrt.11
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:24 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:51:01 +0100
Message-Id: <20180724105109.8392-10-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/17] docker: add test-unit runner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This test doesn't even build QEMU, it just builds and runs all the
unit tests. Intended to make checking unit tests on all docker images
easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
