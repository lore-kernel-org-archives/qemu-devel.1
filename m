Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8211C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A81212CC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 21:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAQiKPok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A81212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQHRG-0003qt-Mf
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 17:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kQHOw-0002Qk-T5; Wed, 07 Oct 2020 17:55:10 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:36009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kQHOu-0003j9-O2; Wed, 07 Oct 2020 17:55:10 -0400
Received: by mail-lf1-x143.google.com with SMTP id h6so4106590lfj.3;
 Wed, 07 Oct 2020 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=Rd/cDEaFC4+wp88YaSYWny8ui4u764JHTBOldt5ufvE=;
 b=fAQiKPokH6h+wdAAVMzY7/0axYCw8adgDm8aWwzaO7dFy2DKSKbMCEm5Wog+iVV2Sa
 pNayGLljNc26eCcltkDG4bz2eIM7VBOBcBW/0N2eNHQ/gz7EO+sUL5yeGhXcr9L2CfaL
 Rk8EgNazk4EALBAA0kKUNTwd0F6nFbYMIIFzKwa55SNgfyvUJ7zrt+jdrNoKy3ZZ2zod
 RI2AXNV+uH2+x6ubSu0VYlEdrbGm9ueDkldITlfN9uB4Uiquh4cCFsUR0VXjW+GGT57F
 t/N3uX4QkP3ybh27ExCdeM+oNt1zoGFBKbBXmpolBFPcCsBCIk6LMMD7SbtxjJmIv/Rb
 FyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=Rd/cDEaFC4+wp88YaSYWny8ui4u764JHTBOldt5ufvE=;
 b=bCtDzpWXrazidefdxcVm/4cBDQNVTePwGTMQ15xgIIdoFB6P1vdrdu8giET6apk2nk
 uL1wWrE/hm4DlzRID+bGrYOfHWNYmkMev56DS3lCIpMeb6N9REdwg6Dubtgtwnt9uaCI
 I7D3tt/b88i7Hv1aY5uZJ4J0zu9oonWKUd2APd9KpOlScC5792uGLd99hQhRNjPL8DsE
 RQciQ3ivXc005lPoMZP1/MN4hT0k6X4UGi7+KVu2RwriWN/IViLbg7mOFPuRmz/LdPj1
 GKqhzl65OD0gvSe+vSpWUjX9P8curVNCKCiY53iKefPG6AOTBe28oVBVzUCxteF+OYc0
 WV8Q==
X-Gm-Message-State: AOAM5339ozsvhjWzmRZO9hsgFEptRrUNVT6JBxEnJC+erh7QRayoa/79
 AJhFN7eFkA+1Xn0EWGrfvWxP6bLkMvylvndu
X-Google-Smtp-Source: ABdhPJyE+a2/H1qmnXUWj+d+EgLZ9S5CPaStSnkrnbqIe0zbUTpchkKgoZE99cXLTqATHCjG9WvrOA==
X-Received: by 2002:a19:40c:: with SMTP id 12mr1496806lfe.193.1602107705535;
 Wed, 07 Oct 2020 14:55:05 -0700 (PDT)
Received: from [192.168.167.128] (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id x2sm551574lji.9.2020.10.07.14.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 14:55:04 -0700 (PDT)
Message-ID: <f21781e85b10bdce0a3ecc87304e8214096140d8.camel@gmail.com>
Subject: [PATCH v2] bsd-user/elfload: use g_new/g_malloc
From: Elena Afanasova <eafanasova@gmail.com>
To: qemu-devel@nongnu.org, armbru@redhat.com, thuth@redhat.com,
 kamil@netbsd.org,  brad@comstyle.com, emaste@freebsd.org, lwhsu@freebsd.org
Date: Wed, 07 Oct 2020 14:54:52 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=eafanasova@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
---
 bsd-user/elfload.c | 88 ++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 58 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 32378af7b2..f1be01c410 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -867,18 +867,14 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
         if (sizeof(struct elf_phdr) * interp_elf_ex->e_phnum > TARGET_PAGE_SIZE)
             return ~(abi_ulong)0UL;
 
-        elf_phdata =  (struct elf_phdr *)
-                malloc(sizeof(struct elf_phdr) * interp_elf_ex->e_phnum);
-
-        if (!elf_phdata)
-          return ~((abi_ulong)0UL);
+        elf_phdata = g_new(struct elf_phdr, interp_elf_ex->e_phnum);
 
         /*
          * If the size of this structure has changed, then punt, since
          * we will be doing the wrong thing.
          */
         if (interp_elf_ex->e_phentsize != sizeof(struct elf_phdr)) {
-            free(elf_phdata);
+            g_free(elf_phdata);
             return ~((abi_ulong)0UL);
         }
 
@@ -890,8 +886,8 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
         }
         if (retval < 0) {
                 perror("load_elf_interp");
+                g_free(elf_phdata);
                 exit(-1);
-                free (elf_phdata);
                 return retval;
         }
 #ifdef BSWAP_NEEDED
@@ -940,7 +936,7 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
             if (error == -1) {
               /* Real error */
               close(interpreter_fd);
-              free(elf_phdata);
+              g_free(elf_phdata);
               return ~((abi_ulong)0UL);
             }
 
@@ -983,7 +979,7 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
                         PROT_READ|PROT_WRITE|PROT_EXEC,
                         MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);
         }
