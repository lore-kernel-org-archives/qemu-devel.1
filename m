Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6610BC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E8D235FD
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BumFl4HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E8D235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmQT-0001Oz-Nt
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:50:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOf-0007yh-WD
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:46789)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOV-0004Ky-S0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:09 -0400
Received: by mail-pf1-x429.google.com with SMTP id b124so13115397pfg.13
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/MwDE87kvs37+LuOQWfCbKlVXbdf8wzkD2pAO2kX6Cc=;
 b=BumFl4HXJsPVWLPhDj69j4XyJGtQCHaSBFEzpECOlVghhpU+sHuXq0v7hmInlVBsmL
 VjPfAiXEs+MVoRieIx6bMm0ztV7qbNKuIb2VFqmLnJhQFaZ/iX02t+4yqAaScUv9+cSy
 1LxIJNdYFRv1EE355J0pzdrs9yKaSY6VJKaUeNtkgaP/5FuuG2M+G/k4qbQXzO+7MUyP
 JJkDZKz/zqn9guTfOSFbKx6NY+GKJW6bsc44zCVXoSqH+clAJJb2frGNMLotKrxhTmV7
 vMQOtuP5sg3pA0nUuoTFH+5dNYTnpKBdvLhMZsoGBQ7KyuPH9pKMa18YgTzjqogg3Ix6
 K8kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/MwDE87kvs37+LuOQWfCbKlVXbdf8wzkD2pAO2kX6Cc=;
 b=qIwQSXRJn6LFWH4zE7qNVTFu77dz/6HOZ9JukY18qTmuZnHylpxxVaiK0dBmxCs6zF
 qD6JW/8YyzCkNXvBz/ml2xsnlZtZSvYmlMURsDDAibibyNrnddLVM/KA0HGF3/BHrloz
 mjpUaNfNUKEdqYqZyXetH8C65mQ6sXQS2J6CFDGeTWm0CtUqgepL4UrCh6H1T23k3uEL
 vpNCXZCaZTRwTdYvyRFu3n+49BH+bldtxw6uCHFALLPpPhRb5Z4NXtyx2Hvil6kPn89U
 59yls1XMwzFcyNQc2Q+FlF5cl4mwvLZLEbxzm6g1jl9pIqKms+mejH+2OsorHHZx51eW
 dR/Q==
X-Gm-Message-State: AOAM530NHdEWa5E3TdDiW1DRg+PM4Yx8e8AAJP4sCEl6IHuH12x+8Ko+
 A8Cni5HuX3SVduM4W8wR+ErI6vSYaJx+6Q==
X-Google-Smtp-Source: ABdhPJwP6KgTysIeL1/zByG9RfyQz0pBjexWdZvYoHG0gH5UAakpNmO07SRuV2ggW8oJHU42a4iGZw==
X-Received: by 2002:a17:902:7c83:b029:d1:e603:af74 with SMTP id
 y3-20020a1709027c83b02900d1e603af74mr5737532pll.82.1600796871967; 
 Tue, 22 Sep 2020 10:47:51 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r1sm14825310pgl.66.2020.09.22.10.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 10:47:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] disas: Clean up CPUDebug initialization
Date: Tue, 22 Sep 2020 10:47:35 -0700
Message-Id: <20200922174741.475876-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename several functions, dropping "generic" and making "host"
vs "target" clearer.  Make a bunch of functions static that are
not used outside this file. Replace INIT_DISASSEMBLE_INFO with
a trio of functions.

Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/dis-asm.h |  62 --------
 disas.c                 | 330 ++++++++++++++++++----------------------
 2 files changed, 151 insertions(+), 241 deletions(-)

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 9856bf7921..dda247eaf2 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -406,7 +406,6 @@ typedef struct disassemble_info {
 
 } disassemble_info;
 
-
 /* Standard disassemblers.  Disassemble one instruction at the given
    target address.  Return number of bytes processed.  */
 typedef int (*disassembler_ftype) (bfd_vma, disassemble_info *);
