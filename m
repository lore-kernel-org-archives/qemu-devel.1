Received: from eggs.gnu.org ([2001:4830:134:3::10]:44106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tk-00070S-MQ
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Tf-0003bF-3j
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz1Te-0003ap-Tz
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:13:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11F82883AC
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:13:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:13:33 +0200
Message-Id: <20171002141341.24616-4-armbru@redhat.com>
In-Reply-To: <20171002141341.24616-1-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 03/11] qapi: Eliminate
 QAPISchemaParser.__init__()'s local fname
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index dc92bca620..6c8001e96d 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -261,8 +261,7 @@ class QAPISchemaParser(object):
 
     def __init__(self, fp, previously_included=[], incl_info=None):
         abs_fname = os.path.abspath(fp.name)
-        fname = fp.name
-        self.fname = fname
+        self.fname = fp.name
         previously_included.append(abs_fname)
         self.incl_info = incl_info
         self.src = fp.read()
@@ -277,7 +276,7 @@ class QAPISchemaParser(object):
         self.accept()
 
         while self.tok is not None:
-            info = {'file': fname, 'line': self.line,
+            info = {'file': self.fname, 'line': self.line,
                     'parent': self.incl_info}
             if self.tok == '#':
                 self.reject_expr_doc()
-- 
2.13.6
