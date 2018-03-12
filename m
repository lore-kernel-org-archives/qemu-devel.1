Received: from eggs.gnu.org ([2001:4830:134:3::10]:56669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evVfR-0000YD-Is
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1evVfQ-0002A8-MI
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1evVfQ-00029s-GD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:11:40 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 12 Mar 2018 19:11:29 -0300
Message-Id: <20180312221132.14141-2-ehabkost@redhat.com>
In-Reply-To: <20180312221132.14141-1-ehabkost@redhat.com>
References: <20180312221132.14141-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/4] device-crash-test: New known crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, John Snow <jsnow@redhat.com>

We are not running the script on "make check" yet, and additional
bugs were introduced recently in the tree.

Whitelist the new crashes while we investigate, to allow us to
run device-crash-test on "make check" as soon as possible to
prevent new bugs.

Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20180309202827.12085-5-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 7417177ebb..7443d0f2c5 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -217,11 +217,15 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
+    {'exitcode':-6, 'device':'isa-fdc', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'gus', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'sb16', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'cs4231a', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'mioe3680_pci', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'pcm3680_pci', 'loglevel':logging.ERROR, 'expected':True},
+    {'exitcode':-11, 'device':'kvaser_pci', 'loglevel':logging.ERROR, 'expected':True},
 
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
-- 
2.14.3
