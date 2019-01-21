Received: from eggs.gnu.org ([209.51.188.92]:40240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1glexJ-0001mU-2r
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1glexI-0004L8-Cx
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:57 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:50408 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1glexG-0003uD-B6
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:09:56 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 21 Jan 2019 20:08:14 +0100
Message-Id: <1548097698-28951-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548097698-28951-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548097698-28951-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/6] target/mips: nanoMIPS: Remove an unused
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove a macro that is never used.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index fb2c42c..aad760c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -18393,7 +18393,6 @@ enum {
 
 #define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
 #define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
-#define NANOMIPS_EXTRACT_RS2(op) uMIPS_RS(op)
 #define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
 #define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
 #define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
-- 
2.7.4
