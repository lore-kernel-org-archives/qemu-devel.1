Received: from eggs.gnu.org ([2001:4830:134:3::10]:47278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCiNU-0002Ig-6l
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCiNO-0004xK-CC
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:44:31 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:25823)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gCiNN-0004rm-Ff
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 05:44:26 -0400
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Date: Wed, 17 Oct 2018 17:44:06 +0800
Message-Id: <20181017094406.4844-4-maozhongyi@cmss.chinamobile.com>
In-Reply-To: <20181017094406.4844-1-maozhongyi@cmss.chinamobile.com>
References: <20181017094406.4844-1-maozhongyi@cmss.chinamobile.com>
Subject: [Qemu-devel] [PATCH 3/3] po/Makefile: Modern shell scripting (use
 $() instead of ``)
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
---
 po/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/Makefile b/po/Makefile
index e47e262ee6..10605e8eb3 100644
--- a/po/Makefile
+++ b/po/Makefile
@@ -36,7 +36,7 @@ clean:
 
 install: $(OBJS)
 	for obj in $(OBJS); do \
-	    base=`basename $$obj .mo`; \
+	    base=$(basename $$obj .mo); \
 	    $(INSTALL) -d $(DESTDIR)$(prefix)/share/locale/$$base/LC_MESSAGES; \
 	    $(INSTALL) -m644 $$obj $(DESTDIR)$(prefix)/share/locale/$$base/LC_MESSAGES/qemu.mo; \
 	done
-- 
2.17.1
