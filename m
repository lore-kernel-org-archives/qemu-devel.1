Received: from eggs.gnu.org ([2001:4830:134:3::10]:54677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f7M9i-0004XD-A5
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 10:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f7M9f-0002wW-6H
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 10:27:54 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 14 Apr 2018 17:27:39 +0300
Message-Id: <20180414142739.23375-1-mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PATCH trivial for-2.12] Makefile: install gtk message
 catalogs if CONFIG_GTK=y too, not only =m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 727ef118f3..8644c2e918 100644
--- a/Makefile
+++ b/Makefile
@@ -856,7 +856,7 @@ ifneq ($(BLOBS),)
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
 	done
 endif
-ifeq ($(CONFIG_GTK),m)
+ifneq ($(filter $(CONFIG_GTK),y m),)
 	$(MAKE) -C po $@
 endif
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
-- 
2.11.0
