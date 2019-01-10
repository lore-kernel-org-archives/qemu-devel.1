Received: from eggs.gnu.org ([209.51.188.92]:36367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheXj-0004Sa-35
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gheXi-00019n-9k
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:54:59 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gheXi-00018Z-3j
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:54:58 -0500
Received: by mail-wr1-x442.google.com with SMTP id p4so12401936wrt.7
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:54:58 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 Jan 2019 17:45:12 +0000
Message-Id: <20190110174516.21586-16-alex.bennee@linaro.org>
In-Reply-To: <20190110174516.21586-1-alex.bennee@linaro.org>
References: <20190110174516.21586-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 15/19] travis: remove matrix settings that
 duplicate global settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Daniel P. Berrangé <berrange@redhat.com>

The global defaults request "trusty" and "gcc", so matrix entries do not
need to repeat this.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 39dbda7a0b..79da3a495a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -128,39 +128,33 @@ matrix:
         - CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
-      compiler: gcc
 
 
     # We manually include builds which we disable "make check" for
     - env:
         - CONFIG="--enable-debug --enable-tcg-interpreter"
         - TEST_CMD=""
-      compiler: gcc
 
 
     # We don't need to exercise every backend with every front-end
     - env:
         - CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
         - TEST_CMD=""
-      compiler: gcc
 
 
     - env:
         - CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
         - TEST_CMD=""
-      compiler: gcc
 
 
     - env:
         - CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
         - TEST_CMD=""
-      compiler: gcc
 
 
     - env:
         - CONFIG="--disable-tcg"
         - TEST_CMD=""
-      compiler: gcc
 
 
     # MacOSX builds
@@ -251,5 +245,3 @@ matrix:
     - env:
         - CONFIG="--disable-system --disable-docs"
         - TEST_CMD="make -j3 check-tcg V=1"
-      dist: trusty
-      compiler: gcc
-- 
2.17.1
