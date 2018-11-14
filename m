Received: from eggs.gnu.org ([2001:4830:134:3::10]:40468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMuvu-0001K7-P9
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMuvr-0004HF-U9
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:14 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMuvr-0004GO-OL
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:11 -0500
Received: by mail-wr1-x42f.google.com with SMTP id b13so17200096wrx.6
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:10:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Nov 2018 13:10:07 +0000
Message-Id: <20181114131008.27599-2-alex.bennee@linaro.org>
In-Reply-To: <20181114131008.27599-1-alex.bennee@linaro.org>
References: <20181114131008.27599-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/2] .travis.yml: split MacOSX builds and reduce
 target list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

We have reached the point where the MacOSX build was regularly timing
out. So as before I've reduced the target list to "major"
architectures to try and bring the build time down. I've added an
additional MacOSX build with the latest XCode with a minimal list of
"most likely" targets on MacOS.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index aa49c7b114..d472fd650b 100644
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
