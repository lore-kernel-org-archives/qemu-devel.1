Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09159C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:14:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C202420679
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 14:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5KiN35V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C202420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxB5d-00041j-0C
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 10:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hxB5C-0003aI-QE
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hxB5B-0000v5-4d
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 10:13:58 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hxB5A-0000ul-T4; Mon, 12 Aug 2019 10:13:57 -0400
Received: by mail-pf1-x441.google.com with SMTP id u14so49776262pfn.2;
 Mon, 12 Aug 2019 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=jeVYxBKWMzqjksCMr2kqixZfwiMeOmYGjjMCVnetHOg=;
 b=Q5KiN35V4UCGQaCmu6rIn2KbwEXgpg5gXMfh9pbeMhynduUENSyoWeoL+1OiobzrKJ
 fjJQ4E1ilciCk2wRQiKfk2BqpSgGzqPF03SRk0oI3Z6YBHA1oa1o+iR+5I/ltN3UTHeu
 8U6ejEexIIRietyVqJrA4N9eGdDxwlm3Z76KgeuvNldl/3cirYlpMfHQ3PlYyLNhJzuS
 7FB1nva4mmSskIo1XX7efNpVfvG0TXdLrt9xe0kxr0zndHu0VBnIsfSp4q6NJvEAuvgx
 Ks3VA9eElM/vsugLqCrO3qKl7iKs4xXRq0zEJsohWZvXz3+MDVLIFJtmWHmQJM6t4u2s
 Am3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=jeVYxBKWMzqjksCMr2kqixZfwiMeOmYGjjMCVnetHOg=;
 b=tjQMxEkd0jrKY+5wRQqlwYDx8AMNIlPcfjtx2oNkOLCudOxLks9ktrPZKyhuMtrVYA
 YYLUZBS6GDK8YpVKy73byFlgs2buw1WA0ZapOEkkk8XGso0MfjlNGuOxNC/mpP+A//Sg
 lW+hjD+v61EsqTm8Tjzsa13MoeuTE42VXdVrH/SA4Amps7tKc9USgNciEBto9yOg2eoU
 KRKBlhFqGvfm7cgHkjz+l2g9LIs69urqTq6HyVeY9mgnA4zkCDfVzyRR1PbtQefMUS0l
 YszTVXRo6lhv43HusXBGjtviG8agzPhIo5D77MZrBuyLzI8hn0kr5wd8+Ag360Wblhga
 Skjw==
X-Gm-Message-State: APjAAAVGr1zjdenRtfAeG2UL8KSZrbH7BuUTaiBSZPBlTMsdiKRZ7KuK
 natFu5HyYBB8nPNbozRKGBM=
X-Google-Smtp-Source: APXvYqx4ne8KkQBpKHdTXT6yrMBXZA+TjvvgDti2dnUZDg9o6MseqQVAv5PL6MokQE3cp5lDaTszBg==
X-Received: by 2002:a63:1020:: with SMTP id f32mr31396124pgl.203.1565619235410; 
 Mon, 12 Aug 2019 07:13:55 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id t96sm13406767pjb.1.2019.08.12.07.13.54
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 12 Aug 2019 07:13:54 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon, 12 Aug 2019 07:13:49 -0700
Message-Id: <1565619229-379-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3] riscv: hmp: Add a command to show virtual
 memory mappings
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds 'info mem' command for RISC-V, to show virtual memory
mappings of each hart that aids debugging.

Rather than showing every valid PTE, the command compacts the
output by merging all contiguous physical address mappings into
one block and only shows the merged block mapping details.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

---

Changes in v3:
- print PTEs for all harts instead of just current hart

Changes in v2:
- promote ppn to hwaddr when doing page table address calculation

 hmp-commands-info.hx       |   2 +-
 target/riscv/Makefile.objs |   4 +
 target/riscv/monitor.c     | 234 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/monitor.c

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c59444c..257ee7d 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -249,7 +249,7 @@ STEXI
 Show virtual to physical memory mappings.
 ETEXI
 
