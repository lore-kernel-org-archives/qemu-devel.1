Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B58C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAD320706
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4qzcgSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAD320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNxtC-0004zN-Av
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 08:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kNxs3-0003a1-Jn; Thu, 01 Oct 2020 08:39:39 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kNxs1-0001ZK-9j; Thu, 01 Oct 2020 08:39:39 -0400
Received: by mail-lf1-x144.google.com with SMTP id q8so6376260lfb.6;
 Thu, 01 Oct 2020 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PFgifKQ05HFzybd7AFrHrcTUhJTM94i6SivwDjFeLcc=;
 b=R4qzcgScOBzRv15rAyTsTaTLz3S5EVBKQPlZhPRRbba7XR2AWu2AHEFgcERmFByKc/
 WwL3HagBl3v/xlVUpSV8fVNqeszvaQiP5xgOs9RVjMRuISgoulE5xLIRuiax0EzHsj9p
 Aaco99VjLULUzyCpXcvJmdnIRUGsq6mVuynag/84TTlFzSmd6qKNauTi/v8sbs+jMyvg
 hvDk38zxr+5lckQHy87zlAMUKuHIRfn9MMtNS3wQeeN7AqQ5s50U/HwkeBl0eZEHXUH+
 0Y+Izqgsd6UAlGRwEyETAxNO5QEYccZasNAxsdqf8pmk25snYpH4H8j6Aejusme/dipx
 VIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PFgifKQ05HFzybd7AFrHrcTUhJTM94i6SivwDjFeLcc=;
 b=sxQ+e+Az8f1vPiowiksE6LiSSpAf2SDmpoT0d1I5BC/uFbyZ1npcmhjtuGt4C4d+Bm
 LXRGTphSBvPuUpZA1wFV000Ex6D2jIBAX+EnSJciVU/G8CmBv0BdKfnlTBuBG9NPBUS/
 17offI+aTe1qWanUWShbuzzHOz5i2Halm9xsibWwnlWHLX6ga12sehsVZsT7PjPqkkS+
 gdjEWV1a8uFL2fEKGPoaKzowd18Yf/IYNIWCckgYHNrzqSu3W0dTuwfk3r2HcY79GyRh
 Xc8T9yd0STKazG9MwnYCIRZO/Qh8x+Z/LLU221RnPZAZNag6NlZg16cEX0r+Im+QqCxf
 UbMg==
X-Gm-Message-State: AOAM531TcslIh9zr8bqezgVMUECJmi1EDcdflTgbuEtNDiJXSwpjftG/
 beqzQVJXoJyyuzR/g8s9pGATA+u0dyi5EhzN
X-Google-Smtp-Source: ABdhPJyScbAsVNagoPIExigFuG/piUddqxSOIKP+/fOa3iD8p9iamqjEFlfSoZQHeHRqx9mc7zsqsA==
X-Received: by 2002:ac2:4316:: with SMTP id l22mr2340215lfh.310.1601555972192; 
 Thu, 01 Oct 2020 05:39:32 -0700 (PDT)
Received: from localhost.localdomain (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id b14sm531875lfo.257.2020.10.01.05.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 05:39:31 -0700 (PDT)
From: Elena Afanasova <eafanasova@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] elfload: use g_new instead of malloc
Date: Thu,  1 Oct 2020 05:38:07 -0700
Message-Id: <20201001123807.42978-1-eafanasova@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=eafanasova@gmail.com; helo=mail-lf1-x144.google.com
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
Cc: qemu-trivial@nongnu.org, Elena Afanasova <eafanasova@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
---
 bsd-user/elfload.c | 92 +++++++++++++++-------------------------------
 1 file changed, 30 insertions(+), 62 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 32378af7b2..e10ca54eb7 100644
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
 
@@ -890,9 +886,8 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
         }
         if (retval < 0) {
                 perror("load_elf_interp");
+                g_free(elf_phdata);
                 exit(-1);
-                free (elf_phdata);
-                return retval;
         }
 #ifdef BSWAP_NEEDED
         eppnt = elf_phdata;
