Received: from eggs.gnu.org ([209.51.188.92]:59931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtF9A-00024i-QM
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtExm-0000v3-1l
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:01:47 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtExl-0000tC-JA
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:01:45 -0500
Received: by mail-pl1-x644.google.com with SMTP id k15so5567335pls.8
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 09:01:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 09:01:34 -0800
Message-Id: <20190211170136.18680-3-richard.henderson@linaro.org>
In-Reply-To: <20190211170136.18680-1-richard.henderson@linaro.org>
References: <20190211170136.18680-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 2/4] tcg/i386: fix unsigned vector saturating
 arithmetic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Due to a cut/paste error in the original implementation, the unsigned
vector saturating arithmetic was erroneously being calculated as signed
vector saturating arithmetic.

Fixes: 8ffafbcec2 ("tcg/i386: Implement vector saturating arithmetic")
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20190207224258.426-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 4d84aea3a9..e0670e5098 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2615,7 +2615,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         OPC_PADDSB, OPC_PADDSW, OPC_UD2, OPC_UD2
     };
     static int const usadd_insn[4] = {
-        OPC_PADDSB, OPC_PADDSW, OPC_UD2, OPC_UD2
+        OPC_PADDUB, OPC_PADDUW, OPC_UD2, OPC_UD2
     };
     static int const sub_insn[4] = {
         OPC_PSUBB, OPC_PSUBW, OPC_PSUBD, OPC_PSUBQ
@@ -2624,7 +2624,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         OPC_PSUBSB, OPC_PSUBSW, OPC_UD2, OPC_UD2
     };
     static int const ussub_insn[4] = {
-        OPC_PSUBSB, OPC_PSUBSW, OPC_UD2, OPC_UD2
+        OPC_PSUBUB, OPC_PSUBUW, OPC_UD2, OPC_UD2
     };
     static int const mul_insn[4] = {
         OPC_UD2, OPC_PMULLW, OPC_PMULLD, OPC_UD2
-- 
2.17.2