-#if defined(TARGET_I386)
+#if defined(TARGET_I386) || defined(TARGET_RISCV)
     {
         .name       = "mem",
         .args_type  = "",
diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
index b1c79bc..a8ceccd 100644
--- a/target/riscv/Makefile.objs
+++ b/target/riscv/Makefile.objs
@@ -1,5 +1,9 @@
 obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o pmp.o
 
+ifeq ($(CONFIG_SOFTMMU),y)
+obj-y += monitor.o
+endif
+
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
 
 decode32-y = $(SRC_PATH)/target/riscv/insn32.decode
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
new file mode 100644
index 0000000..9b480ad
--- /dev/null
+++ b/target/riscv/monitor.c
@@ -0,0 +1,234 @@
+/*
+ * QEMU monitor for RISC-V
+ *
+ * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
+ *
+ * RISC-V specific monitor commands implementation
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
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "cpu_bits.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp-target.h"
+
+#ifdef TARGET_RISCV64
+#define PTE_HEADER_FIELDS       "vaddr            paddr            "\
+                                "size             attr\n"
+#define PTE_HEADER_DELIMITER    "---------------- ---------------- "\
+                                "---------------- -------\n"
+#else
+#define PTE_HEADER_FIELDS       "vaddr    paddr            size     attr\n"
+#define PTE_HEADER_DELIMITER    "-------- ---------------- -------- -------\n"
+#endif
+
+/* Perform linear address sign extension */
+static target_ulong addr_canonical(int va_bits, target_ulong addr)
+{
+#ifdef TARGET_RISCV64
+    if (addr & (1UL << (va_bits - 1))) {
+        addr |= (hwaddr)-(1L << va_bits);
+    }
+#endif
+
+    return addr;
+}
+
+static void print_pte_header(Monitor *mon)
+{
+    monitor_printf(mon, PTE_HEADER_FIELDS);
+    monitor_printf(mon, PTE_HEADER_DELIMITER);
+}
+
+static void print_pte(Monitor *mon, int va_bits, target_ulong vaddr,
+                      hwaddr paddr, target_ulong size, int attr)
+{
+    /* santity check on vaddr */
+    if (vaddr >= (1UL << va_bits)) {
+        return;
+    }
+
+    if (!size) {
+        return;
+    }
+
+    monitor_printf(mon, TARGET_FMT_lx " " TARGET_FMT_plx " " TARGET_FMT_lx
+                   " %c%c%c%c%c%c%c\n",
+                   addr_canonical(va_bits, vaddr),
+                   paddr, size,
+                   attr & PTE_R ? 'r' : '-',
+                   attr & PTE_W ? 'w' : '-',
+                   attr & PTE_X ? 'x' : '-',
+                   attr & PTE_U ? 'u' : '-',
+                   attr & PTE_G ? 'g' : '-',
+                   attr & PTE_A ? 'a' : '-',
+                   attr & PTE_D ? 'd' : '-');
+}
+
+static void walk_pte(Monitor *mon, hwaddr base, target_ulong start,
+                     int level, int ptidxbits, int ptesize, int va_bits,
+                     target_ulong *vbase, hwaddr *pbase, hwaddr *last_paddr,
+                     target_ulong *last_size, int *last_attr)
+{
+    hwaddr pte_addr;
+    hwaddr paddr;
+    target_ulong pgsize;
+    target_ulong pte;
+    int ptshift;
+    int attr;
+    int idx;
+
+    if (level < 0) {
+        return;
+    }
+
+    ptshift = level * ptidxbits;
+    pgsize = 1UL << (PGSHIFT + ptshift);
+
+    for (idx = 0; idx < (1UL << ptidxbits); idx++) {
+        pte_addr = base + idx * ptesize;
+        cpu_physical_memory_read(pte_addr, &pte, ptesize);
+
+        paddr = (hwaddr)(pte >> PTE_PPN_SHIFT) << PGSHIFT;
+        attr = pte & 0xff;
+
+        /* PTE has to be valid */
+        if (attr & PTE_V) {
+            if (attr & (PTE_R | PTE_W | PTE_X)) {
+                /*
+                 * A leaf PTE has been found
+                 *
+                 * If current PTE's permission bits differ from the last one,
+                 * or current PTE's ppn does not make a contiguous physical
+                 * address block together with the last one, print out the last
+                 * contiguous mapped block details.
+                 */
+                if ((*last_attr != attr) ||
+                    (*last_paddr + *last_size != paddr)) {
+                    print_pte(mon, va_bits, *vbase, *pbase,
+                              *last_paddr + *last_size - *pbase, *last_attr);
+
+                    *vbase = start;
+                    *pbase = paddr;
+                    *last_attr = attr;
+                }
+
+                *last_paddr = paddr;
+                *last_size = pgsize;
+            } else {
+                /* pointer to the next level of the page table */
+                walk_pte(mon, paddr, start, level - 1, ptidxbits, ptesize,
+                         va_bits, vbase, pbase, last_paddr,
+                         last_size, last_attr);
+            }
+        }
+
+        start += pgsize;
+    }
+
+}
+
+static void mem_info_svxx(Monitor *mon, CPUArchState *env)
+{
+    int levels, ptidxbits, ptesize, vm, va_bits;
+    hwaddr base;
+    target_ulong vbase;
+    hwaddr pbase;
+    hwaddr last_paddr;
+    target_ulong last_size;
+    int last_attr;
+
+    base = (hwaddr)get_field(env->satp, SATP_PPN) << PGSHIFT;
+
+    vm = get_field(env->satp, SATP_MODE);
+    switch (vm) {
+    case VM_1_10_SV32:
+        levels = 2;
+        ptidxbits = 10;
+        ptesize = 4;
+        break;
+    case VM_1_10_SV39:
+        levels = 3;
+        ptidxbits = 9;
+        ptesize = 8;
+        break;
+    case VM_1_10_SV48:
+        levels = 4;
+        ptidxbits = 9;
+        ptesize = 8;
+        break;
+    case VM_1_10_SV57:
+        levels = 5;
+        ptidxbits = 9;
+        ptesize = 8;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+
+    /* calculate virtual address bits */
+    va_bits = PGSHIFT + levels * ptidxbits;
+
+    /* print header */
+    print_pte_header(mon);
+
+    vbase = -1;
+    pbase = -1;
+    last_paddr = -1;
+    last_size = 0;
+    last_attr = 0;
+
+    /* walk page tables, starting from address 0 */
+    walk_pte(mon, base, 0, levels - 1, ptidxbits, ptesize, va_bits,
+             &vbase, &pbase, &last_paddr, &last_size, &last_attr);
+
+    /* don't forget the last one */
+    print_pte(mon, va_bits, vbase, pbase,
+              last_paddr + last_size - pbase, last_attr);
+}
+
+void hmp_info_mem(Monitor *mon, const QDict *qdict)
+{
+    CPUArchState *env;
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        monitor_printf(mon, "\nhart#%d:\n", cs->cpu_index);
+
+        env = (CPUArchState *)(cs->env_ptr);
+        if (!env) {
+            monitor_printf(mon, "No CPU available\n");
+            continue;
+        }
+
+        if (!riscv_feature(env, RISCV_FEATURE_MMU)) {
+            monitor_printf(mon, "S-mode MMU unavailable\n");
+            continue;
+        }
+
+        if (env->priv_ver < PRIV_VERSION_1_10_0) {
+            monitor_printf(mon, "Privileged mode < 1.10 unsupported\n");
+            continue;
+        }
+
+        if (!(env->satp & SATP_MODE)) {
+            monitor_printf(mon, "No translation or protection\n");
+            continue;
+        }
+
+        mem_info_svxx(mon, env);
+    }
+}
-- 
2.7.4


