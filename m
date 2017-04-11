Received: from eggs.gnu.org ([2001:4830:134:3::10]:57712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cy5n8-00008h-2k
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 20:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cy5n3-00016Y-3y
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 20:05:46 -0400
Received: from mail-bn3nam01on0072.outbound.protection.outlook.com
	([104.47.33.72]:44017
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cy5n2-00016Q-Ic
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 20:05:40 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 11 Apr 2017 15:30:17 -0700
Message-ID: <988b183dcf951856d8b3379f7e911ec95233bbf4.1491947224.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1491947224.git.alistair.francis@xilinx.com>
References: <cover.1491947224.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/5] cadence_gem: Read the correct queue
 descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: f4bug@amsat.org, alistair.francis@xilinx.com, alistair23@gmail.com

Read the correct descriptor instead of hardcoding the first (q=3D0).

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

 hw/net/cadence_gem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index d4de8ad..17c229d 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -790,8 +790,8 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
 {
     DB_PRINT("read descriptor 0x%x\n", (unsigned)s->rx_desc_addr[q]);
     /* read current descriptor */
-    cpu_physical_memory_read(s->rx_desc_addr[0],
-                             (uint8_t *)s->rx_desc[0], sizeof(s->rx_desc[0=
]));
+    cpu_physical_memory_read(s->rx_desc_addr[q],
+                             (uint8_t *)s->rx_desc[q], sizeof(s->rx_desc[q=
]));
=20
     /* Descriptor owned by software ? */
     if (rx_desc_get_ownership(s->rx_desc[q]) =3D=3D 1) {
--=20
2.9.3
