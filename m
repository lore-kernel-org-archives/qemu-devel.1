Received: from eggs.gnu.org ([209.51.188.92]:45921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGls-0002N3-4X
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghGlr-0001OR-91
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:32:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghGlr-0001OC-3j
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:31:59 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed,  9 Jan 2019 16:31:14 +0000
Message-Id: <20190109163114.17010-14-berrange@redhat.com>
In-Reply-To: <20190109163114.17010-1-berrange@redhat.com>
References: <20190109163114.17010-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/13] travis: remove matrix settings that
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The global defaults request "trusty" and "gcc", so matrix entries do not
need to repeat this.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 .travis.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index a632fc0b3a..9859f6e60b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -122,39 +122,33 @@ matrix:
         - CONFIG=3D"--enable-gprof --enable-gcov --disable-pie --target-=
list=3Daarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softm=
mu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
       after_success:
         - ${SRC_DIR}/scripts/travis/coverage-summary.sh
-      compiler: gcc
=20
=20
     # We manually include builds which we disable "make check" for
     - env:
         - CONFIG=3D"--enable-debug --enable-tcg-interpreter"
         - TEST_CMD=3D""
-      compiler: gcc
=20
=20
     # We don't need to exercise every backend with every front-end
     - env:
         - CONFIG=3D"--enable-trace-backends=3Dlog,simple,syslog --disabl=
e-system"
         - TEST_CMD=3D""
-      compiler: gcc
=20
=20
     - env:
         - CONFIG=3D"--enable-trace-backends=3Dftrace --target-list=3Dx86=
_64-softmmu"
         - TEST_CMD=3D""
-      compiler: gcc
=20
=20
     - env:
         - CONFIG=3D"--enable-trace-backends=3Dust --target-list=3Dx86_64=
-softmmu"
         - TEST_CMD=3D""
-      compiler: gcc
=20
=20
     - env:
         - CONFIG=3D"--disable-tcg"
         - TEST_CMD=3D""
-      compiler: gcc
=20
=20
     # MacOSX builds
@@ -249,5 +243,3 @@ matrix:
     - env:
         - CONFIG=3D"--disable-system --disable-docs"
         - TEST_CMD=3D"make -j3 check-tcg V=3D1"
-      dist: trusty
-      compiler: gcc
--=20
2.19.2
