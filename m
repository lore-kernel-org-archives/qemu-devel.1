Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D84EC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 12:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8976C206A1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 12:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqAI0EQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8976C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP31j-0003Fi-Ks
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 08:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kP30K-0002iY-1p; Sun, 04 Oct 2020 08:20:40 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kP30H-0002QT-Qz; Sun, 04 Oct 2020 08:20:39 -0400
Received: by mail-lj1-x241.google.com with SMTP id w3so4846521ljo.5;
 Sun, 04 Oct 2020 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=gUGwOZQkxmPD7anmpZi8bbMrX9lFvKWVHOaabMtKDfA=;
 b=pqAI0EQP6Er14VEHAPNmZp8RG8CgbWsTbDCrVjv5PZQ+IA2sXERTnCfxlFSwjZywUB
 SvayKozUYmEI0Hm2Q67NdPAPZAAQ/a0dvB4rsxDo13VNYzwsEohmD1AwQ3sUCXh4MHMC
 cgt+pafsQp1kHjKL1OgGVTXMb6c+yMP6KK6CYxazyTaYmILPTDV5tv6lbHGrwFiVqKo4
 yLba+e+U5l/slo7zjc3bEqpgvVJc5lt+POhsiE3Nyxozl/Q8bwE8oY20V0SPvJH0VRaW
 Q2AEciQOG0wSNNcpCxy4ucWkFzuvwyG/fv+uPdAiWd1egaQ0NCDGme9jnuoxDjgRFlxT
 Xr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=gUGwOZQkxmPD7anmpZi8bbMrX9lFvKWVHOaabMtKDfA=;
 b=dLvjLy8Z4az/PF4mCZAW3Y8kKkN6s3VruT6sfPqHxJO4uGgm52um3xEQuY6CiMiUQ2
 n/wLlgNYjKMHpXS47TOB6ekxpqKxkW1G6TTrJ8WRKfBEj0Dezd0K5pjP1M6KavngqBYm
 F/TdE9UYDqlPnEXUpC9M/L/CTsnhhQltCsq6aikeeGOudZh80HjsuKfi5d2TUh6eB/Qx
 z0tYzt4802v0DT6SUbuRXH/mGEi9QIwAO6iiS6h61cNc5muRmi5rZAd1ffh1JOre1760
 ALam5NzUoIGlWpTJ6QPUnCcUM48/9rKTPRdI7dlj09jfwIewJSDk3RpoPeMe2H5Dteq4
 YdmA==
X-Gm-Message-State: AOAM530t35hOAeL/Vtdlre0Fk7z1PCbM9krSUCOf5Yli4EKtmwQl4guw
 D4U896PRUfw08xPMKuj77ps=
X-Google-Smtp-Source: ABdhPJxgbSwb1WlcH+FASiaFUo6MZy4RbDr7m/3UZWoKiC/pqzP96KAK7zPFVq76pSyAkD1KMrrRVg==
X-Received: by 2002:a2e:7809:: with SMTP id t9mr2603458ljc.115.1601814034833; 
 Sun, 04 Oct 2020 05:20:34 -0700 (PDT)
