Received: from eggs.gnu.org ([2001:4830:134:3::10]:42890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFHTA-00085q-Te
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFHT5-0008R1-1y
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:27:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39835
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cFHT4-0008Qq-Rs
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:27:50 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB99OvnF059889
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 04:27:50 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277rtjauhj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 04:27:50 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 9 Dec 2016 02:27:49 -0700
From: Greg Kurz <groug@kaod.org>
Date: Fri, 09 Dec 2016 10:27:45 +0100
In-Reply-To: <148127558476.2633.13433882390740185948.stgit@bahia>
References: <148127558476.2633.13433882390740185948.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148127566547.2633.14151802942325528071.stgit@bahia>
Subject: [Qemu-devel] [PATCH 1/8] tests: virtio-9p: rename PCI configuration
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |    4 ++--
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
