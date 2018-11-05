Received: from eggs.gnu.org ([2001:4830:134:3::10]:60810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjR6-0008LX-Tl
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjR3-0003cb-Uc
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:17:16 -0500
Date: Mon, 5 Nov 2018 13:17:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-31-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/33] i440fx: use ARRAY_SIZE for pam_regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Li Qiang <liq3ea@gmail.com>, qemu-trivial@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Cc: qemu-trivial@nongnu.org

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index ec5441583a..b5ded1a806 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -142,7 +142,7 @@ static void i440fx_update_memory_mappings(PCII440FXSt=
ate *d)
     PCIDevice *pd =3D PCI_DEVICE(d);
=20
     memory_region_transaction_begin();
-    for (i =3D 0; i < 13; i++) {
+    for (i =3D 0; i < ARRAY_SIZE(d->pam_regions); i++) {
         pam_update(&d->pam_regions[i], i,
                    pd->config[I440FX_PAM + DIV_ROUND_UP(i, 2)]);
     }
@@ -412,7 +412,7 @@ PCIBus *i440fx_init(const char *host_type, const char=
 *pci_type,
=20
     init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
              &f->pam_regions[0], PAM_BIOS_BASE, PAM_BIOS_SIZE);
-    for (i =3D 0; i < 12; ++i) {
+    for (i =3D 0; i < ARRAY_SIZE(f->pam_regions) - 1; ++i) {
         init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_sp=
ace,
                  &f->pam_regions[i+1], PAM_EXPAN_BASE + i * PAM_EXPAN_SI=
ZE,
                  PAM_EXPAN_SIZE);
--=20
MST
