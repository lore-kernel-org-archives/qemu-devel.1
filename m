Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C7C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618002070D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 22:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618002070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37749 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRP09-000724-Jx
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 18:37:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyO-0005qV-Tc
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hROyN-00023U-PL
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:36 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hROyN-0001zi-FQ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 18:35:35 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MBUuP-1hX9C60p1b-00CzGe; Fri, 17 May 2019 00:35:33 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 00:35:16 +0200
Message-Id: <20190516223519.7520-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190516223519.7520-1-laurent@vivier.eu>
References: <20190516223519.7520-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:l9C8KLvBW2gomwO+cpQLeYlEVNz3HseGsRFns7bsiU+O6tkAfy5
	k5eGTtSxtfBicIOjZ+tSGRY40Rpqn1EKPhDfuSQ7WXFCJ9Pl3CZ39a51u1SUn2mpPLvq8/b
	Kbk7lw1eDPMAcTIg4OFdZHNFK2TaVzRSgGlDK2SVats0o5DZFxTkwmk+H9sSfl9r4UzJHVS
	f11z2bBpZ+9jaXFZKmXSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KuBjqcR/sak=:YFalkuBsw0/Jgukd69HVaS
	kqKHfK9UpnHcYDiT+wqN5/tBNp1dqCtpPS0tlU1vnJ57a+PKwVBR6Y9ryU2c5Fr9ka7q5MfDt
	9i3GbWOaUf+FXLKNLjkuEuBbgQyixNm2+FVX0SIX6yllhXqp3xZwKqdZi+gTrYgHGOkfghr+3
	A4OoErNP48zHBZb2tDGiW1wb/MGZNVW/IfnwCOWvknetxBV37UzC37iKCWrMCPiOvrJM3Ox2l
	M5zeWCHc6+FxfVjeHlfFPxGgOvCMvshZDDbz9jS4dx8QWJzLvNibK+H69FKIFNvIZkMyqw6Gi
	T7nkxz9fgGxkITmNx1WrqSW65f2a1UP8K9qcBu93+lPOQ+IlTe2wT9ENNohc0pOv8o8rWVwo0
	LHZCTOQ6I96EQV9dWnAEaMsRRdTPERNtCmZ6IvlRjCpyueK9Y68WsPFPAs1kY8TZhWunnc+5j
	aj6bNiUp6mbkhUQ3UCKXErBf1ibyVsg4UMiFHJwe3nlxWHPRYHQrEe9MYgsHWs2UnIp07js0m
	bv9E1dtWH2zQbRLPO+tORJ1TMcd7+tBfAnkaT8/3GPCm0o2zCjE0TXWvp5YVMSFAXr36E5Xw6
	yCyVRgkf+dim6prNADyixP8evFFD//4+ig9bplBdcftvavxfrHPUrWfEI+7h6W+JqjNQWyrsq
	V2CHGw4N+AJtK9kYavf9cY3zR8e4GC19GjPkJoWXoe1SgG3OLmRR7aAeKkkRJS+s4RWqo6Xhl
	0wdcL/fQtGha/TuiKGJxB6ldOl7qKUauqn5V9A==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 3/6] target/m68k: Switch to transaction_failed
 hook
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Switch the m68k target from the old unassigned_access hook
to the transaction_failed hook.

The notable difference is that rather than it being called
for all physical memory accesses which fail (including
those made by DMA devices or by the gdbstub), it is only
called for those made by the CPU via its MMU. (In previous
commits we put in explicit checks for the direct physical
loads made by the target/m68k code which will no longer
be handled by calling the unassigned_access hook.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20181210165636.28366-4-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.c       |  2 +-
 target/m68k/cpu.h       |  7 ++++---
 target/m68k/op_helper.c | 20 ++++++++------------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 582e3a73b3..6d09c630b0 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -271,7 +271,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_write_register = m68k_cpu_gdb_write_register;
     cc->handle_mmu_fault = m68k_cpu_handle_mmu_fault;
 #if defined(CONFIG_SOFTMMU)
-    cc->do_unassigned_access = m68k_cpu_unassigned_access;
+    cc->do_transaction_failed = m68k_cpu_transaction_failed;
     cc->get_phys_page_debug = m68k_cpu_get_phys_page_debug;
 #endif
     cc->disas_set_info = m68k_cpu_disas_set_info;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index ad41608341..6039b47d0c 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -544,9 +544,10 @@ static inline int cpu_mmu_index (CPUM68KState *env, bool ifetch)
 
 int m68k_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int size, int rw,
                               int mmu_idx);
-void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr,
-                                bool is_write, bool is_exec, int is_asi,
-                                unsigned size);
+void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                                 unsigned size, MMUAccessType access_type,
+                                 int mmu_idx, MemTxAttrs attrs,
+                                 MemTxResult response, uintptr_t retaddr);
 
 #include "exec/cpu-all.h"
 
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 76f439985a..1c272b4cda 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -454,19 +454,15 @@ static inline void do_interrupt_m68k_hardirq(CPUM68KState *env)
     do_interrupt_all(env, 1);
 }
 
-void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
-                                bool is_exec, int is_asi, unsigned size)
+void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
+                                 unsigned size, MMUAccessType access_type,
+                                 int mmu_idx, MemTxAttrs attrs,
+                                 MemTxResult response, uintptr_t retaddr)
 {
     M68kCPU *cpu = M68K_CPU(cs);
     CPUM68KState *env = &cpu->env;
-#ifdef DEBUG_UNASSIGNED
-    qemu_log_mask(CPU_LOG_INT, "Unassigned " TARGET_FMT_plx " wr=%d exe=%d\n",
-             addr, is_write, is_exec);
-#endif
-    if (env == NULL) {
-        /* when called from gdb, env is NULL */
-        return;
-    }
+
+    cpu_restore_state(cs, retaddr, true);
 
     if (m68k_feature(env, M68K_FEATURE_M68040)) {
         env->mmu.mmusr = 0;
@@ -476,7 +472,7 @@ void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
         if (env->sr & SR_S) { /* SUPERVISOR */
             env->mmu.ssw |= M68K_TM_040_SUPER;
         }
-        if (is_exec) { /* instruction or data */
+        if (access_type == MMU_INST_FETCH) { /* instruction or data */
             env->mmu.ssw |= M68K_TM_040_CODE;
         } else {
             env->mmu.ssw |= M68K_TM_040_DATA;
@@ -494,7 +490,7 @@ void m68k_cpu_unassigned_access(CPUState *cs, hwaddr addr, bool is_write,
             break;
         }
 
-        if (!is_write) {
+        if (access_type != MMU_DATA_STORE) {
             env->mmu.ssw |= M68K_RW_040;
         }
 
-- 
2.20.1


