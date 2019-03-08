Received: from eggs.gnu.org ([209.51.188.92]:54666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2IN2-0001m6-P6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2IN2-0008J9-2a
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2IN1-0008Fs-Rk
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:29:16 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 17:29:04 +0100
Message-Id: <20190308162906.10491-2-philmd@redhat.com>
In-Reply-To: <20190308162906.10491-1-philmd@redhat.com>
References: <20190308162906.10491-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] .travis.yml: Reduce the out-of-tree target
 list
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
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index e942175dd3..681ed1c216 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -127,7 +127,7 @@ matrix:
=20
     # Test out-of-tree builds
     - env:
-        - CONFIG=3D"--enable-debug --enable-debug-tcg"
+        - CONFIG=3D"--enable-debug --enable-debug-tcg --target-list=3Dmi=
croblaze-softmmu,xtensa-softmmu,cris-linux-user,hppa-linux-user"
         - BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
=20
=20
--=20
2.20.1
