Received: from eggs.gnu.org ([2001:4830:134:3::10]:43542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOq-00081C-1F
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnQOp-0007f1-3a
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnQOo-0007eb-Tc
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 10:24:51 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 31 Aug 2017 15:24:29 +0100
Message-Id: <20170831142430.16665-5-berrange@redhat.com>
In-Reply-To: <20170831142430.16665-1-berrange@redhat.com>
References: <20170831142430.16665-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] qapi: adapt to moved location of
 StringIO module in py3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 05cb1ee38c..3c06711e2c 100644
--- a/scripts/qapi.py
+++ b/scripts/qapi.py
@@ -22,6 +22,10 @@ try:
     from collections import OrderedDict
 except:
     from ordereddict import OrderedDict
+try:
+    from StringIO import StringIO
+except ImportError:
+    from io import StringIO
 
 builtin_types = {
     'null':     'QTYPE_QNULL',
@@ -2000,8 +2004,7 @@ def open_output(output_dir, do_c, do_h, prefix, c_file, h_file,
         if really:
             return open(name, opt)
         else:
-            import StringIO
-            return StringIO.StringIO()
+            return StringIO()
 
     fdef = maybe_open(do_c, c_file, 'w')
     fdecl = maybe_open(do_h, h_file, 'w')
-- 
2.13.5
