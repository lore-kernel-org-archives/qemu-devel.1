Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B51AC3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA56D21897
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FytNptYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA56D21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3h4K-0002g7-H1
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 09:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3gxp-0006R9-Px
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1i3gxh-0002ui-N3
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:29:15 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734]:36160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1i3gxh-0002sj-1f
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:29:09 -0400
Received: by mail-qk1-x734.google.com with SMTP id d23so6117685qko.3
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yfyGE+FNbrAIEiZJiPMjAsRKhvxpo+JwFp+DO5oZcN4=;
 b=FytNptYnBFQwbgY3GGnzqpvxYpjVVYldJosCDuWs3M/WGmgr412UWt8YRGpVa8U6FR
 6dONmRskEsDva8bClSIngen1+FkVuqqTeE2TpaL7fML6Z/TKBKYApJETCRzKCImT7O2w
 LxE7WAPxJkx/96ZSNywUpZfi3GKkPO1yjOpvr75KbRYC6LArzoh40ovshDI78Mu3wXXA
 Yfh12KcoWbyts7C8zZR3FQpNOV6HBnT4U5AknQLenJCEu7SbZrSKysa6nxM1xPq1PrPP
 Ct68nJQcITld8VRGr8aFJ9LDftpuHNByGiNOkv2BURDNyeMSX4Mx+SwD2R4YlyAI2C+B
 YCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yfyGE+FNbrAIEiZJiPMjAsRKhvxpo+JwFp+DO5oZcN4=;
 b=N57SCsHp3BfjzlWWw8oK+UIYSe5mgnGmMcfrN9nD2sH0wX1qYwYYC1rVxbLBiqUSu4
 QoqVthxgqCPTBR0J6AKMF1DmAKJoKzvEidfsyPEJHcpEQ/DCxFy7iG/afOeI2ZXAyGfe
 yzTRzunfb1BuEPeXsKI3lcx2Ij41rHOdoxFbh8pWxD3WPo5YzXyLeiZcLqYlCs2ywx2d
 gIzYl9q1vmFRZ6fSgZcHf/5M8S7JrrcNgT/wQ6Nh2VPWVFUYsomJ6SIb8QhnRK6mGFRC
 vEQnyNrIP2JOXjJoIb3egYiRs6wWcS1zRmmkCg9y4SzoOAagmcY4UMJc41xMI3nBLE8X
 VAlQ==
X-Gm-Message-State: APjAAAVcltyrg7qPCaY1el0pJQmXHK4FTIjz/VKOUWX2Gm3X83V1Ph0L
 giGUq24yqlEW/pHwib0TaB9sWt/KRPjdVw==
X-Google-Smtp-Source: APXvYqwMwPS36frP/2cVFWmYLLfguhcDyM8sc/GKlKqGfI3GB9VJwA2Y/eOgnbh3Gr8vmo1HXkE5IA==
X-Received: by 2002:a37:a305:: with SMTP id m5mr1541345qke.124.1567167555856; 
 Fri, 30 Aug 2019 05:19:15 -0700 (PDT)
Received: from vanderson-lmcad.gw.lmcad.ic.unicamp.br (gw.lmcad.ic.unicamp.br.
 [143.106.73.166]) by smtp.googlemail.com with ESMTPSA id
 o127sm3001299qkd.104.2019.08.30.05.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 05:19:15 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 30 Aug 2019 09:19:02 -0300
Message-Id: <20190830121903.17585-2-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190830121903.17585-1-vandersonmr2@gmail.com>
References: <20190830121903.17585-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::734
Subject: [Qemu-devel] [PATCH v2 1/2] accel/tcg: adding integration with
 linux perf
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 vandersonmr <vandersonmr2@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds support to Linux Perf in order
to be able to analyze qemu jitted code and
also to able to see the TBs PC in it.

When using "-perf" qemu creates a jitdump file in
the current working directory. The file format
specification can be found in:
https://github.com/torvalds/linux/blob/master/tools/perf/Documentation/jitdump-specification.tx

