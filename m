Received: from eggs.gnu.org ([209.51.188.92]:33021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gkEsO-0004uD-3U
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gkEsL-0007LU-EF
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:06:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gkEsL-0007Gr-3b
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 16:06:57 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 17 Jan 2019 22:06:30 +0100
Message-Id: <20190117210632.18567-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] vfio-pci: Introduce
 vfio_set_event_handler()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com
Cc: aik@ozlabs.ru, cohuck@redhat.com

This small series introduces the vfio_set_event_handler()
helper which allows to set up/tear down the VFIO signalling of eventfd
for ERR, REQ and INTX irq indices.

On top of that, a new irq index is planned to signal DMA faults
in nested mode use case. This would use exactly the same mechanics.

Eric Auger (2):
  vfio-pci: Introduce vfio_set_event_handler helper
  vfio-pci: Use vfio_set_event_handler in vfio_intx_enable

 hw/vfio/pci.c | 347 +++++++++++++++++++++-----------------------------
 1 file changed, 145 insertions(+), 202 deletions(-)

--=20
2.20.1
