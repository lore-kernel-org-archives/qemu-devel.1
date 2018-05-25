Received: from eggs.gnu.org ([2001:4830:134:3::10]:44347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDYv-0000x5-CX
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMDYu-0000Oc-Gx
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:19:21 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fMDYu-0000OH-Ao
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:19:20 -0400
Received: by mail-wr0-x241.google.com with SMTP id i14-v6so9546257wre.2
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:19:20 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 May 2018 15:19:02 +0100
Message-Id: <20180525141910.6384-2-alex.bennee@linaro.org>
In-Reply-To: <20180525141910.6384-1-alex.bennee@linaro.org>
References: <20180525133851.27161-1-alex.bennee@linaro.org>
	<20180525141910.6384-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 31/49] tests/tcg: enable building for MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Yongbok Kim <yongbok.kim@mips.com>

This doesn't add any additional tests but enables building the
multiarch tests for MIPS using docker cross compilers. We don't have a
cross compiler for mips64 big endian though.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/tcg/mips/Makefile.include | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 tests/tcg/mips/Makefile.include

diff --git a/tests/tcg/mips/Makefile.include b/tests/tcg/mips/Makefile.include
new file mode 100644
index 0000000000..a9beceb623
--- /dev/null
+++ b/tests/tcg/mips/Makefile.include
@@ -0,0 +1,17 @@
+#
+# Makefile.include for all MIPs targets
+#
+# As Debian doesn't support mip64 in big endian mode the only way to
+# build BE is to pass a working cross compiler to ./configure
+#
+
+ifeq ($(TARGET_NAME),mips64el)
+DOCKER_IMAGE=debian-mips64el-cross
+DOCKER_CROSS_COMPILER=mips64el-linux-gnuabi64-gcc
+else ifeq ($(TARGET_NAME),mipsel)
+DOCKER_IMAGE=debian-mipsel-cross
+DOCKER_CROSS_COMPILER=mipsel-linux-gnu-gcc
+else ifeq ($(TARGET_NAME),mips)
+DOCKER_IMAGE=debian-mips-cross
+DOCKER_CROSS_COMPILER=mips-linux-gnu-gcc
+endif
-- 
2.17.0