@@ -461,67 +460,6 @@ int print_insn_riscv32          (bfd_vma, disassemble_info*);
 int print_insn_riscv64          (bfd_vma, disassemble_info*);
 int print_insn_rx(bfd_vma, disassemble_info *);
 
-#if 0
-/* Fetch the disassembler for a given BFD, if that support is available.  */
-disassembler_ftype disassembler(bfd *);
-#endif
-
-
-/* This block of definitions is for particular callers who read instructions
-   into a buffer before calling the instruction decoder.  */
-
-/* Here is a function which callers may wish to use for read_memory_func.
-   It gets bytes from a buffer.  */
-int buffer_read_memory(bfd_vma, bfd_byte *, int, struct disassemble_info *);
-
-/* This function goes with buffer_read_memory.
-   It prints a message using info->fprintf_func and info->stream.  */
-void perror_memory(int, bfd_vma, struct disassemble_info *);
-
-
-/* Just print the address in hex.  This is included for completeness even
-   though both GDB and objdump provide their own (to print symbolic
-   addresses).  */
-void generic_print_address(bfd_vma, struct disassemble_info *);
-
-/* Always true.  */
-int generic_symbol_at_address(bfd_vma, struct disassemble_info *);
-
-/* Macro to initialize a disassemble_info struct.  This should be called
-   by all applications creating such a struct.  */
-#define INIT_DISASSEMBLE_INFO(INFO, STREAM, FPRINTF_FUNC) \
-  (INFO).flavour = bfd_target_unknown_flavour, \
-  (INFO).arch = bfd_arch_unknown, \
-  (INFO).mach = 0, \
-  (INFO).endian = BFD_ENDIAN_UNKNOWN, \
-  INIT_DISASSEMBLE_INFO_NO_ARCH(INFO, STREAM, FPRINTF_FUNC)
-
-/* Call this macro to initialize only the internal variables for the
-   disassembler.  Architecture dependent things such as byte order, or machine
-   variant are not touched by this macro.  This makes things much easier for
-   GDB which must initialize these things separately.  */
-
-#define INIT_DISASSEMBLE_INFO_NO_ARCH(INFO, STREAM, FPRINTF_FUNC) \
-  (INFO).fprintf_func = (FPRINTF_FUNC), \
-  (INFO).stream = (STREAM), \
-  (INFO).symbols = NULL, \
-  (INFO).num_symbols = 0, \
-  (INFO).private_data = NULL, \
-  (INFO).buffer = NULL, \
-  (INFO).buffer_vma = 0, \
-  (INFO).buffer_length = 0, \
-  (INFO).read_memory_func = buffer_read_memory, \
-  (INFO).memory_error_func = perror_memory, \
-  (INFO).print_address_func = generic_print_address, \
-  (INFO).print_insn = NULL, \
-  (INFO).symbol_at_address_func = generic_symbol_at_address, \
-  (INFO).flags = 0, \
-  (INFO).bytes_per_line = 0, \
-  (INFO).bytes_per_chunk = 0, \
-  (INFO).display_endian = BFD_ENDIAN_UNKNOWN, \
-  (INFO).disassembler_options = NULL, \
-  (INFO).insn_info_valid = 0
-
 #ifndef ATTRIBUTE_UNUSED
 #define ATTRIBUTE_UNUSED __attribute__((unused))
 #endif
diff --git a/disas.c b/disas.c
index a4304e8137..1f35a4a33b 100644
--- a/disas.c
+++ b/disas.c
@@ -16,78 +16,68 @@ typedef struct CPUDebug {
 /* Filled in by elfload.c.  Simplistic, but will do for now. */
 struct syminfo *syminfos = NULL;
 
-/* Get LENGTH bytes from info's buffer, at target address memaddr.
-   Transfer them to myaddr.  */
-int
-buffer_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
-                   struct disassemble_info *info)
+/*
+ * Get LENGTH bytes from info's buffer, at host address memaddr.
+ * Transfer them to myaddr.
+ */
+static int host_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
+                            struct disassemble_info *info)
 {
     if (memaddr < info->buffer_vma
-        || memaddr + length > info->buffer_vma + info->buffer_length)
+        || memaddr + length > info->buffer_vma + info->buffer_length) {
         /* Out of bounds.  Use EIO because GDB uses it.  */
         return EIO;
+    }
     memcpy (myaddr, info->buffer + (memaddr - info->buffer_vma), length);
     return 0;
 }
 
