Received: from eggs.gnu.org ([209.51.188.92]:46956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sR-0004IB-EL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJ2sQ-0007eR-0I
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJ2sP-0007c4-J6
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 17:22:53 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 23 Apr 2019 18:22:44 -0300
Message-Id: <20190423212246.3542-2-ehabkost@redhat.com>
In-Reply-To: <20190423212246.3542-1-ehabkost@redhat.com>
References: <20190423212246.3542-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qapi: SupportStatusInfo struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, mprivozn@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

This struct will be used to represent support and deprecation
status of QEMU features.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/common.json | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/qapi/common.json b/qapi/common.json
index 99d313ef3b..b59d0dc66b 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -193,3 +193,27 @@
              'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
              'x86_64', 'xtensa', 'xtensaeb' ] }
+
+##
+# @SupportStatusInfo:
+#
+# Information on support status of a given feature
+# (e.g. machine type)
+#
+# @deprecated: if true, the given feature is deprecated and may be removed
+#              in future versions of QEMU according to the QEMU deprecation
+#              policy.
+#
+# @status-message: Human readable message describing support status
+#                  of the feature.
+#
+# @suggested-alternative: Optional.  Suggested alternative for a deprecated
+#                         feature.  For machine types, this should be the name
+#                         of an available machine-type.
+#
+# Since: 4.1
+##
+{ 'struct': 'SupportStatusInfo',
+  'data': { 'deprecated': 'bool',
+            '*status-message': 'str',
+            '*suggested-alternative': 'str' } }
-- 
2.18.0.rc1.1.g3f1ff2140