-        free(elf_phdata);
+        g_free(elf_phdata);
 
         *interp_load_addr = load_addr;
         return ((abi_ulong) interp_elf_ex->e_entry) + load_addr;
@@ -1064,24 +1060,15 @@ static void load_symbols(struct elfhdr *hdr, int fd)
 
  found:
     /* Now know where the strtab and symtab are.  Snarf them. */
-    s = malloc(sizeof(*s));
-    syms = malloc(symtab.sh_size);
-    if (!syms) {
-        free(s);
-        return;
-    }
-    s->disas_strtab = strings = malloc(strtab.sh_size);
-    if (!s->disas_strtab) {
-        free(s);
-        free(syms);
-        return;
-    }
+    s = g_malloc(sizeof(*s));
+    syms = g_malloc(symtab.sh_size);
+    s->disas_strtab = strings = g_malloc(strtab.sh_size);
 
     lseek(fd, symtab.sh_offset, SEEK_SET);
     if (read(fd, syms, symtab.sh_size) != symtab.sh_size) {
-        free(s);
-        free(syms);
-        free(strings);
+        g_free(s);
+        g_free(syms);
+        g_free(strings);
         return;
     }
 
@@ -1113,22 +1100,16 @@ static void load_symbols(struct elfhdr *hdr, int fd)
         that we threw away.  Whether or not this has any effect on the
         memory allocation depends on the malloc implementation and how
         many symbols we managed to discard. */
-    new_syms = realloc(syms, nsyms * sizeof(*syms));
-    if (new_syms == NULL) {
-        free(s);
-        free(syms);
-        free(strings);
-        return;
-    }
+    new_syms = g_realloc(syms, nsyms * sizeof(*syms));
     syms = new_syms;
 
     qsort(syms, nsyms, sizeof(*syms), symcmp);
 
     lseek(fd, strtab.sh_offset, SEEK_SET);
     if (read(fd, strings, strtab.sh_size) != strtab.sh_size) {
-        free(s);
-        free(syms);
-        free(strings);
+        g_free(s);
+        g_free(syms);
+        g_free(strings);
         return;
     }
     s->disas_num_syms = nsyms;
@@ -1190,10 +1171,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
     }
 
     /* Now read in all of the header information */
-    elf_phdata = (struct elf_phdr *)malloc(elf_ex.e_phentsize*elf_ex.e_phnum);
-    if (elf_phdata == NULL) {
-        return -ENOMEM;
-    }
+    elf_phdata = g_malloc(elf_ex.e_phentsize * elf_ex.e_phnum);
 
     retval = lseek(bprm->fd, elf_ex.e_phoff, SEEK_SET);
     if(retval > 0) {
@@ -1203,8 +1181,8 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
 
     if (retval < 0) {
         perror("load_elf_binary");
+        g_free(elf_phdata);
         exit(-1);
-        free (elf_phdata);
         return -errno;
     }
 
@@ -1231,8 +1209,8 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
         if (elf_ppnt->p_type == PT_INTERP) {
             if ( elf_interpreter != NULL )
             {
-                free (elf_phdata);
-                free(elf_interpreter);
+                g_free(elf_phdata);
+                g_free(elf_interpreter);
                 close(bprm->fd);
                 return -EINVAL;
             }
@@ -1242,13 +1220,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
              * is an a.out format binary
              */
 
-            elf_interpreter = (char *)malloc(elf_ppnt->p_filesz);
-
-            if (elf_interpreter == NULL) {
-                free (elf_phdata);
-                close(bprm->fd);
-                return -ENOMEM;
-            }
+            elf_interpreter = g_malloc(elf_ppnt->p_filesz);
 
             retval = lseek(bprm->fd, elf_ppnt->p_offset, SEEK_SET);
             if(retval >= 0) {
@@ -1297,10 +1269,10 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
             }
             if (retval < 0) {
                 perror("load_elf_binary3");
-                exit(-1);
-                free (elf_phdata);
-                free(elf_interpreter);
+                g_free(elf_phdata);
+                g_free(elf_interpreter);
                 close(bprm->fd);
+                exit(-1);
                 return retval;
             }
         }
@@ -1323,8 +1295,8 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
         }
 
         if (!interpreter_type) {
-            free(elf_interpreter);
-            free(elf_phdata);
+            g_free(elf_interpreter);
+            g_free(elf_phdata);
             close(bprm->fd);
             return -ELIBBAD;
         }
@@ -1346,8 +1318,8 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
             }
         }
         if (!bprm->p) {
-            free(elf_interpreter);
-            free (elf_phdata);
+            g_free(elf_interpreter);
+            g_free(elf_phdata);
             close(bprm->fd);
             return -E2BIG;
         }
@@ -1486,17 +1458,17 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
         reloc_func_desc = interp_load_addr;
 
         close(interpreter_fd);
-        free(elf_interpreter);
+        g_free(elf_interpreter);
 
         if (elf_entry == ~((abi_ulong)0UL)) {
             printf("Unable to load interpreter\n");
-            free(elf_phdata);
+            g_free(elf_phdata);
             exit(-1);
             return 0;
         }
     }
 
-    free(elf_phdata);
+    g_free(elf_phdata);
 
     if (qemu_log_enabled())
         load_symbols(&elf_ex, bprm->fd);
-- 
2.25.1



