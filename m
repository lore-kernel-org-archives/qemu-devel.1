Received: from eggs.gnu.org ([2001:4830:134:3::10]:50405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f80Zq-0004g5-Fi
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f80Zl-0000ZG-JO
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:37:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:60229)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1f80Zl-0000Hs-Bc
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:37:29 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Apr 2018 12:37:19 +0300
Message-Id: <20180416093719.2543-1-mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PATCH v2 for-2.12] Makefile: install gtk message
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruce Rogers <brogers@suse.com>

Fixes 722cd7496474cebb2218f21e038592fad8603365

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 727ef118f3..d71dd5bea4 100644
--- a/Makefile
+++ b/Makefile
@@ -856,7 +856,7 @@ ifneq ($(BLOBS),)
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
 	done
 endif
-ifeq ($(CONFIG_GTK),m)
+ifdef CONFIG_GTK
 	$(MAKE) -C po $@
 endif
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
-- 
2.11.0
