Received: from eggs.gnu.org ([2001:4830:134:3::10]:60603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsv-00026X-8x
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsu-0001Jp-4P
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:29 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:56 -0300
Message-Id: <20170718061005.29518-21-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 20/29] disas: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eric Blake <eblake@redhat.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 disas/ia64.c |  4 ++--
 disas/m68k.c |  5 ++---
 disas/ppc.c  | 12 ++++--------
 disas/s390.c |  3 +--
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/disas/ia64.c b/disas/ia64.c
index 140754c944..a668a49f69 100644
--- a/disas/ia64.c
+++ b/disas/ia64.c
@@ -385,7 +385,7 @@ struct ia64_operand
 /* Disassemble as unsigned decimal (instead of hex): */
 #define IA64_OPND_FLAG_DECIMAL_UNSIGNED	(1<<1)
 
-#define NELEMS(a)	((int) (sizeof (a) / sizeof (a[0])))
+#define NELEMS(a) ((int) ARRAY_SIZE(a))
 
 static const char*
 ins_rsvd (const struct ia64_operand *self ATTRIBUTE_UNUSED,
@@ -2857,7 +2857,7 @@ static const unsigned short dep257[] = {
   2170, 2173, 2274, 2284, 2327, 4135, 20616, 28866, 29018,
 };
 
-#define NELS(X) (sizeof(X)/sizeof(X[0]))
+#define NELS(X) ARRAY_SIZE(X)
 static const struct ia64_opcode_dependency
 op_dependencies[] = {
   { NELS(dep1), dep1, NELS(dep0), dep0, },
diff --git a/disas/m68k.c b/disas/m68k.c
index 61b689ef3e..9989989e02 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -4197,7 +4197,7 @@ TBL("tblunb", "tblunw", "tblunl", 0, 0),
 {"wdebug", 4,	two(0175750, 03),	two(0177770, 0xffff), "ds", mcfisa_a },
 };
 
-const int m68k_numopcodes = sizeof m68k_opcodes / sizeof m68k_opcodes[0];
+const int m68k_numopcodes = ARRAY_SIZE(m68k_opcodes);
 
 /* These aliases used to be in the above table, each one duplicating
    all of the entries for its primary exactly.  This table was
@@ -4450,8 +4450,7 @@ const struct m68k_opcode_alias m68k_opcode_aliases[] =
 
 };
 
-const int m68k_numaliases =
-  sizeof m68k_opcode_aliases / sizeof m68k_opcode_aliases[0];
+const int m68k_numaliases = ARRAY_SIZE(m68k_opcode_aliases);
 /* **** End of m68k-opc.c */
 /* **** floatformat.c from sourceware.org CVS 2005-08-14.  */
 /* IEEE floating point support routines, for GDB, the GNU Debugger.
diff --git a/disas/ppc.c b/disas/ppc.c
index 5ab9c35a84..337415b887 100644
--- a/disas/ppc.c
+++ b/disas/ppc.c
@@ -893,8 +893,7 @@ const struct powerpc_operand powerpc_operands[] =
   { 0x1, 25, NULL, NULL, PPC_OPERAND_OPTIONAL},
 };
 
-const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
-					   / sizeof (powerpc_operands[0]));
+const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
 
 /* The functions used to insert and extract complicated operands.  */
 
@@ -5029,10 +5028,8 @@ const struct powerpc_opcode powerpc_opcodes[] = {
 
 };
 
-const int powerpc_num_opcodes =
-  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
-

-/* The macro table.  This is only used by the assembler.  */
+const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
+/* The macro table.  This is only used by the assembler. */
 
 /* The expressions of the form (-x ! 31) & (x | 31) have the value 0
    when x=0; 32-x when x is between 1 and 31; are negative if x is
@@ -5086,8 +5083,7 @@ const struct powerpc_macro powerpc_macros[] = {
 { "clrlslwi.",4,  PPCCOM,	"rlwinm. %0,%1,%3,(%2)-(%3),31-(%3)" },
 };
 
-const int powerpc_num_macros =
-  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
+const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
 
 
 /* This file provides several disassembler functions, all of which use
diff --git a/disas/s390.c b/disas/s390.c
index 1f167d2eaa..ffa1519622 100644
--- a/disas/s390.c
+++ b/disas/s390.c
@@ -1893,5 +1893,4 @@ static const struct s390_opcode s390_opcodes[] =
   { "pr", OP16(0x0101LL), MASK_E, INSTR_E, 3, 0},
 };
 
-static const int s390_num_opcodes =
-  sizeof (s390_opcodes) / sizeof (s390_opcodes[0]);
+static const int s390_num_opcodes = ARRAY_SIZE(s390_opcodes);
-- 
2.13.2
