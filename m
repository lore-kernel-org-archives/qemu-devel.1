Received: from eggs.gnu.org ([209.51.188.92]:46452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6o-0004lA-Lx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkE6n-0003Y5-Ne
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkE6m-0003W2-L8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 15:17:49 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 17 Jan 2019 18:17:35 -0200
Message-Id: <20190117201743.20470-2-ehabkost@redhat.com>
In-Reply-To: <20190117201743.20470-1-ehabkost@redhat.com>
References: <20190117201743.20470-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] scripts/device-crash-test: Remove known
 crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Looks like we've fixed them all already in the past months, e.g. with:

 f7d6bfcdc0fe49040aac3ac131a319cb5427957e
 spapr_pci: fail gracefully with non-pseries machine types

 2363d5ee231bf047479422d56d3b85b7d37a7c23
 hw/ppc/spapr_cpu_core: Add a proper check for spapr machine

 ef0e8fc768a561dd13a86420b3268f6f3d5d0621
 iommu: Don't crash if machine is not PC_MACHINE

 8929fc3a55f33a103adddf9cfd010bcf2b255c7d
 hw/block/pflash_cfi*.c: fix confusing assert fail message

... so we can remove these entries from the ERROR_WHITELIST now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1541510826-21031-1-git-send-email-thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e93a7c0c84..549162a547 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -182,21 +182,6 @@ ERROR_WHITELIST = [
     # other exitcode=1 failures not listed above will just generate INFO messages:
     {'exitcode':1, 'loglevel':logging.INFO},
 
-    # KNOWN CRASHES:
-    # Known crashes will generate error messages, but won't be fatal.
-    # Those entries must be removed once we fix the crashes.
-    {'exitcode':-6, 'log':r"Device 'serial0' is in use", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"qemu_net_client_setup: Assertion `!peer->peer' failed", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r'RAMBlock "[\w.-]+" already registered', 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"find_ram_offset: Assertion `size != 0' failed.", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"add_cpreg_to_hashtable: code should not be reached", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"qemu_alloc_display: Assertion `surface->image != NULL' failed", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"Unexpected error in error_set_from_qdev_prop_error", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"Object .* is not an instance of type spapr-machine", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"Object .* is not an instance of type generic-pc-machine", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
-    {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
-
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
 ]
-- 
2.18.0.rc1.1.g3f1ff2140
