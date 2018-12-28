Received: from eggs.gnu.org ([208.118.235.92]:39697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gcyEt-0007Dk-OQ
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 14:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gcy3x-0003U0-0N
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 14:44:57 -0500
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Date: Fri, 28 Dec 2018 14:44:42 -0500
Message-Id: <20181228194442.3506-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qmp: Add examples to qom list, get,
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
Cc: qemu-trivial@nongnu.org, eblake@redhat.com, armbru@redhat.com

Added examples for the qom-list, qom-get, and qom-set
commands in qapi misc JSON file.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
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
+#                  { "name": "mon0", "type": "child<chardev-stdio>" } ] =
}
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
--=20
2.19.2
