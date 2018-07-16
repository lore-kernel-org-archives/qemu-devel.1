Received: from eggs.gnu.org ([2001:4830:134:3::10]:40024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fez1S-0001Dk-60
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fez1Q-00051L-05
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:38:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 16 Jul 2018 18:38:09 +1000
Message-Id: <20180716083809.17115-7-david@gibson.dropbear.id.au>
In-Reply-To: <20180716083809.17115-1-david@gibson.dropbear.id.au>
References: <20180716083809.17115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/6] sm501: Fix warning about unreachable code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Coverity warned that the false arm of conditional expression is
unreachable when it is inside an if with the same condition.
Remove the unreachable code to avoid the warning.

Fixes: CID 1394215
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 9ab29d35dd..874260a143 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1024,7 +1024,7 @@ static void sm501_i2c_write(void *opaque, hwaddr ad=
dr, uint64_t value,
                         if (res) {
                             SM501_DPRINTF("sm501 i2c : transfer failed"
                                           " i=3D%d, res=3D%d\n", i, res)=
;
-                            s->i2c_status |=3D (res ? SM501_I2C_STATUS_E=
RROR : 0);
+                            s->i2c_status |=3D SM501_I2C_STATUS_ERROR;
                             return;
                         }
                     }
--=20
2.17.1
