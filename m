Received: from eggs.gnu.org ([2001:4830:134:3::10]:40801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7P-0001NT-Lw
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7O-0008Nu-PI
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU7O-0008KD-JW
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:43:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1FBA7FEA3
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 19:43:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:39 -0600
Message-Id: <20180301194245.29854-25-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 24/30] watchdog: Consolidate QAPI into single
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Commit f0df84c6 added watchdog-set-action in the main qapi-schema.json,
but it belongs better in qapi/run-state.json alongside the definition
of WatchdogAction.  The command was written prior to commit 0e201d34
creating the latter file, even though it was merged after.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180226225744.26356-1-eblake@redhat.com>
---
 qapi-schema.json    | 9 ---------
 qapi/run-state.json | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index d214529547d..3c1abf27005 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3291,12 +3291,3 @@
 # Since: 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
-
-##
-# @watchdog-set-action:
-#
-# Set watchdog action
-#
-# Since: 2.11
-##
-{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 92d29fd5710..1c9fff3aefe 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -283,6 +283,15 @@
   'data': [ 'reset', 'shutdown', 'poweroff', 'pause', 'debug', 'none',
             'inject-nmi' ] }

+##
+# @watchdog-set-action:
+#
+# Set watchdog action
+#
+# Since: 2.11
+##
+{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
+
 ##
 # @GUEST_PANICKED:
 #
-- 
2.14.3
