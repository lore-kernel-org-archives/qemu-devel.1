Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C0C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4697D2376F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEF5DiMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4697D2376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmXB-0000rr-88
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOm-0008E2-Mx
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:16 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOf-0004LK-MW
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:16 -0400
Received: by mail-pg1-x542.google.com with SMTP id l71so12570240pge.4
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=32ksAvLgJOxJOqykaUU7L7gysmeStCf/ZQlD3B5l6Po=;
 b=yEF5DiMoelbTd0weLAhRFc8ob5svQtbfIaP2HHeauQQQtTqD/LxiKQcAeszkh2BE/q
 nNvcPQvUxj0non327ADbfLqeP7KhjosjeeHAbtnsjWx7VC/f8ApjvTtL1RFG7JkAuqiX
 /yRpdP9BVZ9KnZV6S1T0KE8kNetm4e51OOTScjySo6d4ILdm+9+CQKmI/GyuaB6bB74D
 w0vR0YYiYzGlfnGsuYmv0NioMtxwLEVzhUrZ6ca2+293FW0rLl/mkINhcF/+oepffZ+H
 LtVx7l/JiQutz1/H7cwS6BTNaL6QzebuOjM5SMNw68BgdAMfO4R/ylF5N+H4bG109Auz
 03jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=32ksAvLgJOxJOqykaUU7L7gysmeStCf/ZQlD3B5l6Po=;
 b=UE5df7cYnOXlbx07/VSF1/pQu4zwL0BbDMlHDAc5MBx5WT0pIff7C0fHfV1WhyH4un
 Au9gh/8WTAEzWTwN6MvwaZpj0ZqPagcmrbjlvGvA/L8PsckSy6iliYUiQkJo2+7cX3VZ
 U8Xkv0v/Tnrpc8b0O605OCWlqAqIR4EUGko/Apqu5XCfZyj2wPz0TjEZzC/BWospw6m7
 a9KJghutyLy5+bFr8GIQmimO/bXg7Mj+qnbevgkgo18mcrEuNVEr0jqDWODvUFXTDk/3
 R49VPq5xBtmK4sTm24OKOeudKfZRwVCp6ZrD3dOBznnkgvzi0IhaA3A1nSrhs5D3q1dT
 wKXg==
X-Gm-Message-State: AOAM5305XhmqIXiirN5nZGMUUzS3Ud0yc5EBtC/k0Zj1Auy6ZwM8GzMH
 hFxQuFYN6rcgAVhIpI8n7mSs8z7FWmRasQ==
X-Google-Smtp-Source: ABdhPJzU4CdbAXMyeNVAO8KlzH9gc7R8rGCg2fJ6Wd4RaYwF/GV2ARzvIo8Ro1DvtUDFv3Z2tBJkhA==
X-Received: by 2002:a05:6a00:1481:b029:142:2501:35d7 with SMTP id
 v1-20020a056a001481b0290142250135d7mr5168510pfu.55.1600796877904; 
 Tue, 22 Sep 2020 10:47:57 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r1sm14825310pgl.66.2020.09.22.10.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 10:47:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/11] disas: Split out capstone code to disas/capstone.c
Date: Tue, 22 Sep 2020 10:47:39 -0700
Message-Id: <20200922174741.475876-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing target-specific about this code, so it
can be added to common_ss.  This also requires that the
base capstone dependency be added to common_ss, so that
we get the correct include paths added to CFLAGS.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build             |   1 +
 include/disas/dis-asm.h |  12 ++
 disas.c                 | 275 --------------------------------------
 disas/capstone.c        | 286 ++++++++++++++++++++++++++++++++++++++++
 disas/meson.build       |   1 +
 5 files changed, 300 insertions(+), 275 deletions(-)
 create mode 100644 disas/capstone.c

diff --git a/meson.build b/meson.build
index 114b136129..f06e3a1b65 100644
--- a/meson.build
+++ b/meson.build
@@ -965,6 +965,7 @@ common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
 
