Received: from eggs.gnu.org ([2001:4830:134:3::10]:38769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYh-00070Y-FX
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFjYg-00085Q-8s
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFjYg-00084p-2L
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:04:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 May 2018 14:03:15 -0300
Message-Id: <20180507170315.11497-13-ehabkost@redhat.com>
In-Reply-To: <20180507170315.11497-1-ehabkost@redhat.com>
References: <20180507170315.11497-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/12] scripts/device-crash-test: Removed fixed
 CAN entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The CAN device crashes have been fixed with the commit
089eac81e1d34d202471c0a023284f47f4c5f00e already.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1523900489-25950-1-git-send-email-thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 5d17dc68dd..b3ce72069f 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -218,9 +218,6 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
     {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'mioe3680_pci', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'pcm3680_pci', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'kvaser_pci', 'loglevel':logging.ERROR, 'expected':True},
 
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
-- 
2.14.3
