Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225E1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A8120709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 17:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qe1KLMgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A8120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbSZ0-0007nS-3A
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 13:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbSVm-0001mw-NS
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:28:10 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbSVl-0004Jk-Kx
 for qemu-devel@nongnu.org; Wed, 20 May 2020 13:28:10 -0400
Received: by mail-pl1-x643.google.com with SMTP id m7so1616132plt.5
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kNZVz8klhhmHc+6CSnLmSvrnq7KlJ9l7rdqsf1uPN3I=;
 b=Qe1KLMgobeZhDjzsypCfxSLx4xtJO1IjMquCHfYfmVljfGRz1UNRKncmsT6HSil9kw
 Kr6L0LLBLCtwORj3VdMJjTUjT2orsw6x2bhhZjI/SUE8zkY1e3YjUlvbdqlQyXnBs/gq
 T1f2PgMb+hkI5R+wCLa9b3R9/danLQegAzbzlDqJRyWLBTjEHTrR861IT/MKBya89/nj
 NO7NAB2dfk2P3umwbIrUJdoaD+SN+ikzTFc3VT1zxu8nvB3pT56OVozkJ6Wlfe3jBgWN
 OyzxNHpvE+D15PS6gYhw/k9zN8o5FBjUm96atKcWeOFNsZJniosGyJF2rHFmGqsWPw5H
 aY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kNZVz8klhhmHc+6CSnLmSvrnq7KlJ9l7rdqsf1uPN3I=;
 b=nE1OLXM5cC8R2HWdMeRqZNpb59NqR4i6gLZIBt4XhhDdZx3OJJOO8WgGa2NQAP7QD9
 opvrvRS1VR/AR9Qq3cd0n9JszTNrs97HhcOHSaQmDvgXjMqatwc4aB35ZnUA6HnLEQM3
 WGppuXKbQ3gwUCcAaeQA1A7ld6Zaa9sOR2ognr24te5rfEqW7vcDfSSHdRdLx3hYwI9p
 bx4Qa/breKVh9onB8d5OzKunyMWyAvabv7uU9cLTbqIKHSRFwx0TdQl12HuutqApk+2N
 r3IaJIKGZV0Y/7mZDM7+OAygotHBU852XP4t901PpyVTPZ4WHyfANfaIzPPLQeexNo9R
 5Chw==
X-Gm-Message-State: AOAM533Tws8Fnd/9hLEb3UnMsVrEahCwGhC0yifBwHnh1ByoMA/mDbQg
 xzWyCTOzRvgUcuX5bF7+ZawkTkeV3vU=
X-Google-Smtp-Source: ABdhPJzUDUW653ntcxnWAaJbI6k0bsg4nQRHnUKCSp2ZpEDQ/kv2q3xNbryAgUAtNQcVEBkOdO30nQ==
X-Received: by 2002:a17:902:fe0c:: with SMTP id
 g12mr2833090plj.316.1589995687542; 
 Wed, 20 May 2020 10:28:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id k18sm2643672pfg.217.2020.05.20.10.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 10:28:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 4/5] linux-user: Parse NT_GNU_PROPERTY_TYPE_0 notes
Date: Wed, 20 May 2020 10:27:59 -0700
Message-Id: <20200520172800.8499-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520172800.8499-1-richard.henderson@linaro.org>
References: <20200520172800.8499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For aarch64, this includes the GNU_PROPERTY_AARCH64_FEATURE_1_BTI bit,
which indicates that the image should be mapped with guarded pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v9: Only map the startup executable with BTI; anything else must be
    handled by the interpreter.
