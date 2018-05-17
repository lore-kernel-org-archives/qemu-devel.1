Received: from eggs.gnu.org ([2001:4830:134:3::10]:51019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN0B-0006PK-Cw
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN08-0003bh-8z
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:43 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJN08-0003bD-3V
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:40 -0400
Received: by mail-wr0-x241.google.com with SMTP id p18-v6so6566208wrm.1
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:47:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 May 2018 18:46:59 +0100
Message-Id: <20180517174718.10107-31-alex.bennee@linaro.org>
In-Reply-To: <20180517174718.10107-1-alex.bennee@linaro.org>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 30/49] tests/tcg: enable building for AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

We only have compilers for the (default) little endian variants.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - update MAINTAINERS
---
 MAINTAINERS                        | 1 +
 tests/tcg/aarch64/Makefile.include | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 tests/tcg/aarch64/Makefile.include

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e331c4db4..ee7f101890 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -136,6 +136,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: target/arm/
 F: tests/tcg/arm/
+F: tests/tcg/aarch64/
 F: hw/arm/
 F: hw/cpu/a*mpcore.c
 F: include/hw/cpu/a*mpcore.h
diff --git a/tests/tcg/aarch64/Makefile.include b/tests/tcg/aarch64/Makefile.include
new file mode 100644
index 0000000000..de32c91235
--- /dev/null
+++ b/tests/tcg/aarch64/Makefile.include
@@ -0,0 +1,8 @@
+# Makefile.include for AArch64 targets
+#
+# We don't have any bigendian build tools so we only use this for AArch64
+
+ifeq ($(TARGET_NAME),aarch64)
+DOCKER_IMAGE=debian-arm64-cross
+DOCKER_CROSS_COMPILER=aarch64-linux-gnu-gcc
+endif
-- 
2.17.0
