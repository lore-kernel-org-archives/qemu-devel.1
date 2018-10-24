Received: from eggs.gnu.org ([2001:4830:134:3::10]:58952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFI8v-0000kK-3r
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFI8p-00033W-6d
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:20:09 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39064 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFI8o-00031W-Qt
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:20:03 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 14:18:33 +0200
Message-Id: <1540383527-7923-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 06/20] target/mips: Add bit encoding for MXU
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

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ed72b32..f274ac1 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23844,6 +23844,12 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
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
