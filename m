Received: from eggs.gnu.org ([2001:4830:134:3::10]:46474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8SP-0002nB-GI
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Qo-0002hg-Tn
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:54:57 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54343 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8Qo-0002gn-K5
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:53:18 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:51:58 +0200
Message-Id: <1532004727-13778-3-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 02/11] target/mips: Workaround for
 checkpatch.pl hanging on msa_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

If checkpatch.pl is applied (using switch "-f") on file
target/mips/msa_helper.c, it will hang.

This is a workaround by correcting the source file. The workaround is
found by partial deleting and undeleting of the code in msa_helper.c
in binary search fashion.

The bug (for checkpatch.pl) is already reported to the qemu-devel list.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/msa_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index c74e3cd..1691b70 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -2750,8 +2750,8 @@ void helper_msa_ftq_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 
 #define FMAXMIN_A(F, G, X, _S, _T, BITS, STATUS)                    \
     do {                                                            \
-        uint## BITS ##_t S = _S, T = _T;                            \
-        uint## BITS ##_t as, at, xs, xt, xd;                        \
+        uint## BITS ## _t S = _S, T = _T;                           \
+        uint## BITS ## _t as, at, xs, xt, xd;                       \
         if (NUMBER_QNAN_PAIR(S, T, BITS, STATUS)) {                 \
             T = S;                                                  \
         }                                                           \
-- 
2.7.4
