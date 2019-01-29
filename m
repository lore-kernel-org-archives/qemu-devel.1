Received: from eggs.gnu.org ([209.51.188.92]:39452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk6-0001zO-GR
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk4-0001jK-Fl
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1goRk4-0001cP-7C
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:48 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 29 Jan 2019 11:39:20 +0000
Message-Id: <20190129113921.21599-5-berrange@redhat.com>
In-Reply-To: <20190129113921.21599-1-berrange@redhat.com>
References: <20190129113921.21599-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/5] nsis: fix location of icons to be bundled
 in the installer
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

The bmp icon files no longer exist in the root of the installation
tree. Instead we must reference the new icons subdirectory location
introduced in

  commit a8260d3876389eb52ca5c62ed4d80cdb7e025c85
  Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
  Date:   Thu Jan 10 12:00:45 2019 +0000

    ui: install logo icons to $prefix/share/icons

Reported-by: Adam Baxter <voltagex@voltagex.org>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 qemu.nsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu.nsi b/qemu.nsi
index 75f1608b9e..53fd974877 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -119,12 +119,12 @@ Section "${PRODUCT} (required)"
     File "${SRCDIR}\README"
     File "${SRCDIR}\VERSION"
=20
-    File "${BINDIR}\*.bmp"
     File "${BINDIR}\*.bin"
     File "${BINDIR}\*.dtb"
     File "${BINDIR}\*.rom"
     File "${BINDIR}\openbios-*"
=20
+    File /r "${BINDIR}\icons"
     File /r "${BINDIR}\keymaps"
 !ifdef CONFIG_GTK
     File /r "${BINDIR}\share"
@@ -206,7 +206,6 @@ Section "Uninstall"
     Delete "$INSTDIR\COPYING.LIB"
     Delete "$INSTDIR\README"
     Delete "$INSTDIR\VERSION"
-    Delete "$INSTDIR\*.bmp"
     Delete "$INSTDIR\*.bin"
     Delete "$INSTDIR\*.dll"
     Delete "$INSTDIR\*.dtb"
@@ -217,6 +216,7 @@ Section "Uninstall"
     Delete "$INSTDIR\qemu.exe"
     Delete "$INSTDIR\qemu-system-*.exe"
     Delete "$INSTDIR\qemu-doc.html"
+    RMDir /r "$INSTDIR\icons"
     RMDir /r "$INSTDIR\keymaps"
     RMDir /r "$INSTDIR\share"
     ; Remove generated files
--=20
2.20.1
