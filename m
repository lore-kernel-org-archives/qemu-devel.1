Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB39ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8332320679
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5wKWy4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8332320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVDo-0008CW-Md
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwP-0002hB-UW
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwN-0005D5-AN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwN-0005Cf-0m
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id h4so7115109wrv.7
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T4HMZgJ1Rxlmg8Ern4sSS2h2E1T91khiCacVECvr12c=;
 b=l5wKWy4Ar2iH1p7q8hEe+nyy9Fnlm9r/RPgMLb+BDLiQwJ243rN/rSUWL8sOtyN3eb
 j4izBQsb2O3YBQq2BI6LeuPJgkaZnKb/ttSD9otLKAerni16RiEJNvWBKCM84bG5uA01
 Kt1ZAU/lHtvJ05NwXPxLo+AYo165YWX/O3VlxiOa7E41l529+LHGbW6iHKQWvOrJQVw6
 DCefmfBcQw5K+5PZ0NLTVfi3aGJdW8Owk91rdTq8H+Wz3dVmqAD+v89Df+vQAqE/O/zi
 d84ar9ZNw72LGgCf851XF/Ea6A38ekIZ/ek3Pb3fd2r02LHxmLXtfMtJMJ6BFtghiRKt
 p/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T4HMZgJ1Rxlmg8Ern4sSS2h2E1T91khiCacVECvr12c=;
 b=WgFJrHfd0HZNdcz2Z55Z/pzUAUL4126pFqLX5EZb71ZKFbvF5wwNNcx8a01AA+j/cY
 0OMGiV8TT9uRXSGlEJ2qOATD0EmWD+buGiH5ri0LO1hAeGhBKouKSHkC1SIMqw/ZxQdV
 TR8tprAIirgzbKzPc03Mi/c9+5RuWFzALgTrn4RGimtxZ7kyJ3ysKStpydm6ofur4wIp
 lqSfovl7zHJX7P77P+lcAlPrRvq3fLwQaQTqNHMkBS9Zz50v7B3tAkoTUHj7qCA6K+vn
 xx954pIDyUJvJV8+ShUYPunjKPDFWGkl42Z3Kr0RMMH2jNEXLL2tg55qZc1sdJAVOP+r
 lqLQ==
X-Gm-Message-State: APjAAAV8SasEzBryp3mANkSYf/Cv+FzK+XmcuIvYAvZ9rUyF5mCiU7ut
 eBAJNk7XAJ9my6SOYWDcVPcO0g==
X-Google-Smtp-Source: APXvYqyFDaNCuIQMYkXvBgHoVRzBFjcVeIVJqAMQPv1/EnjNx8xLvc7NDsmW4Mxcm/AO7YeP/p3KzA==
X-Received: by 2002:a5d:4f0b:: with SMTP id c11mr22923034wru.63.1570462129758; 
 Mon, 07 Oct 2019 08:28:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t123sm25635432wma.40.2019.10.07.08.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:47 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8AA471FF9B;
 Mon,  7 Oct 2019 16:28:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v9 11/13] accel/tcg: adding integration with linux perf
Date: Mon,  7 Oct 2019 16:28:37 +0100
Message-Id: <20191007152839.30804-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007152839.30804-1-alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

This commit adds support to Linux Perf in order to be able to analyze
qemu jitted code and also to able to see the TBs PC in it.

When using "-perf" qemu creates a jitdump file in the current working
directory. You then integrate the file using perf inject.

Example of use:
 perf record -k 1 qemu-x86_64 -perf ./a.out
 perf inject -j -i perf.data -o perf.data.jitted
 perf report -i perf.data.jitted

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190830121903.17585-2-vandersonmr2@gmail.com>
[AJB: rebase and various fixes]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
AJB:
   - use get_clock instead of repeating ourselves
   - add lock for writing to file
   - use canonical kernel.org links
   - g_autoptr/g_autofree strings
---
 accel/tcg/Makefile.objs      |   2 +-
 accel/tcg/perf/Makefile.objs |   1 +
 accel/tcg/perf/jitdump.c     | 194 +++++++++++++++++++++++++++++++++++
 accel/tcg/perf/jitdump.h     |  36 +++++++
 accel/tcg/translate-all.c    |  14 +++
 docs/devel/tcg.rst           |  15 +++
 include/qemu-common.h        |   3 +
 linux-user/main.c            |   7 ++
 os-posix.c                   |   5 +
 qemu-options.hx              |  11 ++
 10 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 accel/tcg/perf/Makefile.objs
 create mode 100644 accel/tcg/perf/jitdump.c
 create mode 100644 accel/tcg/perf/jitdump.h

diff --git a/accel/tcg/Makefile.objs b/accel/tcg/Makefile.objs
index 49ffe81b5d..6a1ad59199 100644
--- a/accel/tcg/Makefile.objs
+++ b/accel/tcg/Makefile.objs
@@ -3,6 +3,6 @@ obj-$(CONFIG_SOFTMMU) += cputlb.o
 obj-y += tcg-runtime.o tcg-runtime-gvec.o
 obj-y += cpu-exec.o cpu-exec-common.o translate-all.o
 obj-y += translator.o tb-stats.o
