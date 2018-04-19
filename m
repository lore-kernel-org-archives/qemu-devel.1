Received: from eggs.gnu.org ([2001:4830:134:3::10]:52805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANX-0004mU-FQ
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ANR-00067W-Vd
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:38 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:42545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ANR-00066e-PA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:17:33 -0400
Received: by mail-wr0-x244.google.com with SMTP id s18-v6so14504737wrg.9
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:17:33 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:43 +0100
Message-Id: <20180419135901.30035-26-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 25/43] tests/tcg: move ARM specific tests
 into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

These only need to be built for ARM guests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2
  - do VPATH manipulation in tests/tcg/arm/Makefile.target
  - merge with fix hello-arm test
---
 tests/tcg/README                      |  9 ---------
 tests/tcg/arm/Makefile.target         | 13 +++++++++++++
 tests/tcg/arm/README                  | 11 +++++++++++
 tests/tcg/{ => arm}/hello-arm.c       |  0
 tests/tcg/{ => arm}/test-arm-iwmmxt.s |  0
 5 files changed, 24 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/arm/Makefile.target
 create mode 100644 tests/tcg/arm/README
 rename tests/tcg/{ => arm}/hello-arm.c (100%)
 rename tests/tcg/{ => arm}/test-arm-iwmmxt.s (100%)

diff --git a/tests/tcg/README b/tests/tcg/README
index 469504c4cb..625f2326e6 100644
--- a/tests/tcg/README
+++ b/tests/tcg/README
@@ -5,15 +5,6 @@ or they are architecture specific.
 
 
 
-ARM
-===
-
-hello-arm
----------
-
-test-arm-iwmmxt
----------------
-
 MIPS
 ====
 
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
new file mode 100644
index 0000000000..bc6962ecc6
--- /dev/null
+++ b/tests/tcg/arm/Makefile.target
@@ -0,0 +1,13 @@
+# -*- Mode: makefile -*-
+#
+# ARM - included from tests/tcg/Makefile.target
+#
+
+ARM_SRC=$(SRC_PATH)/tests/tcg/arm
+
+# Set search path for all sources
+VPATH 		+= $(ARM_SRC)
+
+
+hello-arm: CFLAGS+=-marm -ffreestanding
+hello-arm: LDFLAGS+=-nostdlib
diff --git a/tests/tcg/arm/README b/tests/tcg/arm/README
new file mode 100644
index 0000000000..e6307116e2
--- /dev/null
+++ b/tests/tcg/arm/README
@@ -0,0 +1,11 @@
+These are ARM specific guest programs
+
+hello-arm
+---------
+
+A very simple inline assembly, write syscall based hello world
+
+test-arm-iwmmxt
+---------------
+
+A simple test case for older iwmmxt extended ARMs
diff --git a/tests/tcg/hello-arm.c b/tests/tcg/arm/hello-arm.c
similarity index 100%
rename from tests/tcg/hello-arm.c
rename to tests/tcg/arm/hello-arm.c
diff --git a/tests/tcg/test-arm-iwmmxt.s b/tests/tcg/arm/test-arm-iwmmxt.s
similarity index 100%
rename from tests/tcg/test-arm-iwmmxt.s
rename to tests/tcg/arm/test-arm-iwmmxt.s
-- 
2.17.0
