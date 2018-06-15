Received: from eggs.gnu.org ([2001:4830:134:3::10]:41662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTmbO-00010Z-BQ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTmbM-0006Gc-Ni
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:10 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTmbM-0006Fw-GF
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:08 -0400
Received: by mail-wr0-x241.google.com with SMTP id l10-v6so9555181wrn.2
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 04:09:08 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 12:09:02 +0100
Message-Id: <20180615110903.29674-3-alex.bennee@linaro.org>
In-Reply-To: <20180615110903.29674-1-alex.bennee@linaro.org>
References: <20180615110903.29674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/3] travis: reduce coverage of gprof build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This build is regularly timing out and even switching off linux-user
wasn't enough. Instead explicitly choose a target list of broadly the
"major" architectures. This is enough to check the gprof build
machinery works without worrying about the actual coverage results.

I did try various YAML constructs for specifying CONFIG with
continuation but couldn't get any of them to work hence the very long
line.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/.travis.yml b/.travis.yml
index d5e6d50e6d..c200dde534 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -80,7 +80,7 @@ matrix:
     - env: CONFIG="--disable-user"
       compiler: clang
     # gprof/gcov are GCC features
-    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --disable-linux-user"
+    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
       compiler: gcc
     # We manually include builds which we disable "make check" for
     - env: CONFIG="--enable-debug --enable-tcg-interpreter"
-- 
2.17.1