---
 linux-user/qemu.h    |   4 ++
 linux-user/elfload.c | 143 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 112 insertions(+), 35 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index ce902f5132..d36b18b678 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -61,6 +61,10 @@ struct image_info {
         abi_ulong       interpreter_loadmap_addr;
         abi_ulong       interpreter_pt_dynamic_addr;
         struct image_info *other_info;
+
+        /* For target-specific processing of NT_GNU_PROPERTY_TYPE_0. */
+        uint32_t        note_flags;
+
 #ifdef TARGET_MIPS
         int             fp_abi;
         int             interp_fp_abi;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 01a9323a63..c84c9991fd 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2319,7 +2319,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
-    int i, retval;
+    int i, retval, prot_exec;
     const char *errmsg;
 
     /* First of all, some simple consistency checks */
@@ -2354,17 +2354,90 @@ static void load_elf_image(const char *image_name, int image_fd,
     loaddr = -1, hiaddr = 0;
     info->alignment = 0;
     for (i = 0; i < ehdr->e_phnum; ++i) {
-        if (phdr[i].p_type == PT_LOAD) {
-            abi_ulong a = phdr[i].p_vaddr - phdr[i].p_offset;
+        struct elf_phdr *eppnt = phdr + i;
+
+        if (eppnt->p_type == PT_LOAD) {
+            abi_ulong a = eppnt->p_vaddr - eppnt->p_offset;
             if (a < loaddr) {
                 loaddr = a;
             }
-            a = phdr[i].p_vaddr + phdr[i].p_memsz;
+            a = eppnt->p_vaddr + eppnt->p_memsz;
             if (a > hiaddr) {
                 hiaddr = a;
             }
             ++info->nsegs;
-            info->alignment |= phdr[i].p_align;
+            info->alignment |= eppnt->p_align;
+        } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
+            char *interp_name;
+
+            if (*pinterp_name) {
+                errmsg = "Multiple PT_INTERP entries";
+                goto exit_errmsg;
+            }
+            interp_name = malloc(eppnt->p_filesz);
+            if (!interp_name) {
+                goto exit_perror;
+            }
+
+            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
+                memcpy(interp_name, bprm_buf + eppnt->p_offset,
+                       eppnt->p_filesz);
+            } else {
+                retval = pread(image_fd, interp_name, eppnt->p_filesz,
+                               eppnt->p_offset);
+                if (retval != eppnt->p_filesz) {
+                    goto exit_perror;
+                }
+            }
+            if (interp_name[eppnt->p_filesz - 1] != 0) {
+                errmsg = "Invalid PT_INTERP entry";
+                goto exit_errmsg;
+            }
+            *pinterp_name = interp_name;
+        } else if (eppnt->p_type == PT_GNU_PROPERTY) {
+            /* Process NT_GNU_PROPERTY_TYPE_0. */
+            const uint32_t gnu0_magic = const_le32('G' | 'N' << 8 | 'U' << 16);
+            uint32_t note[7];
+
+            /*
+             * The note contents are 7 words, but depending on LP64 vs ILP32
+             * there may be an 8th padding word at the end.  Check for and
+             * read the minimum size.  Further checks below will validate
+             * that the sizes of everything involved are as we expect.
+             */
+            if (eppnt->p_filesz < sizeof(note)) {
+                continue;
+            }
+            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
+                memcpy(note, bprm_buf + eppnt->p_offset, sizeof(note));
+            } else {
+                retval = pread(image_fd, note, sizeof(note), eppnt->p_offset);
+                if (retval != sizeof(note)) {
+                    goto exit_perror;
+                }
+            }
+#ifdef BSWAP_NEEDED
+            for (i = 0; i < ARRAY_SIZE(note); ++i) {
+                bswap32s(note + i);
+            }
+#endif
+            /*
+             * Check that this is a NT_GNU_PROPERTY_TYPE_0 note.
+             * Again, descsz includes padding.  Full size validation
+             * awaits checking the final payload.
+             */
+            if (note[0] != 4 ||                       /* namesz */
+                note[1] < 12 ||                       /* descsz */
+                note[2] != NT_GNU_PROPERTY_TYPE_0 ||  /* type */
+                note[3] != gnu0_magic) {              /* name */
+                continue;
+            }
+#ifdef TARGET_AARCH64
+            if (note[4] == GNU_PROPERTY_AARCH64_FEATURE_1_AND &&
+                note[5] == 4) {
+                info->note_flags = note[6];
+            }
+#endif /* TARGET_AARCH64 */
         }
     }
 
@@ -2453,15 +2526,42 @@ static void load_elf_image(const char *image_name, int image_fd,
     info->brk = 0;
     info->elf_flags = ehdr->e_flags;
 
+    prot_exec = PROT_EXEC;
+#ifdef TARGET_AARCH64
+    /*
+     * If the BTI feature is present, this indicates that the executable
+     * pages of the startup binary should be mapped with PROT_BTI, so that
+     * branch targets are enforced.
+     *
+     * The startup executable is either the interpreter or the static
+     * binary.  The interpreter is responsible for all pages of a
+     * dynamic executable.
+     *
+     * Elf notes are backward compatible to older cpus.
+     * Do not enable BTI unless it is supported.
+     */
+    if ((info->note_flags & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)
+        && (pinterp_name == NULL || *pinterp_name == 0)
+        && cpu_isar_feature(aa64_bti, ARM_CPU(thread_cpu))) {
+        prot_exec |= TARGET_PROT_BTI;
+    }
+#endif
+
     for (i = 0; i < ehdr->e_phnum; i++) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
             abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
             int elf_prot = 0;
 
-            if (eppnt->p_flags & PF_R) elf_prot =  PROT_READ;
-            if (eppnt->p_flags & PF_W) elf_prot |= PROT_WRITE;
-            if (eppnt->p_flags & PF_X) elf_prot |= PROT_EXEC;
+            if (eppnt->p_flags & PF_R) {
+                elf_prot |= PROT_READ;
+            }
+            if (eppnt->p_flags & PF_W) {
+                elf_prot |= PROT_WRITE;
+            }
+            if (eppnt->p_flags & PF_X) {
+                elf_prot |= prot_exec;
+            }
 
             vaddr = load_bias + eppnt->p_vaddr;
             vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
@@ -2511,33 +2611,6 @@ static void load_elf_image(const char *image_name, int image_fd,
                     info->brk = vaddr_em;
                 }
             }
-        } else if (eppnt->p_type == PT_INTERP && pinterp_name) {
-            char *interp_name;
-
-            if (*pinterp_name) {
-                errmsg = "Multiple PT_INTERP entries";
-                goto exit_errmsg;
-            }
-            interp_name = malloc(eppnt->p_filesz);
-            if (!interp_name) {
-                goto exit_perror;
-            }
-
-            if (eppnt->p_offset + eppnt->p_filesz <= BPRM_BUF_SIZE) {
-                memcpy(interp_name, bprm_buf + eppnt->p_offset,
-                       eppnt->p_filesz);
-            } else {
-                retval = pread(image_fd, interp_name, eppnt->p_filesz,
-                               eppnt->p_offset);
-                if (retval != eppnt->p_filesz) {
-                    goto exit_perror;
-                }
-            }
-            if (interp_name[eppnt->p_filesz - 1] != 0) {
-                errmsg = "Invalid PT_INTERP entry";
-                goto exit_errmsg;
-            }
-            *pinterp_name = interp_name;
 #ifdef TARGET_MIPS
         } else if (eppnt->p_type == PT_MIPS_ABIFLAGS) {
             Mips_elf_abiflags_v0 abiflags;
-- 
2.20.1


