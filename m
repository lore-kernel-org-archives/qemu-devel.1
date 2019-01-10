Received: from eggs.gnu.org ([209.51.188.92]:36064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbLy-0004JG-Vc
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbLx-00063P-Sz
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghbLx-00062t-Mz
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:37 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 12:29:51 -0200
Message-Id: <20190110142955.23254-7-ehabkost@redhat.com>
In-Reply-To: <20190110142955.23254-1-ehabkost@redhat.com>
References: <20190110142955.23254-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/10] spapr: Eliminate
 SPAPR_PCI_2_7_MMIO_WIN_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

The macro is only used in one place, where the purpose of the
value is obvious.  Eliminate the macro so we don't need to rely
on stringify().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190107193020.21744-2-ehabkost@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/pci-host/spapr.h | 1 -
 hw/ppc/spapr.c              | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 4eb3a2ce3e..a5a7bf4837 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -101,7 +101,6 @@ struct sPAPRPHBState {
 #define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
                         SPAPR_PCI_MEM64_WIN_SIZE - 1)
=20
-#define SPAPR_PCI_2_7_MMIO_WIN_SIZE  0xf80000000
 #define SPAPR_PCI_IO_WIN_SIZE        0x10000
=20
 #define SPAPR_PCI_MSI_WINDOW         0x40000000000ULL
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 83081defde..54a19d2db8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4285,7 +4285,7 @@ static void spapr_machine_2_7_class_options(Machine=
Class *mc)
         {
             .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
             .property =3D "mem_win_size",
-            .value    =3D stringify(SPAPR_PCI_2_7_MMIO_WIN_SIZE),
+            .value    =3D "0xf80000000",
         },
         {
             .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
--=20
2.18.0.rc1.1.g3f1ff2140
