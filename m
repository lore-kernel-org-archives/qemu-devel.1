Received: from eggs.gnu.org ([2001:4830:134:3::10]:33054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEWEs-0006rT-2T
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEWEr-0002Qj-5N
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fEWEr-0002QG-10
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:38:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C4518163AD4
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 08:38:48 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri,  4 May 2018 10:37:41 +0200
Message-Id: <1525423069-61903-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v7 03/11] qapi: introduce preconfig runstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

New preconfig runstate will be used in follow up patches
related to introducing --preconfig CLI option and is
intended to replace prelaunch runstate from QEMU start
up to machine_init callback.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 qapi/run-state.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 1c9fff3..9694a9f 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -49,12 +49,15 @@
 # @colo: guest is paused to save/restore VM state under colo checkpoint,
 #        VM can not get into this state unless colo capability is enabled
 #        for migration. (since 2.8)
+# @preconfig: QEMU is paused before board specific init callback is executed.
+#             The state is reachable only if the --preconfig CLI option is used.
+#             (Since 2.13)
 ##
 { 'enum': 'RunState',
   'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
             'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
             'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
-            'guest-panicked', 'colo' ] }
+            'guest-panicked', 'colo', 'preconfig' ] }
 
 ##
 # @StatusInfo:
-- 
2.7.4
