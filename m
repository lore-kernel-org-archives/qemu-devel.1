Received: from eggs.gnu.org ([2001:4830:134:3::10]:41692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMpa-0002lL-JY
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dnMpU-0006K1-Uy
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:36:14 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 31 Aug 2017 12:34:22 +0200
Message-Id: <20170831103432.6007-20-marcandre.lureau@redhat.com>
In-Reply-To: <20170831103432.6007-1-marcandre.lureau@redhat.com>
References: <20170831103432.6007-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/29] q35: use DIV_ROUND_UP
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
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 hw/pci-host/q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0e472f2ed4..1ff648e80c 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -315,7 +315,7 @@ static void mch_update_pam(MCHPCIState *mch)
     memory_region_transaction_begin();
     for (i =3D 0; i < 13; i++) {
         pam_update(&mch->pam_regions[i], i,
-                   pd->config[MCH_HOST_BRIDGE_PAM0 + ((i + 1) / 2)]);
+                   pd->config[MCH_HOST_BRIDGE_PAM0 + (DIV_ROUND_UP(i, 2)=
)]);
     }
     memory_region_transaction_commit();
 }
--=20
2.14.1.146.gd35faa819
