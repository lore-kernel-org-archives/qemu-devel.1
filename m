Received: from eggs.gnu.org ([2001:4830:134:3::10]:46770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z7A-0000JZ-Qo
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z79-0006QP-V1
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:36 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:52524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z79-0006Pl-Nv
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:35 -0400
Received: by mail-wm0-x243.google.com with SMTP id g8so28362596wmd.2
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:13 +0100
Message-Id: <20180410193919.28026-19-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 18/24] tests/tcg/arm: fix hello-arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As hello-arm is a bare bones syscall test it needs specific compiler
flags so it doesn't try and link against glibc.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/Makefile.target | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 tests/tcg/arm/Makefile.target

diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
new file mode 100644
index 0000000000..b7c146c88e
--- /dev/null
+++ b/tests/tcg/arm/Makefile.target
@@ -0,0 +1,6 @@
+# -*- Mode: makefile -*-
+#
+# ARM specific tweaks
+
+hello-arm: CFLAGS+=-marm -ffreestanding
+hello-arm: LDFLAGS+=-nostdlib
-- 
2.16.2
