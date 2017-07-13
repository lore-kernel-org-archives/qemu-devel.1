Received: from eggs.gnu.org ([2001:4830:134:3::10]:43214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh4a-000501-OJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh4Z-0005eD-SV
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:34:40 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:32:08 +0200
Message-Id: <20170713163219.9024-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 18/29] piix: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-host/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index a2c1033dbe..3745b56c8e 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -140,7 +140,7 @@ static void i440fx_update_memory_mappings(PCII440FXSt=
ate *d)
     memory_region_transaction_begin();
     for (i =3D 0; i < 13; i++) {
         pam_update(&d->pam_regions[i], i,
-                   pd->config[I440FX_PAM + ((i + 1) / 2)]);
+                   pd->config[I440FX_PAM + (DIV_ROUND_UP(i, 2))]);
     }
     memory_region_set_enabled(&d->smram_region,
                               !(pd->config[I440FX_SMRAM] & SMRAM_D_OPEN)=
);
--=20
2.13.1.395.gf7b71de06
