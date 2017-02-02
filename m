Received: from eggs.gnu.org ([2001:4830:134:3::10]:51616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9js-0007Qd-GI
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jn-0003ma-Br
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:13:30 +1100
Message-Id: <20170202051445.5735-33-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 032/107] prep: do not use global variable to
 access nvram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 054af1e..9fb89d3 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -339,13 +339,13 @@ static PortioList prep_port_list;
 /* NVRAM helpers */
 static inline uint32_t nvram_read(Nvram *nvram, uint32_t addr)
 {
-    NvramClass *k =3D NVRAM_GET_CLASS(sysctrl->nvram);
+    NvramClass *k =3D NVRAM_GET_CLASS(nvram);
     return (k->read)(nvram, addr);
 }
=20
 static inline void nvram_write(Nvram *nvram, uint32_t addr, uint32_t val=
)
 {
-    NvramClass *k =3D NVRAM_GET_CLASS(sysctrl->nvram);
+    NvramClass *k =3D NVRAM_GET_CLASS(nvram);
     (k->write)(nvram, addr, val);
 }
=20
--=20
2.9.3
