Received: from eggs.gnu.org ([2001:4830:134:3::10]:40653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXyo-0000ui-15
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fcXyj-0005Z5-VA
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:34 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fcXyj-0005YW-OW
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:21:29 -0400
Received: by mail-wm0-x244.google.com with SMTP id h20-v6so5276149wmb.4
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 08:21:29 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  9 Jul 2018 16:21:16 +0100
Message-Id: <20180709152117.21585-10-alex.bennee@linaro.org>
In-Reply-To: <20180709152117.21585-1-alex.bennee@linaro.org>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 3.0 09/10] docker: add test-unit runner
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

This test doesn't even build QEMU, it just runs all the unit tests.
Intended to make checking unit tests on all docker images easier.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/test-unit | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100755 tests/docker/test-unit

diff --git a/tests/docker/test-unit b/tests/docker/test-unit
new file mode 100755
index 0000000000..be0d90d748
--- /dev/null
+++ b/tests/docker/test-unit
@@ -0,0 +1,19 @@
+#!/bin/bash
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
+configure_qemu
+check_qemu check-unit
-- 
2.17.1