-/* Get LENGTH bytes from info's buffer, at target address memaddr.
-   Transfer them to myaddr.  */
-static int
-target_read_memory (bfd_vma memaddr,
-                    bfd_byte *myaddr,
-                    int length,
-                    struct disassemble_info *info)
+/*
+ * Get LENGTH bytes from info's buffer, at target address memaddr.
+ * Transfer them to myaddr.
+ */
+static int target_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
+                              struct disassemble_info *info)
 {
     CPUDebug *s = container_of(info, CPUDebug, info);
-    int r;
-
-    r = cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
-
+    int r = cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
     return r ? EIO : 0;
 }
 
-/* Print an error message.  We can assume that this is in response to
-   an error return from buffer_read_memory.  */
-void
-perror_memory (int status, bfd_vma memaddr, struct disassemble_info *info)
+/*
+ * Print an error message.  We can assume that this is in response to
+ * an error return from {host,target}_read_memory.
+ */
+static void perror_memory(int status, bfd_vma memaddr,
+                          struct disassemble_info *info)
 {
-  if (status != EIO)
-    /* Can't happen.  */
-    (*info->fprintf_func) (info->stream, "Unknown error %d\n", status);
-  else
-    /* Actually, address between memaddr and memaddr + len was
-       out of bounds.  */
-    (*info->fprintf_func) (info->stream,
-			   "Address 0x%" PRIx64 " is out of bounds.\n", memaddr);
+    if (status != EIO) {
+        /* Can't happen.  */
+        info->fprintf_func(info->stream, "Unknown error %d\n", status);
+    } else {
+        /* Address between memaddr and memaddr + len was out of bounds.  */
+        info->fprintf_func(info->stream,
+                           "Address 0x%" PRIx64 " is out of bounds.\n",
+                           memaddr);
+    }
 }
 
-/* This could be in a separate file, to save minuscule amounts of space
-   in statically linked executables.  */
-
-/* Just print the address is hex.  This is included for completeness even
-   though both GDB and objdump provide their own (to print symbolic
-   addresses).  */
-
-void
-generic_print_address (bfd_vma addr, struct disassemble_info *info)
+/* Print address in hex. */
+static void print_address(bfd_vma addr, struct disassemble_info *info)
 {
-    (*info->fprintf_func) (info->stream, "0x%" PRIx64, addr);
+    info->fprintf_func(info->stream, "0x%" PRIx64, addr);
 }
 
 /* Print address in hex, truncated to the width of a host virtual address. */
-static void
-generic_print_host_address(bfd_vma addr, struct disassemble_info *info)
+static void host_print_address(bfd_vma addr, struct disassemble_info *info)
 {
-    uint64_t mask = ~0ULL >> (64 - (sizeof(void *) * 8));
-    generic_print_address(addr & mask, info);
+    print_address((uintptr_t)addr, info);
 }
 
-/* Just return the given address.  */
-
-int
-generic_symbol_at_address (bfd_vma addr, struct disassemble_info *info)
+/* Stub prevents some fruitless earching in optabs disassemblers. */
+static int symbol_at_address(bfd_vma addr, struct disassemble_info *info)
 {
-  return 1;
+    return 1;
 }
 
 bfd_vma bfd_getl64 (const bfd_byte *addr)
@@ -423,36 +413,116 @@ static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
 # define cap_disas_plugin(i, p, c) false
 #endif /* CONFIG_CAPSTONE */
 