+common_ss.add(capstone)
 specific_ss.add(files('disas.c', 'exec.c', 'gdbstub.c'), capstone, libpmem, libdaxctl)
 specific_ss.add(files('exec-vary.c'))
 specific_ss.add(when: 'CONFIG_TCG', if_true: files(
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 6b45aa9898..2164762b46 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -460,6 +460,18 @@ int print_insn_riscv32          (bfd_vma, disassemble_info*);
 int print_insn_riscv64          (bfd_vma, disassemble_info*);
 int print_insn_rx(bfd_vma, disassemble_info *);
 
+#ifdef CONFIG_CAPSTONE
+bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size);
+bool cap_disas_host(disassemble_info *info, void *code, size_t size);
+bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count);
+bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size);
+#else
+# define cap_disas_target(i, p, s)  false
+# define cap_disas_host(i, p, s)    false
+# define cap_disas_monitor(i, p, c) false
+# define cap_disas_plugin(i, p, c)  false
+#endif /* CONFIG_CAPSTONE */
+
 #ifndef ATTRIBUTE_UNUSED
 #define ATTRIBUTE_UNUSED __attribute__((unused))
 #endif
diff --git a/disas.c b/disas.c
index cafd063d42..9dfbeededc 100644
--- a/disas.c
+++ b/disas.c
@@ -109,255 +109,6 @@ static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
     return print_insn_objdump(pc, info, "OBJD-T");
 }
 
