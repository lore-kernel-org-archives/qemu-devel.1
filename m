Received: from eggs.gnu.org ([2001:4830:134:3::10]:37942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etqyn-0000zk-Di
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1etqym-0008Lr-LC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:32:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1etqym-0008LN-Gy
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 03:32:48 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  8 Mar 2018 09:32:24 +0100
Message-Id: <20180308083231.20180-2-kraxel@redhat.com>
In-Reply-To: <20180308083231.20180-1-kraxel@redhat.com>
References: <20180308083231.20180-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/8] make: switch language file build to be gtk
 module aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Bruce Rogers <brogers@suse.com>

From: Bruce Rogers <brogers@suse.com>

Now that gtk support builds as a module, CONFIG_GTK changed from
y to m. Adjust Makefile correspondingly.

Signed-off-by: Bruce Rogers <brogers@suse.com>
Message-id: 20180307155517.32570-1-brogers@suse.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.9.3
