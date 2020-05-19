Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD9FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:45:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE486206C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 19:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rO0n7HoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE486206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb8BP-0003AV-VN
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 15:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb8Ae-0002Ct-VT
 for qemu-devel@nongnu.org; Tue, 19 May 2020 15:45:00 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb8Ad-0002Gh-Gw
 for qemu-devel@nongnu.org; Tue, 19 May 2020 15:45:00 -0400
Received: by mail-pf1-x441.google.com with SMTP id y18so377523pfl.9
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 12:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KsWHtii54LVZuH4FTz7r+ZtKBBP67SvZtiMpOvG46T0=;
 b=rO0n7HoSzbiSrVSZJJxAWKC9ELV+n/Gnt0uoLgtH2AVY12INAoj5ko2AOxYudU/73J
 4bhnnzfx6K+C/Kp4Z0XBsuk2ppq2lrMNauafaBcxAewzbtnf0ZnglvKUWCLO9Fb3oHc+
 6fPIkiv6otBPW2+gjSx4BzNYqYb3d2YMqPJ1VJwPuYrD5tbp+iPzLl1tvglZl74LJs3D
 w7knx5JCxAIHw+scCgLvxUzuYt+BZn4adRki3omOvQIsOFM7Q1hJXHhxpQoWxIWFt7IZ
 o2aAhOqjiRUISunTIJeLt1qT3SF9XV/JqnXn3p6Q8bvs8QJDAymCJ+XJACcjOqHjDZue
 v5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KsWHtii54LVZuH4FTz7r+ZtKBBP67SvZtiMpOvG46T0=;
 b=e/fivUAkgD9DVLVqv7l6PFL2wA64piNU3VhqLG3n+qlJt9wbmjHjBZvDj8vcavvgtY
 ElNI1pR5lGeAqgWofwFm6v8sV9nylv9fiO2MGdzl85VBvPJ6ohfMwf/I++7ZzIR/tR+V
 SEyR4tm0249rTHP+JbqOUj/0zXfDnCg3ekNngwnIhWJDVs2za953PUDKQP4EoOBaSPrm
 UOapLnjMajK/hFiLDv6Zao2GzGTQq75ocymy2aJEdgDPhXo07QRtFNqf6z5LXbL1HuIk
 huUajwVTZLxGnwODE0+qSx8lVfKm7vaB6RItKo3yWr256gy8l/B+jpTwHmOultZmNBTS
 pLHg==
X-Gm-Message-State: AOAM532vSQ23+hAf2kjHJRLC4oz4c/w4ipMZXEzpQEBtjTQip3TQKum7
 RYfBWit0y8Wta4DdcHr0I04TpOg8Vhw=
X-Google-Smtp-Source: ABdhPJzbDxFyKNeaw7caR9QdEZWGINmgHK1Dv7ooYDjz9KIkC5rFFWVfSyWY4aSgMJ32LaPdK77LzQ==
X-Received: by 2002:a62:16d5:: with SMTP id 204mr690158pfw.10.1589917497699;
 Tue, 19 May 2020 12:44:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i7sm285744pjj.33.2020.05.19.12.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 12:44:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] linux-user: Load a VDSO for x86-64.
Date: Tue, 19 May 2020 12:44:52 -0700
Message-Id: <20200519194452.9009-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519194452.9009-1-richard.henderson@linaro.org>
References: <20200519194452.9009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: laurent@vivier.eu, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/elfload.c | 203 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 198 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 01a9323a63..d70e27cb62 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -199,6 +199,8 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
     (*regs)[26] = env->segs[R_GS].selector & 0xffff;
 }
 
+#define VDSO_BASENAME  "vdso-linux-x64.so"
+
 #else
 
 #define ELF_START_MMAP 0x80000000
@@ -1499,6 +1501,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 #define STACK_ALIGNMENT 16
 #endif
 
+#ifndef VDSO_BASENAME
+#define VDSO_BASENAME NULL
+#endif
+
 #ifdef TARGET_ABI32
 #undef ELF_CLASS
 #define ELF_CLASS ELFCLASS32