+static void initialize_debug(CPUDebug *s)
+{
+    memset(s, 0, sizeof(*s));
+    s->info.arch = bfd_arch_unknown;
+    s->info.cap_arch = -1;
+    s->info.cap_insn_unit = 4;
+    s->info.cap_insn_split = 4;
+    s->info.memory_error_func = perror_memory;
+    s->info.symbol_at_address_func = symbol_at_address;
+}
+
+static void initialize_debug_target(CPUDebug *s, CPUState *cpu)
+{
+    initialize_debug(s);
+
+    s->cpu = cpu;
+    s->info.read_memory_func = target_read_memory;
+    s->info.print_address_func = print_address;
+#ifdef TARGET_WORDS_BIGENDIAN
+    s->info.endian = BFD_ENDIAN_BIG;
+#else
+    s->info.endian = BFD_ENDIAN_LITTLE;
+#endif
+
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    if (cc->disas_set_info) {
+        cc->disas_set_info(cpu, &s->info);
+    }
+}
+
+static void initialize_debug_host(CPUDebug *s)
+{
+    initialize_debug(s);
+
+    s->info.read_memory_func = host_read_memory;
+    s->info.print_address_func = host_print_address;
+#ifdef HOST_WORDS_BIGENDIAN
+    s->info.endian = BFD_ENDIAN_BIG;
+#else
+    s->info.endian = BFD_ENDIAN_LITTLE;
+#endif
+#if defined(CONFIG_TCG_INTERPRETER)
+    s->info.print_insn = print_insn_tci;
+#elif defined(__i386__)
+    s->info.mach = bfd_mach_i386_i386;
+    s->info.print_insn = print_insn_i386;
+    s->info.cap_arch = CS_ARCH_X86;
+    s->info.cap_mode = CS_MODE_32;
+    s->info.cap_insn_unit = 1;
+    s->info.cap_insn_split = 8;
+#elif defined(__x86_64__)
+    s->info.mach = bfd_mach_x86_64;
+    s->info.print_insn = print_insn_i386;
+    s->info.cap_arch = CS_ARCH_X86;
+    s->info.cap_mode = CS_MODE_64;
+    s->info.cap_insn_unit = 1;
+    s->info.cap_insn_split = 8;
+#elif defined(_ARCH_PPC)
+    s->info.disassembler_options = (char *)"any";
+    s->info.print_insn = print_insn_ppc;
+    s->info.cap_arch = CS_ARCH_PPC;
+# ifdef _ARCH_PPC64
+    s->info.cap_mode = CS_MODE_64;
+# endif
+#elif defined(__riscv) && defined(CONFIG_RISCV_DIS)
+#if defined(_ILP32) || (__riscv_xlen == 32)
+    s->info.print_insn = print_insn_riscv32;
+#elif defined(_LP64)
+    s->info.print_insn = print_insn_riscv64;
+#else
+#error unsupported RISC-V ABI
+#endif
+#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
+    s->info.print_insn = print_insn_arm_a64;
+    s->info.cap_arch = CS_ARCH_ARM64;
+#elif defined(__alpha__)
+    s->info.print_insn = print_insn_alpha;
+#elif defined(__sparc__)
+    s->info.print_insn = print_insn_sparc;
+    s->info.mach = bfd_mach_sparc_v9b;
+#elif defined(__arm__)
+    /* TCG only generates code for arm mode.  */
+    s->info.print_insn = print_insn_arm;
+    s->info.cap_arch = CS_ARCH_ARM;
+#elif defined(__MIPSEB__)
+    s->info.print_insn = print_insn_big_mips;
+#elif defined(__MIPSEL__)
+    s->info.print_insn = print_insn_little_mips;
+#elif defined(__m68k__)
+    s->info.print_insn = print_insn_m68k;
+#elif defined(__s390__)
+    s->info.print_insn = print_insn_s390;
+#elif defined(__hppa__)
+    s->info.print_insn = print_insn_hppa;
+#endif
+}
+
 /* Disassemble this for me please... (debugging).  */
 void target_disas(FILE *out, CPUState *cpu, target_ulong code,
                   target_ulong size)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     target_ulong pc;
     int count;
     CPUDebug s;
 