@@ -940,7 +935,7 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
             if (error == -1) {
               /* Real error */
               close(interpreter_fd);
-              free(elf_phdata);
+              g_free(elf_phdata);
               return ~((abi_ulong)0UL);
             }
 
@@ -983,7 +978,7 @@ static abi_ulong load_elf_interp(struct elfhdr * interp_elf_ex,
                         PROT_READ|PROT_WRITE|PROT_EXEC,
                         MAP_FIXED|MAP_PRIVATE|MAP_ANON, -1, 0);
         }
-        free(elf_phdata);
+        g_free(elf_phdata);
 
         *interp_load_addr = load_addr;
         return ((abi_ulong) interp_elf_ex->e_entry) + load_addr;
@@ -1064,24 +1059,15 @@ static void load_symbols(struct elfhdr *hdr, int fd)
 
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
+    syms = g_new(symtab.sh_size, 1);
+    s->disas_strtab = strings = g_new(strtab.sh_size, 1);
 
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
 
@@ -1113,22 +1099,16 @@ static void load_symbols(struct elfhdr *hdr, int fd)
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
@@ -1190,10 +1170,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
     }
 
     /* Now read in all of the header information */
-    elf_phdata = (struct elf_phdr *)malloc(elf_ex.e_phentsize*elf_ex.e_phnum);
-    if (elf_phdata == NULL) {
-        return -ENOMEM;
-    }
+    elf_phdata = g_new(elf_ex.e_phentsize, elf_ex.e_phnum);
 
     retval = lseek(bprm->fd, elf_ex.e_phoff, SEEK_SET);
     if(retval > 0) {
@@ -1203,9 +1180,8 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
 
     if (retval < 0) {
         perror("load_elf_binary");
+        g_free(elf_phdata);
         exit(-1);
-        free (elf_phdata);
-        return -errno;
     }
 
 #ifdef BSWAP_NEEDED
@@ -1231,8 +1207,8 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
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
@@ -1242,13 +1218,7 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
              * is an a.out format binary
              */
 
-            elf_interpreter = (char *)malloc(elf_ppnt->p_filesz);
-
-            if (elf_interpreter == NULL) {
-                free (elf_phdata);
-                close(bprm->fd);
-                return -ENOMEM;
-            }
+            elf_interpreter = g_new(elf_ppnt->p_filesz, 1);
 
             retval = lseek(bprm->fd, elf_ppnt->p_offset, SEEK_SET);
             if(retval >= 0) {
@@ -1297,11 +1267,10 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
             }
             if (retval < 0) {
                 perror("load_elf_binary3");
-                exit(-1);
-                free (elf_phdata);
-                free(elf_interpreter);
+                g_free(elf_phdata);
+                g_free(elf_interpreter);
                 close(bprm->fd);
-                return retval;
+                exit(-1);
             }
         }
         elf_ppnt++;
@@ -1323,8 +1292,8 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
         }
 
         if (!interpreter_type) {
-            free(elf_interpreter);
-            free(elf_phdata);
+            g_free(elf_interpreter);
+            g_free(elf_phdata);
             close(bprm->fd);
             return -ELIBBAD;
         }
@@ -1346,8 +1315,8 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
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
@@ -1486,17 +1455,16 @@ int load_elf_binary(struct linux_binprm * bprm, struct target_pt_regs * regs,
         reloc_func_desc = interp_load_addr;
 
         close(interpreter_fd);
-        free(elf_interpreter);
+        g_free(elf_interpreter);
 
         if (elf_entry == ~((abi_ulong)0UL)) {
             printf("Unable to load interpreter\n");
-            free(elf_phdata);
+            g_free(elf_phdata);
             exit(-1);
-            return 0;
         }
     }
 
-    free(elf_phdata);
+    g_free(elf_phdata);
 
     if (qemu_log_enabled())
         load_symbols(&elf_ex, bprm->fd);
-- 
2.25.1


