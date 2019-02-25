Received: from eggs.gnu.org ([209.51.188.92]:49172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyMTx-0006wr-7v
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:04:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyMTv-00013Y-04
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 15:04:09 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 25 Feb 2019 21:03:13 +0100
Message-Id: <20190225200318.16102-3-david@redhat.com>
In-Reply-To: <20190225200318.16102-1-david@redhat.com>
References: <20190225200318.16102-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/7] s390x/tcg: Simplify disassembler
 operands initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

Let's simplify initialization to 0.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/translate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 19072efec6..c646e50eb3 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6091,7 +6091,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     const DisasInsn *insn;
     DisasJumpType ret = DISAS_NEXT;
     DisasFields f;
-    DisasOps o;
+    DisasOps o = {};
 
     /* Search for the insn in the table.  */
     insn = extract_insn(env, s, &f);
@@ -6161,12 +6161,6 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     /* Set up the strutures we use to communicate with the helpers. */
     s->insn = insn;
     s->fields = &f;
-    o.g_out = o.g_out2 = o.g_in1 = o.g_in2 = false;
-    o.out = NULL;
-    o.out2 = NULL;
-    o.in1 = NULL;
-    o.in2 = NULL;
-    o.addr1 = NULL;
 
     /* Implement the instruction.  */
     if (insn->help_in1) {
-- 
2.17.2
