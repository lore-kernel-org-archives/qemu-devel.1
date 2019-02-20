Received: from eggs.gnu.org ([209.51.188.92]:49464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwPNa-0000ZI-33
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwPNY-0002Yc-5I
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:45:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gwPNX-0002Xk-VV
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:45:28 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Feb 2019 11:45:23 +0100
Message-Id: <20190220104523.22059-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] travis: the xcode10 image seems to be hosed
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

It fails to install homebrew.  Since this is out of our control, mark
it as an expected failure.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .travis.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index baa06b976a..a7ab72b43b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -254,3 +254,11 @@ matrix:
     - env:
         - CONFIG=3D"--disable-system"
         - TEST_CMD=3D"make -j3 check-tcg V=3D1"
+
+
+  allow_failures:
+    - env:
+        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-softm=
mu,m68k-softmmu,x86_64-softmmu"
+      os: osx
+      osx_image: xcode10
+      compiler: clang
--=20
2.20.1
