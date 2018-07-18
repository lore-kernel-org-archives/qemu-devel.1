Received: from eggs.gnu.org ([2001:4830:134:3::10]:55484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKi-0003Js-FM
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffjKf-0001A7-SM
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffjKf-00019D-C2
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:05:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id h10-v6so4044365wre.6
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 03:05:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 18 Jul 2018 11:05:05 +0100
Message-Id: <20180718100505.7546-11-alex.bennee@linaro.org>
In-Reply-To: <20180718100505.7546-1-alex.bennee@linaro.org>
References: <20180718100505.7546-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH RFC 10/10] tests/tcg:
 debian-mips64el-user-cross fallback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <aleksandar.markovic@mips.com>

When we can't use the debian-mips64el-cross to build our tests we can
use the user-cross fallback.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/mips/Makefile.include | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/tcg/mips/Makefile.include b/tests/tcg/mips/Makefile.include
index 4a14fc078d..cc82e586fd 100644
--- a/tests/tcg/mips/Makefile.include
+++ b/tests/tcg/mips/Makefile.include
@@ -6,8 +6,13 @@
 #
 
 ifeq ($(TARGET_NAME),mips64el)
+ifneq ($(ARCH),x86_64)
+DOCKER_IMAGE=debian-mips64el-user-cross
+DOCKER_CROSS_COMPILER=gcc
+else
 DOCKER_IMAGE=debian-mips64el-cross
 DOCKER_CROSS_COMPILER=mips64el-linux-gnuabi64-gcc
+endif
 else ifeq ($(TARGET_NAME),mips64)
 DOCKER_IMAGE=debian-mips64-cross
 DOCKER_CROSS_COMPILER=mips64-linux-gnuabi64-gcc
-- 
2.17.1
