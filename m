Received: from eggs.gnu.org ([2001:4830:134:3::10]:55274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL9cB-0008Ev-FZ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL9c6-00019f-L2
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:49:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dL9c6-00019Q-Ej
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:49:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49275D5988
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 14:49:41 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 14 Jun 2017 11:49:39 -0300
Message-Id: <20170614144939.1115-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] device-crash-test: Fix regexp on whitelist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The "||" in the whitelist entry was not escaped, making the regexp match
all strings, on every single cases where QEMU aborted.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 5f90e9bb54..e77b693eb2 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -219,7 +219,7 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"Object .* is not an instance of type spapr-machine", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat || se->instance_id == 0' failed", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
     {'exitcode':-11, 'device':'stm32f205-soc', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'xlnx,zynqmp', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'mips-cps', 'loglevel':logging.ERROR, 'expected':True},
-- 
2.11.0.259.g40922b1