@@ -1859,7 +1865,8 @@ static abi_ulong loader_build_fdpic_loadmap(struct image_info *info, abi_ulong s
 static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
                                    struct elfhdr *exec,
                                    struct image_info *info,
-                                   struct image_info *interp_info)
+                                   struct image_info *interp_info,
+                                   struct image_info *vdso_info)
 {
     abi_ulong sp;
     abi_ulong u_argc, u_argv, u_envp, u_auxv;
@@ -1931,8 +1938,12 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     }
 
     size = (DLINFO_ITEMS + 1) * 2;
-    if (k_platform)
+    if (k_platform) {
         size += 2;
+    }
+    if (vdso_info) {
+        size += 4;
+    }
 #ifdef DLINFO_ARCH_ITEMS
     size += DLINFO_ARCH_ITEMS * 2;
 #endif
@@ -2009,6 +2020,10 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     if (u_platform) {
         NEW_AUX_ENT(AT_PLATFORM, u_platform);
     }
+    if (vdso_info) {
+        NEW_AUX_ENT(AT_SYSINFO, vdso_info->entry);
+        NEW_AUX_ENT(AT_SYSINFO_EHDR, vdso_info->load_addr);
+    }
     NEW_AUX_ENT (AT_NULL, 0);
 #undef NEW_AUX_ENT
 
@@ -2614,6 +2629,177 @@ static void load_elf_interp(const char *filename, struct image_info *info,
     exit(-1);
 }
 
