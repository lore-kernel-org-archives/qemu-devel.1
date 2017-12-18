Received: from eggs.gnu.org ([2001:4830:134:3::10]:34454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQsHM-0004V3-VW
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eQsHM-0001La-98
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:04:12 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Dec 2017 21:04:04 +1100
Message-Id: <20171218100404.4427-5-david@gibson.dropbear.id.au>
In-Reply-To: <20171218100404.4427-1-david@gibson.dropbear.id.au>
References: <20171218100404.4427-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCHv2 4/4] tests/pxe-test: Add some extra tests
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
---
 tests/pxe-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 18e02c246c..009a82bb97 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -31,6 +31,8 @@ typedef struct testdef {
 static testdef_t x86_tests[] = {
     { "pc", "e1000" },
     { "pc", "virtio-net-pci" },
+    { "q35", "e1000e" },
+    { "q35", "virtio-net-pci", },
     { NULL },
 };
 
@@ -44,11 +46,11 @@ static testdef_t x86_tests_slow[] = {
 
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
