Received: from eggs.gnu.org ([2001:4830:134:3::10]:55253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9XLW-00036D-Bu
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9XLH-0006pJ-VB
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:21:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9XLH-0006oO-BT
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:21:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id a8-v6so8663434wmf.1
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 08:21:07 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  8 Oct 2018 16:20:58 +0100
Message-Id: <20181008152059.17503-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] .travis.yml: split MacOSX builds and reduce
 target list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

We have reached the point where the MacOSX build was regularly timing
out. So as before I've reduced the target list to "major"
architectures to try and bring the build time down. I've added an
additional MacOSX build with the latest XCode with a minimal list of
"most likely" targets on MacOS.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .travis.yml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 95be6ec59f..13a09facd3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -107,8 +107,14 @@ matrix:
     - env: CONFIG="--disable-tcg"
            TEST_CMD=""
       compiler: gcc
-    - env: CONFIG=""
+    # MacOSX builds
+    - env: CONFIG="--target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
       os: osx
+      osx_image: xcode9.4
+      compiler: clang
+    - env: CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
+      os: osx
+      osx_image: xcode10
       compiler: clang
     # Python builds
     - env: CONFIG="--target-list=x86_64-softmmu"
-- 
2.17.1