+static void load_elf_vdso(const char *basename, struct image_info *info,
+                          char bprm_buf[BPRM_BUF_SIZE])
+{
+    const char *errmsg;
+    char *filename;
+    int fd, retval, i;
+    abi_ulong load_bias;
+
+    /*
+     * ??? What we really need access to is qemu_find_file, but that is
+     * only built for system targets at the moment.
+     */
+    filename = g_build_filename(CONFIG_QEMU_DATADIR, basename, NULL);
+    fd = open(filename, O_RDONLY);
+    if (fd < 0) {
+        goto exit_perror;
+    }
+    g_free(filename);
+
+    retval = read(fd, bprm_buf, BPRM_BUF_SIZE);
+    if (retval < 0) {
+        goto exit_perror;
+    }
+    if (retval < BPRM_BUF_SIZE) {
+        memset(bprm_buf + retval, 0, BPRM_BUF_SIZE - retval);
+    }
+
+    load_elf_image(basename, fd, info, NULL, bprm_buf);
+    load_bias = info->load_bias;
+
+    /*
+     * We most likely need to relocate the VDSO image.  The one built into
+     * the kernel is built for a fixed address.  The one built for QEMU is
+     * not, since that requires close control of the guest address space.
+     */
+    if (load_bias) {
+        struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
+        struct elf_phdr *phdr;
+        abi_ulong dynamic_addr = -1;
+        abi_ulong dynsym_addr = -1;
+
+        /*
+         * ??? Assume QEMU's VDSO is built "properly", which arranges
+         * for the PHDRs, and all the sections manipulated below, to
+         * be included with a writable load segment.
+         *
+         * ??? One might think that we'd need to relocate ehdr.e_entry,
+         * but for some reason glibc does that one itself, though that
+         * is also available via the AT_SYSINFO entry.
+         */
+
+        /* Relocate the program headers.  */
+        phdr = (struct elf_phdr *)g2h(info->load_addr + ehdr->e_phoff);
+        bswap_phdr(phdr, ehdr->e_phnum);
+        for (i = 0; i < ehdr->e_phnum; ++i) {
+            phdr[i].p_vaddr += load_bias;
+            phdr[i].p_paddr += load_bias;
+            if (phdr[i].p_type == PT_DYNAMIC) {
+                dynamic_addr = phdr[i].p_vaddr;
+            }
+        }
+        bswap_phdr(phdr, ehdr->e_phnum);
+
+        /* Relocate the DYNAMIC entries.  */
+        if (dynamic_addr != -1) {
+            abi_ulong tag, val, *dyn = (abi_ulong *)g2h(dynamic_addr);
+            do {
+                tag = tswapl(dyn[0]);
+                val = tswapl(dyn[1]);
+                switch (tag) {
+                case DT_SYMTAB:
+                    dynsym_addr = load_bias + val;
+                    dyn[1] = tswapl(dynsym_addr);
+                    break;
+                case DT_SYMENT:
+                    if (val != sizeof(struct elf_sym)) {
+                        errmsg = "VDSO has an unexpected dynamic symbol size";
+                        goto exit_errmsg;
+                    }
+                    break;
+
+                case DT_HASH:
+                case DT_STRTAB:
+                case DT_VERDEF:
+                case DT_VERSYM:
+                case DT_ADDRRNGLO ... DT_ADDRRNGHI:
+                    /* These entries store an address in the entry.  */
+                    dyn[1] = tswapl(load_bias + val);
+                    break;
+
+                case DT_NULL:
+                case DT_STRSZ:
+                case DT_SONAME:
+                case DT_DEBUG:
+                case DT_FLAGS:
+                case DT_FLAGS_1:
+                case DT_VERDEFNUM:
+                case DT_VALRNGLO ... DT_VALRNGHI:
+                    /* These entries store an integer in the entry.  */
+                    break;
+
+                case DT_REL:
+                case DT_RELA:
+                    /*
+                     * These entries indicate that the VDSO was built
+                     * incorrectly.  It should not have real relocations.
+                     */
+                    errmsg = "VDSO has relocations";
+                    goto exit_errmsg;
+                case DT_NEEDED:
+                case DT_VERNEED:
+                    errmsg = "VDSO has external dependancies";
+                    goto exit_errmsg;
+
+                default:
+                    /* This is probably something target specific.  */
+                    errmsg = "VDSO has unknown DYNAMIC entry";
+                    goto exit_errmsg;
+                }
+                dyn += 2;
+            } while (tag != DT_NULL);
+        }
+
+        /* Relocate the dynamic symbol table.  */
+        if (dynsym_addr != -1) {
+            struct elf_shdr *shdr;
+            struct elf_sym *sym;
+            int dynsym_size = 0;
+
+            /*
+             * Read the section headers to find out the size of the
+             * dynamic symbol table.
+             */
+            shdr = (struct elf_shdr *)g2h(info->load_addr + ehdr->e_shoff);
+            for (i = 0; i < ehdr->e_shnum; ++i) {
+                abi_ulong addr = tswapl(shdr[i].sh_addr) + load_bias;
+                if (addr == dynsym_addr) {
+                    dynsym_size = tswapl(shdr[i].sh_size);
+                    break;
+                }
+            }
+
+            sym = (struct elf_sym *)g2h(dynsym_addr);
+            for (i = 0; i < dynsym_size / sizeof(*sym); ++i) {
+                sym[i].st_value = tswapl(tswapl(sym[i].st_value) + load_bias);
+            }
+        }
+    }
+
+    /*
+     * Mark the VDSO writable segment read-only.
+     *
+     * ??? This assumes that the VDSO implementation doesn't actually
+     * have any truely writable data.  Perhaps we should instead use
+     * the PT_GNU_RELRO header to indicate that we really want this.
+     */
+    retval = target_mprotect(info->start_data, info->brk - info->start_data,
+                             PROT_READ);
+    if (retval < 0) {
+        goto exit_perror;
+    }
+    return;
+
+ exit_perror:
+    errmsg = strerror(errno);
+ exit_errmsg:
+    fprintf(stderr, "%s: %s\n", filename, errmsg);
+    exit(-1);
+}
+
+
 static int symfind(const void *s0, const void *s1)
 {
     target_ulong addr = *(target_ulong *)s0;
@@ -2803,7 +2989,7 @@ uint32_t get_elf_eflags(int fd)
 
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 {
-    struct image_info interp_info;
+    struct image_info interp_info, vdso_info;
     struct elfhdr elf_ex;
     char *elf_interpreter = NULL;
     char *scratch;
@@ -2879,8 +3065,15 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
 #endif
     }
 
-    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc, &elf_ex,
-                                info, (elf_interpreter ? &interp_info : NULL));
+    /* If we've been given a VDSO to load, do so.  */
+    if (VDSO_BASENAME) {
+        load_elf_vdso(VDSO_BASENAME, &vdso_info, bprm->buf);
+    }
+
+    bprm->p = create_elf_tables(bprm->p, bprm->argc, bprm->envc,
+                                &elf_ex, info,
+                                (elf_interpreter ? &interp_info : NULL),
+                                (VDSO_BASENAME ? &vdso_info : NULL));
     info->start_stack = bprm->p;
 
     /* If we have an interpreter, set that as the program's entry point.
-- 
2.20.1