-#ifdef CONFIG_CAPSTONE
-/* Temporary storage for the capstone library.  This will be alloced via
-   malloc with a size private to the library; thus there's no reason not
-   to share this across calls and across host vs target disassembly.  */
-static __thread cs_insn *cap_insn;
-
-/* Initialize the Capstone library.  */
-/* ??? It would be nice to cache this.  We would need one handle for the
-   host and one for the target.  For most targets we can reset specific
-   parameters via cs_option(CS_OPT_MODE, new_mode), but we cannot change
-   CS_ARCH_* in this way.  Thus we would need to be able to close and
-   re-open the target handle with a different arch for the target in order
-   to handle AArch64 vs AArch32 mode switching.  */
-static cs_err cap_disas_start(disassemble_info *info, csh *handle)
-{
-    cs_mode cap_mode = info->cap_mode;
-    cs_err err;
-
-    cap_mode += (info->endian == BFD_ENDIAN_BIG ? CS_MODE_BIG_ENDIAN
-                 : CS_MODE_LITTLE_ENDIAN);
-
-    err = cs_open(info->cap_arch, cap_mode, handle);
-    if (err != CS_ERR_OK) {
-        return err;
-    }
-
-    /* ??? There probably ought to be a better place to put this.  */
-    if (info->cap_arch == CS_ARCH_X86) {
-        /* We don't care about errors (if for some reason the library
-           is compiled without AT&T syntax); the user will just have
-           to deal with the Intel syntax.  */
-        cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
-    }
-
-    /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
-    cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
-
-    /* Allocate temp space for cs_disasm_iter.  */
-    if (cap_insn == NULL) {
-        cap_insn = cs_malloc(*handle);
-        if (cap_insn == NULL) {
-            cs_close(handle);
-            return CS_ERR_MEM;
-        }
-    }
-    return CS_ERR_OK;
-}
-
-static void cap_dump_insn_units(disassemble_info *info, cs_insn *insn,
-                                int i, int n)
-{
-    fprintf_function print = info->fprintf_func;
-    FILE *stream = info->stream;
-
-    switch (info->cap_insn_unit) {
-    case 4:
-        if (info->endian == BFD_ENDIAN_BIG) {
-            for (; i < n; i += 4) {
-                print(stream, " %08x", ldl_be_p(insn->bytes + i));
-
-            }
-        } else {
-            for (; i < n; i += 4) {
-                print(stream, " %08x", ldl_le_p(insn->bytes + i));
-            }
-        }
-        break;
-
-    case 2:
-        if (info->endian == BFD_ENDIAN_BIG) {
-            for (; i < n; i += 2) {
-                print(stream, " %04x", lduw_be_p(insn->bytes + i));
-            }
-        } else {
-            for (; i < n; i += 2) {
-                print(stream, " %04x", lduw_le_p(insn->bytes + i));
-            }
-        }
-        break;
-
-    default:
-        for (; i < n; i++) {
-            print(stream, " %02x", insn->bytes[i]);
-        }
-        break;
-    }
-}
-
-static void cap_dump_insn(disassemble_info *info, cs_insn *insn)
-{
-    fprintf_function print = info->fprintf_func;
-    int i, n, split;
-
-    print(info->stream, "0x%08" PRIx64 ": ", insn->address);
-
-    n = insn->size;
-    split = info->cap_insn_split;
-
-    /* Dump the first SPLIT bytes of the instruction.  */
-    cap_dump_insn_units(info, insn, 0, MIN(n, split));
-
-    /* Add padding up to SPLIT so that mnemonics line up.  */
-    if (n < split) {
-        int width = (split - n) / info->cap_insn_unit;
-        width *= (2 * info->cap_insn_unit + 1);
-        print(info->stream, "%*s", width, "");
-    }
-
-    /* Print the actual instruction.  */
-    print(info->stream, "  %-8s %s\n", insn->mnemonic, insn->op_str);
-
-    /* Dump any remaining part of the insn on subsequent lines.  */
-    for (i = split; i < n; i += split) {
-        print(info->stream, "0x%08" PRIx64 ": ", insn->address + i);
-        cap_dump_insn_units(info, insn, i, MIN(n, i + split));
-        print(info->stream, "\n");
-    }
-}
-
-/* Disassemble SIZE bytes at PC for the target.  */
-static bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
-{
-    uint8_t cap_buf[1024];
-    csh handle;
-    cs_insn *insn;
-    size_t csize = 0;
-
-    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
-        return false;
-    }
-    insn = cap_insn;
-
-    while (1) {
-        size_t tsize = MIN(sizeof(cap_buf) - csize, size);
-        const uint8_t *cbuf = cap_buf;
-
-        target_read_memory(pc + csize, cap_buf + csize, tsize, info);
-        csize += tsize;
-        size -= tsize;
-
-        while (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-            cap_dump_insn(info, insn);
-        }
-
-        /* If the target memory is not consumed, go back for more... */
-        if (size != 0) {
-            /* ... taking care to move any remaining fractional insn
-               to the beginning of the buffer.  */
-            if (csize != 0) {
-                memmove(cap_buf, cbuf, csize);
-            }
-            continue;
-        }
-
-        /* Since the target memory is consumed, we should not have
-           a remaining fractional insn.  */
-        if (csize != 0) {
-            (*info->fprintf_func)(info->stream,
-                "Disassembler disagrees with translator "
-                "over instruction decoding\n"
-                "Please report this to qemu-devel@nongnu.org\n");
-        }
-        break;
-    }
-
-    cs_close(&handle);
-    return true;
-}
-
-/* Disassemble SIZE bytes at CODE for the host.  */
-static bool cap_disas_host(disassemble_info *info, void *code, size_t size)
-{
-    csh handle;
-    const uint8_t *cbuf;
-    cs_insn *insn;
-    uint64_t pc;
-
-    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
-        return false;
-    }
-    insn = cap_insn;
-
-    cbuf = code;
-    pc = (uintptr_t)code;
-
-    while (cs_disasm_iter(handle, &cbuf, &size, &pc, insn)) {
-        cap_dump_insn(info, insn);
-    }
-    if (size != 0) {
-        (*info->fprintf_func)(info->stream,
-            "Disassembler disagrees with TCG over instruction encoding\n"
-            "Please report this to qemu-devel@nongnu.org\n");
-    }
-
-    cs_close(&handle);
-    return true;
-}
-
-#if !defined(CONFIG_USER_ONLY)
-/* Disassemble COUNT insns at PC for the target.  */
-static bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
-{
-    uint8_t cap_buf[32];
-    csh handle;
-    cs_insn *insn;
-    size_t csize = 0;
-
-    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
-        return false;
-    }
-    insn = cap_insn;
-
-    while (1) {
-        /* We want to read memory for one insn, but generically we do not
-           know how much memory that is.  We have a small buffer which is
-           known to be sufficient for all supported targets.  Try to not
-           read beyond the page, Just In Case.  For even more simplicity,
-           ignore the actual target page size and use a 1k boundary.  If
-           that turns out to be insufficient, we'll come back around the
-           loop and read more.  */
-        uint64_t epc = QEMU_ALIGN_UP(pc + csize + 1, 1024);
-        size_t tsize = MIN(sizeof(cap_buf) - csize, epc - pc);
-        const uint8_t *cbuf = cap_buf;
-
-        /* Make certain that we can make progress.  */
-        assert(tsize != 0);
-        info->read_memory_func(pc, cap_buf + csize, tsize, info);
-        csize += tsize;
-
-        if (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-            cap_dump_insn(info, insn);
-            if (--count <= 0) {
-                break;
-            }
-        }
-        memmove(cap_buf, cbuf, csize);
-    }
-
-    cs_close(&handle);
-    return true;
-}
-#endif /* !CONFIG_USER_ONLY */
-#else
-# define cap_disas_target(i, p, s)  false
-# define cap_disas_host(i, p, s)  false
-# define cap_disas_monitor(i, p, c)  false
-# define cap_disas_plugin(i, p, c) false
-#endif /* CONFIG_CAPSTONE */
-
 static void initialize_debug(CPUDebug *s)
 {
     memset(s, 0, sizeof(*s));
@@ -515,32 +266,6 @@ static void plugin_print_address(bfd_vma addr, struct disassemble_info *info)
 }
 
 
