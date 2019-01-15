Received: from eggs.gnu.org ([209.51.188.92]:35453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUym-00080A-FA
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyQ-0003Pw-Jz
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64995)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyP-00038d-JF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:10 -0500
Date: Tue, 15 Jan 2019 15:05:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-37-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 36/49] hw/misc/edu: add msi_uninit() for
 pci_edu_uninit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fei Li <shirley17fei@gmail.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Xu <peterx@redhat.com>, Jiri Slaby <jslaby@suse.cz>

From: Fei Li <shirley17fei@gmail.com>

Let's supplement the msi_uninit() when failing to realize
the pci edu device.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fei Li <shirley17fei@gmail.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/misc/edu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index cdcf550dd7..ceaf688bfb 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -377,6 +377,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
     qemu_mutex_destroy(&edu->thr_mutex);
=20
     timer_del(&edu->dma_timer);
+    msi_uninit(pdev);
 }
=20
 static void edu_obj_uint64(Object *obj, Visitor *v, const char *name,
--=20
MST
