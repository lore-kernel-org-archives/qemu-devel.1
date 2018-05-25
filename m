Received: from eggs.gnu.org ([2001:4830:134:3::10]:44315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDYo-0000qA-9c
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:19:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDYn-0000L7-Ci
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:19:14 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fMDYn-0000KZ-6G
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:19:13 -0400
Received: by mail-wr0-x244.google.com with SMTP id 94-v6so9544422wrf.5
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:19:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 May 2018 15:19:02 +0100
Message-Id: <20180525141903.6257-7-alex.bennee@linaro.org>
In-Reply-To: <20180525141903.6257-1-alex.bennee@linaro.org>
References: <20180525133851.27161-1-alex.bennee@linaro.org>
	<20180525141903.6257-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 28/49] tests/tcg: enable building for AArch64
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v4
  - update MAINTAINERS
---
 MAINTAINERS                        | 1 +
 tests/tcg/aarch64/Makefile.include | 8 ++++++++
 2 files changed, 9 insertions(+)
 create mode 100644 tests/tcg/aarch64/Makefile.include

diff --git a/MAINTAINERS b/MAINTAINERS
index e8abe172f5..ec385a15df 100644
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
