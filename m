Received: from eggs.gnu.org ([209.51.188.92]:38902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9T-0001Co-G9
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa9N-0000Hb-Jv
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:47 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:01:13 +1100
Message-Id: <20190204090124.26191-27-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/37] hw/ppc/spapr: Add support for "-vga
 cirrus"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

The cirrus VGA card has been enabled in the PPC builds with
commit 29f9cef39eb1ae55e82c ("ppc: Include vga cirrus card into
the compiling process") last year. It also works on the pseries
machine, even SLOF contains support for this card, so we can
also support this for the "-vga" parameter here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c66e7d8e0a..0fcdd35cbe 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1715,6 +1715,7 @@ static bool spapr_vga_init(PCIBus *pci_bus, Error *=
*errp)
         return true;
     case VGA_STD:
     case VGA_VIRTIO:
+    case VGA_CIRRUS:
         return pci_vga_init(pci_bus) !=3D NULL;
     default:
         error_setg(errp,
--=20
2.20.1
