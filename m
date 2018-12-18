Received: from eggs.gnu.org ([2001:4830:134:3::10]:52831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92r-0001dS-TW
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92q-0002oo-0Z
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:57 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92p-0002kn-Bx
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:55 -0500
Received: by mail-pg1-x544.google.com with SMTP id z11so7360434pgu.0
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:05 -0800
Message-Id: <20181218063911.2112-29-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 28/34] target/ppc: Remove vscr_nj and vscr_sat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

These macros are no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c8f449081d..a2fe6058b1 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -700,8 +700,6 @@ enum {
 /* Vector status and control register */
 #define VSCR_NJ		16 /* Vector non-java */
 #define VSCR_SAT	0 /* Vector saturation */
-#define vscr_nj		(((env->vscr) >> VSCR_NJ)	& 0x1)
-#define vscr_sat	(((env->vscr) >> VSCR_SAT)	& 0x1)
 
 /*****************************************************************************/
 /* BookE e500 MMU registers */
-- 
2.17.2
