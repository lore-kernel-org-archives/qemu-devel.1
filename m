Received: from eggs.gnu.org ([2001:4830:134:3::10]:51754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JQ-0003MH-Vu
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JF-0008Gj-Uu
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:11 -0400
Received: from [185.30.24.106] (port=13504
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JE-0008C0-I9
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:01 -0400
Date: Tue, 23 Oct 2018 19:41:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-28-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/28] piix_pci: fix i440fx data sheet link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@163.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Li Qiang <liq3ea@163.com>

It seems that the intel link is unavailable, change it to point to the
qemu site.

Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 731190d92d..213a81e669 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -40,7 +40,7 @@
=20
 /*
  * I440FX chipset data sheet.
- * http://download.intel.com/design/chipsets/datashts/29054901.pdf
+ * https://wiki.qemu.org/File:29054901.pdf
  */
=20
 #define I440FX_PCI_HOST_BRIDGE(obj) \
--=20
MST
