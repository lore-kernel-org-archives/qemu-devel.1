Received: from eggs.gnu.org ([2001:4830:134:3::10]:38635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvD-00042j-6y
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVIvA-0001gI-EB
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:55 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVIv5-0001cR-PW
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:51:52 -0400
Received: by mail-wm0-x243.google.com with SMTP id z6-v6so19402098wma.0
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 08:51:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 19 Jun 2018 16:44:07 +0100
Message-Id: <20180619154435.18898-29-alex.bennee@linaro.org>
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 28/56] tests/tcg: enable building for MIPS
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

This doesn't add any additional tests but enables building the
multiarch tests for MIPS using docker cross compilers. We don't have a
cross compiler for mips64 big endian though.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
2.17.1
