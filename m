Received: from eggs.gnu.org ([2001:4830:134:3::10]:44069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9md-0006PB-EC
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9mW-0000hr-Ss
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:45:39 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Dec 2017 15:45:22 +1100
Message-Id: <20171219044522.10850-5-david@gibson.dropbear.id.au>
In-Reply-To: <20171219044522.10850-1-david@gibson.dropbear.id.au>
References: <20171219044522.10850-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv3 4/4] tests/pxe-test: Add some extra tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Previously virtio-net was only tested for ppc64 in "slow" mode.  That
doesn't make much sense since virtio-net is used much more often in
practice than the spapr-vlan device which was tested always.  So, move
virtio-net to always be tested on ppc64.

We had no tests at all for the q35 machine, which doesn't seem wise
given its increasing prominence.  Add a couple of tests for it,
including testing the newer e1000e adapter.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/pxe-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 5689c7d7ee..5ca84805eb 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -30,6 +30,8 @@ typedef struct testdef {
 static testdef_t x86_tests[] = {
     { "pc", "e1000" },
     { "pc", "virtio-net-pci" },
+    { "q35", "e1000e" },
+    { "q35", "virtio-net-pci", },
     { NULL },
 };
 
@@ -43,11 +45,11 @@ static testdef_t x86_tests_slow[] = {
 
 static testdef_t ppc64_tests[] = {
     { "pseries", "spapr-vlan" },
+    { "pseries", "virtio-net-pci", },
     { NULL },
 };
 
 static testdef_t ppc64_tests_slow[] = {
-    { "pseries", "virtio-net-pci", },
     { "pseries", "e1000" },
     { NULL },
 };
-- 
2.14.3
