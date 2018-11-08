Received: from eggs.gnu.org ([2001:4830:134:3::10]:56181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKiJD-0005m3-LO
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKiJ9-0008Fl-N5
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:17:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gKiJ9-0008FH-Br
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:17:07 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu,  8 Nov 2018 11:15:27 +0000
Message-Id: <20181108111531.30671-5-stefanha@redhat.com>
In-Reply-To: <20181108111531.30671-1-stefanha@redhat.com>
References: <20181108111531.30671-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/8] gitmodules: use 'https://' instead of
 'git://'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Daniel Berrange <berrange@redhat.com>, eblake@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When you clone the repository without previous commit history, 'git://'
doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
since the client verifies the server certificate.

Also change git.qemu-project.org to git.qemu.org (we control both domain
names but qemu.org is used more widely).

Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .gitmodules | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index a48d2a764c..6b91176098 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,51 +1,51 @@
 [submodule "roms/seabios"]
 	path =3D roms/seabios
-	url =3D git://git.qemu-project.org/seabios.git/
+	url =3D https://git.qemu.org/git/seabios.git/
 [submodule "roms/SLOF"]
 	path =3D roms/SLOF
-	url =3D git://git.qemu-project.org/SLOF.git
+	url =3D https://git.qemu.org/git/SLOF.git
 [submodule "roms/ipxe"]
 	path =3D roms/ipxe
-	url =3D git://git.qemu-project.org/ipxe.git
+	url =3D https://git.qemu.org/git/ipxe.git
 [submodule "roms/openbios"]
 	path =3D roms/openbios
-	url =3D git://git.qemu-project.org/openbios.git
+	url =3D https://git.qemu.org/git/openbios.git
 [submodule "roms/openhackware"]
 	path =3D roms/openhackware
-	url =3D git://git.qemu-project.org/openhackware.git
+	url =3D https://git.qemu.org/git/openhackware.git
 [submodule "roms/qemu-palcode"]
 	path =3D roms/qemu-palcode
-	url =3D git://git.qemu.org/qemu-palcode.git
+	url =3D https://git.qemu.org/git/qemu-palcode.git
 [submodule "roms/sgabios"]
 	path =3D roms/sgabios
-	url =3D git://git.qemu-project.org/sgabios.git
+	url =3D https://git.qemu.org/git/sgabios.git
 [submodule "dtc"]
 	path =3D dtc
-	url =3D git://git.qemu-project.org/dtc.git
+	url =3D https://git.qemu.org/git/dtc.git
 [submodule "roms/u-boot"]
 	path =3D roms/u-boot
-	url =3D git://git.qemu-project.org/u-boot.git
+	url =3D https://git.qemu.org/git/u-boot.git
 [submodule "roms/skiboot"]
 	path =3D roms/skiboot
-	url =3D git://git.qemu.org/skiboot.git
+	url =3D https://git.qemu.org/git/skiboot.git
 [submodule "roms/QemuMacDrivers"]
 	path =3D roms/QemuMacDrivers
-	url =3D git://git.qemu.org/QemuMacDrivers.git
+	url =3D https://git.qemu.org/git/QemuMacDrivers.git
 [submodule "ui/keycodemapdb"]
 	path =3D ui/keycodemapdb
-	url =3D git://git.qemu.org/keycodemapdb.git
+	url =3D https://git.qemu.org/git/keycodemapdb.git
 [submodule "capstone"]
 	path =3D capstone
-	url =3D git://git.qemu.org/capstone.git
+	url =3D https://git.qemu.org/git/capstone.git
 [submodule "roms/seabios-hppa"]
 	path =3D roms/seabios-hppa
-	url =3D git://github.com/hdeller/seabios-hppa.git
+	url =3D https://github.com/hdeller/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path =3D roms/u-boot-sam460ex
-	url =3D git://git.qemu.org/u-boot-sam460ex.git
+	url =3D https://git.qemu.org/git/u-boot-sam460ex.git
 [submodule "tests/fp/berkeley-testfloat-3"]
 	path =3D tests/fp/berkeley-testfloat-3
-	url =3D git://github.com/cota/berkeley-testfloat-3
+	url =3D https://github.com/cota/berkeley-testfloat-3
 [submodule "tests/fp/berkeley-softfloat-3"]
 	path =3D tests/fp/berkeley-softfloat-3
-	url =3D git://github.com/cota/berkeley-softfloat-3
+	url =3D https://github.com/cota/berkeley-softfloat-3
--=20
2.19.1
