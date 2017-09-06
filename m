Received: from eggs.gnu.org ([2001:4830:134:3::10]:53491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxU-0002Zn-B9
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxR-000149-AS
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpgxR-00012V-7Z
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:29:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  6 Sep 2017 16:28:46 -0400
Message-Id: <1504729728-23279-5-git-send-email-cota@braap.org>
In-Reply-To: <1504729728-23279-1-git-send-email-cota@braap.org>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [RFC 4/6] Makefile: install qemu-api.h as
 include/qemu-plugin.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ef72148..326867e 100644
--- a/Makefile
+++ b/Makefile
@@ -602,8 +602,10 @@ ifneq (,$(findstring qemu-ga,$(TOOLS)))
 endif
 endif
 
+install-includedir:
+	$(INSTALL_DIR) "$(DESTDIR)$(includedir)"
 
-install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir
+install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir install-includedir
 ifneq ($(TOOLS),)
 	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
 endif
@@ -626,6 +628,9 @@ endif
 ifeq ($(CONFIG_GTK),y)
 	$(MAKE) -C po $@
 endif
+ifeq ($(CONFIG_PLUGINS),y)
+	$(INSTALL_DATA) $(SRC_PATH)/include/qemu/plugin-api.h "$(DESTDIR)$(includedir)/qemu-plugin.h"
+endif
 	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/keymaps"
 	set -e; for x in $(KEYMAPS); do \
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
-- 
2.7.4