Received: from [192.168.167.128] (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id m13sm2380333lfb.172.2020.10.04.05.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 05:20:34 -0700 (PDT)
Message-ID: <d52b5d3655fba86d1b3816115b24997b36952e3b.camel@gmail.com>
Subject: Re: [PATCH v2] elfload: use g_new/g_malloc and g_autofree
From: Elena Afanasova <eafanasova@gmail.com>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, kamil@netbsd.org, brad@comstyle.com,
 emaste@freebsd.org, lwhsu@freebsd.org
Date: Sun, 04 Oct 2020 05:20:18 -0700
In-Reply-To: <17636b91-e111-1b60-4eb2-d526df4a6bb6@redhat.com>
References: <20201001123807.42978-1-eafanasova@gmail.com>
 <87r1qhtdxt.fsf@dusky.pond.sub.org>
 <b4ab229a-0e84-9d0b-1287-846c52a667bb@redhat.com>
 <87eemhm2b9.fsf@dusky.pond.sub.org>
 <17636b91-e111-1b60-4eb2-d526df4a6bb6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=eafanasova@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Subject: [PATCH v2] elfload: use g_new/g_malloc and g_autofree

Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
---
 bsd-user/elfload.c | 79 ++++++++--------------------------------------
 1 file changed, 14 insertions(+), 65 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 32378af7b2..bc4be4c874 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -838,7 +838,7 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
                                  int interpreter_fd,
                                  abi_ulong *interp_load_addr)
 {
-        struct elf_phdr *elf_phdata  =  NULL;
+        g_autofree struct elf_phdr *elf_phdata = NULL;
         struct elf_phdr *eppnt;
         abi_ulong load_addr = 0;
         int load_addr_set = 0;
@@ -867,18 +867,13 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
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
             return ~((abi_ulong)0UL);
         }
 
@@ -891,7 +886,6 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
         if (retval < 0) {
                 perror("load_elf_interp");
                 exit(-1);
-                free (elf_phdata);
                 return retval;
         }
 #ifdef BSWAP_NEEDED
@@ -940,7 +934,6 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
             if (error == -1) {
               /* Real error */
               close(interpreter_fd);
-              free(elf_phdata);
               return ~((abi_ulong)0UL);
             }
 
@@ -983,7 +976,6 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
                         PROT_READ|PROT_WRITE|PROT_EXEC,
                         MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);
         }
-        free(elf_phdata);
 
         *interp_load_addr = load_addr;
         return ((abi_ulong) interp_elf_ex->e_entry) + load_addr;
@@ -1036,9 +1028,10 @@ static void load_symbols(struct elfhdr *hdr, int fd)
 {
     unsigned int i, nsyms;
     struct elf_shdr sechdr, symtab, strtab;
-    char *strings;
-    struct syminfo *s;
-    struct elf_sym *syms, *new_syms;
+    g_autofree char *strings = NULL;
+    g_autofree struct syminfo *s = NULL;
+    g_autofree struct elf_sym *syms = NULL;
+    struct elf_sym *new_syms;
 
     lseek(fd, hdr->e_shoff, SEEK_SET);
     for (i = 0; i < hdr->e_shnum; i++) {
@@ -1064,24 +1057,12 @@ static void load_symbols(struct elfhdr *hdr, int fd)
 
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
+    s = g_new(struct syminfo, 1);
+    syms = g_malloc(symtab.sh_size);
+    s->disas_strtab = strings = g_new(char, strtab.sh_size);
 
     lseek(fd, symtab.sh_offset, SEEK_SET);
     if (read(fd, syms, symtab.sh_size) != symtab.sh_size) {
-        free(s);
-        free(syms);
-        free(strings);
         return;
     }
 
@@ -1113,22 +1094,13 @@ static void load_symbols(struct elfhdr *hdr, int fd)
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
         return;
     }
     s->disas_num_syms = nsyms;
@@ -1156,10 +1128,10 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
     unsigned char ibcs2_interpreter;
     int i;
     struct elf_phdr * elf_ppnt;
-    struct elf_phdr *elf_phdata;
+    g_autofree struct elf_phdr *elf_phdata = NULL;
     abi_ulong elf_bss, k, elf_brk;
     int retval;
-    char * elf_interpreter;
+    g_autofree char *elf_interpreter = NULL;
     abi_ulong elf_entry, interp_load_addr = 0;
     abi_ulong start_code, end_code, start_data, end_data;
     abi_ulong reloc_func_desc = 0;
@@ -1190,10 +1162,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
     }
 
     /* Now read in all of the header information */
