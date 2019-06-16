Return-Path: <SRS0=kfsH=UP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA9AC31E50
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 15:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678302084B
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Jun 2019 15:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678302084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40646 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcWsA-0004aN-Fk
	for qemu-devel@archiver.kernel.org; Sun, 16 Jun 2019 11:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hcW9i-0005QA-JQ
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hcW9g-0002YZ-KC
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:29:14 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:55645)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hcW9c-00025h-Lm
 for qemu-devel@nongnu.org; Sun, 16 Jun 2019 10:29:08 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id C68B23F4D1;
 Sun, 16 Jun 2019 23:28:46 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 4F711240085;
 Sun, 16 Jun 2019 23:28:46 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Sun, 16 Jun 2019 23:28:16 +0900
Message-Id: <20190616142836.10614-5-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190616142836.10614-1-ysato@users.sourceforge.jp>
References: <20190616142836.10614-1-ysato@users.sourceforge.jp>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.14
Subject: [Qemu-devel] [PATCH v20 04/24] target/rx: Follow the change of tcg.
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add cpu-param.h
Remove CPU_COMMON
Use env_cpu

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 target/rx/cpu-param.h | 31 +++++++++++++++++++++++++++++++
 target/rx/cpu.h       | 21 +--------------------
 target/rx/cpu.c       |  1 +
 target/rx/op_helper.c |  6 +++---
 4 files changed, 36 insertions(+), 23 deletions(-)
 create mode 100644 target/rx/cpu-param.h

diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
new file mode 100644
index 0000000000..5da87fbebe
--- /dev/null
+++ b/target/rx/cpu-param.h
@@ -0,0 +1,31 @@
+/*
+ *  RX cpu parameters
+ *
+ *  Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef RX_CPU_PARAM_H
+#define RX_CPU_PARAM_H
+
+#define TARGET_LONG_BITS 32
+#define TARGET_PAGE_BITS 12
+
+#define TARGET_PHYS_ADDR_SPACE_BITS 32
+#define TARGET_VIRT_ADDR_SPACE_BITS 32
+
+#define NB_MMU_MODES 1
+#define MMU_MODE0_SUFFIX _all
+
+#endif
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 3e5f371f51..3f9c4fdd25 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -25,14 +25,8 @@
 #include "cpu-qom.h"
 #include "qom/cpu.h"
 
-#define TARGET_LONG_BITS 32
-#define TARGET_PAGE_BITS 12
-
 #include "exec/cpu-defs.h"
 
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
-#define TARGET_VIRT_ADDR_SPACE_BITS 32
-
 /* PSW define */
 REG32(PSW, 0)
 FIELD(PSW, C, 0, 1)
@@ -69,9 +63,6 @@ FIELD(FPSW, FX, 30, 1)
 FIELD(FPSW, FLAGS, 26, 4)
 FIELD(FPSW, FS, 31, 1)
 
-#define NB_MMU_MODES 1
-#define MMU_MODE0_SUFFIX _all
-
 enum {
     NUM_REGS = 16,
 };
@@ -108,8 +99,6 @@ typedef struct CPURXState {
     uint32_t ack_ipl;           /* execute ipl */
     float_status fp_status;
     qemu_irq ack;               /* Interrupt acknowledge */
-
-    CPU_COMMON
 } CPURXState;
 
 /*
@@ -123,19 +112,13 @@ struct RXCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUNegativeOffsetState neg;
     CPURXState env;
 };
 
 typedef struct RXCPU RXCPU;
 typedef RXCPU ArchCPU;
 
-static inline RXCPU *rx_env_get_cpu(CPURXState *env)
-{
-    return container_of(env, RXCPU, env);
-}
-
-#define ENV_GET_CPU(e) CPU(rx_env_get_cpu(e))
-
 #define ENV_OFFSET offsetof(RXCPU, env)
 
 #define RX_CPU_TYPE_SUFFIX "-" TYPE_RX_CPU
@@ -156,8 +139,6 @@ int cpu_rx_signal_handler(int host_signum, void *pinfo,
                            void *puc);
 
 void rx_cpu_list(void);
-void rx_load_image(RXCPU *cpu, const char *filename,
-                   uint32_t start, uint32_t size);
 void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte);
 
 #define cpu_signal_handler cpu_rx_signal_handler
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 4147c5c939..a6dde613ab 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -173,6 +173,7 @@ static void rx_cpu_init(Object *obj)
     RXCPU *cpu = RXCPU(obj);
     CPURXState *env = &cpu->env;
 
+    cpu_set_cpustate_pointers(cpu);
     cs->env_ptr = env;
     qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
 }
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index fb7ae3c3ec..f89d294f2b 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -421,7 +421,7 @@ uint32_t helper_divu(CPURXState *env, uint32_t num, uint32_t den)
 static inline void QEMU_NORETURN raise_exception(CPURXState *env, int index,
                                                  uintptr_t retaddr)
 {
-    CPUState *cs = CPU(rx_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = index;
     cpu_loop_exit_restore(cs, retaddr);
@@ -444,7 +444,7 @@ void QEMU_NORETURN helper_raise_illegal_instruction(CPURXState *env)
 
 void QEMU_NORETURN helper_wait(CPURXState *env)
 {
-    CPUState *cs = CPU(rx_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->halted = 1;
     env->in_sleep = 1;
@@ -453,7 +453,7 @@ void QEMU_NORETURN helper_wait(CPURXState *env)
 
 void QEMU_NORETURN helper_debug(CPURXState *env)
 {
-    CPUState *cs = CPU(rx_env_get_cpu(env));
+    CPUState *cs = env_cpu(env);
 
     cs->exception_index = EXCP_DEBUG;
     cpu_loop_exit(cs);
-- 
2.11.0


