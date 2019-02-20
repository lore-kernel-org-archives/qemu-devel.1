Received: from eggs.gnu.org ([209.51.188.92]:41112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGPu-00059h-Dc
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwGOq-0004NU-Qx
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 20:10:17 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Wed, 20 Feb 2019 02:02:22 +0100
Message-Id: <20190220010232.18731-16-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-1-philmd@redhat.com>
References: <20190220010232.18731-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 15/25] spapr-vty: Let vty_putchars() use
 size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Both callers (h_put_term_char and rtas_display_character) use
an unsigned value.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/spapr_vty.c        | 2 +-
 include/hw/ppc/spapr_vio.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/char/spapr_vty.c b/hw/char/spapr_vty.c
index 6748334ded..92b8c40410 100644
--- a/hw/char/spapr_vty.c
+++ b/hw/char/spapr_vty.c
@@ -83,7 +83,7 @@ static int vty_getchars(VIOsPAPRDevice *sdev, uint8_t *=
buf, int max)
     return n;
 }
=20
-void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, int len)
+void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, size_t len)
 {
     VIOsPAPRVTYDevice *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
=20
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index e8b006d18f..ed79d2f380 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -126,7 +126,7 @@ static inline int spapr_vio_dma_set(VIOsPAPRDevice *d=
ev, uint64_t taddr,
 int spapr_vio_send_crq(VIOsPAPRDevice *dev, uint8_t *crq);
=20
 VIOsPAPRDevice *vty_lookup(sPAPRMachineState *spapr, target_ulong reg);
-void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, int len);
+void vty_putchars(VIOsPAPRDevice *sdev, uint8_t *buf, size_t len);
 void spapr_vty_create(VIOsPAPRBus *bus, Chardev *chardev);
 void spapr_vlan_create(VIOsPAPRBus *bus, NICInfo *nd);
 void spapr_vscsi_create(VIOsPAPRBus *bus);
--=20
2.20.1
