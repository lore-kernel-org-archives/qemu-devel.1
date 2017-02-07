Received: from eggs.gnu.org ([2001:4830:134:3::10]:32830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6D7-0008WC-4Q
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cb6D6-0008Pj-0P
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cb6D5-0008PG-RD
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:53:31 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  7 Feb 2017 17:52:04 +0400
Message-Id: <20170207135211.15870-22-marcandre.lureau@redhat.com>
In-Reply-To: <20170207135211.15870-1-marcandre.lureau@redhat.com>
References: <20170207135211.15870-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/28] tests: fix virtio-9p-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

Spotted by ASAN.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/virtio-9p-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 9556291567..43a1ad813f 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -80,7 +80,7 @@ static void qvirtio_9p_pci_stop(QVirtIO9P *v9p)
 {
     qvirtqueue_cleanup(v9p->dev->bus, v9p->vq, v9p->qs->alloc);
     qvirtio_pci_device_disable(container_of(v9p->dev, QVirtioPCIDevice, =
vdev));
-    g_free(v9p->dev);
+    qvirtio_pci_device_free((QVirtioPCIDevice *)v9p->dev);
     qvirtio_9p_stop(v9p);
 }
=20
--=20
2.11.0.295.gd7dffce1c.dirty
