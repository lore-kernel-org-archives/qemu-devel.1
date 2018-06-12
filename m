Received: from eggs.gnu.org ([2001:4830:134:3::10]:58841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3l-0002io-VH
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3l-0001sH-4S
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:44 +1000
Message-Id: <20180612064503.14282-15-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/33] hw/misc/mos6522: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/mos6522.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 6163cea6ab..49166cb8ad 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -189,12 +189,12 @@ static uint64_t mos6522_get_load_time(MOS6522State =
*s, MOS6522Timer *ti)
=20
 static void mos6522_portA_write(MOS6522State *s)
 {
-    qemu_log_mask(LOG_UNIMP, "portA_write unimplemented");
+    qemu_log_mask(LOG_UNIMP, "portA_write unimplemented\n");
 }
=20
 static void mos6522_portB_write(MOS6522State *s)
 {
-    qemu_log_mask(LOG_UNIMP, "portB_write unimplemented");
+    qemu_log_mask(LOG_UNIMP, "portB_write unimplemented\n");
 }
=20
 uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size)
--=20
2.17.1
