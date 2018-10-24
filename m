Received: from eggs.gnu.org ([2001:4830:134:3::10]:58579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFI8H-0000FF-BU
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gFI8A-0002SP-Os
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:19:28 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38459 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gFI86-0002Mi-TP
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 08:19:19 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Oct 2018 14:18:29 +0200
Message-Id: <1540383527-7923-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540383527-7923-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 02/20] target/mips: Define a bit for MXU in
 insn_flags
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

Define a bit for MXU in insn_flags. This is the first non-MIPS
(third party) ASE supported in QEMU for MIPS, so it is placed in
the section "bits 56-63: vendor-specific ASEs".

Signed-off-by: Craig Janeczek <jancraig@amazon.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/mips-defs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 5177618..dbdb4b2 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -69,6 +69,7 @@
  *   bits 56-63: vendor-specific ASEs
  */
 #define ASE_MMI           0x0100000000000000ULL
+#define ASE_MXU           0x0200000000000000ULL
 
 /* MIPS CPU defines. */
 #define		CPU_MIPS1	(ISA_MIPS1)
-- 
2.7.4
