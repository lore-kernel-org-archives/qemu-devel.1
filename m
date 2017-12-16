Received: from eggs.gnu.org ([2001:4830:134:3::10]:38844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQ9OS-0007ro-Ur
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 05:08:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eQ9OO-00083p-U3
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 05:08:32 -0500
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:45511)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eQ9OO-00082V-N1
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 05:08:28 -0500
Received: from player694.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 82F3311871A
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 11:08:26 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Sat, 16 Dec 2017 11:08:24 +0100
Message-ID: <151341890412.21880.8358856828225630003.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] tests: virtio-9p: set DRIVER_OK before using
 the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |    3 +++
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
 
