Received: from eggs.gnu.org ([2001:4830:134:3::10]:42260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTsvA-0005RJ-4K
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTsv8-0005vu-T5
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:17:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cTsv8-0005vG-Nk
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:17:10 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0FA272CC1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:17:10 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Wed, 18 Jan 2017 10:16:53 -0600
Message-Id: <20170118161653.19296-7-eblake@redhat.com>
In-Reply-To: <20170118161653.19296-1-eblake@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] qapi: Promote blockdev-change-medium
 arguments to QAPI type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Having a named rather than anonymous C type will make it easier
to improve the testsuite in a later patch. No semantic change,
to any of the existing code or to the introspection output.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: rebase to master
---
 qapi/block-core.json | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1b3e6eb..0e31d25 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3119,6 +3119,15 @@
 # combines blockdev-open-tray, x-blockdev-remove-medium,
 # x-blockdev-insert-medium and blockdev-close-tray).
 #
+# Since: 2.5
+##
+{ 'command': 'blockdev-change-medium',
+  'data': 'BlockdevChangeMedium' }
+
+
+##
+# @BlockdevChangeMedium:
+#
 # @device:          #optional Block device name (deprecated, use @id instead)
 #
 # @id:              #optional The name or QOM path of the guest device
@@ -3165,7 +3174,7 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'blockdev-change-medium',
+{ 'struct': 'BlockdevChangeMedium',
   'data': { '*device': 'str',
             '*id': 'str',
             'filename': 'str',
-- 
2.9.3