-
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
index 0000000000..e1d6f2214e
--- /dev/null
+++ b/accel/tcg/perf/jitdump.c
@@ -0,0 +1,194 @@
+/*
+ * This code implements an interface to create and fill jitdump files. These files
+ * store information used by Linux Perf to enhance the presentation of jitted
+ * code and to allow the disassembly of jitted code.
+ *
+ * The jitdump file specification can be found in the Linux Kernel Source tree:
+ *    tools/perf/Documentation/jitdump-specification.txt
+ *
+ * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/tools/perf/Documentation/jitdump-specification.txt
+ *
+ * Copyright (c) 2019 Vanderson M. do Rosario
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
+#include "qemu/timer.h"
+#include "exec/tb-stats.h"
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
+QemuMutex dumpfile_lock;
+void *perf_marker;
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
+    g_autofree gchar *dumpfile_name = g_strdup_printf("./jit-%d.dump", getpid());
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
+    struct jitheader header;
+    header.magic = 0x4A695444;
+    header.version = 1;
+    header.elf_mach = get_e_machine();
+    header.total_size = sizeof(struct jitheader);
+    header.pid = getpid();
+    header.timestamp = get_clock();
+    header.flags = 0;
+
+    fwrite(&header, header.total_size, 1, dumpfile);
+
+    fflush(dumpfile);
+
+    qemu_mutex_init(&dumpfile_lock);
+}
+
+void append_load_in_jitdump_file(TranslationBlock *tb)
+{
+    gchar *func_name = g_strdup_printf("TB virt:0x"TARGET_FMT_lx, tb->pc);
+
+    /* Serialise the writing of the dump file */
+    qemu_mutex_lock(&dumpfile_lock);
+
+    struct jr_code_load load_event;
+    load_event.p.id = JIT_CODE_LOAD;
+    load_event.p.total_size =
+        sizeof(struct jr_code_load) + func_name->len + 1 + tb->tc.size;
+    load_event.p.timestamp = get_clock();
+    load_event.pid = getpid();
+    load_event.tid = syscall(SYS_gettid);
+    load_event.vma = tb->pc;
+    load_event.code_addr = (uint64_t) tb->tc.ptr;
+    load_event.code_size = tb->tc.size;
+    load_event.code_index = tb->pc;
+
+    fwrite(&load_event, sizeof(struct jr_code_load), 1, dumpfile);
+    fwrite(func_name->str, func_name->len + 1, 1, dumpfile);
+    fwrite(tb->tc.ptr, tb->tc.size, 1, dumpfile);
+
+    g_free(func_name);
+    fflush(dumpfile);
+
+    qemu_mutex_unlock(&dumpfile_lock);
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
index 871d91d559..3fafb656e7 100644
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
@@ -1167,6 +1171,11 @@ void tcg_exec_init(unsigned long tb_size)
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
@@ -1978,6 +1987,11 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
 
diff --git a/docs/devel/tcg.rst b/docs/devel/tcg.rst
index 4956a30a4e..ab5639cf67 100644
--- a/docs/devel/tcg.rst
+++ b/docs/devel/tcg.rst
@@ -109,3 +109,18 @@ memory areas instead calls out to C code for device emulation.
 Finally, the MMU helps tracking dirty pages and pages pointed to by
 translation blocks.
 
+Profiling JITted code
+---------------------
+
+The Linux `perf` tool will treat all JITed code as a single block as
+unlike the main code it can't use debug information to link individual
+program counter samples with larger functions. To overcome this
+limitation you can use the `--perf` option to generate a map file.
+This needs to be integrated with the `perf.data` file before the final
+report can be viewed.
+
+.. code::
+
+  perf record -k 1 $QEMU --perf $REMAINING_ARGS
+  perf inject -i perf.data -j -o perf.data.jitted
+  perf report -i perf.data.jitted
diff --git a/include/qemu-common.h b/include/qemu-common.h
index 8d84db90b0..a16e0e7eb6 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -129,4 +129,7 @@ void page_size_init(void);
  * returned. */
 bool dump_in_progress(void);
 
+void enable_jitdump(void);
+bool jitdump_enabled(void);
+
 #endif
diff --git a/linux-user/main.c b/linux-user/main.c
index 560d053f72..18f771c0be 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -377,6 +377,11 @@ static void handle_arg_strace(const char *arg)
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
@@ -449,6 +454,8 @@ static const struct qemu_argument arg_table[] = {
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
+    {"perf",      "QEMU_PERF",         false, handle_arg_perf,
+     "",           "dump jitdump files to help linux perf JIT code visualization"},
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
 #if defined(TARGET_XTENSA)
diff --git a/os-posix.c b/os-posix.c
index 86cffd2c7d..36ea3a08ca 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -191,6 +191,11 @@ int os_parse_cmd_args(int index, const char *optarg)
     case QEMU_OPTION_enablefips:
         fips_set_state(true);
         break;
+#if defined(CONFIG_TCG) && defined (CLOCK_MONOTONIC)
+    case QEMU_OPTION_perf:
+        enable_jitdump();
+        break;
+#endif
 #endif
     default:
         return -1;
diff --git a/qemu-options.hx b/qemu-options.hx
index 2a04ca6ac5..2924032c3b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4160,6 +4160,17 @@ STEXI
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
 HXCOMM Deprecated by -accel tcg
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
-- 
2.20.1


