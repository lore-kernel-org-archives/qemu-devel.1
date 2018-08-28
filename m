Received: from eggs.gnu.org ([2001:4830:134:3::10]:33389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujXO-0006N8-Qu
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:20:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujO6-0004ji-Ln
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:10:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fujO6-0004gK-CY
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:10:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7F9040241C9
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 19:10:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-97.ams2.redhat.com
	[10.36.116.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C3EDB2166B41
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 19:10:49 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Aug 2018 21:10:45 +0200
Message-Id: <20180828191048.29806-4-armbru@redhat.com>
In-Reply-To: <20180828191048.29806-1-armbru@redhat.com>
References: <20180828191048.29806-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] qapi: Emit a blank line before dummy
 declaration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We emit a dummy variable in each .c file "to shut up OSX toolchain
warnings about empty .o files" (commit 252dc3105fc).  Separate it from
the code preceding it (if any) with a blank line.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180828120736.32323-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 scripts/qapi/common.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 3b0d4bf9c0..7b62a4c7b0 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2218,6 +2218,7 @@ class QAPIGenC(QAPIGenCCode):
 
     def _bottom(self, fname):
         return mcgen('''
+
 /* Dummy declaration to prevent empty .o file */
 char dummy_%(name)s;
 ''',
-- 
2.17.1
