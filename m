Received: from eggs.gnu.org ([2001:4830:134:3::10]:48761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5h2-0008HD-9K
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH5h1-0003m7-Eq
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:48 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33428 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH5h1-0003jv-6P
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:26:47 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 12:25:14 +0100
Message-Id: <1540812328-16163-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540812328-16163-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 06/20] target/mips: Add bit encoding for MXU
 accumulate add/sub 1-bit pattern 'aptn1'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, jancraig@amazon.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add bit encoding for MXU accumulate add/subtract 1-bit pattern
'aptn1'.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 699a7e7..7130729 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23976,6 +23976,12 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+
+/* MXU accumulate add/subtract 1-bit pattern 'aptn1' */
+#define MXU_APTN1_A    0
+#define MXU_APTN1_S    1
+
+
 /*
  *
  * Decode MXU pool00
-- 
2.7.4
