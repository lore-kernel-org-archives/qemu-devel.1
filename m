Received: from eggs.gnu.org ([209.51.188.92]:53314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJdvu-0002IS-WD
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hJdvu-0003EO-0W
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:56:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hJdvt-0003D5-RO
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:56:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 25 Apr 2019 13:56:50 +0100
Message-Id: <20190425125650.28846-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] gitmodules: use qemu.org git mirrors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

qemu.org hosts git repository mirrors of all submodules.  Update
.gitmodules to use the mirrors and not the upstream repositories.

Mirroring upstream repositories ensures that QEMU continues to build
even when upstream repositories are deleted or temporarily offline.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
Based-on: <20190424110041.8175-1-marcandre.lureau@redhat.com>
          "[PATCH v2 0/2] slirp: move slirp as git submodule project"

Peter: Please apply Marc-Andr=C3=A9's series.  I have set up the necessar=
y
mirrors and this patch will fix up the libsirp URL as well as the
other URLs.

 .gitmodules | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index aa77ce6f50..84b260031c 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -39,19 +39,19 @@
 	url =3D https://git.qemu.org/git/capstone.git
 [submodule "roms/seabios-hppa"]
 	path =3D roms/seabios-hppa
-	url =3D https://github.com/hdeller/seabios-hppa.git
+	url =3D https://git.qemu.org/git/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path =3D roms/u-boot-sam460ex
 	url =3D https://git.qemu.org/git/u-boot-sam460ex.git
 [submodule "tests/fp/berkeley-testfloat-3"]
 	path =3D tests/fp/berkeley-testfloat-3
-	url =3D https://github.com/cota/berkeley-testfloat-3
+	url =3D https://git.qemu.org/git/berkeley-testfloat-3.git
 [submodule "tests/fp/berkeley-softfloat-3"]
 	path =3D tests/fp/berkeley-softfloat-3
-	url =3D https://github.com/cota/berkeley-softfloat-3
+	url =3D https://git.qemu.org/git/berkeley-softfloat-3.git
 [submodule "roms/edk2"]
 	path =3D roms/edk2
-	url =3D https://github.com/tianocore/edk2.git
+	url =3D https://git.qemu.org/git/tianocore/edk2.git
 [submodule "slirp"]
 	path =3D slirp
-	url =3D https://gitlab.freedesktop.org/slirp/libslirp.git
+	url =3D https://git.qemu.org/git/libslirp.git
--=20
2.20.1
