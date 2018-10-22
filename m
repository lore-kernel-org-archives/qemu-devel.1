Received: from eggs.gnu.org ([2001:4830:134:3::10]:33345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEVtD-0003H0-W1
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEVt8-0008Bt-WB
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:48:43 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:49585)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEVt8-00084W-9f
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 04:48:38 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Mon, 22 Oct 2018 16:48:24 +0800
Message-Id: <20181022084824.555-3-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181022084824.555-1-maozhongyi@cmss.chinamobile.com>
References: <20181022084824.555-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH v3 2/2] po/Makefile: Modern shell scripting
 (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, philmd@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, sw@weilnetz.de

Various shell files contain a mix between obsolete ``
and modern $(); It would be nice to convert to using $()
everywhere.

Cc: philmd@redhat.com
Cc: peter.maydell@linaro.org
Cc: thuth@redhat.com
Cc: sw@weilnetz.de

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 po/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/Makefile b/po/Makefile
index e47e262ee6..c041f4c858 100644
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
2.17.1
