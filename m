Received: from eggs.gnu.org ([2001:4830:134:3::10]:33348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuco1-0005H7-J8
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fucmc-000063-O9
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:07:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fucmc-00005E-J0
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:07:42 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Aug 2018 14:07:35 +0200
Message-Id: <20180828120736.32323-2-armbru@redhat.com>
In-Reply-To: <20180828120736.32323-1-armbru@redhat.com>
References: <20180828120736.32323-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qapi: Emit a blank line before dummy
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
Cc: mdroth@linux.vnet.ibm.com, eblake@redhat.com

We emit a dummy variable in each .c file "to shut up OSX toolchain
warnings about empty .o files" (commit 252dc3105fc).  Separate it from
the code preceding it (if any) with a blank line.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/common.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 02c5c6767a..5bbf1c353d 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -2220,6 +2220,7 @@ class QAPIGenC(QAPIGenCCode):
 
     def _bottom(self, fname):
         return mcgen('''
+
 /* Dummy declaration to prevent empty .o file */
 char dummy_%(name)s;
 ''',
-- 
2.17.1
