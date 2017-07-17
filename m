Received: from eggs.gnu.org ([2001:4830:134:3::10]:34362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6g-0003Bk-Vj
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dXB6e-0003U1-MG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:50:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dXB6e-0003SC-Fc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 14:50:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Jul 2017 15:50:37 -0300
Message-Id: <20170717185051.18740-2-ehabkost@redhat.com>
In-Reply-To: <20170717185051.18740-1-ehabkost@redhat.com>
References: <20170717185051.18740-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] device-crash-test: Fix regexp on whitelist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

The "||" in the whitelist entry was not escaped, making the regexp match
all strings, on every single cases where QEMU aborted.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170614144939.1115-1-ehabkost@redhat.com>
---
 scripts/device-crash-test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 5f90e9b..e77b693 100755
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
2.9.4