-    INIT_DISASSEMBLE_INFO(s.info, out, fprintf);
-
-    s.cpu = cpu;
-    s.info.read_memory_func = target_read_memory;
+    initialize_debug_target(&s, cpu);
+    s.info.fprintf_func = fprintf;
+    s.info.stream = out;
     s.info.buffer_vma = code;
     s.info.buffer_length = size;
-    s.info.print_address_func = generic_print_address;
-    s.info.cap_arch = -1;
-    s.info.cap_mode = 0;
-    s.info.cap_insn_unit = 4;
-    s.info.cap_insn_split = 4;
-
-#ifdef TARGET_WORDS_BIGENDIAN
-    s.info.endian = BFD_ENDIAN_BIG;
-#else
-    s.info.endian = BFD_ENDIAN_LITTLE;
-#endif
-
-    if (cc->disas_set_info) {
-        cc->disas_set_info(cpu, &s.info);
-    }
 
     if (s.info.cap_arch >= 0 && cap_disas_target(&s.info, code, size)) {
         return;
@@ -540,34 +610,17 @@ bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size)
  */
 char *plugin_disas(CPUState *cpu, uint64_t addr, size_t size)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     int count;
     CPUDebug s;
     GString *ds = g_string_set_size(&plugin_disas_output, 0);
 
     g_assert(ds == &plugin_disas_output);
 
-    INIT_DISASSEMBLE_INFO(s.info, NULL, plugin_printf);
-
-    s.cpu = cpu;
-    s.info.read_memory_func = target_read_memory;
+    initialize_debug_target(&s, cpu);
+    s.info.fprintf_func = plugin_printf;
     s.info.buffer_vma = addr;
     s.info.buffer_length = size;
     s.info.print_address_func = plugin_print_address;
-    s.info.cap_arch = -1;
-    s.info.cap_mode = 0;
-    s.info.cap_insn_unit = 4;
-    s.info.cap_insn_split = 4;
-
-#ifdef TARGET_WORDS_BIGENDIAN
-    s.info.endian = BFD_ENDIAN_BIG;
-#else
-    s.info.endian = BFD_ENDIAN_LITTLE;
-#endif
-
-    if (cc->disas_set_info) {
-        cc->disas_set_info(cpu, &s.info);
-    }
 
     if (s.info.cap_arch >= 0 && cap_disas_plugin(&s.info, addr, size)) {
         return g_strdup(ds->str);
@@ -593,89 +646,24 @@ void disas(FILE *out, void *code, unsigned long size)
     uintptr_t pc;
     int count;
     CPUDebug s;
-    int (*print_insn)(bfd_vma pc, disassemble_info *info) = NULL;
-
-    INIT_DISASSEMBLE_INFO(s.info, out, fprintf);
-    s.info.print_address_func = generic_print_host_address;
 
+    initialize_debug_host(&s);
+    s.info.fprintf_func = fprintf;
+    s.info.stream = out;
     s.info.buffer = code;
     s.info.buffer_vma = (uintptr_t)code;
     s.info.buffer_length = size;
-    s.info.cap_arch = -1;
-    s.info.cap_mode = 0;
-    s.info.cap_insn_unit = 4;
-    s.info.cap_insn_split = 4;
-
-#ifdef HOST_WORDS_BIGENDIAN
-    s.info.endian = BFD_ENDIAN_BIG;
-#else
-    s.info.endian = BFD_ENDIAN_LITTLE;
-#endif
-#if defined(CONFIG_TCG_INTERPRETER)
-    print_insn = print_insn_tci;
-#elif defined(__i386__)
-    s.info.mach = bfd_mach_i386_i386;
-    print_insn = print_insn_i386;
-    s.info.cap_arch = CS_ARCH_X86;
-    s.info.cap_mode = CS_MODE_32;
-    s.info.cap_insn_unit = 1;
-    s.info.cap_insn_split = 8;
-#elif defined(__x86_64__)
-    s.info.mach = bfd_mach_x86_64;
-    print_insn = print_insn_i386;
-    s.info.cap_arch = CS_ARCH_X86;
-    s.info.cap_mode = CS_MODE_64;
-    s.info.cap_insn_unit = 1;
-    s.info.cap_insn_split = 8;
-#elif defined(_ARCH_PPC)
-    s.info.disassembler_options = (char *)"any";
-    print_insn = print_insn_ppc;
-    s.info.cap_arch = CS_ARCH_PPC;
-# ifdef _ARCH_PPC64
-    s.info.cap_mode = CS_MODE_64;
-# endif
-#elif defined(__riscv) && defined(CONFIG_RISCV_DIS)
-#if defined(_ILP32) || (__riscv_xlen == 32)
-    print_insn = print_insn_riscv32;
-#elif defined(_LP64)
-    print_insn = print_insn_riscv64;
-#else
-#error unsupported RISC-V ABI
-#endif
-#elif defined(__aarch64__) && defined(CONFIG_ARM_A64_DIS)
-    print_insn = print_insn_arm_a64;
-    s.info.cap_arch = CS_ARCH_ARM64;
-#elif defined(__alpha__)
-    print_insn = print_insn_alpha;
-#elif defined(__sparc__)
-    print_insn = print_insn_sparc;
-    s.info.mach = bfd_mach_sparc_v9b;
-#elif defined(__arm__)
-    print_insn = print_insn_arm;
-    s.info.cap_arch = CS_ARCH_ARM;
-    /* TCG only generates code for arm mode.  */
-#elif defined(__MIPSEB__)
-    print_insn = print_insn_big_mips;
-#elif defined(__MIPSEL__)
-    print_insn = print_insn_little_mips;
-#elif defined(__m68k__)
-    print_insn = print_insn_m68k;
-#elif defined(__s390__)
-    print_insn = print_insn_s390;
-#elif defined(__hppa__)
-    print_insn = print_insn_hppa;
-#endif
 
     if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
         return;
     }
 
