Received: from eggs.gnu.org ([2001:4830:134:3::10]:39899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1etbPk-0003jD-NK
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:55:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brogers@suse.com>) id 1etbPf-0007fd-Rl
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:55:36 -0500
Received: from inet-orm.provo.novell.com ([137.65.248.124]:41991
	helo=mail.novell.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brogers@suse.com>) id 1etbPf-0007er-Kn
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:55:31 -0500
From: Bruce Rogers <brogers@suse.com>
Date: Wed,  7 Mar 2018 08:55:17 -0700
Message-Id: <20180307155517.32570-1-brogers@suse.com>
Subject: [Qemu-devel] [PATCH] make: switch language file build to be gtk
 module aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: brogers@suse.com

Now that gtk support builds as a module, CONFIG_GTK changed from
y to m. Adjust Makefile correspondingly.

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 9a75c48ae0..026fa17dc0 100644
--- a/Makefile
+++ b/Makefile
@@ -851,7 +851,7 @@ ifneq ($(BLOBS),)
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
 	done
 endif
-ifeq ($(CONFIG_GTK),y)
+ifeq ($(CONFIG_GTK),m)
 	$(MAKE) -C po $@
 endif
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
-- 
2.16.2
