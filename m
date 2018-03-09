Received: from eggs.gnu.org ([2001:4830:134:3::10]:50236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOdC-0008Nv-S9
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOdB-0006pl-QC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euOdB-0006pR-Ku
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:45 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  9 Mar 2018 17:28:23 -0300
Message-Id: <20180309202827.12085-5-ehabkost@redhat.com>
In-Reply-To: <20180309202827.12085-1-ehabkost@redhat.com>
References: <20180309202827.12085-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 4/8] device-crash-test: New known crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, John Snow <jsnow@redhat.com>

We are not running the script on "make check" yet, and additional
bugs were introduced recently in the tree.

Whitelist the new crashes while we investigate, to allow us to
run device-crash-test on "make check" as soon as possible to
prevent new bugs.

Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: John Snow <jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 632b128e44..b9a7470efc 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -241,11 +241,15 @@ ERROR_WHITELIST = [
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
