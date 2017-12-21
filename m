Received: from eggs.gnu.org ([2001:4830:134:3::10]:45873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qd-0007vC-8M
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qc-0005j2-Fd
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1qc-0005iZ-8H
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:22 -0500
Date: Thu, 21 Dec 2017 16:29:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-15-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 14/25] tests/pxe-test: Add some extra tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: David Gibson <david@gibson.dropbear.id.au>

Previously virtio-net was only tested for ppc64 in "slow" mode.  That
doesn't make much sense since virtio-net is used much more often in
practice than the spapr-vlan device which was tested always.  So, move
virtio-net to always be tested on ppc64.

We had no tests at all for the q35 machine, which doesn't seem wise
given its increasing prominence.  Add a couple of tests for it,
including testing the newer e1000e adapter.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/pxe-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 5689c7d..5ca8480 100644
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
MST
