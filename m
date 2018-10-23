Received: from eggs.gnu.org ([2001:4830:134:3::10]:56895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEzPm-0006Ts-3s
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEzPe-0001H0-NP
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:14 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45318 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEzPe-0001FW-8X
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 12:20:10 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Oct 2018 18:18:19 +0200
Message-Id: <1540311509-23970-9-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540311509-23970-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540311509-23970-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 08/18] target/mips: Add bit encoding for MXU
 execute add/sub pattern 'eptn2'
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

Add bit encoding for MXU execute 2-bit add/subtract pattern 'eptn2'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 97fb2e0..665a584 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -23855,6 +23855,12 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
 #define MXU_APTN2_SA    2
 #define MXU_APTN2_SS    3
 
+/* MXU execute add/subtract 2-bit pattern 'eptn2' */
+#define MXU_EPTN2_AA    0
+#define MXU_EPTN2_AS    1
+#define MXU_EPTN2_SA    2
+#define MXU_EPTN2_SS    3
+
 
 /*
  *
-- 
2.7.4
