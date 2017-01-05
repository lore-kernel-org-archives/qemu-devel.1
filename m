Received: from eggs.gnu.org ([2001:4830:134:3::10]:57267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cPG23-00035L-KE
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cPG1y-0007lV-PJ
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 16:57:11 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Thu,  5 Jan 2017 22:56:54 +0100
Message-Id: <1483653417-17439-2-git-send-email-hpoussin@reactos.org>
In-Reply-To: <1483653417-17439-1-git-send-email-hpoussin@reactos.org>
References: <1483653417-17439-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/4] prep: do not use global variable to
 access nvram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, Giancarlo Teodori <gteodori@gmail.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
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
2.1.4
