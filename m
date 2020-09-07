Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181ACC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:21:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF082075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PT/LZSS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF082075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFG9M-0000dk-G8
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFG04-0004UT-4t
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58509)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFG02-0007xD-64
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599480713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=1QysZWRlo9EIs93h7DxGsAI8V3a46YYZMxwFvZBPfuw=;
 b=PT/LZSS6aRau3SwqGed0VGdlQtlw+NKY82ansjLWW+Ess30WUc7glTaoQT8sdpQlk8XwZt
 4xVbMkTRi/LmFG/43I6K9RVK8qRuz5+awQtHooSzAEUmQDv2RdevNHX6fpIsHb3aVtGiMs
 UYUo2ZIDzFphrQo8RLgYMeo442X4w/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-mjVja0MiMQGbH6X9T7X7nQ-1; Mon, 07 Sep 2020 08:11:51 -0400
X-MC-Unique: mjVja0MiMQGbH6X9T7X7nQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72C4E18B9F8F;
 Mon,  7 Sep 2020 12:11:50 +0000 (UTC)
Received: from thuth.com (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96DAA5C1BB;
 Mon,  7 Sep 2020 12:11:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/14] target/microblaze: Collected fixes for env->iflags
Date: Mon,  7 Sep 2020 14:11:27 +0200
Message-Id: <20200907121127.136243-15-thuth@redhat.com>
In-Reply-To: <20200907121127.136243-1-thuth@redhat.com>
References: <20200907121127.136243-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

There are several problems here that can result in soft lockup,
depending on exactly where an interrupt or exception is delivered:

Include BIMM_FLAG in IFLAGS_TB_MASK, since it needs to follow D_FLAG.
Ensure that iflags is 0 when entering an interrupt/exception handler.
Add mb_cpu_synchronize_from_tb to restore iflags from tb->flags.
The change to t_sync_flags is cosmetic, but makes the code clearer.

This fixes the reported regression in acceptance/replay_kernel.py.

Fixes: 683a247ed7a4 ("target/microblaze: Store "current" iflags in insn_start")
Tested-by: Thomas Huth <thuth@redhat.com>
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200904190842.2282109-2-richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/microblaze/cpu.c       | 11 +++++++++++
 target/microblaze/cpu.h       |  3 ++-
 target/microblaze/helper.c    | 17 +++++++++++------
 target/microblaze/translate.c |  4 ++--
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 67017ecc33..6392524135 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -80,6 +80,16 @@ static void mb_cpu_set_pc(CPUState *cs, vaddr value)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
 
     cpu->env.pc = value;
+    /* Ensure D_FLAG and IMM_FLAG are clear for the new PC */
+    cpu->env.iflags = 0;
+}
+
+static void mb_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+
+    cpu->env.pc = tb->pc;
+    cpu->env.iflags = tb->flags & IFLAGS_TB_MASK;
 }
 
 static bool mb_cpu_has_work(CPUState *cs)
@@ -321,6 +331,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = mb_cpu_exec_interrupt;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
+    cc->synchronize_from_tb = mb_cpu_synchronize_from_tb;
     cc->gdb_read_register = mb_cpu_gdb_read_register;
     cc->gdb_write_register = mb_cpu_gdb_write_register;
     cc->tlb_fill = mb_cpu_tlb_fill;
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d11b6fa995..a25a2b427f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -270,7 +270,8 @@ struct CPUMBState {
 #define D_FLAG		(1 << 19)  /* Bit in ESR.  */
 
 /* TB dependent CPUMBState.  */
-#define IFLAGS_TB_MASK  (D_FLAG | IMM_FLAG | DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)
+#define IFLAGS_TB_MASK  (D_FLAG | BIMM_FLAG | IMM_FLAG | \
+                         DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)
 #define MSR_TB_MASK     (MSR_UM | MSR_VM | MSR_EE)
 
     uint32_t iflags;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 48547385b0..00090526da 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -113,7 +113,10 @@ void mb_cpu_do_interrupt(CPUState *cs)
     uint32_t t, msr = mb_cpu_read_msr(env);
 
     /* IMM flag cannot propagate across a branch and into the dslot.  */
-    assert(!((env->iflags & D_FLAG) && (env->iflags & IMM_FLAG)));
+    assert((env->iflags & (D_FLAG | IMM_FLAG)) != (D_FLAG | IMM_FLAG));
+    /* BIMM flag cannot be set without D_FLAG. */
+    assert((env->iflags & (D_FLAG | BIMM_FLAG)) != BIMM_FLAG);
+    /* RTI flags are private to translate. */
     assert(!(env->iflags & (DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)));
     env->res_addr = RES_ADDR_NONE;
     switch (cs->exception_index) {
@@ -146,7 +149,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
                           env->pc, env->ear,
                           env->esr, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-            env->iflags &= ~(IMM_FLAG | D_FLAG);
+            env->iflags = 0;
             env->pc = cpu->cfg.base_vectors + 0x20;
             break;
 
@@ -186,14 +189,14 @@ void mb_cpu_do_interrupt(CPUState *cs)
                           "exception at pc=%x ear=%" PRIx64 " iflags=%x\n",
                           env->pc, env->ear, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-            env->iflags &= ~(IMM_FLAG | D_FLAG);
+            env->iflags = 0;
             env->pc = cpu->cfg.base_vectors + 0x20;
             break;
 
         case EXCP_IRQ:
             assert(!(msr & (MSR_EIP | MSR_BIP)));
             assert(msr & MSR_IE);
-            assert(!(env->iflags & D_FLAG));
+            assert(!(env->iflags & (D_FLAG | IMM_FLAG)));
 
             t = (msr & (MSR_VM | MSR_UM)) << 1;
 
@@ -226,13 +229,14 @@ void mb_cpu_do_interrupt(CPUState *cs)
             mb_cpu_write_msr(env, msr);
 
             env->regs[14] = env->pc;
+            env->iflags = 0;
             env->pc = cpu->cfg.base_vectors + 0x10;
             //log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             break;
 
         case EXCP_HW_BREAK:
-            assert(!(env->iflags & IMM_FLAG));
-            assert(!(env->iflags & D_FLAG));
+            assert(!(env->iflags & (D_FLAG | IMM_FLAG)));
+
             t = (msr & (MSR_VM | MSR_UM)) << 1;
             qemu_log_mask(CPU_LOG_INT,
                           "break at pc=%x msr=%x %x iflags=%x\n",
@@ -242,6 +246,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             msr |= t;
             msr |= MSR_BIP;
             env->regs[16] = env->pc;
+            env->iflags = 0;
             env->pc = cpu->cfg.base_vectors + 0x18;
             mb_cpu_write_msr(env, msr);
             break;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a377818b5e..a8a3249185 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -91,8 +91,8 @@ static int typeb_imm(DisasContext *dc, int x)
 static void t_sync_flags(DisasContext *dc)
 {
     /* Synch the tb dependent flags between translator and runtime.  */
-    if ((dc->tb_flags ^ dc->base.tb->flags) & ~MSR_TB_MASK) {
-        tcg_gen_movi_i32(cpu_iflags, dc->tb_flags & ~MSR_TB_MASK);
+    if ((dc->tb_flags ^ dc->base.tb->flags) & IFLAGS_TB_MASK) {
+        tcg_gen_movi_i32(cpu_iflags, dc->tb_flags & IFLAGS_TB_MASK);
     }
 }
 
-- 
2.18.2