Example of use:
 perf record -k 1 qemu-x86_64 -perf ./a.out
 perf inject -j -i perf.data -o perf.data.jitted
 perf report -i perf.data.jitted

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 accel/tcg/Makefile.objs      |   1 +
 accel/tcg/perf/Makefile.objs |   1 +
 accel/tcg/perf/jitdump.c     | 192 +++++++++++++++++++++++++++++++++++
 accel/tcg/perf/jitdump.h     |  36 +++++++
 accel/tcg/translate-all.c    |  14 +++
 include/qemu-common.h        |   3 +
 linux-user/main.c            |   7 ++
 os-posix.c                   |   3 +
 qemu-options.hx              |  11 ++
 9 files changed, 268 insertions(+)
 create mode 100644 accel/tcg/perf/Makefile.objs
 create mode 100644 accel/tcg/perf/jitdump.c
 create mode 100644 accel/tcg/perf/jitdump.h

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index d381a02f34..f393a7438f 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -3,6 +3,7 @@ obj-$(CONFIG_SOFTMMU) += cputlb.o
 obj-y += tcg-runtime.o tcg-runtime-gvec.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o
+obj-y += perf/
 
 obj-$(CONFIG_USER_ONLY) += user-exec.o
 obj-$(call lnot,$(CONFIG_SOFTMMU)) += user-exec-stub.o
