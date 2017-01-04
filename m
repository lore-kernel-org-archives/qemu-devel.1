Received: from eggs.gnu.org ([2001:4830:134:3::10]:57724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq0-00070Z-H6
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgpx-0000Am-DT
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39520
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgpx-0000AQ-7X
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:21 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048J4PB005846
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:20 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27ruc1vfx3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:20 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:19 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:40 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-7-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 06/13] tests: virtio-9p: rename PCI
 configuration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 9c4f6cb40647..f458297f9ae1 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -92,7 +92,7 @@ static void qvirtio_9p_pci_free(QVirtIO9P *v9p)
     g_free(v9p);
 }
 
-static void pci_basic_config(void)
+static void pci_config(void)
 {
     QVirtIO9P *v9p;
     size_t tag_len;
@@ -121,7 +121,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
     qtest_add_func("/virtio/9p/pci/nop", pci_nop);
-    qtest_add_func("/virtio/9p/pci/basic/configuration", pci_basic_config);
+    qtest_add_func("/virtio/9p/pci/config", pci_config);
 
     return g_test_run();
 }
-- 
2.7.4
