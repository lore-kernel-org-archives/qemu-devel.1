Received: from eggs.gnu.org ([2001:4830:134:3::10]:46150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOA9z-0004YO-UB
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fOA9z-0008VO-0f
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fOA9y-0008VC-QP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 19:05:38 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 30 May 2018 20:05:20 -0300
Message-Id: <20180530230528.30166-5-ehabkost@redhat.com>
In-Reply-To: <20180530230528.30166-1-ehabkost@redhat.com>
References: <20180530230528.30166-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 04/12] qapi: introduce preconfig runstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

New preconfig runstate will be used in follow up patches
related to introducing --preconfig CLI option and is
intended to replace prelaunch runstate from QEMU start
up to machine_init callback.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1525423069-61903-4-git-send-email-imammedo@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[ehabkost: Changed "since 2.13" to "since 3.0"]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qapi/run-state.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 1c9fff3aef..d3c2a9113b 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -49,12 +49,15 @@
 # @colo: guest is paused to save/restore VM state under colo checkpoint,
 #        VM can not get into this state unless colo capability is enabled
 #        for migration. (since 2.8)
+# @preconfig: QEMU is paused before board specific init callback is executed.
+#             The state is reachable only if the --preconfig CLI option is used.
+#             (Since 3.0)
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
2.17.1
