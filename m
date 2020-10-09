Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17D2C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB4922248
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 06:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB4922248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmMy-00041m-8h
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 02:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kQmA4-0005nM-SF; Fri, 09 Oct 2020 02:45:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4774 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kQmA1-0001C5-2f; Fri, 09 Oct 2020 02:45:52 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 823846AE669EF6E15121;
 Fri,  9 Oct 2020 14:45:42 +0800 (CST)
Received: from localhost (10.174.186.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 14:45:36 +0800
From: zhaolichang <zhaolichang@huawei.com>
To: <qemu-trivial@nongnu.org>
Subject: [PATCH V2 01/14] cris/: fix some comment spelling errors
Date: Fri, 9 Oct 2020 14:44:36 +0800
Message-ID: <20201009064449.2336-2-zhaolichang@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
In-Reply-To: <20201009064449.2336-1-zhaolichang@huawei.com>
References: <20201009064449.2336-1-zhaolichang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.238]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhaolichang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:45:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: David
 Edmondson <david.edmondson@oracle.com>, zhaolichang <zhaolichang@huawei.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found that there are many spelling errors in the comments of qemu/target/cris.
I used spellcheck to check the spelling errors and found some errors in the folder.

Signed-off-by: zhaolichang <zhaolichang@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
---
 target/cris/helper.c    |  6 +++---
 target/cris/op_helper.c |  2 +-
 target/cris/translate.c | 14 +++++++-------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/cris/helper.c b/target/cris/helper.c
index b5159b8357..50419e72c5 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -141,7 +141,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
     assert(!(env->pregs[PR_CCS] & PFIX_FLAG));
     switch (cs->exception_index) {
     case EXCP_BREAK:
-        /* These exceptions are genereated by the core itself.
+        /* These exceptions are generated by the core itself.
            ERP should point to the insn following the brk.  */
         ex_vec = env->trap_vector;
         env->pregs[PRV10_BRP] = env->pc;
@@ -197,7 +197,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
 
     switch (cs->exception_index) {
     case EXCP_BREAK:
-        /* These exceptions are genereated by the core itself.
+        /* These exceptions are generated by the core itself.
            ERP should point to the insn following the brk.  */
         ex_vec = env->trap_vector;
         env->pregs[PR_ERP] = env->pc;
@@ -256,7 +256,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
        undefined.  */
     env->pc = cpu_ldl_code(env, env->pregs[PR_EBP] + ex_vec * 4);
 
-    /* Clear the excption_index to avoid spurios hw_aborts for recursive
+    /* Clear the excption_index to avoid spurious hw_aborts for recursive
        bus faults.  */
     cs->exception_index = -1;
 
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index 6b1e7ae4a8..3c4aacc26a 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -231,7 +231,7 @@ static inline uint32_t evaluate_flags_writeback(CPUCRISState *env,
 {
     unsigned int x, z, mask;
 
-    /* Extended arithmetics, leave the z flag alone.  */
+    /* Extended arithmetic, leave the z flag alone.  */
     x = env->cc_x;
     mask = env->cc_mask | X_FLAG;
     if (x) {
diff --git a/target/cris/translate.c b/target/cris/translate.c
index c312e6f8a6..16b0ef8073 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -348,7 +348,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, TCGv ccs)
     tcg_temp_free(t);
 }
 
-/* Extended arithmetics on CRIS.  */
+/* Extended arithmetic on CRIS.  */
 static inline void t_gen_add_flag(TCGv d, int flag)
 {
     TCGv c;
@@ -725,7 +725,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
     switch (op) {
     case CC_OP_ADD:
         tcg_gen_add_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_addx_carry(dc, dst);
         break;
     case CC_OP_ADDC:
@@ -738,7 +738,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         break;
     case CC_OP_SUB:
         tcg_gen_sub_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
         break;
     case CC_OP_MOVE:
@@ -764,7 +764,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         break;
     case CC_OP_NEG:
         tcg_gen_neg_tl(dst, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
         break;
     case CC_OP_LZ:
@@ -787,7 +787,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         break;
     case CC_OP_CMP:
         tcg_gen_sub_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
         break;
     default:
@@ -3053,12 +3053,12 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
  * On QEMU care needs to be taken when a branch+delayslot sequence is broken
  * and the branch and delayslot don't share pages.
  *
- * The TB contaning the branch insn will set up env->btarget and evaluate 
+ * The TB containing the branch insn will set up env->btarget and evaluate 
  * env->btaken. When the translation loop exits we will note that the branch 
  * sequence is broken and let env->dslot be the size of the branch insn (those
  * vary in length).
  *
- * The TB contaning the delayslot will have the PC of its real insn (i.e no lsb
+ * The TB containing the delayslot will have the PC of its real insn (i.e no lsb
  * set). It will also expect to have env->dslot setup with the size of the 
  * delay slot so that env->pc - env->dslot point to the branch insn. This TB 
  * will execute the dslot and take the branch, either to btarget or just one 
-- 
2.26.2.windows.1


