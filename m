Received: from eggs.gnu.org ([209.51.188.92]:47950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg9X-0004Ic-0Z
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg9V-0004oB-5t
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmg9U-0004W1-P8
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:38:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9885B7F7B5
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:38:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Jan 2019 15:38:24 +0100
Message-Id: <20190124143825.25921-4-armbru@redhat.com>
In-Reply-To: <20190124143825.25921-1-armbru@redhat.com>
References: <20190124143825.25921-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] qmp: Add examples to qom list, get,
 and set commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

Added examples for the qom-list, qom-get, and qom-set
commands in qapi misc JSON file.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20181228194442.3506-1-wainersm@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc.json | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index 24d20a880a..426274ecf8 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1380,6 +1380,16 @@
 #          object.
 #
 # Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "qom-list",
+#      "arguments": { "path": "/chardevs" } }
+# <- { "return": [ { "name": "type", "type": "string" },
+#                  { "name": "parallel0", "type": "child<chardev-vc>" },
+#                  { "name": "serial0", "type": "child<chardev-vc>" },
+#                  { "name": "mon0", "type": "child<chardev-stdio>" } ] }
+#
 ##
 { 'command': 'qom-list',
   'data': { 'path': 'str' },
@@ -1417,6 +1427,23 @@
 #          returned as #int.
 #
 # Since: 1.2
+#
+# Example:
+#
+# 1. Use absolute path
+#
+# -> { "execute": "qom-get",
+#      "arguments": { "path": "/machine/unattached/device[0]",
+#                     "property": "hotplugged" } }
+# <- { "return": false }
+#
+# 2. Use partial path
+#
+# -> { "execute": "qom-get",
+#      "arguments": { "path": "unattached/sysbus",
+#                     "property": "type" } }
+# <- { "return": "System" }
+#
 ##
 { 'command': 'qom-get',
   'data': { 'path': 'str', 'property': 'str' },
@@ -1436,6 +1463,15 @@
 #         for a description of type mapping.
 #
 # Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "qom-set",
+#      "arguments": { "path": "/machine",
+#                     "property": "graphics",
+#                     "value": false } }
+# <- { "return": {} }
+#
 ##
 { 'command': 'qom-set',
   'data': { 'path': 'str', 'property': 'str', 'value': 'any' },
-- 
2.17.2
