Received: from eggs.gnu.org ([2001:4830:134:3::10]:49281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6R-0003dD-RC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cpx6O-0002b3-JY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cpx6O-0002ao-CY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:12:00 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 20 Mar 2017 14:11:51 +0100
Message-Id: <1490015515-25851-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1490015515-25851-1-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 2/6] qapi2texi: Fix to actually fail
 when 'doc-required' is false
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

Messed up in commit bc52d03.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi2texi.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
index 8eed11a..5c4db78 100755
--- a/scripts/qapi2texi.py
+++ b/scripts/qapi2texi.py
@@ -292,6 +292,7 @@ def main(argv):
     if not qapi.doc_required:
         print >>sys.stderr, ("%s: need pragma 'doc-required' "
                              "to generate documentation" % argv[0])
+        sys.exit(1)
     print texi_schema(schema)
 
 
-- 
2.7.4
