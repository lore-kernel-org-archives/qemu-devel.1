Received: from eggs.gnu.org ([2001:4830:134:3::10]:51564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1yj-0001Ge-AI
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb1yi-0007Ng-KY
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:26:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb1yi-0007NP-Ep
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:26:56 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 Jan 2018 10:26:12 +0000
Message-Id: <20180115102621.9183-5-berrange@redhat.com>
In-Reply-To: <20180115102621.9183-1-berrange@redhat.com>
References: <20180115102621.9183-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/13] qapi: adapt to moved location of
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/qapi.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi.py b/scripts/qapi.py
index 7ec2e00b2c..eaa63a58be 100644
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
@@ -1995,8 +1999,7 @@ def open_output(output_dir, do_c, do_h, prefix, c_file, h_file,
         if really:
             return open(name, opt)
         else:
-            import StringIO
-            return StringIO.StringIO()
+            return StringIO()
 
     fdef = maybe_open(do_c, c_file, 'w')
     fdecl = maybe_open(do_h, h_file, 'w')
-- 
2.14.3
