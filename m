Received: from eggs.gnu.org ([208.118.235.92]:41461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gecbq-0005rA-Td
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 04:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gecbn-0007oe-CP
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 04:14:42 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Wed,  2 Jan 2019 09:14:15 +0000
Message-Id: <20190102091423.21155-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190102091423.21155-1-mark.cave-ayland@ilande.co.uk>
References: <20190102091423.21155-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v5 1/9] target/ppc: fix typo in SIMM5
 extraction helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

As the macro name suggests, the argument should be signed and not unsigned.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
-- 
2.11.0
