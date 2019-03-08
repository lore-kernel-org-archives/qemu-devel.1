Received: from eggs.gnu.org ([209.51.188.92]:54686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2IN6-0001p1-Dv
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2IN5-0008QT-Lg
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2IN5-0008Po-FA
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:19 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 17:29:05 +0100
Message-Id: <20190308162906.10491-3-philmd@redhat.com>
In-Reply-To: <20190308162906.10491-1-philmd@redhat.com>
References: <20190308162906.10491-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] .travis.yml: Test the documentation
 installation process
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

We invert the BASE_CONFIG arguments order to match the
BASE_CONFIG at top of this file, this way it is easier
to find this job in Travis Job View.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 681ed1c216..df6700d93a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -114,10 +114,11 @@ matrix:
         - TEST_CMD=3D"make check-unit -j3 V=3D1"
=20
=20
-    # Check we can build docs and tools
+    # Check we can build docs and tools (in-tree) and install them
     - env:
-        - BASE_CONFIG=3D"--enable-tools --enable-docs"
-        - CONFIG=3D"--target-list=3Dx86_64-softmmu,aarch64-linux-user"
+        - BASE_CONFIG=3D"--enable-docs --enable-tools"
+        - CONFIG=3D"--prefix=3D$PWD/prefix --target-list=3Dx86_64-softmm=
u,aarch64-linux-user"
+        - TEST_CMD=3D"make check install -j3"
       addons:
         apt:
           packages:
--=20
2.20.1
