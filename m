Received: from eggs.gnu.org ([209.51.188.92]:39906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyY-000789-5G
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyW-0003Z4-Jt
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:54 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:43 +1100
Message-Id: <20190218143049.17142-38-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/43] target/ppc: Remove vscr_nj and vscr_sat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

These macros are no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215100058.20015-12-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 78af7e4608..1c883fa836 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -689,8 +689,6 @@ enum {
 /* Vector status and control register */
 #define VSCR_NJ		16 /* Vector non-java */
 #define VSCR_SAT	0 /* Vector saturation */
-#define vscr_nj		(((env->vscr) >> VSCR_NJ)	& 0x1)
-#define vscr_sat	(((env->vscr) >> VSCR_SAT)	& 0x1)
=20
 /***********************************************************************=
******/
 /* BookE e500 MMU registers */
--=20
2.20.1
