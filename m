Received: from eggs.gnu.org ([2001:4830:134:3::10]:44350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQqB-00056V-JV
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQqA-0002HY-B1
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:11 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:44 +1000
Message-Id: <20180709074350.27086-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/16] ppc440_uc: Fix a copy/paste error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Missed in 3c409c1927e, hopefully reported by Coverity.

Fixes: Coverity CID 1393788 (Copy-paste error)
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_uc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 0bbaa6844a..09ccda548f 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -935,7 +935,7 @@ static void dcr_write_dma(void *opaque, int dcrn, uin=
t32_t val)
                     if (wptr) {
                         cpu_physical_memory_unmap(wptr, wlen, 1, didx);
                     }
-                    if (wptr) {
+                    if (rptr) {
                         cpu_physical_memory_unmap(rptr, rlen, 0, sidx);
                     }
                 }
--=20
2.17.1
