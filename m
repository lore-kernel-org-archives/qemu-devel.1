Received: from eggs.gnu.org ([209.51.188.92]:54722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2INB-0001tC-TR
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2INA-0008Vx-Ig
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2INA-0008Tg-Be
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:24 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 17:29:06 +0100
Message-Id: <20190308162906.10491-4-philmd@redhat.com>
In-Reply-To: <20190308162906.10491-1-philmd@redhat.com>
References: <20190308162906.10491-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] .travis.yml: Test installing Sphinx
 documentation in out-of-tree build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index df6700d93a..2c6b6c05b0 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -126,10 +126,19 @@ matrix:
             - texinfo
             - perl
=20
-    # Test out-of-tree builds
+
+    # Test out-of-tree builds (and install)
     - env:
-        - CONFIG=3D"--enable-debug --enable-debug-tcg --target-list=3Dmi=
croblaze-softmmu,xtensa-softmmu,cris-linux-user,hppa-linux-user"
+        - BASE_CONFIG=3D"--enable-docs --disable-tools"
+        - CONFIG=3D"--prefix=3D$PWD/prefix --enable-debug --enable-debug=
-tcg --target-list=3Dmicroblaze-softmmu,xtensa-softmmu,cris-linux-user,hp=
pa-linux-user"
         - BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
+        - TEST_CMD=3D"make check install -j3"
+      addons:
+        apt:
+          packages:
+            - python-sphinx
+            - texinfo
+            - perl
=20
=20
     # Test with Clang for compile portability (Travis uses clang-5.0)
--=20
2.20.1
