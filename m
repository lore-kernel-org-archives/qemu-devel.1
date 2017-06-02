Received: from eggs.gnu.org ([2001:4830:134:3::10]:35312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dGpZD-0001HO-Co
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krzk@kernel.org>) id 1dGpZC-0007kw-GK
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:36:51 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri,  2 Jun 2017 18:36:17 +0200
Message-Id: <20170602163618.6369-8-krzk@kernel.org>
In-Reply-To: <20170602163618.6369-1-krzk@kernel.org>
References: <20170602162857.6065-1-krzk@kernel.org>
	<20170602163618.6369-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 8/9] hw/intc/exynos4210_gic: Constify array
 of combiner interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>

The static array of interrupt combiner mappings is not modified so it
can be made const for code safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/intc/exynos4210_gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/exynos4210_gic.c b/hw/intc/exynos4210_gic.c
index 62acede72f62..b6b00a4f5891 100644
--- a/hw/intc/exynos4210_gic.c
+++ b/hw/intc/exynos4210_gic.c
@@ -116,7 +116,7 @@ enum ExtInt {
  * which is INTG16 in Internal Interrupt Combiner.
  */
=20
-static uint32_t
+static const uint32_t
 combiner_grp_to_gic_id[64-EXYNOS4210_MAX_EXT_COMBINER_OUT_IRQ][8] =3D {
     /* int combiner groups 16-19 */
     { }, { }, { }, { },
--=20
2.9.3