-    elf_phdata = (struct elf_phdr *)malloc(elf_ex.e_phentsize*elf_ex.e_phnum);
-    if (elf_phdata == NULL) {
-        return -ENOMEM;
-    }
+    elf_phdata = g_new(struct elf_phdr, elf_ex.e_phnum);
 
     retval = lseek(bprm->fd, elf_ex.e_phoff, SEEK_SET);
     if(retval > 0) {
@@ -1204,7 +1173,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
     if (retval < 0) {
         perror("load_elf_binary");
         exit(-1);
-        free (elf_phdata);
         return -errno;
     }
 
@@ -1220,7 +1188,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
     elf_brk = 0;
 
 
-    elf_interpreter = NULL;
     start_code = ~((abi_ulong)0UL);
     end_code = 0;
     start_data = 0;
@@ -1231,8 +1198,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
         if (elf_ppnt->p_type == PT_INTERP) {
             if ( elf_interpreter != NULL )
             {
-                free (elf_phdata);
-                free(elf_interpreter);
                 close(bprm->fd);
                 return -EINVAL;
             }
@@ -1242,13 +1207,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
              * is an a.out format binary
              */
 
-            elf_interpreter = (char *)malloc(elf_ppnt->p_filesz);
-
-            if (elf_interpreter == NULL) {
-                free (elf_phdata);
-                close(bprm->fd);
-                return -ENOMEM;
-            }
+            elf_interpreter = g_new(char, elf_ppnt->p_filesz);
 
             retval = lseek(bprm->fd, elf_ppnt->p_offset, SEEK_SET);
             if(retval >= 0) {
@@ -1298,8 +1257,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
             if (retval < 0) {
                 perror("load_elf_binary3");
                 exit(-1);
-                free (elf_phdata);
-                free(elf_interpreter);
                 close(bprm->fd);
                 return retval;
             }
@@ -1323,8 +1280,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
         }
 
         if (!interpreter_type) {
-            free(elf_interpreter);
-            free(elf_phdata);
             close(bprm->fd);
             return -ELIBBAD;
         }
@@ -1346,8 +1301,6 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
             }
         }
         if (!bprm->p) {
-            free(elf_interpreter);
-            free (elf_phdata);
             close(bprm->fd);
             return -E2BIG;
         }
@@ -1486,18 +1439,14 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
         reloc_func_desc = interp_load_addr;
 
         close(interpreter_fd);
-        free(elf_interpreter);
 
         if (elf_entry == ~((abi_ulong)0UL)) {
             printf("Unable to load interpreter\n");
-            free(elf_phdata);
             exit(-1);
             return 0;
         }
     }
 
-    free(elf_phdata);
-
     if (qemu_log_enabled())
         load_symbols(&elf_ex, bprm->fd);
 
-- 
2.25.1

On Fri, 2020-10-02 at 10:08 -0500, Eric Blake wrote:
> On 10/2/20 3:58 AM, Markus Armbruster wrote:
> 
> > > > > @@ -890,9 +886,8 @@ static abi_ulong load_elf_interp(struct
> > > > > elfhdr * interp_elf_ex,
> > > > >          }
> > > > >          if (retval < 0) {
> > > > >                  perror("load_elf_interp");
> > > > > +                g_free(elf_phdata);
> > > > >                  exit(-1);
> > > > > -                free (elf_phdata);
> > > > > -                return retval;
> > > > 
> > > > Deleting return looks wrong.
> > > 
> > > Why? There is an exit(-1) right in front of it, so this is dead
> > > code...
> > > well, maybe that should be done in a separate patch, or at least
> > > mentioned in the patch description, though.
> > 
> > You're right; I missed the exit(-1).
> > 
> > Following the unpleasant odour spread by exit(-1)...  Aha, the
> > function's behavior on error is inconsistent: sometimes it returns
> > zero,
> > sometimes it exits.
> 
> Eradicating exit(-1) (which is indistinguishable from exit(255), and
> generally not what you want, unless your program is designed to
> specifically invoke the immediate-exit semantics of xargs) is also a
> worthwhile cleanup project.  But I agree with the advice for separate
> patches for separate bugs.
> 
> > Since the problem is bigger than just one dead return, I recommend
> > leaving it to a separate patch, and keeping this one focused on
> > g_new().
> > 
> > 


