Received: from eggs.gnu.org ([2001:4830:134:3::10]:38938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXkL-00060a-Cs
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gDXkC-0000jy-Kc
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58247 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gDXk4-0000Gr-7H
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:35:20 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Oct 2018 18:33:39 +0200
Message-Id: <1539966828-20947-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539966828-20947-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 05/14] target/mips: Add bit encoding for MXU
 add/subtract patterns 'aptn2'
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

From: Craig Janeczek <jancraig@amazon.com>

Add bit encoding for MXU add/subtract patterns 'aptn2'.

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 5f8dcc9..f465635 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23311,6 +23311,13 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+/* MXU add/subtract patterns 'aptn2' */
+#define MXU_APTN2_AA    0
+#define MXU_APTN2_AS    1
+#define MXU_APTN2_SA    2
+#define MXU_APTN2_SS    3
+
+
 /*
  *
  * Decode MXU pool00
-- 
2.7.4
