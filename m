Received: from eggs.gnu.org ([209.51.188.92]:57674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08X-0005cb-QY
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08U-0006XL-5r
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:36 +1100
Message-Id: <20190108224600.23125-6-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/29] target/ppc: fix typo in SIMM5 extraction
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

As the macro name suggests, the argument should be signed and not unsigne=
d.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index a9bcadff42..8b35863549 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -124,7 +124,7 @@ EXTRACT_SHELPER(SIMM, 0, 16);
 /* 16 bits unsigned immediate value */
 EXTRACT_HELPER(UIMM, 0, 16);
 /* 5 bits signed immediate value */
-EXTRACT_HELPER(SIMM5, 16, 5);
+EXTRACT_SHELPER(SIMM5, 16, 5);
 /* 5 bits signed immediate value */
 EXTRACT_HELPER(UIMM5, 16, 5);
 /* 4 bits unsigned immediate value */
--=20
2.20.1
