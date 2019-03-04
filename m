Received: from eggs.gnu.org ([209.51.188.92]:46350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIy-00005P-M2
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mIw-0000HR-LP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:02:48 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:01:50 +0100
Message-Id: <20190304120210.31500-8-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 07/27] s390x/tcg: Simplify disassembler operands
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's simplify initialization to 0.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190225200318.16102-3-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 19072efec655..c646e50eb388 100644
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