diff --git a/accel/tcg/perf/Makefile.objs b/accel/tcg/perf/Makefile.objs
new file mode 100644
index 0000000000..ca9abb4f48
--- /dev/null
+++ b/accel/tcg/perf/Makefile.objs
@@ -0,0 +1 @@
+obj-$(CONFIG_LINUX) += jitdump.o
diff --git a/accel/tcg/perf/jitdump.c b/accel/tcg/perf/jitdump.c
new file mode 100644
index 0000000000..6fb464039d
--- /dev/null
+++ b/accel/tcg/perf/jitdump.c
@@ -0,0 +1,192 @@
+/*
+ * This code implements an interface to create and fill jitdump files. These files
+ * store information used by Linux Perf to enhance the presentation of jitted
+ * code and to allow the disassembly of jitted code.
+ *
+ * The jitdump file specification can be found in the Linux Kernel Source tree:
+ *    linux/tools/perf/Documentation/jitdump-specification.txt
+ *
+ * https://github.com/torvalds/linux/blob/master/tools/perf/Documentation/jitdump-specification.txt
+ */
+
+#include "qemu/osdep.h"
+
+#include <sys/syscall.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <time.h>
+#include <elf.h>
+
+#include "disas/disas.h"
+#include "jitdump.h"
+#include "qemu-common.h"
+
+struct jitheader {
+    uint32_t magic;     /* characters "jItD" */
+    uint32_t version;   /* header version */
+    uint32_t total_size;/* total size of header */
+    uint32_t elf_mach;  /* elf mach target */
+    uint32_t pad1;      /* reserved */
+    uint32_t pid;       /* JIT process id */
+    uint64_t timestamp; /* timestamp */
+    uint64_t flags;     /* flags */
+};
+
+enum jit_record_type {
+    JIT_CODE_LOAD       = 0,
+    JIT_CODE_MOVE       = 1,
+    JIT_CODE_DEBUG_INFO = 2,
+    JIT_CODE_CLOSE      = 3,
+
+    JIT_CODE_MAX,
+};
+
+/* record prefix (mandatory in each record) */
+struct jr_prefix {
+    uint32_t id;
+    uint32_t total_size;
+    uint64_t timestamp;
+};
+
+struct jr_code_load {
+    struct jr_prefix p;
+
+    uint32_t pid;
+    uint32_t tid;
+    uint64_t vma;
+    uint64_t code_addr;
+    uint64_t code_size;
+    uint64_t code_index;
+};
+
+struct jr_code_close {
+    struct jr_prefix p;
+};
+
+struct jr_code_move {
+    struct jr_prefix p;
+
+    uint32_t pid;
+    uint32_t tid;
+    uint64_t vma;
+    uint64_t old_code_addr;
+    uint64_t new_code_addr;
+    uint64_t code_size;
+    uint64_t code_index;
+};
+
+FILE *dumpfile;
+void *perf_marker;
+
+static uint64_t get_timestamp(void)
+{
+    struct timespec ts;
+    if (clock_gettime(CLOCK_MONOTONIC, &ts)) {
+        fprintf(stderr, "No support for CLOCK_MONOTONIC! -perf cannot be used!\n");
+        exit(1);
+    }
+    return (uint64_t) ts.tv_sec * 1000000000 + ts.tv_nsec;
+}
+
+static uint32_t get_e_machine(void)
+{
+    uint32_t e_machine = EM_NONE;
+    Elf64_Ehdr elf_header;
+    FILE *exe = fopen("/proc/self/exe", "r");
+
+    if (exe == NULL) {
+        return e_machine;
+    }
+
+    if (fread(&elf_header, sizeof(Elf64_Ehdr), 1, exe) != 1) {
+        goto end;
+    }
+
+    e_machine = elf_header.e_machine;
+
+end:
+    fclose(exe);
+    return e_machine;
+}
+
+void start_jitdump_file(void)
+{
+    gchar *dumpfile_name = g_strdup_printf("./jit-%d.dump", getpid());
+    dumpfile = fopen(dumpfile_name, "w+");
+
+    /* 'Perf record' saves mmaped files during the execution of a program and
+     * 'perf inject' iterate over them to reconstruct all used/executed binary.
+     * So, we create a mmap with the path of our jitdump that is processed
+     * and used by 'perf inject' to reconstruct jitted binaries.
+     */
+    perf_marker = mmap(NULL, sysconf(_SC_PAGESIZE),
+                          PROT_READ | PROT_EXEC,
+                          MAP_PRIVATE,
+                          fileno(dumpfile), 0);
+
+    if (perf_marker == MAP_FAILED) {
+        printf("Failed to create mmap marker file for perf %d\n", fileno(dumpfile));
+        fclose(dumpfile);
+        return;
+    }
+
+    g_free(dumpfile_name);
+
+    struct jitheader header;
+    header.magic = 0x4A695444;
+    header.version = 1;
+    header.elf_mach = get_e_machine();
+    header.total_size = sizeof(struct jitheader);
+    header.pid = getpid();
+    header.timestamp = get_timestamp();
+    header.flags = 0;
+
+    fwrite(&header, header.total_size, 1, dumpfile);
+
+    fflush(dumpfile);
+}
+
+void append_load_in_jitdump_file(TranslationBlock *tb)
+{
+    gchar *func_name = g_strdup_printf("TB virt:0x"TARGET_FMT_lx, tb->pc);
+
+    struct jr_code_load load_event;
+    load_event.p.id = JIT_CODE_LOAD;
+    load_event.p.total_size =
+        sizeof(struct jr_code_load) + strlen(func_name) + 1 + tb->tc.size;
+    load_event.p.timestamp = get_timestamp();
+    load_event.pid = getpid();
+    load_event.tid = syscall(SYS_gettid);
+    load_event.vma = tb->pc;
+    load_event.code_addr = (uint64_t) tb->tc.ptr;
+    load_event.code_size = tb->tc.size;
+    load_event.code_index = tb->pc;
+
+    fwrite(&load_event, sizeof(struct jr_code_load), 1, dumpfile);
+    fwrite(func_name, strlen(func_name) + 1, 1, dumpfile);
+    fwrite(tb->tc.ptr, tb->tc.size, 1, dumpfile);
+
+    g_free(func_name);
+    fflush(dumpfile);
+}
+
+void close_jitdump_file(void)
+{
+    fclose(dumpfile);
+    if (perf_marker != MAP_FAILED) {
+        munmap(perf_marker, sysconf(_SC_PAGESIZE));
+    }
+}
+
+bool is_jitdump_enabled;
+
+void enable_jitdump(void)
+{
+    is_jitdump_enabled = true;
+}
+
+bool jitdump_enabled(void)
+{
+    return is_jitdump_enabled;
+}
diff --git a/accel/tcg/perf/jitdump.h b/accel/tcg/perf/jitdump.h
new file mode 100644
index 0000000000..5d6df3ec91
--- /dev/null
+++ b/accel/tcg/perf/jitdump.h
@@ -0,0 +1,36 @@
+/*
+ * QEMU Linux Perf Support
+ *
+ * Copyright (c) 2019 Vanderson M. do Rosario (vandersonmr2@gmail.com)
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
+#ifndef JITDUMP_H
+#define JITDUMP_H
+
+#include "exec/exec-all.h"
+
+void start_jitdump_file(void);
+
+void append_load_in_jitdump_file(TranslationBlock *tb);
+void append_move_in_jitdump_file(TranslationBlock *tb);
+
+void close_jitdump_file(void);
+
+#endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5d1e08b169..9b30d96af5 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -58,6 +58,10 @@
 #include "sysemu/cpus.h"
 #include "sysemu/tcg.h"
 
+#ifdef __linux__
+#include "perf/jitdump.h"
+#endif
+
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
 /* make various TB consistency checks */