-#ifdef CONFIG_CAPSTONE
-/* Disassemble a single instruction directly into plugin output */
-static
-bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size)
-{
-    uint8_t cap_buf[64];
-    const uint8_t *cbuf = cap_buf;
-    csh handle;
-
-    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
-        return false;
-    }
-
-    assert(size < sizeof(cap_buf));
-    target_read_memory(pc, cap_buf, size, info);
-
-    if (cs_disasm_iter(handle, &cbuf, &size, &pc, cap_insn)) {
-        GString *s = (GString *)info->stream;
-        g_string_printf(s, "%s %s", cap_insn->mnemonic, cap_insn->op_str);
-    }
-
-    cs_close(&handle);
-    return true;
-}
-#endif
-
 /*
  * We should only be dissembling one instruction at a time here. If
  * there is left over it usually indicates the front end has read more
diff --git a/disas/capstone.c b/disas/capstone.c
new file mode 100644
index 0000000000..b48f83958d
--- /dev/null
+++ b/disas/capstone.c
@@ -0,0 +1,286 @@
+/*
+ * Interface to the capstone disassembler.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "disas/dis-asm.h"
+#include "disas/capstone.h"
+
+
+/*
+ * Temporary storage for the capstone library.  This will be alloced via
+ * malloc with a size private to the library; thus there's no reason not
+ * to share this across calls and across host vs target disassembly.
+ */
+static __thread cs_insn *cap_insn;
+
+/*
+ * Initialize the Capstone library.
+ *
+ * ??? It would be nice to cache this.  We would need one handle for the
+ * host and one for the target.  For most targets we can reset specific
+ * parameters via cs_option(CS_OPT_MODE, new_mode), but we cannot change
+ * CS_ARCH_* in this way.  Thus we would need to be able to close and
+ * re-open the target handle with a different arch for the target in order
+ * to handle AArch64 vs AArch32 mode switching.
+ */
+static cs_err cap_disas_start(disassemble_info *info, csh *handle)
+{
+    cs_mode cap_mode = info->cap_mode;
+    cs_err err;
+
+    cap_mode += (info->endian == BFD_ENDIAN_BIG ? CS_MODE_BIG_ENDIAN
+                 : CS_MODE_LITTLE_ENDIAN);
+
+    err = cs_open(info->cap_arch, cap_mode, handle);
+    if (err != CS_ERR_OK) {
+        return err;
+    }
+
+    /* "Disassemble" unknown insns as ".byte W,X,Y,Z".  */
+    cs_option(*handle, CS_OPT_SKIPDATA, CS_OPT_ON);
+
+    if (info->cap_arch == CS_ARCH_X86) {
+        /*
+         * We don't care about errors (if for some reason the library
+         * is compiled without AT&T syntax); the user will just have
+         * to deal with the Intel syntax.
+         */
+        cs_option(*handle, CS_OPT_SYNTAX, CS_OPT_SYNTAX_ATT);
+    }
+
+    /* Allocate temp space for cs_disasm_iter.  */
+    if (cap_insn == NULL) {
+        cap_insn = cs_malloc(*handle);
+        if (cap_insn == NULL) {
+            cs_close(handle);
+            return CS_ERR_MEM;
+        }
+    }
+    return CS_ERR_OK;
+}
+
+static void cap_dump_insn_units(disassemble_info *info, cs_insn *insn,
+                                int i, int n)
+{
+    fprintf_function print = info->fprintf_func;
+    FILE *stream = info->stream;
+
+    switch (info->cap_insn_unit) {
+    case 4:
+        if (info->endian == BFD_ENDIAN_BIG) {
+            for (; i < n; i += 4) {
+                print(stream, " %08x", ldl_be_p(insn->bytes + i));
+
+            }
+        } else {
+            for (; i < n; i += 4) {
+                print(stream, " %08x", ldl_le_p(insn->bytes + i));
+            }
+        }
+        break;
+
+    case 2:
+        if (info->endian == BFD_ENDIAN_BIG) {
+            for (; i < n; i += 2) {
+                print(stream, " %04x", lduw_be_p(insn->bytes + i));
+            }
+        } else {
+            for (; i < n; i += 2) {
+                print(stream, " %04x", lduw_le_p(insn->bytes + i));
+            }
+        }
+        break;
+
+    default:
+        for (; i < n; i++) {
+            print(stream, " %02x", insn->bytes[i]);
+        }
+        break;
+    }
+}
+
+static void cap_dump_insn(disassemble_info *info, cs_insn *insn)
+{
+    fprintf_function print = info->fprintf_func;
+    FILE *stream = info->stream;
+    int i, n, split;
+
+    print(stream, "0x%08" PRIx64 ": ", insn->address);
+
+    n = insn->size;
+    split = info->cap_insn_split;
+
+    /* Dump the first SPLIT bytes of the instruction.  */
+    cap_dump_insn_units(info, insn, 0, MIN(n, split));
+
+    /* Add padding up to SPLIT so that mnemonics line up.  */
+    if (n < split) {
+        int width = (split - n) / info->cap_insn_unit;
+        width *= (2 * info->cap_insn_unit + 1);
+        print(stream, "%*s", width, "");
+    }
+
+    /* Print the actual instruction.  */
+    print(stream, "  %-8s %s\n", insn->mnemonic, insn->op_str);
+
+    /* Dump any remaining part of the insn on subsequent lines.  */
+    for (i = split; i < n; i += split) {
+        print(stream, "0x%08" PRIx64 ": ", insn->address + i);
+        cap_dump_insn_units(info, insn, i, MIN(n, i + split));
+        print(stream, "\n");
+    }
+}
+
+/* Disassemble SIZE bytes at PC for the target.  */
+bool cap_disas_target(disassemble_info *info, uint64_t pc, size_t size)
+{
+    uint8_t cap_buf[1024];
+    csh handle;
+    cs_insn *insn;
+    size_t csize = 0;
+
+    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
+        return false;
+    }
+    insn = cap_insn;
+
+    while (1) {
+        size_t tsize = MIN(sizeof(cap_buf) - csize, size);
+        const uint8_t *cbuf = cap_buf;
+
+        info->read_memory_func(pc + csize, cap_buf + csize, tsize, info);
+        csize += tsize;
+        size -= tsize;
+
+        while (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
+            cap_dump_insn(info, insn);
+        }
+
+        /* If the target memory is not consumed, go back for more... */
+        if (size != 0) {
+            /*
+             * ... taking care to move any remaining fractional insn
+             * to the beginning of the buffer.
+             */
+            if (csize != 0) {
+                memmove(cap_buf, cbuf, csize);
+            }
+            continue;
+        }
+
+        /*
+         * Since the target memory is consumed, we should not have
+         * a remaining fractional insn.
+         */
+        if (csize != 0) {
+            info->fprintf_func(info->stream,
+                "Disassembler disagrees with translator "
+                "over instruction decoding\n"
+                "Please report this to qemu-devel@nongnu.org\n");
+        }
+        break;
+    }
+
+    cs_close(&handle);
+    return true;
+}
+
+/* Disassemble SIZE bytes at CODE for the host.  */
+bool cap_disas_host(disassemble_info *info, void *code, size_t size)
+{
+    csh handle;
+    const uint8_t *cbuf;
+    cs_insn *insn;
+    uint64_t pc;
+
+    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
+        return false;
+    }
+    insn = cap_insn;
+
+    cbuf = code;
+    pc = (uintptr_t)code;
+
+    while (cs_disasm_iter(handle, &cbuf, &size, &pc, insn)) {
+        cap_dump_insn(info, insn);
+    }
+    if (size != 0) {
+        info->fprintf_func(info->stream,
+            "Disassembler disagrees with TCG over instruction encoding\n"
+            "Please report this to qemu-devel@nongnu.org\n");
+    }
+
+    cs_close(&handle);
+    return true;
+}
+
+/* Disassemble COUNT insns at PC for the target.  */
+bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
+{
+    uint8_t cap_buf[32];
+    csh handle;
+    cs_insn *insn;
+    size_t csize = 0;
+
+    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
+        return false;
+    }
+    insn = cap_insn;
+
+    while (1) {
+        /*
+         * We want to read memory for one insn, but generically we do not
+         * know how much memory that is.  We have a small buffer which is
+         * known to be sufficient for all supported targets.  Try to not
+         * read beyond the page, Just In Case.  For even more simplicity,
+         * ignore the actual target page size and use a 1k boundary.  If
+         * that turns out to be insufficient, we'll come back around the
+         * loop and read more.
+         */
+        uint64_t epc = QEMU_ALIGN_UP(pc + csize + 1, 1024);
+        size_t tsize = MIN(sizeof(cap_buf) - csize, epc - pc);
+        const uint8_t *cbuf = cap_buf;
+
+        /* Make certain that we can make progress.  */
+        assert(tsize != 0);
+        info->read_memory_func(pc, cap_buf + csize, tsize, info);
+        csize += tsize;
+
+        if (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
+            cap_dump_insn(info, insn);
+            if (--count <= 0) {
+                break;
+            }
+        }
+        memmove(cap_buf, cbuf, csize);
+    }
+
+    cs_close(&handle);
+    return true;
+}
+
+/* Disassemble a single instruction directly into plugin output */
+bool cap_disas_plugin(disassemble_info *info, uint64_t pc, size_t size)
+{
+    uint8_t cap_buf[32];
+    const uint8_t *cbuf = cap_buf;
+    csh handle;
+
+    if (cap_disas_start(info, &handle) != CS_ERR_OK) {
+        return false;
+    }
+
+    assert(size < sizeof(cap_buf));
+    info->read_memory_func(pc, cap_buf, size, info);
+
+    if (cs_disasm_iter(handle, &cbuf, &size, &pc, cap_insn)) {
+        info->fprintf_func(info->stream, "%s %s",
+                           cap_insn->mnemonic, cap_insn->op_str);
+    }
+
+    cs_close(&handle);
+    return true;
+}
diff --git a/disas/meson.build b/disas/meson.build
index bde8280c73..09a852742e 100644
--- a/disas/meson.build
+++ b/disas/meson.build
@@ -21,5 +21,6 @@ common_ss.add(when: 'CONFIG_S390_DIS', if_true: files('s390.c'))
 common_ss.add(when: 'CONFIG_SH4_DIS', if_true: files('sh4.c'))
 common_ss.add(when: 'CONFIG_SPARC_DIS', if_true: files('sparc.c'))
 common_ss.add(when: 'CONFIG_XTENSA_DIS', if_true: files('xtensa.c'))
+common_ss.add(when: capstone, if_true: files('capstone.c'))
 
 specific_ss.add(when: 'CONFIG_TCG_INTERPRETER', if_true: files('tci.c'))
-- 
2.25.1


