Received: from eggs.gnu.org ([2001:4830:134:3::10]:42790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5n-00067O-US
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5n-0002XI-4g
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:20 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34142)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9A5m-0002T7-ME
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:19 -0400
Received: by mail-wr0-x241.google.com with SMTP id d19-v6so14369181wre.1
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:59:18 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:35 +0100
Message-Id: <20180419135901.30035-18-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 17/43] tests/tcg: enable building for i386
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

While you can construct a compile command that does work using the
x86_64 host compiler that most people use this is flakey. Different
distros handle this is different ways so we default to using a known
good i386 compiler via docker.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.include | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 tests/tcg/i386/Makefile.include

diff --git a/tests/tcg/i386/Makefile.include b/tests/tcg/i386/Makefile.include
new file mode 100644
index 0000000000..be1c3008dd
--- /dev/null
+++ b/tests/tcg/i386/Makefile.include
@@ -0,0 +1,9 @@
+#
+# Makefile.include for all i386
+#
+# There is enough brokeness in x86_64 compilers that we don't default
+# to using the x86_64 system compiler for i386 binaries.
+#
+
+DOCKER_IMAGE=fedora-i386-cross
+DOCKER_CROSS_COMPILER=gcc
-- 
2.17.0
