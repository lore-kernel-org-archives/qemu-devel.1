Received: from eggs.gnu.org ([2001:4830:134:3::10]:58161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tUK-0007Qj-Ks
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tU3-0006Px-Jo
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9tU3-0006OY-8B
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:39 -0400
Received: by mail-wm1-x333.google.com with SMTP id 189-v6so2218671wmw.2
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:59:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Oct 2018 15:59:31 +0100
Message-Id: <20181009145933.18925-2-alex.bennee@linaro.org>
In-Reply-To: <20181009145933.18925-1-alex.bennee@linaro.org>
References: <20181009145933.18925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/3] .travis.yml: split MacOSX builds and
 reduce target list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, f4bug@amsat.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
