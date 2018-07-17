Received: from eggs.gnu.org ([2001:4830:134:3::10]:40914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4s-00033u-4v
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4r-0004iT-86
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35307)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffW4r-0004hU-1e
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:05 -0400
Received: by mail-wr1-x443.google.com with SMTP id a3-v6so2390104wrt.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:56:04 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:45 +0100
Message-Id: <20180717195553.9111-11-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-1-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 10/18] docker: add test-unit runner
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
