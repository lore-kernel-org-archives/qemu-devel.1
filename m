Received: from eggs.gnu.org ([209.51.188.92]:50584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwPTU-0002iZ-PP
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwPTU-0007XR-1a
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:51:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gwPTT-0007VT-RX
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:51:35 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Feb 2019 11:51:31 +0100
Message-Id: <20190220105131.23479-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] travis: the xcode10 image seems to be hosed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

It fails to install homebrew.  Unfortunately we cannot mark
it as an expected failure because Travis does not match
allow_failures rows against include rows (only against the
main test matrix, which we do not use at all), so just disable
it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index a7ab72b43b..866a1872b1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -174,13 +174,6 @@ matrix:
       compiler: clang
=20
=20
-    - env:
-        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
-      os: osx
-      osx_image: xcode10
-      compiler: clang
-
-
     # Python builds
     - env:
         - CONFIG=3D"--target-list=3Dx86_64-softmmu"
@@ -254,11 +247,3 @@ matrix:
     - env:
         - CONFIG=3D"--disable-system"
         - TEST_CMD=3D"make -j3 check-tcg V=3D1"
-
-
-  allow_failures:
-    - env:
-        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
-      os: osx
-      osx_image: xcode10
-      compiler: clang
--=20
2.20.1