-    if (print_insn == NULL) {
-        print_insn = print_insn_od_host;
+    if (s.info.print_insn == NULL) {
+        s.info.print_insn = print_insn_od_host;
     }
     for (pc = (uintptr_t)code; size > 0; pc += count, size -= count) {
         fprintf(out, "0x%08" PRIxPTR ":  ", pc);
-        count = print_insn(pc, &s.info);
+        count = s.info.print_insn(pc, &s.info);
         fprintf(out, "\n");
         if (count < 0) {
             break;
@@ -720,31 +708,15 @@ physical_read_memory(bfd_vma memaddr, bfd_byte *myaddr, int length,
 void monitor_disas(Monitor *mon, CPUState *cpu,
                    target_ulong pc, int nb_insn, int is_physical)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     int count, i;
     CPUDebug s;
 
-    INIT_DISASSEMBLE_INFO(s.info, NULL, qemu_fprintf);
-
-    s.cpu = cpu;
-    s.info.read_memory_func
-        = (is_physical ? physical_read_memory : target_read_memory);
-    s.info.print_address_func = generic_print_address;
-    s.info.buffer_vma = pc;
-    s.info.cap_arch = -1;
-    s.info.cap_mode = 0;
-    s.info.cap_insn_unit = 4;
-    s.info.cap_insn_split = 4;
-
-#ifdef TARGET_WORDS_BIGENDIAN
-    s.info.endian = BFD_ENDIAN_BIG;
-#else
-    s.info.endian = BFD_ENDIAN_LITTLE;
-#endif
-
-    if (cc->disas_set_info) {
-        cc->disas_set_info(cpu, &s.info);
+    initialize_debug_target(&s, cpu);
+    s.info.fprintf_func = qemu_fprintf;
+    if (is_physical) {
+        s.info.read_memory_func = physical_read_memory;
     }
+    s.info.buffer_vma = pc;
 
     if (s.info.cap_arch >= 0 && cap_disas_monitor(&s.info, pc, nb_insn)) {
         return;
-- 
2.25.1


