Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB8BC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E352086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 13:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ZCxwxyDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E352086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgrFD-00039x-Ll
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 09:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46050)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <luc.michel@greensocs.com>) id 1hgqRg-0008C4-9J
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1hgqRe-0000a6-Cz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:57:40 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:37386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1hgqRb-0000Vs-F6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:57:36 -0400
Received: from michell-laptop.bar.greensocs.com (tiramisu.bar.greensocs.com
 [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPS id 4458996F50;
 Fri, 28 Jun 2019 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1561721966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vGJglh702cl6FmRisJGywG+JklkMnabza5AspO4T1mg=;
 b=ZCxwxyDuFpRcpgO5pMImOmPGRT3u+rAJ9LmfFhxpvp4GUwwWB5ZOolyY1tsfOwaqMo8/wI
 7VyovHbgAUMbHtB7mH+2ZYF2hJylKYNS3YV3Q+CrYReGJVBhmRrEiaI9M5Z31J4xNPxxpQ
 BKuXjadrUBwfeBXZZtcaFlxe6YDnYIc=
From: Luc Michel <luc.michel@greensocs.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 13:39:17 +0200
Message-Id: <20190628113917.15869-1-luc.michel@greensocs.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1561721966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vGJglh702cl6FmRisJGywG+JklkMnabza5AspO4T1mg=;
 b=Cbh/iJS1Ogf1gxxRQ5t8tWL/C5cwTLZVxXKa80/sDFPtCnmc9aQKts3zjxL4izs+v0a83F
 ckphuYV7eMebR7nE7vBalo95vNqzAr8p95VMEJ7eu71nxPY2eVEKJjikiCUvh5UYaw2jzN
 4gz0mpec8ia9Th4HqhKrVjYSjKsERKs=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1561721966; a=rsa-sha256; cv=none;
 b=Tf4yhS/UERwQVKapa5GJ8PaC5CGCN6JNUAPUq8bSzpHDeXWdyXqxhaLLihEk0pjOZzfu6K
 KalHXXpjpmg+T6/9t26au9t7kYdz1w+JDNVctusLgKo6Tc7BOlM1bMQdieU3W2UAQK2gMp
 mH0Qa7tKPa3GWoVjHOZtgYBA0EydXoQ=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH] accel/tcg/translator: add tb_enter TCG
 trace
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
Cc: damien.hedde@greensocs.com, mark.burton@greensocs.com, sakisp@xilinx.com,
 edgari@xilinx.com, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a TCG trace at the begining of a translation block recording the
first and last (past-the-end) PC values.

Signed-off-by: Luc Michel <luc.michel@greensocs.com>
---
This can be used to trace the execution of the guest quite efficiently.
It will report each time a TB is entered (using the tb_enter_exec
trace). The traces arguments give the PC start and past-the-end values.
It has very little to no performance impact since the trace is actually
emitted in the generated code only when it is enabled at run time.

It works already quite well on its own to trace guest execution. However
it does not handle the case where a TB is exited in the middle of
execution. I'm not sure how to properly trace that. A trace could be
added when `cpu_loop_exit()' is called to report the current PC, but in
most cases the interesting value (the PC of the instruction that
caused the exit) is already lost at this stage.

I'm not sure there is a generic (i.e. not target specific) way of
recovering the last PC executed when cpu_loop_exit() is called. Do you
think of a better way?

Thanks to the Xilinx's QEMU team who sponsored this work.
---
 accel/tcg/translator.c | 24 ++++++++++++++++++++++++
 trace-events           |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9226a348a3..c55377aa18 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -14,10 +14,11 @@
 #include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
 #include "exec/gen-icount.h"
 #include "exec/log.h"
 #include "exec/translator.h"
+#include "trace-tcg.h"
=20
 /* Pairs with tcg_clear_temp_count.
    To be called by #TranslatorOps.{translate_insn,tb_stop} if
    (1) the target is sufficiently clean to support reporting,
    (2) as and when all temporaries are known to be consumed.
@@ -28,14 +29,31 @@ void translator_loop_temp_check(DisasContextBase *db)
         qemu_log("warning: TCG temporary leaks before "
                  TARGET_FMT_lx "\n", db->pc_next);
     }
 }
=20
+static TCGOp *gen_trace_tb_enter(TranslationBlock *tb)
+{
+    TCGOp *last_pc_op;
+
+    TCGv pc_end =3D tcg_temp_new();
+
+    /* The last PC value is not known yet */
+    tcg_gen_movi_tl(pc_end, 0xdeadbeef);
+    last_pc_op =3D tcg_last_op();
+
+    trace_tb_enter_tcg(tcg_ctx->cpu, cpu_env, tb->pc, pc_end);
+    tcg_temp_free(pc_end);
+
+    return last_pc_op;
+}
+
 void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
                      CPUState *cpu, TranslationBlock *tb, int max_insns)
 {
     int bp_insn =3D 0;
+    TCGOp *trace_pc_end;
=20
     /* Initialize DisasContext */
     db->tb =3D tb;
     db->pc_first =3D tb->pc;
     db->pc_next =3D db->pc_first;
@@ -50,10 +68,13 @@ void translator_loop(const TranslatorOps *ops, DisasC=
ontextBase *db,
     /* Reset the temp count so that we can identify leaks */
     tcg_clear_temp_count();
=20
     /* Start translating.  */
     gen_tb_start(db->tb);
+
+    trace_pc_end =3D gen_trace_tb_enter(tb);
+
     ops->tb_start(db, cpu);
     tcg_debug_assert(db->is_jmp =3D=3D DISAS_NEXT);  /* no early exit */
=20
     while (true) {
         db->num_insns++;
@@ -110,10 +131,13 @@ void translator_loop(const TranslatorOps *ops, Disa=
sContextBase *db,
=20
     /* Emit code to exit the TB, as indicated by db->is_jmp.  */
     ops->tb_stop(db, cpu);
     gen_tb_end(db->tb, db->num_insns - bp_insn);
=20
+    /* Fixup the last PC value in the tb_enter trace now that we know it=
 */
+    tcg_set_insn_param(trace_pc_end, 1, db->pc_next);
+
     /* The disas_log hook may use these values rather than recompute.  *=
/
     db->tb->size =3D db->pc_next - db->pc_first;
     db->tb->icount =3D db->num_insns;
=20
 #ifdef DEBUG_DISAS
diff --git a/trace-events b/trace-events
index aeea3c2bdb..e37fa12ef0 100644
--- a/trace-events
+++ b/trace-events
@@ -157,10 +157,13 @@ vcpu guest_cpu_reset(void)
 #
 # Mode: user, softmmu
 # Targets: TCG(all)
 vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=3D%d", "vaddr=3D=
0x%016"PRIx64" info=3D%d"
=20
+# translator.c
+vcpu tcg tb_enter(uint64_t pc_start, TCGv pc_end) "pc_start:0x%"PRIx64, =
"pc:0x%"PRIx64" pc_end:0x%"PRIx64
+
 # linux-user/syscall.c
 # bsd-user/syscall.c
=20
 # @num: System call number.
 # @arg*: System call argument value.
--=20
2.22.0


