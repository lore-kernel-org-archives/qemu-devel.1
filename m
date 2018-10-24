Received: from eggs.gnu.org ([2001:4830:134:3::10]:43414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFq4-0004ll-AO
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFFq2-0006BS-8A
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gFFq0-00066h-MM
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 05:52:29 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 24 Oct 2018 10:52:07 +0100
Message-Id: <1540374728-27579-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1540374728-27579-1-git-send-email-thuth@redhat.com>
References: <1540374728-27579-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] po/Makefile: Modern shell scripting (use
 $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Various shell files contain a mix between obsolete ``
and modern $(); It would be nice to convert to using $()
everywhere.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 po/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/Makefile b/po/Makefile
index e47e262..c041f4c 100644
--- a/po/Makefile
+++ b/po/Makefile
@@ -36,7 +36,7 @@ clean:
 
 install: $(OBJS)
 	for obj in $(OBJS); do \
-	    base=`basename $$obj .mo`; \
+	    base=$$(basename $$obj .mo); \
 	    $(INSTALL) -d $(DESTDIR)$(prefix)/share/locale/$$base/LC_MESSAGES; \
 	    $(INSTALL) -m644 $$obj $(DESTDIR)$(prefix)/share/locale/$$base/LC_MESSAGES/qemu.mo; \
 	done
-- 
1.8.3.1
