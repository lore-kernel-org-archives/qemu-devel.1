Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7824C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1735320789
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6QV+zb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1735320789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ3tN-0003aK-1B
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 20:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mU-00043V-Rh
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:38 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3mQ-0006fZ-3r
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 19:57:38 -0400
Received: by mail-pl1-x644.google.com with SMTP id q12so1982064plr.12
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kxms3FS2kG3VRY7JUUSIn+glY/IToVYjcyoEFpFah2g=;
 b=O6QV+zb/y53SRC4TFEzwK9dUcydWiEW53l+OR1r/9kD6SCXaJ3eCZZe7UPr2Cj2Zas
 Dz3lwlHRWnwBxhJc17hpEIcF2elj9ouaY7jVg1CUa6f/Z3Qj/5KDh3hUYVo/mzY6Qiqj
 tM4tNsuxWsUOdTqNe49NI6Gc4Ltw+/AVLtbRbIRtNditK2b0gjO74IgE97CHvGOJYtim
 0eVDGh2uQu03Llrtkypl5oRY5EBkOD7setJn+IGFSqkaCg0eS9/DYXE7FbL8tWlZ0KK0
 5enJ0NghF1BM5Kr6IOyAk3Ez8MRpd44C+wI9MksV5C7xHuzaARBNpl0sZNBrEoe9u2/3
 dYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kxms3FS2kG3VRY7JUUSIn+glY/IToVYjcyoEFpFah2g=;
 b=bUACco9TzwJlYbz+p9Q6rbmY65XSJV62rdQgyT9FU9clsF8M13hfdYcTu8d5k2a9eM
 PFIYAxDQlCEonRU/NKg8d6BWfECNBhMP59gfNuuBuDBA8zqqkiyXytad3PkSLOae4E6h
 RsWtoq73XdnpF9FO2ItHymqmhIdwarN3T+YpzXs5KYHeQhiROpIiR+ryILQgoRUlrLh4
 fFz8cb12kH7BmAXKleC0SDqQjAif21m0yfeu93ftgqxQ269J6N2f1CTAASx10tWw8pwD
 efDsJLmw4yZhoFYA+g7onLUO+rRCLmaQRfeYzrMHoIPoL7p+XOCvs2qtaecWS/8ugy76
 mWjA==
X-Gm-Message-State: AOAM531Xp6z9jQVTVbPfJhtEKmvK5Lgby8gnYWGmu+WmcF1i5v0n9c8A
 zWfBglKld+VZ4fnCYxSaKJfilTW0LLRWiQ==
X-Google-Smtp-Source: ABdhPJxQwn6/fJwkEddjUihdiWpzYU1DmU0zX2cFAFN6eyCiaXkiyeHaOCHuWzW+ril+/UcOyi2ksQ==
X-Received: by 2002:a17:902:b086:b029:d1:e5e7:bddb with SMTP id
 p6-20020a170902b086b02900d1e5e7bddbmr12621604plr.59.1600387051902; 
 Thu, 17 Sep 2020 16:57:31 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m13sm772699pfk.103.2020.09.17.16.57.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 16:57:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/10] disas: Split out capstone code to disas/capstone.c
Date: Thu, 17 Sep 2020 16:57:18 -0700
Message-Id: <20200917235720.2685978-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917235720.2685978-1-richard.henderson@linaro.org>
References: <20200917235720.2685978-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is nothing target-specific about this code, so it
can be added to common_ss.  This also requires that the
base capstone dependency be added to common_ss, so that
we get the correct include paths added to CFLAGS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/dis-asm.h |  12 ++
 disas.c                 | 275 --------------------------------------
 disas/capstone.c        | 286 ++++++++++++++++++++++++++++++++++++++++
 disas/meson.build       |   1 +
 meson.build             |   1 +
 5 files changed, 300 insertions(+), 275 deletions(-)
 create mode 100644 disas/capstone.c

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
index 01c8bc6c9e..e27dea2c19 100644
--- a/disas.c
+++ b/disas.c
@@ -107,255 +107,6 @@ static int print_insn_od_target(bfd_vma pc, disassemble_info *info)
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
@@ -513,32 +264,6 @@ static void plugin_print_address(bfd_vma addr, struct disassemble_info *info)
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
diff --git a/meson.build b/meson.build
index 4c92b43fe5..e16a2b051d 100644
--- a/meson.build
+++ b/meson.build
@@ -965,6 +965,7 @@ common_ss.add(files('cpus-common.c'))
 
 subdir('softmmu')
 
+common_ss.add(capstone)
 specific_ss.add(files('disas.c', 'exec.c', 'gdbstub.c'), capstone, libpmem, libdaxctl)
 specific_ss.add(files('exec-vary.c'))
 specific_ss.add(when: 'CONFIG_TCG', if_true: files(
-- 
2.25.1


