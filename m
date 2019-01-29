Received: from eggs.gnu.org ([209.51.188.92]:39368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk2-0001wx-7H
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk0-0001fN-7J
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17493)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1goRjz-0001dP-W9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:44 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 29 Jan 2019 11:39:21 +0000
Message-Id: <20190129113921.21599-6-berrange@redhat.com>
In-Reply-To: <20190129113921.21599-1-berrange@redhat.com>
References: <20190129113921.21599-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/5] configure: stop trying to link
 non-existant bmp file from bios dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Adam Baxter <voltagex@voltagex.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The icons were all moved from pci-bios to ui/icons with:

    commit a8260d3876389eb52ca5c62ed4d80cdb7e025c85
    Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
    Date:   Thu Jan 10 12:00:45 2019 +0000

      ui: install logo icons to $prefix/share/icons

Adding symlinks from the source directory into the build directory
for the new source location will not help QEMU to locate them when
running uninstalled binaries, as we no longer search QEMU bios
directory to locate icon files.

Inability to find icons during startup when not having run a
"make install" is harmless, as frontends just continue without
error. So it is not worth trying to add code hacks to find icons
in non-installed directories.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index b18281c61f..fb1f65958e 100755
--- a/configure
+++ b/configure
@@ -7617,7 +7617,6 @@ LINKS=3D"$LINKS pc-bios/optionrom/Makefile pc-bios/=
keymaps"
 LINKS=3D"$LINKS pc-bios/spapr-rtas/Makefile"
 LINKS=3D"$LINKS pc-bios/s390-ccw/Makefile"
 LINKS=3D"$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
-LINKS=3D"$LINKS pc-bios/qemu-icon.bmp"
 LINKS=3D"$LINKS .gdbinit scripts" # scripts needed by relative path in .=
gdbinit
 LINKS=3D"$LINKS tests/acceptance tests/data"
 LINKS=3D"$LINKS tests/qemu-iotests/check"
--=20
2.20.1
