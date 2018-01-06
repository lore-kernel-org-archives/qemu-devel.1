Received: from eggs.gnu.org ([2001:4830:134:3::10]:56690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcy3-0007Ce-Sv
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eXcy0-0006Ft-CL
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48272
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eXcy0-0006FK-59
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 20:08:08 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	w0614ZgS003691
	for <qemu-devel@nongnu.org>; Fri, 5 Jan 2018 20:08:07 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2faehhnt1h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 20:08:07 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Sat, 6 Jan 2018 01:08:05 -0000
From: Greg Kurz <groug@kaod.org>
Date: Sat,  6 Jan 2018 02:07:37 +0100
In-Reply-To: <20180106010739.18201-1-groug@kaod.org>
References: <20180106010739.18201-1-groug@kaod.org>
Message-Id: <20180106010739.18201-11-groug@kaod.org>
Subject: [Qemu-devel] [PULL 10/12] tests: virtio-9p: set DRIVER_OK before
 using the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index ebd24b20f657..00f00f7246e9 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -75,6 +75,9 @@ static QVirtIO9P *qvirtio_9p_pci_start(void)
     qvirtio_set_driver(v9p->dev);
 
     v9p->vq = qvirtqueue_setup(v9p->dev, v9p->qs->alloc, 0);
+
+    qvirtio_set_driver_ok(v9p->dev);
+
     return v9p;
 }
 
-- 
2.13.6
