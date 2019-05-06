Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46227C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 13:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CBF0206A3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 13:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBF0206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56475 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNdUc-0003Em-58
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 09:17:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hNdSM-0001fR-Tv
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hNdSL-0000HZ-B9
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:14:58 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:48628)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hNdSL-0000Gm-0U
	for qemu-devel@nongnu.org; Mon, 06 May 2019 09:14:57 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.vps.ablenet.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 846393B7C4;
	Mon,  6 May 2019 22:14:55 +0900 (JST)
Received: from ysato.dip.jp (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 39112240085; 
	Mon,  6 May 2019 22:14:55 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 22:14:36 +0900
Message-Id: <20190506131444.120869-6-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190506131444.120869-1-ysato@users.sourceforge.jp>
References: <20190506131444.120869-1-ysato@users.sourceforge.jp>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.15
Subject: [Qemu-devel] [PATCH v9 05/13] target/rx: Miscellaneous files
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 target/rx/gdbstub.c     | 112 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/rx/monitor.c     |  38 ++++++++++++++++
 target/rx/Makefile.objs |  12 ++++++
 3 files changed, 162 insertions(+)
 create mode 100644 target/rx/gdbstub.c
 create mode 100644 target/rx/monitor.c
 create mode 100644 target/rx/Makefile.objs

diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
new file mode 100644
index 0000000000..d76ca52e82
--- /dev/null
+++ b/target/rx/gdbstub.c
@@ -0,0 +1,112 @@
+/*
+ * RX gdb server stub
+ *
+ * Copyright (c) 2019 Yoshinori Sato
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
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "exec/gdbstub.h"
+
+int rx_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+
+    switch (n) {
+    case 0 ... 15:
+        return gdb_get_regl(mem_buf, env->regs[n]);
+    case 16:
+        return gdb_get_regl(mem_buf, (env->psw_u) ? env->regs[0] : env->usp);
+    case 17:
+        return gdb_get_regl(mem_buf, (!env->psw_u) ? env->regs[0] : env->isp);
+    case 18:
+        return gdb_get_regl(mem_buf, rx_cpu_pack_psw(env));
+    case 19:
+        return gdb_get_regl(mem_buf, env->pc);
+    case 20:
+        return gdb_get_regl(mem_buf, env->intb);
+    case 21:
+        return gdb_get_regl(mem_buf, env->bpsw);
+    case 22:
+        return gdb_get_regl(mem_buf, env->bpc);
+    case 23:
+        return gdb_get_regl(mem_buf, env->fintv);
+    case 24:
+        return gdb_get_regl(mem_buf, env->fpsw);
+    case 25:
+        return 0;
+    }
+    return 0;
+}
+
+int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+    uint32_t psw;
+    switch (n) {
+    case 0 ... 15:
+        env->regs[n] = ldl_p(mem_buf);
+        if (n == 0) {
+            if (env->psw_u) {
+                env->usp = env->regs[0];
+            } else {
+                env->isp = env->regs[0];
+            }
+        }
+        break;
+    case 16:
+        env->usp = ldl_p(mem_buf);
+        if (env->psw_u) {
+            env->regs[0] = ldl_p(mem_buf);
+        }
+        break;
+    case 17:
+        env->isp = ldl_p(mem_buf);
+        if (!env->psw_u) {
+            env->regs[0] = ldl_p(mem_buf);
+        }
+        break;
+    case 18:
+        psw = ldl_p(mem_buf);
+        rx_cpu_unpack_psw(env, psw, 1);
+        break;
+    case 19:
+        env->pc = ldl_p(mem_buf);
+        break;
+    case 20:
+        env->intb = ldl_p(mem_buf);
+        break;
+    case 21:
+        env->bpsw = ldl_p(mem_buf);
+        break;
+    case 22:
+        env->bpc = ldl_p(mem_buf);
+        break;
+    case 23:
+        env->fintv = ldl_p(mem_buf);
+        break;
+    case 24:
+        env->fpsw = ldl_p(mem_buf);
+        break;
+    case 25:
+        return 8;
+    default:
+        return 0;
+    }
+
+    return 4;
+}
diff --git a/target/rx/monitor.c b/target/rx/monitor.c
new file mode 100644
index 0000000000..5d7a1e58b5
--- /dev/null
+++ b/target/rx/monitor.c
@@ -0,0 +1,38 @@
+/*
+ * QEMU monitor
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp-target.h"
+#include "hmp.h"
+
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+{
+    CPUArchState *env = mon_get_cpu_env();
+
+    if (!env) {
+        monitor_printf(mon, "No CPU available\n");
+        return;
+    }
+}
diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
new file mode 100644
index 0000000000..aa6f2d2d6c
--- /dev/null
+++ b/target/rx/Makefile.objs
@@ -0,0 +1,12 @@
+obj-y += translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
+obj-$(CONFIG_SOFTMMU) += monitor.o
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+
+target/rx/decode.inc.c: \
+  $(SRC_PATH)/target/rx/insns.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --varinsnwidth 32 -o $@ $<, "GEN", $(TARGET_DIR)$@)
+
+target/rx/translate.o: target/rx/decode.inc.c
+target/rx/disas.o: target/rx/decode.inc.c
-- 
2.11.0


