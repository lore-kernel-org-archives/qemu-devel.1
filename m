Received: from eggs.gnu.org ([2001:4830:134:3::10]:53929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUl-0000Gb-5D
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUj-0007MA-C5
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUj-0007LM-3f
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 14AAE7EA9D
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D20859343F
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:53 +0200
Message-Id: <20170901125611.29295-30-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/47] qapi-schema: Make block-core.json
 self-contained
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Except for block-core.json, the sub-schemas are self-contained: if
they use a symbol defined in another sub-schema, they include that
sub-schema.  To check, feed the sub-schema to qapi2texi (or any other
QAPI generator) along with the pragma from qapi-schema.json.

Fix up things to make block-core.json self-contained, too.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503602048-12268-15-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json     | 14 --------------
 qapi/block-core.json |  1 +
 qapi/common.json     | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 4964d927bd..80c15dade3 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2816,20 +2816,6 @@
      'data': { 'info': 'ACPIOSTInfo' } }
=20
 ##
-# @IoOperationType:
-#
-# An enumeration of the I/O operation types
-#
-# @read: read operation
-#
-# @write: write operation
-#
-# Since: 2.1
-##
-{ 'enum': 'IoOperationType',
-  'data': [ 'read', 'write' ] }
-
-##
 # @rtc-reset-reinjection:
 #
 # This command will reset the RTC interrupt reinjection backlog.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 5379674292..f4caa5c21b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5,6 +5,7 @@
 ##
=20
 { 'include': 'common.json' }
+{ 'include': 'crypto.json' }
 { 'include': 'sockets.json' }
=20
 ##
diff --git a/qapi/common.json b/qapi/common.json
index e2c58564d8..fc72d7ec3d 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -132,6 +132,20 @@
 { 'command': 'query-commands', 'returns': ['CommandInfo'] }
=20
 ##
+# @IoOperationType:
+#
+# An enumeration of the I/O operation types
+#
+# @read: read operation
+#
+# @write: write operation
+#
+# Since: 2.1
+##
+{ 'enum': 'IoOperationType',
+  'data': [ 'read', 'write' ] }
+
+##
 # @OnOffAuto:
 #
 # An enumeration of three options: on, off, and auto
--=20
2.13.5
