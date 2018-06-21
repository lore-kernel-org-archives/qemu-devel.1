Received: from eggs.gnu.org ([2001:4830:134:3::10]:56885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtID-00051y-Qf
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtIC-0003RI-Sw
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:05 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVtIC-0003Qe-Ml
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:42:04 -0400
Received: by mail-wm0-x242.google.com with SMTP id r15-v6so3187933wmc.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:42:04 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:39 +0100
Message-Id: <20180621062605.941-32-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 31/57] tests/tcg/mips: include common mips
 hello-mips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Yongbok Kim <yongbok.kim@mips.com>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
new file mode 100644
index 0000000000..71f0c2dd53
--- /dev/null
+++ b/tests/tcg/mips/Makefile.target
@@ -0,0 +1,19 @@
+# -*- Mode: makefile -*-
+#
+# MIPS - included from tests/tcg/Makefile.target
+#
+
+MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
+
+# Set search path for all sources
+VPATH 		+= $(MIPS_SRC)
+
+MIPS_TESTS=hello-mips
+
+TESTS += $(MIPS_TESTS)
+
+hello-mips: CFLAGS+=-ffreestanding
+hello-mips: LDFLAGS+=-nostdlib
+
+# For MIPS32 and 64 we have a bunch of extra tests in sub-directories
+# however they are intended for system tests.
-- 
2.17.1
