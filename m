Received: from eggs.gnu.org ([209.51.188.92]:39412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk4-0001yP-9N
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1goRk2-0001h8-AK
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1goRk0-0001az-89
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:39:46 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 29 Jan 2019 11:39:18 +0000
Message-Id: <20190129113921.21599-3-berrange@redhat.com>
In-Reply-To: <20190129113921.21599-1-berrange@redhat.com>
References: <20190129113921.21599-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/5] make: don't insert a '/' after $(DESTDIR)
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

This breaks when $(prefix) is a relative directory, as it turns it
into an absolute path.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 362a98d275..14a463564e 100644
--- a/Makefile
+++ b/Makefile
@@ -744,19 +744,19 @@ ifneq ($(BLOBS),)
 	done
 endif
 	for s in $(ICON_SIZES); do \
-		mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps"; \
+		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
 		$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
-			"$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
+			"$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
 	done; \
-	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps"; \
+	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps"; \
 	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_32x32.bmp \
-		"$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
-	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps"; \
+		"$(DESTDIR)$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
+	mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps"; \
 	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu.svg \
-		"$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
-	mkdir -p "$(DESTDIR)/$(qemu_desktopdir)"
+		"$(DESTDIR)$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
+	mkdir -p "$(DESTDIR)$(qemu_desktopdir)"
 	$(INSTALL_DATA) $(SRC_PATH)/ui/qemu.desktop \
-		"$(DESTDIR)/$(qemu_desktopdir)/qemu.desktop"
+		"$(DESTDIR)$(qemu_desktopdir)/qemu.desktop"
 ifdef CONFIG_GTK
 	$(MAKE) -C po $@
 endif
--=20
2.20.1
