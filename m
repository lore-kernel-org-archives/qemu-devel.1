Received: from eggs.gnu.org ([2001:4830:134:3::10]:49282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6R-0003dF-RF
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6O-0002b2-IZ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cpx6O-0002aq-Cr
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:00 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 14:11:52 +0100
Message-Id: <1490015515-25851-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1490015515-25851-1-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 3/6] qapi: Drop unused QAPIDoc member
 optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Unused since commit aa964b7 "qapi2texi: Convert to QAPISchemaVisitor"

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index e88c047..6c4d554 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -106,7 +106,6 @@ class QAPIDoc(object):
             self.name = name
             # the list of lines for this section
             self.content = []
-            self.optional = False
 
         def append(self, line):
             self.content.append(line)
-- 
2.7.4
