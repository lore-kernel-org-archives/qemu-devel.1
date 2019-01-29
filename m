Received: from eggs.gnu.org ([209.51.188.92]:39410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk4-0001yO-8q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk2-0001gq-8k
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1goRk0-0001ai-7H
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:46 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 29 Jan 2019 11:39:17 +0000
Message-Id: <20190129113921.21599-2-berrange@redhat.com>
In-Reply-To: <20190129113921.21599-1-berrange@redhat.com>
References: <20190129113921.21599-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/5] nsis: don't install files into /tmp
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

The nsis installer target has to run 'make install' to populate a
directory tree with content for the package. Replace the current
usage of '/tmp/qemu-nsis' with a location underneath the build
directory. This ensures that when a developer cleans their build
directory, any left over files from the installer build process
are also purged.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index de898eab62..362a98d275 100644
--- a/Makefile
+++ b/Makefile
@@ -907,7 +907,7 @@ endif
 .PHONY: installer
 installer: $(INSTALLER)
=20
-INSTDIR=3D/tmp/qemu-nsis
+INSTDIR=3D$(BUILD_DIR)/qemu-nsis-vroot
=20
 $(INSTALLER): $(SRC_PATH)/qemu.nsi
 	$(MAKE) install prefix=3D${INSTDIR}
--=20
2.20.1
