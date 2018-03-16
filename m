Received: from eggs.gnu.org ([2001:4830:134:3::10]:36559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewm1j-0006aa-J9
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewm1d-0004A9-R2
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:51:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40718 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ewm1d-00049S-NB
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 05:51:49 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 16 Mar 2018 10:51:32 +0100
Message-Id: <1521193892-15552-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1521193892-15552-1-git-send-email-thuth@redhat.com>
References: <1521193892-15552-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] scripts/device-crash-test: Remove fixed
 isapc-with-iommu entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Eduardo Habkost <ehabkost@redhat.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Fixed in a0c167a18470831e359f0538c3cf67907808f13e ("x86_iommu: check
if machine has PCI bus").

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/device-crash-test | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 8ad3f44..b3ce720 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -218,7 +218,6 @@ ERROR_WHITELIST = [
     {'exitcode':-6, 'log':r"Object .* is not an instance of type e500-ccsr", 'loglevel':logging.ERROR},
     {'exitcode':-6, 'log':r"vmstate_register_with_alias_id: Assertion `!se->compat \|\| se->instance_id == 0' failed", 'loglevel':logging.ERROR},
     {'exitcode':-11, 'device':'isa-serial', 'loglevel':logging.ERROR, 'expected':True},
-    {'exitcode':-11, 'machine':'isapc', 'device':'.*-iommu', 'loglevel':logging.ERROR, 'expected':True},
 
     # everything else (including SIGABRT and SIGSEGV) will be a fatal error:
     {'exitcode':None, 'fatal':True, 'loglevel':logging.FATAL},
-- 
1.8.3.1
