Received: from eggs.gnu.org ([2001:4830:134:3::10]:55430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW8-0006ja-5N
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdW7-0005iq-F4
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:08 -0500
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:03 -0800
Message-Id: <20161224040042.12654-27-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 26/65] disas/ppc: Handle popcnt and cnttz
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

Cc: qemu-ppc@nongnu.org
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 disas/ppc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/disas/ppc.c b/disas/ppc.c
index bd05623..ed7e0d0 100644
--- a/disas/ppc.c
+++ b/disas/ppc.c
@@ -1955,6 +1955,9 @@ extract_tbr (unsigned long insn,
 #define POWER4	PPC_OPCODE_POWER4
 #define POWER5	PPC_OPCODE_POWER5
 #define POWER6	PPC_OPCODE_POWER6
+/* Documentation purposes only; we don't actually check the isa for disas.  */
+#define POWER7  PPC_OPCODE_POWER6
+#define POWER9  PPC_OPCODE_POWER6
 #define CELL	PPC_OPCODE_CELL
 #define PPC32   PPC_OPCODE_32 | PPC_OPCODE_PPC
 #define PPC64   PPC_OPCODE_64 | PPC_OPCODE_PPC
@@ -3589,6 +3592,13 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 { "lbzux",   X(31,119),	X_MASK,		COM,		{ RT, RAL, RB } },
 
 { "popcntb", X(31,122), XRB_MASK,	POWER5,		{ RA, RS } },
+{ "popcntw", X(31,378), XRB_MASK,       POWER7,         { RA, RS } },
+{ "popcntd", X(31,506), XRB_MASK,       POWER7,         { RA, RS } },
+
+{ "cnttzw",  XRC(31,538,0), XRB_MASK,   POWER9,         { RA, RS } },
+{ "cnttzw.", XRC(31,538,1), XRB_MASK,   POWER9,         { RA, RS } },
+{ "cnttzd",  XRC(31,570,0), XRB_MASK,   POWER9,         { RA, RS } },
+{ "cnttzd.", XRC(31,570,1), XRB_MASK,   POWER9,         { RA, RS } },
 
 { "not",     XRC(31,124,0), X_MASK,	COM,		{ RA, RS, RBS } },
 { "nor",     XRC(31,124,0), X_MASK,	COM,		{ RA, RS, RB } },
-- 
2.9.3