@@ -1148,6 +1152,11 @@ void tcg_exec_init(unsigned long tb_size)
     cpu_gen_init();
     page_init();
     tb_htable_init();
+#ifdef __linux__
+    if (jitdump_enabled()) {
+        start_jitdump_file();
+    }
+#endif
     code_gen_alloc(tb_size);
 #if defined(CONFIG_SOFTMMU)
     /* There's no guest base to take into account, so go ahead and
@@ -1877,6 +1886,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         return existing_tb;
     }
     tcg_tb_insert(tb);
+#ifdef __linux__
+    if (jitdump_enabled()) {
+        append_load_in_jitdump_file(tb);
+    }
+#endif
     return tb;
 }
 
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 0235cd3b91..7ab796e4a3 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -130,4 +130,7 @@ void page_size_init(void);
  * returned. */
 bool dump_in_progress(void);
 
+void enable_jitdump(void);
+bool jitdump_enabled(void);
+
 #endif
diff --git a/linux-user/main.c b/linux-user/main.c
index 47917bbb20..f6618dd060 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -379,6 +379,11 @@ static void handle_arg_strace(const char *arg)
     do_strace = 1;
 }
 
+static void handle_arg_perf(const char *arg)
+{
+    enable_jitdump();
+}
+
 static void handle_arg_version(const char *arg)
 {
     printf("qemu-" TARGET_NAME " version " QEMU_FULL_VERSION
@@ -444,6 +449,8 @@ static const struct qemu_argument arg_table[] = {
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
+    {"perf",      "QEMU_PERF",         false, handle_arg_perf,
+     "",           "dump jitdump files to help linux perf JIT code visualization"},
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
     {NULL, NULL, false, NULL, NULL, NULL}
diff --git a/os-posix.c b/os-posix.c
index 86cffd2c7d..2ddb1e6393 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -191,6 +191,9 @@ int os_parse_cmd_args(int index, const char *optarg)
     case QEMU_OPTION_enablefips:
         fips_set_state(true);
         break;
+    case QEMU_OPTION_perf:
+        enable_jitdump();
+        break;
 #endif
     default:
         return -1;
diff --git a/qemu-options.hx b/qemu-options.hx
index ea0638e92d..24ebfb910c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4156,6 +4156,17 @@ STEXI
 Enable FIPS 140-2 compliance mode.
 ETEXI
 
+#ifdef __linux__
+DEF("perf", 0, QEMU_OPTION_perf,
+    "-perf  dump jitdump files to help linux perf JIT code visualization\n",
+    QEMU_ARCH_ALL)
+#endif
+STEXI
+@item -perf
+@findex -perf
+Dumps jitdump files to help linux perf JIT code visualization
+ETEXI
+
 HXCOMM Deprecated by -machine accel=tcg property
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
-- 
2.22.0


