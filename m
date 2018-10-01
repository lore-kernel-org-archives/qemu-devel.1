Received: from eggs.gnu.org ([2001:4830:134:3::10]:40198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g6yx1-0000uY-JK
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g6ywv-0004Zf-Kc
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g6ywo-0004N4-Dz
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 10:13:22 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  1 Oct 2018 16:13:10 +0200
Message-Id: <1538403190-27146-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] scripts/device-crash-test: Remove entries for
 serial devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

The problem with the various serial devices has been fixed a while
ago in commit 47c4f85a0c27888e12af827471cfef87deb49821 ("hw/char/serial:
Allow disconnected chardevs") already, so we can remove these entries
from the "ignore" list in the device-crash-test script now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/device-crash-test | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e6c233e..3422475 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -99,7 +99,6 @@ ERROR_WHITELIST = [
     {'device':'isa-ipmi-bt', 'expected':True},             # IPMI device requires a bmc attribute to be set
     {'device':'isa-ipmi-kcs', 'expected':True},            # IPMI device requires a bmc attribute to be set
     {'device':'isa-parallel', 'expected':True},            # Can't create serial device, empty char device
-    {'device':'isa-serial', 'expected':True},              # Can't create serial device, empty char device
     {'device':'ivshmem', 'expected':True},                 # You must specify either 'shm' or 'chardev'
     {'device':'ivshmem-doorbell', 'expected':True},        # You must specify a 'chardev'
     {'device':'ivshmem-plain', 'expected':True},           # You must specify a 'memdev'
@@ -110,9 +109,6 @@ ERROR_WHITELIST = [
     {'device':'pc-dimm', 'expected':True},                 # 'memdev' property is not set
     {'device':'pci-bridge', 'expected':True},              # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
     {'device':'pci-bridge-seat', 'expected':True},         # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
-    {'device':'pci-serial', 'expected':True},              # Can't create serial device, empty char device
-    {'device':'pci-serial-2x', 'expected':True},           # Can't create serial device, empty char device
-    {'device':'pci-serial-4x', 'expected':True},           # Can't create serial device, empty char device
     {'device':'pxa2xx-dma', 'expected':True},              # channels value invalid
     {'device':'pxb', 'expected':True},                     # Bridge chassis not specified. Each bridge is required to be assigned a unique chassis id > 0.
     {'device':'scsi-block', 'expected':True},              # drive property not set
@@ -218,7 +214,6 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
-    {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
 
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
-- 
1.8.3.1
