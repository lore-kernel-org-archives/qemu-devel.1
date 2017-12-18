Received: from eggs.gnu.org ([2001:4830:134:3::10]:57457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQy05-0002nU-Ci
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQy02-0007Sn-HB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:10:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eQy02-0007SP-Ai
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:10:42 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90B7772D14
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 16:10:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 18 Dec 2017 17:10:38 +0100
Message-Id: <1513613438-11017-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] scripts: Remove fixed entries from the
 device-crash-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

These are crashes / errors which have been fixed already in the past
months. We can remove these from the device-crash-test script now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/device-crash-test | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index c11fd81..1aca55f 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -208,11 +208,9 @@ ERROR_WHITELIST = [
     # Known crashes will generate error messages, but won't be fatal.
     # Those entries must be removed once we fix the crashes.
     {'exitcode':-6, 'log':r"Device 'serial0' is in use", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"spapr_rtas_register: Assertion .*rtas_table\[token\]\.name.* failed", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"qemu_net_client_setup: Assertion `!peer->peer' failed", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r'RAMBlock "[\w.-]+" already registered', 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"find_ram_offset: Assertion `size != 0' failed.", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"puv3_load_kernel: Assertion `kernel_filename != NULL' failed", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"add_cpreg_to_hashtable: code should not be reached", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"qemu_alloc_display: Assertion `surface->image != NULL' failed", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"Unexpected error in error_set_from_qdev_prop_error", 'loglevel':logging.ERROR},
@@ -220,16 +218,10 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
-    {'exitcode':-11, 'device':'stm32f205-soc', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'xlnx,zynqmp', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'mips-cps', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'gus', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'a9mpcore_priv', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'a15mpcore_priv', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'sb16', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'device':'cs4231a', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'device':'arm-gicv3', 'loglevel':logging.ERROR, 'expected':True},
     {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.ERROR, 'expected':True},
 
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
-- 
1.8.3.1
